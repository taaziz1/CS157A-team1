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
import java.sql.SQLIntegrityConstraintViolationException;

@WebServlet("/addMed")
public class AddMedicationServlet  extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MedicationDao medDao;

    public void init() {
        medDao = new MedicationDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String medIdString = request.getParameter("med_id");
        String priceString =request.getParameter("price");
        String qtyString = request.getParameter("quantity");
        Integer userId = (Integer) request.getSession().getAttribute("user_id");
        if(medIdString==null || medIdString.isEmpty()
                || priceString==null || priceString.isEmpty()
                || qtyString==null || qtyString.isEmpty()){
            request.getRequestDispatcher("addMeds.jsp").forward(request, response);
            return;
        }
        //
        int medId = Integer.parseInt(medIdString);
        double price = Double.parseDouble(priceString);
        int qty =Integer.parseInt(qtyString);

        Medication med = new Medication();
        med.setMedId(medId);
        med.setUserId(userId);
        med.setPrice(price);
        med.setQuantity(qty);
        boolean status = false;
        try{
            status = medDao.insertMedication(med,userId);

        } catch(SQLException e){
           throw new RuntimeException(e);
        }

        if (status){
            response.sendRedirect("loginPharmacySuccess.jsp");
        }else{
            request.setAttribute("errorMessage", "Medication already present");
            request.getRequestDispatcher("addMeds.jsp").forward(request, response);

        }

    }
}



