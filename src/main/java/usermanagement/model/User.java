package usermanagement.model;

import util.Utilities;

import java.io.Serializable;

/**
 * Represents a user. Provides setter and getter methods.
 */
public class User implements Serializable {
    private static final long serialVersionUID = 1L;
    private int userId = 0;
    private String username;
    private String password;

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = Utilities.hash(password);
    }

    /**
     * Used to prevent double hashing a password when copying to a
     * {@code Customer} or {@code Pharmacy} object.
     */
    public void copyPassword(String password) {
        this.password = password;
    }
}
