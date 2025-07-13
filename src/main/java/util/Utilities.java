package util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

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
}
