package usermanagement.dao;

import java.util.ArrayList;

import java.sql.*;

import usermanagement.model.Pharmacy;
import usermanagement.model.Review;

import util.Utilities;


/**
 * The ReviewDao class hosts methods designed to access and modify review entities
 * in the pharmafinder database.
 */
public class ReviewDao {

    /**
     * Adds a tuple into the review table of the pharmafinder database.
     * @param review  object containing customer_id, pharm_id, content, and rating for the review
     * @return {@code > 0} on success and {@code 0} on failure
     */
    public int addReview(Review review) {
        int status = 0;
        String INSERT_REVIEW_SQL = "INSERT INTO review (customer_id, pharm_id, content, rating, creation_date, last_updated)" +
                " VALUES (?, ?, ?, ?, NOW(), NOW())";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(INSERT_REVIEW_SQL)) {

            ps.setInt(1, review.getCustomerId());
            ps.setInt(2, review.getPharmacyId());
            ps.setString(3, review.getContent());
            ps.setInt(4, review.getRating());
            status = ps.executeUpdate();

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return status;
    }


    /**
     * Retrieves all reviews for a given pharmacy.
     * @param pharmacyId  user_id column of a pharmacy tuple
     * @return an {@code ArrayList<Review>} containing all reviews made on the pharmacy's page on success
     * <br> an empty {@code ArrayList<Review>} otherwise
     */
    public ArrayList<Review> getAllReviews(int pharmacyId) {
        ArrayList<Review> reviews = new ArrayList<>();
        String SELECT_REVIEWS_SQL = "SELECT * FROM review WHERE pharm_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_REVIEWS_SQL)) {

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

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return reviews;
    }


    /**
     * Retrieves the average rating for a pharmacy.
     * @param pharmacyId  user_id column of a pharmacy tuple
     * @return a {@code double} on success or {@code 0.0} by default
     */
    public double getAverageRating(int pharmacyId) {
        double averageRating = 0.0;
        String SELECT_AVERAGE_RATING_SQL = "SELECT AVG(rating) AS average_rating FROM review WHERE pharm_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(SELECT_AVERAGE_RATING_SQL)) {

            ps.setInt(1, pharmacyId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                averageRating = rs.getDouble("average_rating");
            }

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return averageRating;
    }


    /**
     * Checks to see if a customer has already posted a review on a pharmacy page.
     * @param pharmacyId  user_id of the pharmacy
     * @param customerId  user_id of the customer
     * @return {@code > 0} if review already posted and {@code 0} otherwise
     */
    public int hasPostedReview(int pharmacyId, int customerId) {
        int hasPosted = 0;
        String CHECK_REVIEW_SQL = "SELECT COUNT(*) AS count FROM review WHERE pharm_id = ? AND customer_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(CHECK_REVIEW_SQL)) {

            ps.setInt(1, pharmacyId);
            ps.setInt(2, customerId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                hasPosted = rs.getInt("count");
            }

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return hasPosted;
    }


    /**
     * Updates a review in the review table of the pharmafinder database.
     * @param review  object storing content and rating information
     * @return {@code > 0} on success and {@code 0} on failure
     */
    public int updateReview(Review review) {
        int status = 0;
        String UPDATE_REVIEW_SQL = "UPDATE review SET content = ?, rating = ?, last_updated = NOW() " +
                "WHERE customer_id = ? AND pharm_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(UPDATE_REVIEW_SQL)) {

            ps.setString(1, review.getContent());
            ps.setInt(2, review.getRating());
            ps.setInt(3, review.getCustomerId());
            ps.setInt(4, review.getPharmacyId());
            status = ps.executeUpdate();

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return status;
    }


    /**
     * Deletes a review from the review table of the pharmafinder database.
     * @param review  object storing pharm_id and customer_id for the review
     * @return {@code > 0} on success and {@code 0} on failure
     */
    public int deleteReview(Review review) {
        int status = 0;
        String DELETE_REVIEW_SQL = "DELETE FROM review WHERE pharm_id = ? AND customer_id = ?";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(DELETE_REVIEW_SQL)) {

            ps.setInt(1, review.getPharmacyId());
            ps.setInt(2, review.getCustomerId());
            status = ps.executeUpdate();

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return status;
    }


    /**
     * Retrieves all reviews made by a customer.
     * @param userId  user_id column of a customer tuple
     * @return an {@code ArrayList<Review>} containing all reviews made by the customer on success
     * <br> an empty {@code ArrayList<Review>} otherwise
     */
    public ArrayList<Review> getReviewList(int userId) {
        ArrayList<Review> reviews = new ArrayList<>();
        String LIST_REVIEW_SQL = "SELECT r.content, r.review_id, r.last_updated, r.rating, p.name AS pharmacy_name,r.pharm_id " +
                "FROM review r JOIN pharmacy p ON r.pharm_id = p.user_id " +
                "WHERE r.customer_id = ? ORDER BY r.last_updated DESC";

        try (Connection con = Utilities.createSQLConnection();
             PreparedStatement ps = con.prepareStatement(LIST_REVIEW_SQL)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
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

        } catch (SQLException e) {
            Utilities.printSQLException(e);
        }

        return reviews;
    }

}
