package usermanagement.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import usermanagement.dao.MedicationDao;
import usermanagement.model.Medication;

import java.io.IOException;
import java.sql.SQLException;
@WebServlet("/getApiKey")
public class ApiServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String apiKey = getServletContext().getInitParameter("googleApiKey");
        resp.setContentType("application/json");
        resp.getWriter().write("{\"apiKey\":\"" + apiKey + "\"}");
    }
}
