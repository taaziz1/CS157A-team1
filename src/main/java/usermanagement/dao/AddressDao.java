package usermanagement.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

import usermanagement.model.Address;

import util.Utilities;


/**
 * The AddressDao class hosts methods designed to access and modify the address table
 * in the pharmafinder database.
 */
public class AddressDao {

    /**
     * Retrieves the fields stored in an Address object to insert
     * a new tuple into the pharmafinder address table.
     * @param address  object storing address data to be inserted
     * @return {@code > 0} on success and {@code 0} on failure
     */
    public int registerAddress(Address address) {
        int status = 0;
        int insertedId = 0;
        String INSERT_ADDRESS_SQL = "INSERT INTO address (street_address, city, state, zip_code) VALUES (?, ?, ?, ?)";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(INSERT_ADDRESS_SQL, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, address.getStreetName());
            ps.setString(2, address.getCity());
            ps.setString(3, address.getState());
            ps.setInt(4, address.getZipcode());

            status = ps.executeUpdate();

            // Get generated address_id for the newly inserted tuple
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                insertedId = rs.getInt(1);
            }

            address.setAddressId(insertedId);

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return status;
    }


    /**
     * Retrieves information from an address tuple in the pharmafinder database.
     * @param addressId  address_id column of an address tuple
     * @return an {@code Address} object for the stored tuple on success and
     * {@code null} on failure
     */
    public Address getAddress(int addressId) {
        Address address = null;
        String RETRIEVE_ADDRESS_SQL = "SELECT * FROM address WHERE address_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(RETRIEVE_ADDRESS_SQL)) {

            ps.setInt(1, addressId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                address = new Address();

                address.setAddressId(addressId);
                address.setState(rs.getString("state"));
                address.setZipcode(rs.getInt("zip_code"));
                address.setCity(rs.getString("city"));
                address.setStreetName(rs.getString("street_address"));
            }

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return address;
    }


    /**
     * Updates an address tuple in the pharmafinder database.
     * @param address  object storing data to update the address table with
     * @return {@code > 0} on success and {@code 0} on failure
     */
    public int updateAddress(Address address) {
        int status = 0;
        String UPDATE_ADDRESS_SQL = "UPDATE address SET street_address = ?, city = ?, state = ?, zip_code = ? WHERE address_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_ADDRESS_SQL)) {

            ps.setString(1, address.getStreetName());
            ps.setString(2, address.getCity());
            ps.setString(3, address.getState());
            ps.setInt(4, address.getZipcode());
            ps.setInt(5, address.getAddressId());

            status = ps.executeUpdate();
        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return status;
    }


    /**
     * Deletes an address tuple in the pharmafinder database.
     * @param addressId  address_id column of an address tuple
     * @return {@code > 0} on success and {@code 0} on failure
     */
    public int deleteAddress(int addressId) {
        int status = 0;
        String DELETE_ADDRESS_SQL = "DELETE FROM address WHERE address_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(DELETE_ADDRESS_SQL)) {

            ps.setInt(1, addressId);
            status = ps.executeUpdate();

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return status;
    }

}
