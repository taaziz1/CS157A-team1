package usermanagement.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;


/**
 * Retrieves the Google Maps API key from {@code database.properties}.
 */
@WebServlet("/getApiKey")
public class GetApiKeyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Properties prop = new Properties();
        String path = System.getProperty("catalina.base") + "/conf/database.properties";
        try (FileInputStream fis = new FileInputStream(path)) {
            prop.load(fis);
        }

        String apiKey = prop.getProperty("apiKey");
        req.setAttribute("apikey", apiKey);
        PrintWriter out = resp.getWriter();
        out.write(apiKey);
    }
}

