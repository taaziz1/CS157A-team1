package usermanagement.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import usermanagement.dao.CustomerDao;
import usermanagement.model.Customer;

import java.io.IOException;

@WebServlet("/updateCustomer")
public class CustomerUpdateServlet extends HttpServlet {

    private CustomerDao customerDao;


    public void init() {
        customerDao = new CustomerDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer userId = (Integer) request.getSession().getAttribute("user_id");
        String avatarIdString = request.getParameter("avatarId");

        int avatarId = Integer.parseInt(avatarIdString);

        Customer customer = new Customer();
        customer.setUserId(userId);
        customer.setAvatarId(avatarId);

        boolean status = false;
        status = customerDao.updateCustomer(customer);

        if(status) {
            HttpSession session = request.getSession();
            customer = customerDao.getCustomerDashboard(userId);
            session.setAttribute("avatar", customer.getAvatarDirectory());
            response.sendRedirect("custDashboard.jsp?success=updated_info");
        } else{
            response.sendRedirect("custDashboard.jsp?error=update_fail");
        }
    }
}
