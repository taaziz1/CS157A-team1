package usermanagement.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import usermanagement.dao.AddressDao;
import usermanagement.dao.PharmacyDao;
import usermanagement.dao.UserDao;
import usermanagement.model.Pharmacy;
import util.Utilities;

import java.io.IOException;


/**
 * Enables a pharmacy to delete their account.
 */
@WebServlet("/deletePharmacyAccount")
public class PharmacyDeleteAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDao;
    private AddressDao addressDao;
    private PharmacyDao pharmacyDao;

    public void init() {
        userDao = new UserDao();
        addressDao = new AddressDao();
        pharmacyDao = new PharmacyDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int status = 0;
        int userId = Integer.parseInt(request.getParameter("user_id"));
        String taxNumber = request.getParameter("taxNumber");
        String password = request.getParameter("password");

        if (userDao.checkPasswordMatch(userId, Utilities.hash(password)) && pharmacyDao.checkTaxNumMatch(userId, taxNumber)) {
            // If password and tax number match, proceed with deletion
            Pharmacy pharmacy = pharmacyDao.getPharmacyDashboard(userId);
            int addressId = pharmacy.getAddressId();

            // Delete the pharmacy record
            status = userDao.deleteAccount(userId);

            status *= addressDao.deleteAddress(addressId);

            if (status > 0) {
                response.sendRedirect("logout");
            } else {
                response.sendRedirect("pharmDashboard.jsp?error=delete_acc_failed");
            }
        } else {
            // If password or tax number does not match, redirect with error
            response.sendRedirect("pharmDashboard.jsp?error=invalid_credentials");
        }


    }
}
