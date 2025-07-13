package usermanagement.dao;

import usermanagement.model.User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class LoginDao {
    public boolean validate(User user) throws ClassNotFoundException {
        boolean status = false;
        String SELECT_USER_SQL = "SELECT * FROM user WHERE username = ? AND password = ?";

        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder", "root", "SicSemperTyrannis@@00");
             PreparedStatement ps = con.prepareStatement(SELECT_USER_SQL)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());

            ResultSet rs = ps.executeQuery();
            status = rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;

    }
}
