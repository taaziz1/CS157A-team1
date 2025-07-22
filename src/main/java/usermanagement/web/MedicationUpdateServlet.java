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
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("medEditPage.jsp").forward(request, response);
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

        boolean status =false;
        try{
            status =medicationDao.editMedication(med,userId);
        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
if(status){
    //success
    response.sendRedirect("loginPharmacySuccess.jsp");
}
else{
    //failed
   request.setAttribute("errorMessage", "Update failed, Please try again");
    System.out.println("Forwarding to edit page with: " + medId + ", " + userId);
    request.getRequestDispatcher("medEditPage.jsp").forward(request, response);

}

    }

}
