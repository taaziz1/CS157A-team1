package usermanagement.web;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import usermanagement.dao.ReviewDao;
import usermanagement.model.Review;

import java.io.IOException;

@WebServlet("/editReview")
public class ReviewEditServlet  extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReviewDao reviewDao;

    public void init() {
        reviewDao = new ReviewDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        int pharmacyId = Integer.parseInt(request.getParameter("pharmacyId"));
        String content = request.getParameter("content");
        int rating = Integer.parseInt(request.getParameter("rating"));

        Review review = new Review();
        review.setContent(content);
        review.setRating(rating);
        review.setCustomerId(customerId);
        review.setPharmacyId(pharmacyId);

        int status = 0;
        try {
            status = reviewDao.updateReview(review);
            if (status > 0) {
                response.sendRedirect("pharmacy.jsp?p=" + pharmacyId + "&success=updated_review");
            } else {
                response.sendRedirect("pharmacy.jsp?p=" + pharmacyId + "&error=update_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }


    }
}
