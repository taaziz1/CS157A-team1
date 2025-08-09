package usermanagement.dao;

import java.sql.*;

import usermanagement.model.Address;
import usermanagement.model.Pharmacy;
import usermanagement.model.User;

import util.Utilities;


/**
 * The PharmacyDao class hosts methods designed to access and modify pharmacy entities
 * in the pharmafinder database.
 */
public class PharmacyDao {

    /**
     * Retrieves the fields stored in a {@code Pharmacy} object to insert
     * a new tuple into the pharmafinder pharmacy table.
     * @param pharmacy  object storing the pharmacy data to be inserted
     * @return {@code > 0} on success and {@code 0} on failure
     */
    public int registerPharmacy(Pharmacy pharmacy, Address address) {
        int status = 0;

        UserDao userDao = new UserDao();

        // Create a User object from the Pharmacy object
        User user = new User();
        user.setUsername(pharmacy.getUsername());
        user.copyPassword(pharmacy.getPassword());

        // Register the user first and verify that the registration succeeded
        if (userDao.registerUser(user) == 0) {
            return status;
        }

        int userId = user.getUserId(); // Get the userId from the User object

        // Register address and verify that the registration succeeded
        AddressDao addressDao = new AddressDao();
        if(addressDao.registerAddress(address) == 0) {
            return status;
        }

        int addressId = address.getAddressId(); // Get the addressId from the Address object

        // Set the user and addressId for the Pharmacy object
        pharmacy.setUserId(userId);
        pharmacy.setAddressId(addressId);

        // Prepare the SQL statement for inserting the pharmacy
        String INSERT_PHARMACY_SQL = "INSERT INTO pharmacy (user_id, address_id, tax_num, name, phone_number, " +
                "fax_number, web_url, operating_hours) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        //Register the pharmacy
        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(INSERT_PHARMACY_SQL)) {

            ps.setInt(1, pharmacy.getUserId());
            ps.setInt(2, pharmacy.getAddressId());
            ps.setString(3, pharmacy.getTaxNum());
            ps.setString(4, pharmacy.getPharmacyName());
            ps.setString(5, pharmacy.getPhoneNumber());
            ps.setString(6, pharmacy.getFaxNumber());
            ps.setString(7, pharmacy.getWebURL());
            ps.setString(8, pharmacy.getOperatingHours());

            status = ps.executeUpdate();

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return status;
    }


    /**
     * Retrieves information from the pharmacy and address tables for a pharmacy
     * in the pharmafinder database.
     * @param userId  user_id column of a pharmacy tuple
     * @return a {@code Pharmacy} object on success and {@code null} on failure
     */
    public Pharmacy getPharmacyDashboard(int userId)  {
    Pharmacy pharmacy = null;
    String RETRIEVE_PHARM_DASH_SQL = "SELECT * FROM pharmacy WHERE user_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(RETRIEVE_PHARM_DASH_SQL)) {

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

                // Address
                AddressDao addressDao = new AddressDao();
                Address address = addressDao.getAddress(pharmacy.getAddressId());
                pharmacy.setAddress(address);

                // Average Rating
                ReviewDao reviewDao = new ReviewDao();
                pharmacy.setRating(reviewDao.getAverageRating(userId));

            }

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return pharmacy;
    }


    /**
     * Changes the password for a pharmacy in the pharmafinder database.
     * @param userId             user_id column of the user table
     * @param userInputTaxNum    the tax number for the pharmacy
     * @param userInputPassword  the current password
     * @param newPassword        a new password to store in the user table
     * @return                   {@code 1} on success <br>
     *                           {@code 0} on generic failure <br>
     *                           {@code 2} on incorrect current password <br>
     *                           {@code 3} on incorrect tax number <br>
     *                           {@code 4} on identical new password
     */
    public int resetPharmacyPassword(int userId, String userInputTaxNum, String userInputPassword, String newPassword) {
        int status = 0;
        String RETRIEVE_PHARMACY_CREDENTIALS_SQL = "SELECT password, tax_num " +
                "FROM pharmacy JOIN user ON pharmacy.user_id = user.user_id " +
                "WHERE user.user_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(RETRIEVE_PHARMACY_CREDENTIALS_SQL)) {

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

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return status;
    }


    /**
     * Updates pharmacy information for a pharmacy entity in the pharmafinder database.
     * @param pharmacy  object storing new information to update the pharmacy table with
     * @return {@code > 0} on success and {@code 0} on failure
     */
    public int updatePharmacy(Pharmacy pharmacy) {
        int status = 0;
        String UPDATE_PHARMACY_SQL = "UPDATE pharmacy SET name = ?, phone_number = ?, fax_number = ?, " +
                "web_url = ?, operating_hours = ? WHERE user_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_PHARMACY_SQL)) {

            ps.setString(1, pharmacy.getPharmacyName());
            ps.setString(2, pharmacy.getPhoneNumber());
            ps.setString(3, pharmacy.getFaxNumber());
            ps.setString(4, pharmacy.getWebURL());
            ps.setString(5, pharmacy.getOperatingHours());
            ps.setInt(6, pharmacy.getUserId());

            status = ps.executeUpdate();

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return status;
    }


    /**
     * Checks if the specified tax number is taken in the database.
     * @param taxNumber  tax number
     * @return {@code true} if not taken and {@code false} otherwise
     */
    public boolean checkTaxNumberUnique(String taxNumber) {
        boolean isUnique = false;
        String SELECT_TAX_NUM_SQL = "SELECT COUNT(tax_num) FROM pharmacy WHERE tax_num = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_TAX_NUM_SQL)) {

            ps.setString(1, taxNumber);

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
     * Checks to see if the specified tax number matches the stored tax number.
     * @param userId  user_id of the pharmacy
     * @param taxNum  tax number of the pharmacy
     * @return {@code true} if not taken and {@code false} otherwise
     */
    public boolean checkTaxNumMatch(int userId, String taxNum) {
        boolean isMatch = false;
        String SELECT_TAX_NUM_SQL = "SELECT tax_num FROM pharmacy WHERE user_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_TAX_NUM_SQL)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedTaxNum = rs.getString("tax_num");
                isMatch = storedTaxNum.equals(taxNum);
            }

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return isMatch;
    }

}
