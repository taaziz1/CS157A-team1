package usermanagement.web;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import usermanagement.dao.CustomerDao;
import usermanagement.model.Customer;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/updateCustomer")
public class UpdateCustomerServlet extends HttpServlet {

    private CustomerDao customerDao;


    public void init() {
        customerDao = new CustomerDao();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int userId = (int) session.getAttribute("user_id");
        Customer customer = customerDao.getCustomerDashboard(userId);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("custUpdate.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer userId = (Integer) request.getSession().getAttribute("user_id");
        String avatarIdString = request.getParameter("avatarId");
        String emailAddress = request.getParameter("emailAddress");
        String username = request.getParameter("username");
        if (avatarIdString == null || avatarIdString.isEmpty()
                || emailAddress == null || emailAddress.trim().isEmpty()
                || username == null || username.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Please fill all the fields.");
            request.setAttribute("userId", userId);
            RequestDispatcher dispatcher = request.getRequestDispatcher("custUpdate.jsp?userId=" + userId);
            dispatcher.forward(request, response);
            return;
        }

        int avatarId = Integer.parseInt(avatarIdString);

        Customer customer = new Customer();
        customer.setUserId(userId);
        customer.setAvatarId(avatarId);
        customer.setEmailAddress(emailAddress);
        customer.setUsername(username);
        boolean status=false;
        try {
             status = customerDao.updateCustomer(customer);
        }catch(SQLException e){
            throw new RuntimeException(e);
        }
        if(status){
            response.sendRedirect("custDashboard.jsp");
        }else{
            RequestDispatcher dispatcher = request.getRequestDispatcher("custUpdate.jsp?userId=" + userId);
            request.setAttribute("errorMessage", "Update failed. Try again.");
            dispatcher.forward(request, response);
        }
    }
}
