package usermanagement.web;
import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;


import usermanagement.dao.PharmacyDao;

@WebServlet("/pharmResetPassword")
public class PharmacyResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PharmacyDao pharmacyDao;

    public void init() {
        pharmacyDao = new PharmacyDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String taxNum = request.getParameter("tax_Number");
        String currentPassword = request.getParameter("current_password");
        String newPassword = request.getParameter("new_password");

        // Basic validation
        if (taxNum == null || taxNum.isEmpty() || newPassword == null || newPassword.isEmpty()) {
            request.setAttribute("errorMessage", "Tax number and new password are required.");
            request.setAttribute("openResetModal", true);
            request.getRequestDispatcher("pharmDashboard.jsp").forward(request, response);
            return;
        }

        // Get user ID from session
        int userId = Integer.parseInt(request.getParameter("user_id"));

        int status = pharmacyDao.resetPharmacyPassword(userId, taxNum, currentPassword, newPassword);
        if (status == 1) {
            response.sendRedirect("logout");
        }
        else if (status == 2) {
            request.setAttribute("errorMessage", "Current password is incorrect. Please try again.");
            request.setAttribute("openResetModal", true);
            request.getRequestDispatcher("pharmDashboard.jsp").forward(request, response);
        }
        else if (status == 3) {
            request.setAttribute("errorMessage", "Tax number is incorrect. Please try again.");
            request.setAttribute("openResetModal", true);
            request.getRequestDispatcher("pharmDashboard.jsp").forward(request, response);
        }
        else if (status == 4) {
            request.setAttribute("errorMessage", "New password cannot be the same as the current password. Please choose a different password.");
            request.setAttribute("openResetModal", true);
            request.getRequestDispatcher("pharmDashboard.jsp").forward(request, response);
        }
        else {
            request.setAttribute("errorMessage", "An error occurred. Please try again.");
            request.setAttribute("openResetModal", true);
            request.getRequestDispatcher("pharmDashboard.jsp").forward(request, response);
        }
    }
}
