package usermanagement.model;


import java.io.Serializable;


/**
 * Represents a medication. Provides setter and getter methods.
 */
public class Medication implements Serializable {
    private static final long serialVersionUID = 1L;
    private String medName;
    private String manfName;
    private int quantity;
    private double price;
    private int medId;
    private int userId;

    public Medication() {
    }

    public Medication(int quantity, double price) {
        this.quantity = quantity;
        this.price = price;

    }

    public Medication(String medName, String manfName, int quantity, double price) {
        this.medName = medName;
        this.manfName = manfName;
        this.quantity = quantity;
        this.price = price;
    }


    public Medication(double price, int quantity) {
        this.quantity = quantity;
        this.price = price;
    }


    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }


    public String getMedName() {
        return medName;
    }

    public void setMedName(String medName) {
        this.medName = medName;
    }


    public String getManufName() {
        return manfName;
    }

    public void setManufName(String manfName) {
        this.manfName = manfName;
    }


    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }


    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }


    public int getMedId() {
        return medId;
    }

    public void setMedId(int medId) {
        this.medId = medId;
    }


}