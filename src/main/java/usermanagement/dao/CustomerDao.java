package usermanagement.dao;

import java.util.ArrayList;
import java.util.List;

import java.sql.*;

import usermanagement.model.*;

import util.Utilities;


/**
 * The CustomerDao class hosts methods designed to access and modify customer entities
 * in the pharmafinder database.
 */
public class CustomerDao {

    /**
     * Retrieves the fields stored in a {@code Customer} object to insert
     * a new tuple into the pharmafinder customer table.
     * @param customer  object storing the customer data to be inserted
     * @return {@code > 0} on success and {@code 0} on failure
     */
    public int registerCustomer(Customer customer) {
        int status = 0;

        UserDao userDao = new UserDao();

        // Create a User object from the Customer object
        User user = new User();
        user.setUsername(customer.getUsername());
        user.copyPassword(customer.getPassword());

        // Register the user first and verify that the registration succeeded
        if (userDao.registerUser(user) == 0) {
            return status;
        }

        int userId = user.getUserId(); // Get the userId from the User object

        customer.setUserId(userId); // Set the userId in the Customer object

        String INSERT_CUSTOMER_SQL = "INSERT INTO customer (user_id, avatar_id, email_address) VALUES (?, ?, ?)";

        //Register the customer
        try(Connection con = Utilities.createSQLConnection();
            PreparedStatement ps = con.prepareStatement(INSERT_CUSTOMER_SQL)) {

            //Randomly generate and set a valid avatar ID in the Customer object
            String SELECT_NUMBER_AVATARS = "SELECT COUNT(*) FROM avatar";
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(SELECT_NUMBER_AVATARS);
            rs.next();
            int avatarId = (int) (Math.random() * rs.getInt(1) + 1);
            customer.setAvatarId(avatarId);

            ps.setInt(1, customer.getUserId());
            ps.setInt(2, customer.getAvatarId());
            ps.setString(3, customer.getEmailAddress());

            status = ps.executeUpdate();

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return status;
    }


    /**
     * Retrieves information from the user, customer, and avatar tables for a customer
     * in the pharmafinder database.
     * @param userId  user_id column of a customer tuple
     * @return a {@code Customer} object on success and {@code null} on failure
     */
    public Customer getCustomerDashboard(int userId)  {
        Customer customer = null;
        String RETRIEVE_CUSTOMER_DASH_SQL = "SELECT * FROM customer JOIN avatar USING (avatar_id) " +
                "JOIN user USING (user_id) WHERE user_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(RETRIEVE_CUSTOMER_DASH_SQL)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                customer = new Customer();
                customer.setUserId(userId);
                customer.setUsername(rs.getString("username"));
                customer.setAvatarDirectory(rs.getString("directory_path"));
                customer.setEmailAddress(rs.getString("email_address"));
            }

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return customer;
    }


    /**
     * Retrieves information about all avatars stored in the database.
     * @return a {@code List<String>} containing the id and directory path of each avatar on success
     * <br> an empty {@code List<String>} otherwise
     */
    public List<String> avatarList() {
        List<String> avList = new ArrayList<>();

        String RETRIEVE_AVATAR_LIST_SQL = "SELECT * FROM avatar";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(RETRIEVE_AVATAR_LIST_SQL)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("avatar_id");
                String path = rs.getString("directory_path");
                avList.add(id + "|" + path);
            }

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return avList;
    }


    /**
     * Changes the avatar for a customer in the pharmafinder database.
     * @param customer  object storing avatarId and userId to update the customer table with
     * @return {@code true} on success and {@code false} on failure
     */
    public boolean updateCustomer(Customer customer) {
        boolean rowUpdated = false;
        String UPDATE_CUSTOMER_SQL = "UPDATE customer SET avatar_id = ? WHERE user_id = ?";

        try (Connection con = Utilities.createSQLConnection();
              PreparedStatement ps = con.prepareStatement(UPDATE_CUSTOMER_SQL)) {

            ps.setInt(1, customer.getAvatarId());
            ps.setInt(2, customer.getUserId());
            rowUpdated = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return rowUpdated;
    }



    public boolean checkEmailAddressUnique(String email) {
        boolean isUnique = false;
        String SELECT_TAX_NUM_SQL = "SELECT COUNT(email_address) FROM customer WHERE email_address = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_TAX_NUM_SQL)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int duplicates = rs.getInt(1);
                isUnique = (duplicates == 0);
            }

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return isUnique;
    }


    /**
     * Changes the password for a customer in the pharmafinder database.
     * @param userId             user_id column of the user table
     * @param userInputPassword  the current password
     * @param newPassword        a new password to store in the user table
     * @return                   {@code 1} on success
     *                           {@code 0} on generic failure <br>
     *                           {@code 2} on incorrect current password <br>
     *                           {@code 3} on identical new password
     */
    public int resetCustomerPassword(int userId, String userInputPassword, String newPassword) {
        int status = 0;
        String RETRIEVE_CUSTOMER_CREDENTIALS_SQL = "SELECT password FROM user WHERE user_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(RETRIEVE_CUSTOMER_CREDENTIALS_SQL)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            String currentPassword = "";

            if (rs.next()) {
                currentPassword = rs.getString("password");
            }

            if (!currentPassword.equals(Utilities.hash(userInputPassword))) {
                status = 2; // Current password does not match
            }
            else if (currentPassword.equals(Utilities.hash(newPassword))) {
                status =  3; // New password is the same as the current password
            }
            else {
                String UPDATE_CUSTOMER_PASSWORD_SQL = "UPDATE user SET password = ? WHERE user_id = ?";
                PreparedStatement updatePs = con.prepareStatement(UPDATE_CUSTOMER_PASSWORD_SQL);
                updatePs.setString(1, Utilities.hash(newPassword));
                updatePs.setInt(2, userId);
                status = updatePs.executeUpdate();
            }

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return status;
    }

}
