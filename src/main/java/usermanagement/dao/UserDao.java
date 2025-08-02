package usermanagement.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

import usermanagement.model.User;

import util.Utilities;

public class UserDao {
    public int registerUser(User user) {
        int status = 0;
        int insertedId = 0;
        String INSERT_USER_SQL = "INSERT INTO user (username, password) VALUES (?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));

            // Ask for generated keys
            PreparedStatement ps = con.prepareStatement(INSERT_USER_SQL, PreparedStatement.RETURN_GENERATED_KEYS);
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

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return status;
    }

    public int deleteAccount(int userId) {
        int status = 0;
        String DELETE_CUSTOMER_SQL = "DELETE FROM user WHERE user_id = ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement(DELETE_CUSTOMER_SQL);
            ps.setInt(1, userId);
            status = ps.executeUpdate();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return status;
    }

    public boolean checkPasswordMatch(int userId, String password) {
        boolean isMatch = false;
        String SELECT_PASSWORD_SQL = "SELECT password FROM user WHERE user_id = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement(SELECT_PASSWORD_SQL);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                isMatch = storedPassword.equals(password);
            }

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return isMatch;
    }

    public boolean checkUsernameUnique(String username) {
        boolean isUnique = false;
        String SELECT_TAX_NUM_SQL = "SELECT COUNT(username) FROM user WHERE username = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement(SELECT_TAX_NUM_SQL);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int duplicates = rs.getInt(1);
                isUnique = (duplicates == 0);
            }

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return isUnique;
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
