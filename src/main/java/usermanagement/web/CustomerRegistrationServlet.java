package usermanagement.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import usermanagement.dao.CustomerDao;
import usermanagement.dao.UserDao;
import usermanagement.model.Customer;

import java.io.IOException;


/**
 * Enables a customer to register an account.
 */
@WebServlet("/registerCustomer")
public class CustomerRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDao;
    private CustomerDao customerDao;

    public void init() {
        userDao = new UserDao();
        customerDao = new CustomerDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String emailAddress = request.getParameter("emailAddress");

        // Basic validation
        if (username == null || username.isEmpty() || password == null || password.isEmpty() || emailAddress == null || emailAddress.isEmpty()) {
            response.sendRedirect("registerCust.jsp?error=invalid_form");
            return;
        }

        //Check for duplicate username or email address
        if (!userDao.checkUsernameUnique(username) || !customerDao.checkEmailAddressUnique(emailAddress)) {
            response.sendRedirect("registerCust.jsp?error=duplicate_account");
            return;
        }

        Customer customer = new Customer();
        customer.setUsername(username);
        customer.setPassword(password);
        customer.setEmailAddress(emailAddress);

        int status = customerDao.registerCustomer(customer);

        if (status > 0) {
            response.sendRedirect("index.jsp?success=registration");
        } else {
            response.sendRedirect("registerCust.jsp?error=creation_error");
        }
    }
}
