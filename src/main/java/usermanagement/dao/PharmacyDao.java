package usermanagement.dao;

import usermanagement.model.Address;
import usermanagement.model.Pharmacy;
import usermanagement.model.User;
import usermanagement.dao.AddressDao;

import util.Utilities;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PharmacyDao {
    public int registerPharmacy(Pharmacy pharmacy, Address address) {
        int status = 0;
        int insertedId = 0;

        UserDao userDao = new UserDao();

        // Register the user first
        // Create a User object from the Pharmacy object
        User user = new User();
        user.setUsername(pharmacy.getUsername());
        user.copyPassword(pharmacy.getPassword());

        // Register the user
        userDao.registerUser(user);
        // Get the userId from the User object
        int userId = user.getUserId(); // Assuming the user ID is set after registration

        // Register address and get the address ID
        AddressDao addressDao = new AddressDao();
        addressDao.registerAddress(address);
        int addressId = address.getAddressId(); // Assuming the address ID is set after registration

        // Set the address ID in the Pharmacy object
        pharmacy.setUserId(userId);
        pharmacy.setAddressId(addressId);
        // Prepare the SQL statement for inserting the pharmacy

        String INSERT_PHARMACY_SQL = "INSERT INTO pharmacy (user_id, address_id, tax_num, name, phone_number, " +
                "fax_number, web_url, operating_hours) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement(INSERT_PHARMACY_SQL, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, pharmacy.getUserId());
            ps.setInt(2, pharmacy.getAddressId());
            ps.setString(3, pharmacy.getTaxNum());
            ps.setString(4, pharmacy.getPharmacyName());
            ps.setString(5, pharmacy.getPhoneNumber());
            ps.setString(6, pharmacy.getFaxNumber());
            ps.setString(7, pharmacy.getWebURL());
            ps.setString(8, pharmacy.getOperatingHours());

            status = ps.executeUpdate();

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return status;
    }

    //pharmacy dashboard to get according to userId
    public Pharmacy getPharmacyDashboard(int userId)  {
    Pharmacy pharmacy = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement("SELECT * FROM pharmacy  WHERE user_id = ?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                pharmacy = new Pharmacy();

                pharmacy.setUserId(userId);
                pharmacy.setTaxNum(rs.getString("tax_num"));
                pharmacy.setPharmacyName(rs.getString("name"));
                pharmacy.setPhoneNumber(rs.getString("phone_number"));
                pharmacy.setFaxNumber(rs.getString("fax_number"));
                pharmacy.setWebURL(rs.getString("web_url"));
                pharmacy.setOperatingHours(rs.getString("operating_hours"));
                pharmacy.setAddressId(rs.getInt("address_id"));
                //Address
                AddressDao addressDao = new AddressDao();
                Address address = addressDao.getAddress(pharmacy.getAddressId());

                // Compute and set the average rating
                ReviewDao reviewDao = new ReviewDao();
                pharmacy.setRating(reviewDao.getAverageRating(userId));

                pharmacy.setAddress(address);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return pharmacy;
    }

    public int resetPharmacyPassword(int userId, String userInputTaxNum, String userInputPassword, String newPassword) {
        int status = 0;
        String RETRIEVE_PHARMACY_CREDENTIALS_SQL = "SELECT password, tax_num " +
                "FROM pharmacy JOIN user ON pharmacy.user_id = user.user_id " +
                "WHERE user.user_id = ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement(RETRIEVE_PHARMACY_CREDENTIALS_SQL);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            String currentPassword = "";
            String taxNum = "";

            if (rs.next()) {
                currentPassword = rs.getString("password");
                taxNum = rs.getString("tax_num");
            }

            if (!currentPassword.equals(Utilities.hash(userInputPassword))) {
                status = 2; // Current password does not match
            }
            else if (!taxNum.equals(userInputTaxNum)) {
                status = 3; // Tax number does not match
            }
            else if (currentPassword.equals(Utilities.hash(newPassword))) {
                status =  4; // New password is the same as the current password
            }
            else {
                String UPDATE_PHARMACY_PASSWORD_SQL = "UPDATE user SET password = ? WHERE user_id = ?";
                PreparedStatement updatePs = con.prepareStatement(UPDATE_PHARMACY_PASSWORD_SQL);
                updatePs.setString(1, Utilities.hash(newPassword));
                updatePs.setInt(2, userId);
                status = updatePs.executeUpdate();
            }

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            printSQLException((SQLException) e);
        }
        return status;
    }

    public int  updatePharmacy(Pharmacy pharmacy) {
        int status = 0;
        String UPDATE_PHARMACY_SQL = "UPDATE pharmacy SET tax_num = ?, name = ?, phone_number = ?, fax_number = ?, web_url = ?, operating_hours = ? WHERE user_id = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement(UPDATE_PHARMACY_SQL);
            ps.setString(1, pharmacy.getTaxNum());
            ps.setString(2, pharmacy.getPharmacyName());
            ps.setString(3, pharmacy.getPhoneNumber());
            ps.setString(4, pharmacy.getFaxNumber());
            ps.setString(5, pharmacy.getWebURL());
            ps.setString(6, pharmacy.getOperatingHours());
            ps.setInt(7, pharmacy.getUserId());

            status = ps.executeUpdate();

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            printSQLException((SQLException) e);
        }
        return status;
    }

    public int deleteAccount(int userId) {
        int status = 0;
        String DELETE_PHARMACY_SQL = "DELETE FROM user WHERE user_id = ?";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement(DELETE_PHARMACY_SQL);
            ps.setInt(1, userId);
            status = ps.executeUpdate();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            printSQLException((SQLException) e);
        }
        return status;
    }

    public boolean checkTaxNumberUnique(String taxNumber) {
        boolean isUnique = false;
        String SELECT_TAX_NUM_SQL = "SELECT COUNT(tax_num) FROM pharmacy WHERE tax_num = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement(SELECT_TAX_NUM_SQL);
            ps.setString(1, taxNumber);
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

    public boolean checkTaxNumMatch(int userId, String taxNum) {
        boolean isMatch = false;
        String SELECT_TAX_NUM_SQL = "SELECT tax_num FROM pharmacy WHERE user_id = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement(SELECT_TAX_NUM_SQL);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedTaxNum = rs.getString("tax_num");
                isMatch = storedTaxNum.equals(taxNum);
            }

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return isMatch;
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
