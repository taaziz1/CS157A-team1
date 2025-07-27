package usermanagement.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

import usermanagement.model.Address;

import usermanagement.model.Pharmacy;
import util.Utilities;

public class AddressDao {
    public int registerAddress(Address address) {
        int status = 0;
        int insertedId = 0;
        String INSERT_ADDRESS_SQL = "INSERT INTO address (street_address, city, state, zip_code) VALUES (?, ?, ?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));

            // Ask for generated keys
            PreparedStatement ps = con.prepareStatement(INSERT_ADDRESS_SQL, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, address.getStreetName());
            ps.setString(2, address.getCity());
            ps.setString(3, address.getState());
            ps.setInt(4, address.getZipcode());

            status = ps.executeUpdate();

            // Get generated ID
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                insertedId = rs.getInt(1);
            }


            // Set the addressId in the Address object
            address.setAddressId(insertedId);

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return status;
    }
    public Address getAddress(int addressId) {
        Address address = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement("SELECT * FROM address  WHERE address_id = ?");
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

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return address;
    }

    public int updateAddress(Address address) throws SQLException {
        int status = 0;
        String UPDATE_ADDRESS_SQL = "UPDATE address SET street_address = ?, city = ?, state = ?, zip_code = ? WHERE address_id = ?";

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
             PreparedStatement ps = con.prepareStatement(UPDATE_ADDRESS_SQL)) {

            Class.forName("com.mysql.cj.jdbc.Driver");

            ps.setString(1, address.getStreetName());
            ps.setString(2, address.getCity());
            ps.setString(3, address.getState());
            ps.setInt(4, address.getZipcode());
            ps.setInt(5, address.getAddressId());

            status = ps.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
            throw e; // Rethrow the exception after logging
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return status;
    }

    public int deleteAddress(int addressId) {
        int status = 0;
        String DELETE_ADDRESS_SQL = "DELETE FROM address WHERE address_id = ?";

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
             PreparedStatement ps = con.prepareStatement(DELETE_ADDRESS_SQL)) {

            Class.forName("com.mysql.cj.jdbc.Driver");

            ps.setInt(1, addressId);
            status = ps.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return status;
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
