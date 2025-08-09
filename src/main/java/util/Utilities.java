package util;

import java.io.FileInputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.security.MessageDigest;
import java.sql.*;
import java.util.Properties;


public class Utilities {

    public static void printSQLException(SQLException ex) {
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

    /**
     * Connects to the pharmafinder database using
     * the credentials in {@code database.properties}.
     * @return a {@code Connection} to the SQL server on success and {@code null} on failure
     */
    public static Connection createSQLConnection() throws SQLException {
        Connection connection = null;

        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                Utilities.getdbvar("user"), Utilities.getdbvar("pass"));

        return connection;
    }


    /**
     * SHA-256 hash algorithm for password storage and verification.
     * @param password  the password to be hashed
     * @return a 64-character long {@code String} on success
     * <br> {@code null} on failure
     */
    public static String hash(String password) {
        try {
            MessageDigest d = MessageDigest.getInstance("SHA-256");

            byte[] passHashed = d.digest(
                    password.getBytes(StandardCharsets.UTF_8));

            StringBuilder sb = new StringBuilder();
            for (byte b : passHashed) {
                sb.append(String.format("%02x", b));
            }

            return sb.toString();
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    /**
     * Retrieves the value for a property in {@code .\conf\database.properties}
     * @param v  the property to be read
     * @return a {@code String} with the value of the property
     */
    public static String getdbvar(String v) {
        try {
            String path = Paths.get(System.getProperty("catalina.base"), "conf", "database.properties").toString();
            Properties prop = new Properties();
            prop.load(new FileInputStream(path));
            return prop.getProperty(v);
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    /**
     * Converts a US state to its abbreviation
     * @param state  the state
     * @return a {@code String} with the abbreviation
     */
    public static String stateToAbbrev(String state) {
        if (state == null) {
            return null;
        }
        switch (state) {
            case "Alabama":              return "AL";
            case "Alaska":               return "AK";
            case "Arizona":              return "AZ";
            case "Arkansas":             return "AR";
            case "California":           return "CA";
            case "Colorado":             return "CO";
            case "Connecticut":          return "CT";
            case "Delaware":             return "DE";
            case "Florida":              return "FL";
            case "Georgia":              return "GA";
            case "Hawaii":               return "HI";
            case "Idaho":                return "ID";
            case "Illinois":             return "IL";
            case "Indiana":              return "IN";
            case "Iowa":                 return "IA";
            case "Kansas":               return "KS";
            case "Kentucky":             return "KY";
            case "Louisiana":            return "LA";
            case "Maine":                return "ME";
            case "Maryland":             return "MD";
            case "Massachusetts":        return "MA";
            case "Michigan":             return "MI";
            case "Minnesota":            return "MN";
            case "Mississippi":          return "MS";
            case "Missouri":             return "MO";
            case "Montana":              return "MT";
            case "Nebraska":             return "NE";
            case "Nevada":               return "NV";
            case "New Hampshire":        return "NH";
            case "New Jersey":           return "NJ";
            case "New Mexico":           return "NM";
            case "New York":             return "NY";
            case "North Carolina":       return "NC";
            case "North Dakota":         return "ND";
            case "Ohio":                 return "OH";
            case "Oklahoma":             return "OK";
            case "Oregon":               return "OR";
            case "Pennsylvania":         return "PA";
            case "Rhode Island":         return "RI";
            case "South Carolina":       return "SC";
            case "South Dakota":         return "SD";
            case "Tennessee":            return "TN";
            case "Texas":                return "TX";
            case "Utah":                 return "UT";
            case "Vermont":              return "VT";
            case "Virginia":             return "VA";
            case "Washington":           return "WA";
            case "West Virginia":        return "WV";
            case "Wisconsin":            return "WI";
            case "Wyoming":              return "WY";
            default:                     return null;
        }
    }


    /**
     * Converts a US state abbreviation to its full name
     * @param abbrev  the state abbreviation
     * @return a {@code String} with the full state name
     */
    public static String abbrevToState(String abbrev) {
        if (abbrev == null) {
            return null;
        }
        switch (abbrev) {
            case "AL": return "Alabama";
            case "AK": return "Alaska";
            case "AZ": return "Arizona";
            case "AR": return "Arkansas";
            case "CA": return "California";
            case "CO": return "Colorado";
            case "CT": return "Connecticut";
            case "DE": return "Delaware";
            case "FL": return "Florida";
            case "GA": return "Georgia";
            case "HI": return "Hawaii";
            case "ID": return "Idaho";
            case "IL": return "Illinois";
            case "IN": return "Indiana";
            case "IA": return "Iowa";
            case "KS": return "Kansas";
            case "KY": return "Kentucky";
            case "LA": return "Louisiana";
            case "ME": return "Maine";
            case "MD": return "Maryland";
            case "MA": return "Massachusetts";
            case "MI": return "Michigan";
            case "MN": return "Minnesota";
            case "MS": return "Mississippi";
            case "MO": return "Missouri";
            case "MT": return "Montana";
            case "NE": return "Nebraska";
            case "NV": return "Nevada";
            case "NH": return "New Hampshire";
            case "NJ": return "New Jersey";
            case "NM": return "New Mexico";
            case "NY": return "New York";
            case "NC": return "North Carolina";
            case "ND": return "North Dakota";
            case "OH": return "Ohio";
            case "OK": return "Oklahoma";
            case "OR": return "Oregon";
            case "PA": return "Pennsylvania";
            case "RI": return "Rhode Island";
            case "SC": return "South Carolina";
            case "SD": return "South Dakota";
            case "TN": return "Tennessee";
            case "TX": return "Texas";
            case "UT": return "Utah";
            case "VT": return "Vermont";
            case "VA": return "Virginia";
            case "WA": return "Washington";
            case "WV": return "West Virginia";
            case "WI": return "Wisconsin";
            case "WY": return "Wyoming";
            default:   return null;
        }
    }

}
