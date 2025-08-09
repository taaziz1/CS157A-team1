package usermanagement.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import usermanagement.dao.CustomerDao;

import java.io.IOException;

/**
 * Enables a customer to change their password.
 */
@WebServlet("/custResetPassword")
public class CustomerResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerDao customerDao;

    public void init() {
        customerDao = new CustomerDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String currentPassword = request.getParameter("current_password");
        String newPassword = request.getParameter("new_password");

        // Basic validation
        if (newPassword == null || newPassword.isEmpty()) {
            response.sendRedirect("custDashboard.jsp?error=incomplete_field"); //new password is required.
            return;
        }

        // Get user ID from session
        int userId = Integer.parseInt(request.getParameter("user_id"));

        int status = customerDao.resetCustomerPassword(userId, currentPassword, newPassword);
        if (status == 1) {
            response.sendRedirect("logout");
        } else if (status == 2) {
            response.sendRedirect("custDashboard.jsp?error=incorrect_pass"); //Current password is incorrect. Please try again.

        } else if (status == 3) {
            response.sendRedirect("custDashboard.jsp?error=identical_pass"); //New password cannot be the same as the current password. Please choose a different password.
        } else {
            response.sendRedirect("custDashboard.jsp?error="); //An unknown error has occurred. Please try again
        }
    }
}
