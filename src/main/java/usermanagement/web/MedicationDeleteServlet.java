package usermanagement.web;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import usermanagement.dao.MedicationDao;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/deleteMedication")
public class MedicationDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MedicationDao medicationdao;
    public void init(){
        medicationdao = new MedicationDao();
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("user_id"));
        int medId=Integer.parseInt(request.getParameter("med_id"));
        try {
           boolean deleted = medicationdao.deleteMedication(userId,medId);
            if(deleted){
                response.sendRedirect("pharmDashboard.jsp");
            }else{
                request.setAttribute("errorMessage", "Deletion failed, Please try again");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
