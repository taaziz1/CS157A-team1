package usermanagement.dao;

import java.util.ArrayList;
import java.util.List;

import java.sql.*;

import usermanagement.model.Medication;

import util.Utilities;


/**
 * The MedicationDao class hosts methods designed to access and modify medication entities
 * in the pharmafinder database.
 */
public class MedicationDao {

    /**
     * Retrieves listed medications for a pharmacy from the medication,
     * sells, and manufacturer tables in the pharmafinder database.
     * @param userId  user_id column of a pharmacy tuple
     * @return a {@code List<Medication>} containing med_id, name, manufacturer, price, and quantity
     * for each of the pharmacy's medications on success <br> an empty {@code List<Medication>} otherwise
     */
    public List<Medication> getMedication(int userId) {
        List<Medication> med = new ArrayList<>();
        String RETRIEVE_PHARMACY_MEDS_SQL =
                "SELECT medication.name AS med_name, " +
                "manufacturer.name AS manuf_name, " +
                "sells.price AS med_price, " +
                "sells.quantity AS med_quantity, " +
                "medication.med_id AS med_id " +
                "FROM medication " +
                "JOIN sells USING (med_id) " +
                "JOIN manufacturer USING (manf_id) " +
                "WHERE user_id = ? " +
                "ORDER BY medication.name ASC";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(RETRIEVE_PHARMACY_MEDS_SQL)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Medication medication = new Medication();
                medication.setMedName(rs.getString("med_name"));
                medication.setManufName(rs.getString("manuf_name"));
                medication.setPrice(rs.getDouble("med_price"));
                medication.setQuantity(rs.getInt("med_quantity"));
                medication.setMedId(rs.getInt("med_id"));

                med.add(medication);
            }

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return med;
    }

    /**
     * Updates a medication listing in the sells table of the pharmafinder database.
     * @param medication  object storing med_id, price, and quantity
     * @param userId  user_id of the pharmacy
     * @return {@code true} on success and {@code false} on failure
     */
    public boolean editMedication(Medication medication, int userId) {
        boolean rowUpdated = false;
        String UPDATE_MEDICATION_SQL = "UPDATE sells SET price = ?, quantity = ? " +
                "WHERE user_id = ? and med_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_MEDICATION_SQL)) {

            ps.setDouble(1, medication.getPrice());
            ps.setInt(2, medication.getQuantity());
            ps.setInt(3, userId);
            ps.setInt(4, medication.getMedId());
            rowUpdated = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return rowUpdated;
    }

    /**
     * Deletes a medication listing from the sells table of the pharmafinder database.
     * @param userId  user_id column of the sells table
     * @param medId  med_id column of the sells table
     * @return {@code true} on success and {@code false} on failure
     */
    public boolean deleteMedication(int userId, int medId) {
        boolean rowDelete = false;
        String DELETE_MEDICATION_SQL = "DELETE FROM sells WHERE user_id = ? and med_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(DELETE_MEDICATION_SQL)){
            ps.setInt(1, userId);
            ps.setInt(2, medId);
            rowDelete = ps.executeUpdate() > 0;

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return rowDelete;
    }


    /**
     * Retrieves all valid PharmaFinder medications that can be used in a medication listing.
     * @return a {@code List<Medication>} containing all valid medications on success
     * <br> an empty {@code List<Medication>} otherwise
     */
    public List<Medication> listMeds() {
        ArrayList<Medication> medList = new ArrayList<>();
        String LIST_MEDICATION_SQL ="SELECT * FROM medication ORDER BY name ASC";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(LIST_MEDICATION_SQL)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Medication medication = new Medication();
                medication.setMedId(rs.getInt("med_id"));
                medication.setMedName(rs.getString("name"));
                medList.add(medication);
            }

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return medList;
    }


    /**
     * Inserts a medication listing into the sells table of the pharmafinder database.
     * @param medication  object containing med_id, price, and quantity for the medication tuple
     * @param userId  user_id column of the sells table
     * @return {@code true} on success and {@code false} on failure
     */
    public boolean insertMedication(Medication medication, int userId) {
        boolean rowInserted = false;
        String ADD_MEDICATION_SQL ="INSERT INTO sells (user_id, med_id, quantity, price) VALUES (?,?,?,?)";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(ADD_MEDICATION_SQL)) {

            ps.setInt(1, userId);
            ps.setInt(2, medication.getMedId());
            ps.setInt(3, medication.getQuantity());
            ps.setDouble(4, medication.getPrice());

            rowInserted = ps.executeUpdate()>0;

        } catch (SQLException e) {
                Utilities.printSQLException(e);
        }

        return rowInserted;
    }

    /**
     * Retrieves name, price, and quantity for a medication listing from the pharmafinder database.
     * @param medId  med_id of the medication
     * @param userId  user_id of the pharmacy
     * @return a {@code Medication} object with med_id, name, price, and quantity info on success
     * <br> {@code null} on failure
     */
    public Medication getMedicationByMedId(int medId, int userId) {
        Medication medication = null;
        String MEDICATION_BY_ID_SQL =
                "SELECT medication.name AS med_name, " +
                        "sells.price AS med_price, " +
                        "sells.quantity AS med_quantity, " +
                        "medication.med_id AS med_id " +
                        "FROM medication " +
                        "JOIN sells USING (med_id) " +
                        "WHERE sells.med_id = ? AND " +
                        "sells.user_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(MEDICATION_BY_ID_SQL)) {

            ps.setInt(1, medId);
            ps.setInt(2, userId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                medication = new Medication();
                medication.setMedId(rs.getInt("med_id"));
                medication.setMedName(rs.getString("med_name"));
                medication.setPrice(rs.getDouble("med_price"));
                medication.setQuantity(rs.getInt("med_quantity"));
            }

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return medication;
    }

}







