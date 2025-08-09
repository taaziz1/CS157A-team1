package usermanagement.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import usermanagement.dao.MedicationDao;
import usermanagement.model.Medication;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/updateMedication")

public class MedicationUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    MedicationDao medicationDao = null;
    public void init(){
        medicationDao = new MedicationDao();
    }
    protected void doPost (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String priceString =request.getParameter("price");
        String qtyString = request.getParameter("qty");
        String medIdString = request.getParameter("med_id");
        Integer userId = (Integer) request.getSession().getAttribute("user_id");

        if(priceString==null||priceString.isEmpty()|| qtyString==null || qtyString.isEmpty()|| medIdString == null || medIdString.isEmpty()){
            response.sendRedirect("medEditPage.jsp?error=missing_fields");
            return;
        }
            double price = Double.parseDouble(priceString);
            int qty = Integer.parseInt(qtyString);
            int medId = Integer.parseInt(medIdString);

            Medication med=new Medication();
        med.setPrice(price);
        med.setQuantity(qty);
        med.setMedId(medId);
        med.setUserId(userId);

        boolean status = false;
        status = medicationDao.editMedication(med,userId);

        if(status) {
            response.sendRedirect("pharmDashboard.jsp?success=updated_med"); //success
        }
        else {
            response.sendRedirect("medEditPage.jsp?error=update_failed"); //failed
        }
    }

}
