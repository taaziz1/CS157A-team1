package usermanagement.web;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpSession;
import usermanagement.model.User;
import usermanagement.dao.LoginDao;

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

        try {
            if (loginDao.validate(user, "customer")) {
                response.sendRedirect("loginCustomerSuccess.jsp");
                HttpSession session = request.getSession();
                session.setAttribute("user_id", user.getUserId()); // Store user ID in session
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("user", username);
                response.sendRedirect("custLogIn.jsp");
            }
            
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
