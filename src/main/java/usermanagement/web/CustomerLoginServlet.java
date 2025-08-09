package usermanagement.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import usermanagement.dao.CustomerDao;
import usermanagement.dao.LoginDao;
import usermanagement.model.Customer;
import usermanagement.model.User;

import java.io.IOException;

/**
 * Enables a customer to log in to the application.
 */
@WebServlet("/loginCustomer")
public class CustomerLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private LoginDao loginDao;

    public void init() {
        loginDao = new LoginDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);


        if (loginDao.validate(user, "customer")) {
            HttpSession session = request.getSession();
            session.setAttribute("user_id", user.getUserId()); // Store user ID in session
            session.setAttribute("username1", username);

            CustomerDao customerDao = new CustomerDao();
            Customer customer = customerDao.getCustomerDashboard(user.getUserId());
            session.setAttribute("avatar", customer.getAvatarDirectory());

            response.sendRedirect("index.jsp?success=log_in");


        } else {
            response.sendRedirect("custLogIn.jsp?error=invalid_credentials");
        }
    }

}
