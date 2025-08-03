package util;

import java.io.FileInputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.security.MessageDigest;
import java.util.Properties;


public class Utilities {

    //SHA-256 hash for password storage and verification
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
        catch(Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //Reads the value stored for property v in .\conf\database.properties
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
