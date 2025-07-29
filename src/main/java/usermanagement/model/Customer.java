package usermanagement.model;

import java.io.Serializable;

public class Customer extends User implements Serializable {
    private static final long serialVersionUID = 1L;
    private int avatarId;
    private String emailAddress;

    //for image display in customer dashboard
    private String avatarDirectory;
    public void setAvatarDirectory(String avatarDirectory) {
        this.avatarDirectory = avatarDirectory;
    }

    public String getAvatarDirectory() {
        return avatarDirectory;
    }

    public int getAvatarId() {
        return avatarId;
    }

    public void setAvatarId(int avatarId) {
        this.avatarId = avatarId;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }
}
