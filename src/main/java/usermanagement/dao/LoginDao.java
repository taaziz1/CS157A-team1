package usermanagement.dao;

import usermanagement.model.User;

import util.Utilities;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class LoginDao {
    private static int user_id = 0;
    public boolean validate(User user, String source) throws ClassNotFoundException {
        boolean status = false;
        String SELECT_USER_SQL = "SELECT * FROM user JOIN $TABLE".replace("$TABLE", source) +
                " USING(user_id) WHERE username = ? AND password = ?";

        Class.forName("com.mysql.cj.jdbc.Driver");
        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement(SELECT_USER_SQL);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());

            // 🔍 Print the username and password being validated
            System.out.println("Trying to log in with:");
            System.out.println("Username: " + user.getUsername());
            System.out.println("Password: " + user.getPassword());

            ResultSet rs = ps.executeQuery();
            status = rs.next();
            if (status) {
                // If the user is found, retrieve the user_id
                user_id = rs.getInt("user_id");
                user.setUserId(user_id); // Set the userId in the User object
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;

    }
}
