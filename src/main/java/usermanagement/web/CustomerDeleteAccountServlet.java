package usermanagement.web;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;

import usermanagement.dao.UserDao;
import util.Utilities;

@WebServlet("/deleteCustomerAccount")
public class CustomerDeleteAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDao;

    public void init() {
        userDao = new UserDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("user_id"));
        String password = request.getParameter("password");

        if (userDao.checkPasswordMatch(userId, Utilities.hash(password))) {
            int status = userDao.deleteAccount(userId);
            if (status > 0) {
                response.sendRedirect("logout");
            }
            else {
                response.sendRedirect("custDashboard.jsp?error=delete_failed");
            }
        }
        else {
            response.sendRedirect("custDashboard.jsp?error=invalid_password");
        }
    }
}
