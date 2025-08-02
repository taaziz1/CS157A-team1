package usermanagement.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;


import usermanagement.model.Pharmacy;
import usermanagement.model.Review;
import util.Utilities;

public class ReviewDao {
    public int addReview(Review review) {
        int status = 0;
        String INSERT_REVIEW_SQL = "INSERT INTO review (customer_id, pharm_id, content, rating, creation_date, last_updated)" +
                " VALUES (?, ?, ?, ?, NOW(), NOW())";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement(INSERT_REVIEW_SQL);
            ps.setInt(1, review.getCustomerId());
            ps.setInt(2, review.getPharmacyId());
            ps.setString(3, review.getContent());
            ps.setInt(4, review.getRating());
            status = ps.executeUpdate();

            con.close();

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return status;
    }

    public ArrayList<Review> getAllReviews(int pharmacyId) {
        ArrayList<Review> reviews = new ArrayList<>();
        String SELECT_REVIEWS_SQL = "SELECT * FROM review WHERE pharm_id = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement(SELECT_REVIEWS_SQL);
            ps.setInt(1, pharmacyId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("review_id"));
                review.setCustomerId(rs.getInt("customer_id"));
                review.setPharmacyId(rs.getInt("pharm_id"));
                review.setContent(rs.getString("content"));
                review.setRating(rs.getInt("rating"));
                review.setCreationDate(rs.getString("creation_date"));
                review.setLastDate(rs.getString("last_updated"));
                reviews.add(review);
            }

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return reviews;
    }

    public double getAverageRating(int pharmacyId) {
        double averageRating = 0.0;
        String SELECT_AVERAGE_RATING_SQL = "SELECT AVG(rating) AS average_rating FROM review WHERE pharm_id = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement(SELECT_AVERAGE_RATING_SQL);
            ps.setInt(1, pharmacyId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                averageRating = rs.getDouble("average_rating");
            }

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return averageRating;
    }

    public int hasPostedReview(int pharmacyId, int customerId) {
        int hasPosted = 0;
        String CHECK_REVIEW_SQL = "SELECT COUNT(*) AS count FROM review WHERE pharm_id = ? AND customer_id = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement(CHECK_REVIEW_SQL);
            ps.setInt(1, pharmacyId);
            ps.setInt(2, customerId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                hasPosted = rs.getInt("count");
            }

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return hasPosted;
    }

    public int updateReview(Review review) {
        int status = 0;
        String UPDATE_REVIEW_SQL = "UPDATE review SET content = ?, rating = ?, last_updated = NOW() " +
                "WHERE customer_id = ? AND pharm_id = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement(UPDATE_REVIEW_SQL);
            ps.setString(1, review.getContent());
            ps.setInt(2, review.getRating());
            ps.setInt(3, review.getCustomerId());
            ps.setInt(4, review.getPharmacyId());
            status = ps.executeUpdate();

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return status;
    }

    public int deleteReview(Review review) {
        int status = 0;
        String DELETE_REVIEW_SQL = "DELETE FROM review WHERE pharm_id = ? AND customer_id = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                    Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
            PreparedStatement ps = con.prepareStatement(DELETE_REVIEW_SQL);
            ps.setInt(1, review.getPharmacyId());
            ps.setInt(2, review.getCustomerId());
            status = ps.executeUpdate();

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return status;
    }

    public ArrayList<Review> getReviewList(int userId){
        String LIST_REVIEW_SQL = "SELECT r.content,r.review_id, r.last_updated, r.rating, p.name AS pharmacy_name,r.pharm_id FROM review r JOIN pharmacy p ON r.pharm_id = p.user_id WHERE r.customer_id = ? ORDER BY  r.last_updated DESC";
        ArrayList<Review> reviews = new ArrayList<>();
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
          Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                  Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
          PreparedStatement ps = con.prepareStatement(LIST_REVIEW_SQL);
          ps.setInt(1,userId);
          ResultSet rs = ps.executeQuery();
          while(rs.next()){
              Review review = new Review();
              review.setContent(rs.getString("content"));
              review.setLastDate(rs.getString("last_updated"));
              review.setRating(rs.getInt("rating"));
              review.setReviewId(rs.getInt("review_id"));
              review.setPharmacyId(rs.getInt("pharm_id"));
              Pharmacy pharmacy = new Pharmacy();
              pharmacy.setPharmacyName(rs.getString("pharmacy_name"));


              review.setPharmacy(pharmacy);
               reviews.add(review);
          }
            con.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return reviews;
    }
}
