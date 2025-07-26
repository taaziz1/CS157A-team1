package usermanagement.dao;


import usermanagement.model.Medication;
import util.Utilities;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class MedicationDao {
    public List<Medication> getMedication(int userId) {


        List<Medication> med = new ArrayList();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement(
                    "SELECT medication.name AS med_name, " +
                            "manufacturer.name AS manuf_name, " +
                            "sells.price AS med_price, " +
                            "sells.quantity AS med_quantity, " +
                            "medication.med_id AS med_id " +
                            "FROM medication " +
                            "JOIN sells USING (med_id) " +
                            "JOIN manufacturer USING (manf_id) " +
                            "WHERE user_id = ?"
            );


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
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return med;
    }

    //connection method
    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return connection;
    }

    //insert new meds
//private static final String INSERT_MEDICAION_SQL ="INSERT sells SET price=?,quantity=? WHERE user_id=?";
//edit function
    private static final String UPDATE_MEDICAION_SQL = "UPDATE  sells SET price=?,quantity=? WHERE user_id=? and med_id=?";

    public boolean editMedication(Medication medication, int userId) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(UPDATE_MEDICAION_SQL);) {
            ps.setDouble(1, medication.getPrice());
            ps.setInt(2, medication.getQuantity());
            ps.setInt(3, userId);
            ps.setInt(4, medication.getMedId());
            rowUpdated = ps.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    //Delete Function
    private static final String DELETE_MEDICAION_SQL = "DELETE FROM sells WHERE user_id=? and med_id=?";
    public boolean deleteMedication(int userId,int medId) throws SQLException{
        boolean rowDelete;
        try(Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(DELETE_MEDICAION_SQL); ){
            ps.setInt(1,userId);
            ps.setInt(2,medId);
            rowDelete = ps.executeUpdate()>0;
        }
        return rowDelete;
    }
//list Med options
private static final String LIST_MEDICATION_SQL ="SELECT * FROM medication";
    public List<Medication> listMeds() {
        ArrayList<Medication> medList = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(LIST_MEDICATION_SQL);) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Medication medication = new Medication();
                medication.setMedId(rs.getInt("med_id"));
                medication.setMedName(rs.getString("name"));
medList.add(medication);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
    return medList;
    }
    // ADD Medication

private static final String ADD_MEDICATION_SQL ="INSERT INTO sells (user_id, med_id, quantity, price) VALUES (?,?,?,?)";
public boolean insertMedication(Medication medication, int userId) throws  SQLException {
    boolean rowInserted = false;
    try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(ADD_MEDICATION_SQL)) {
            ps.setInt(1,userId);
            ps.setInt(2,medication.getMedId());
            ps.setInt(3,medication.getQuantity());
            ps.setDouble(4,medication.getPrice());

            rowInserted= ps.executeUpdate()>0;

    } catch (SQLException e) {
            printSQLException(e);
        }
return rowInserted;
}  private void printSQLException(SQLException ex) {
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







