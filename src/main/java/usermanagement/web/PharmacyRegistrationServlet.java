package usermanagement.web;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;


import usermanagement.model.Address;
import usermanagement.model.Pharmacy;
import usermanagement.dao.PharmacyDao;

@WebServlet("/registerPharmacy")
public class PharmacyRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PharmacyDao pharmacyDao;

    public void init() {
        pharmacyDao = new PharmacyDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().println("Servlet is working!");
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String pharmacyName = request.getParameter("pharmacy_name");
        String taxNum = request.getParameter("tax_Number");
        String streetAddress = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        int zipcode = Integer.parseInt(request.getParameter("zip"));
        String phoneNumber = request.getParameter("phone");
        String faxNumber = request.getParameter("fax");
        String webURL = request.getParameter("url");
        String[] operatingHoursArray = request.getParameterValues("operating_hours");

        // Initialize operatingHours as an empty string
        String operatingHours = "";

        // Check if operatingHoursArray is not null and has exactly 7 elements
        if (operatingHoursArray != null && operatingHoursArray.length == 7) {
            // Join with commas (or any other separator)
            operatingHours = String.join(",", operatingHoursArray);
        } else {
            // Handle missing or malformed input
            operatingHours = "Unavailable";
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
        address.setZipcode(zipcode);

        int status = pharmacyDao.registerPharmacy(pharmacy, address);

        if (status > 0) {
            response.sendRedirect("pharmHome.jsp");
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}
