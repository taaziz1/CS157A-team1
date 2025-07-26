package usermanagement.model;

import java.io.Serializable;
import usermanagement.dao.ReviewDao;

public class Pharmacy extends User implements Serializable{
    private static final long serialVersionUID = 1L;
    private String pharmacyName;
    private int addressId = 0;
    private String taxNum;
    private String phoneNumber;
    private String faxNumber;
    private String webURL;
    private String operatingHours;

    private double rating;
    private Address address;


    public String getPharmacyName() {
        return pharmacyName;
    }

    public void setPharmacyName(String pharmacyName) {
        this.pharmacyName = pharmacyName;
    }

    public String getTaxNum() {
        return taxNum;
    }

    public void setTaxNum(String taxNum) {
        this.taxNum = taxNum;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getFaxNumber() {
        return faxNumber;
    }

    public void setFaxNumber(String faxNumber) {
        this.faxNumber = faxNumber;
    }

    public String getWebURL() {
        return webURL;
    }

    public void setWebURL(String webURL) {
        this.webURL = webURL;
    }

    public String getOperatingHours() {
        return operatingHours;
    }

    public void setOperatingHours(String operatingHours) {
        this.operatingHours = operatingHours;
    }

    public void setAddress(Address address) {
        this.address=address;
    }

    public Address getAddress() {
        return address;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public double getRating(){
        return rating;
    }

    public double getAverageRating() {
        ReviewDao reviewDao = new ReviewDao();
        return reviewDao.getAverageRating(this.getUserId());
    }
}
