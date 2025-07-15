package usermanagement.model;

import java.io.Serializable;

public class Customer extends User implements Serializable {
    private static final long serialVersionUID = 1L;
    private int avatarId;
    private String emailAddress;

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
