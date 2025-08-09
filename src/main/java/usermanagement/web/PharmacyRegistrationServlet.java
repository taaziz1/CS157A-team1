package usermanagement.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import usermanagement.dao.PharmacyDao;
import usermanagement.dao.UserDao;
import usermanagement.model.Address;
import usermanagement.model.Pharmacy;
import util.Utilities;

import java.io.IOException;


/**
 * Enables a pharmacy to register an account.
 */
@WebServlet("/registerPharmacy")
public class PharmacyRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDao;
    private PharmacyDao pharmacyDao;

    public void init() {
        userDao = new UserDao();
        pharmacyDao = new PharmacyDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String pharmacyName = request.getParameter("pharmacy_name");
        String taxNum = request.getParameter("tax_Number");
        String streetAddress = request.getParameter("address");
        String city = request.getParameter("city");
        String state = Utilities.stateToAbbrev(request.getParameter("state"));
        String zipString = request.getParameter("zip");
        String phoneNumber = request.getParameter("phone");
        String faxNumber = request.getParameter("fax");
        String webURL = request.getParameter("url");
        String[] operatingHoursArray = request.getParameterValues("operating_hours");

        // Basic validation
        if (username == null || username.isEmpty() || password == null || password.isEmpty() || pharmacyName == null || pharmacyName.isEmpty() || taxNum == null || taxNum.isEmpty() || streetAddress == null || streetAddress.isEmpty() || city == null || city.isEmpty() || state == null || state.isEmpty() || zipString == null || zipString.isEmpty() || operatingHoursArray == null || operatingHoursArray.length != 7) {
            response.sendRedirect("registerPharm.jsp?error=invalid_form");
            return;
        }

        //Check for duplicate username or tax number
        if (!userDao.checkUsernameUnique(username) || !pharmacyDao.checkTaxNumberUnique(taxNum)) {
            response.sendRedirect("registerPharm.jsp?error=duplicate_account");
            return;
        }

        // Initialize operatingHours as an empty string
        String operatingHours = "";

        // Check if operatingHoursArray is not null and has exactly 7 elements
        if (operatingHoursArray != null && operatingHoursArray.length == 7) {
            // Join with commas (or any other separator)
            operatingHours = String.join(",", operatingHoursArray);
        } else {
            // Handle missing or malformed input
            operatingHours = "N/A,N/A,N/A,N/A,N/A,N/A,N/A";
        }

        Pharmacy pharmacy = new Pharmacy();
        pharmacy.setUsername(username);
        pharmacy.setPassword(password);
        pharmacy.setPharmacyName(pharmacyName);
        pharmacy.setTaxNum(taxNum);
        pharmacy.setPhoneNumber(phoneNumber);
        pharmacy.setFaxNumber(faxNumber);
        pharmacy.setWebURL(webURL);
        pharmacy.setOperatingHours(operatingHours);

        Address address = new Address();
        address.setStreetName(streetAddress);
        address.setCity(city);
        address.setState(state);
        address.setZipcode(Integer.parseInt(zipString));

        int status = pharmacyDao.registerPharmacy(pharmacy, address);

        if (status > 0) {
            response.sendRedirect("index.jsp?success=registration");
        } else {
            response.sendRedirect("registerPharm.jsp?error=creation_error");
        }
    }
}
