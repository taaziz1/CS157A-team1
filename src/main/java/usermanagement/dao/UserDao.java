package usermanagement.dao;

import java.sql.*;

import usermanagement.model.User;

import util.Utilities;


/**
 * The UserDao class hosts methods designed to access and modify user entities
 * in the pharmafinder database.
 */
public class UserDao {

    /**
     * Retrieves the fields stored in a {@code User} object to insert
     * a new tuple into the pharmafinder user table.
     * <br> Sets the userId field of the {@code User} object upon success.
     * @param user  object storing the pharmacy data to be inserted
     * @return {@code > 0} on success and {@code 0} on failure
     */
    public int registerUser(User user) {
        int status = 0;
        int insertedId = 0;
        String INSERT_USER_SQL = "INSERT INTO user (username, password) VALUES (?, ?)";

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
             PreparedStatement ps = con.prepareStatement(INSERT_USER_SQL, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            status = ps.executeUpdate();

            // Get generated ID
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                insertedId = rs.getInt(1);
            }

            // Set the userId in the User object
            user.setUserId(insertedId);

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return status;
    }


    /**
     * Deletes a user tuple in the pharmafinder database.
     * <br>Note: The system will remove all associated records for the
     * specified user (eg: reviews, medication listings, ...)
     * @param userId  user_id column of a user tuple
     * @return {@code > 0} on success and {@code 0} on failure
     */
    public int deleteAccount(int userId) {
        int status = 0;
        String DELETE_CUSTOMER_SQL = "DELETE FROM user WHERE user_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(DELETE_CUSTOMER_SQL);) {

            ps.setInt(1, userId);
            status = ps.executeUpdate();

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return status;
    }


    /**
     * Checks if the password for a user is correct.
     * @param userId  user_id column of a user tuple
     * @param password  password to be checked
     * @return {@code true} if correct and {@code false} otherwise
     */
    public boolean checkPasswordMatch(int userId, String password) {
        boolean isMatch = false;
        String SELECT_PASSWORD_SQL = "SELECT password FROM user WHERE user_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_PASSWORD_SQL);) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                isMatch = storedPassword.equals(password);
            }

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return isMatch;
    }


    /**
     * Checks if the specified username already exists.
     * @param username  username to be checked
     * @return {@code true} if available and {@code false} otherwise
     */
    public boolean checkUsernameUnique(String username) {
        boolean isUnique = false;
        String SELECT_TAX_NUM_SQL = "SELECT COUNT(username) FROM user WHERE username = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_TAX_NUM_SQL);){

            ps.setString(1, username);
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

}
