package usermanagement.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import usermanagement.dao.AddressDao;
import usermanagement.dao.PharmacyDao;
import usermanagement.model.Address;
import usermanagement.model.Pharmacy;
import util.Utilities;

import java.io.IOException;


/**
 * Enables a pharmacy to update their account information.
 */
@WebServlet("/updatePharmacy")
public class PharmacyUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PharmacyDao pharmacyDao;
    private AddressDao addressDao;

    public void init() {
        pharmacyDao = new PharmacyDao();
        addressDao = new AddressDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pharmacyName = request.getParameter("pharmacy_name");
        String streetAddress = request.getParameter("address");
        String city = request.getParameter("city");
        String state = Utilities.stateToAbbrev(request.getParameter("state"));
        String zipString = request.getParameter("zip");
        String phoneNumber = request.getParameter("phone");
        String faxNumber = request.getParameter("fax");
        String webURL = request.getParameter("url");
        String[] operatingHoursArray = request.getParameterValues("operating_hours");

        // Basic validation
        if (pharmacyName == null || pharmacyName.isEmpty() || streetAddress == null || streetAddress.isEmpty() || city == null || city.isEmpty() || state == null || state.isEmpty() || zipString == null || zipString.isEmpty() || operatingHoursArray == null || operatingHoursArray.length != 7) {
            response.sendRedirect("pharmInfoUpdate.jsp?error=invalid_form");
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
        pharmacy.setUserId(Integer.parseInt(request.getParameter("user_id")));
        pharmacy.setPharmacyName(pharmacyName);
        pharmacy.setPhoneNumber(phoneNumber);
        pharmacy.setFaxNumber(faxNumber);
        pharmacy.setWebURL(webURL);
        pharmacy.setOperatingHours(operatingHours);

        Address address = new Address();
        address.setAddressId(Integer.parseInt(request.getParameter("address_id")));
        address.setStreetName(streetAddress);
        address.setCity(city);
        address.setState(state);
        address.setZipcode(Integer.parseInt(zipString));

        int status = 0;
        status = pharmacyDao.updatePharmacy(pharmacy) * addressDao.updateAddress(address);

        if (status > 0) {
            response.sendRedirect("pharmDashboard.jsp?success=updated_info");
        } else {
            response.sendRedirect("pharmInfoUpdate.jsp?error=update_error");
        }
    }
}
