package usermanagement.dao;

import java.sql.*;

import usermanagement.model.User;

import util.Utilities;


/**
 * The LoginDao class hosts user login verification methods.
 */
public class LoginDao {

    /**
     * Determines whether a username, password pair is in the database.
     * @param user  stores user_id if credentials were valid
     * @param source must be {@code "customer"} or {@code "pharmacy"} and
     *               indicates which type of account is being checked
     * @return {@code true} on valid credentials and {@code false} on invalid credentials
     */
    public boolean validate(User user, String source) {
        int user_id = 0;
        boolean status = false;
        String SELECT_USER_SQL = "SELECT * FROM user JOIN $TABLE".replace("$TABLE", source) +
                " USING(user_id) WHERE username = ? AND password = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_USER_SQL)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());

            ResultSet rs = ps.executeQuery();
            status = rs.next();

            if (status) {
                user_id = rs.getInt("user_id"); // If the user is found, retrieve the user_id
                user.setUserId(user_id); // Set the userId in the User object
            }

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return status;
    }

}
