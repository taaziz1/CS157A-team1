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
}
