package usermanagement.dao;

import usermanagement.model.Address;
import usermanagement.model.Customer;
import usermanagement.model.Pharmacy;
import usermanagement.model.User;

import util.Utilities;

import java.sql.*;

public class CustomerDao {
    public int registerCustomer(Customer customer) {
        int status = 0;

        UserDao userDao = new UserDao();

        // Register a user first
        // Create a User object from the Customer object
        User user = new User();
        user.setUsername(customer.getUsername());
        user.copyPassword(customer.getPassword());

        // Register the user
        userDao.registerUser(user);

        // Get the userId from the User object
        int userId = user.getUserId(); // Assuming the user ID is set after registration

        // Set the user ID in the Customer object
        customer.setUserId(userId);

        // Prepare the SQL statement for inserting the customer
        String INSERT_CUSTOMER_SQL = "INSERT INTO customer (user_id, avatar_id, email_address) VALUES (?, ?, ?)";


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));

            //Randomly generate and set a valid avatar ID in the Customer object
            String SELECT_NUMBER_AVATARS = "SELECT COUNT(*) FROM avatar";
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(SELECT_NUMBER_AVATARS);
            rs.next();
            int avatarId = (int) (Math.random() * rs.getInt(1) + 1);
            customer.setAvatarId(avatarId);

            PreparedStatement ps = con.prepareStatement(INSERT_CUSTOMER_SQL, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, customer.getUserId());
            ps.setInt(2, customer.getAvatarId());
            ps.setString(3, customer.getEmailAddress());

            status = ps.executeUpdate();

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return status;
    }

    //Customer DashBoard
    public Customer getCustomerDashboard(int userId)  {
        Customer customer = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement("SELECT * FROM customer JOIN avatar USING (avatar_id)  JOIN user USING (user_id)WHERE user_id = ?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                customer = new Customer();
                customer.setUserId(userId);
                customer.setUsername(rs.getString("username"));
                customer.setAvatarDirectory(rs.getString("directory_path"));
                customer.setEmailAddress(rs.getString("email_address"));
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return customer;
    }


    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
