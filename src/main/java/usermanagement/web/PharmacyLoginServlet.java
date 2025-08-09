package usermanagement.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import usermanagement.dao.LoginDao;
import usermanagement.model.User;

import java.io.IOException;


/**
 * Enables a pharmacy to log in to the application.
 */
@WebServlet("/loginPharmacy")
public class PharmacyLoginServlet extends HttpServlet {
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

        if (loginDao.validate(user, "pharmacy")) {
            HttpSession session = request.getSession();
            session.setAttribute("user_id", user.getUserId()); // Store user ID in session
            session.setAttribute("username2", user.getUsername());

            response.sendRedirect("pharmDashboard.jsp?success=log_in");


        } else {
            response.sendRedirect("pharmLogIn.jsp?error=invalid_credentials");
        }
    }

}
