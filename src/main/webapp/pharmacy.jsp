<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="util.Utilities" %>
<%@ page import="java.sql.*" %>
<%@ page import="usermanagement.dao.PharmacyDao" %>
<%@ page import="usermanagement.model.Pharmacy" %>
<%@ page import="usermanagement.dao.ReviewDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="usermanagement.model.Review" %>
<%@ page import="usermanagement.model.Customer" %>
<%@ page import="usermanagement.dao.CustomerDao" %>
<%@ page import="java.util.Collections" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">

<%-- CSS & Bootstrap Links --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="style.css" type="text/css">

    <%--TO LINK BOOTSTRAP--%>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp"
            crossorigin="anonymous">

    <title id="title"></title>

    <style>
        .table_header {
            text-align: right;
            font-size: large;
            padding: 0.75rem 1rem 0.75rem;
        }

        .table_data {
            text-align: left;
            font-size: medium;
        }

        .checked {
            color: orange;
        }

        /* === Dropdown Menu for Reviews === */
        /* === DO NOT PUT THIS IN CSS FILE OR IT WILL NOT WORK === */
        .dropdown {
            position: absolute;
            top: 15px;
            right: 15px;
        }

        .dropdown .dots-button {
            all: unset;
            display: flex;
            justify-content: center;
            align-items: center;
            width: 32px;
            height: 32px;
            font-size: 20px;
            color: #555;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.2s ease;
            background-color: transparent !important;
        }

        .dots-button:hover {
            background-color: #e0e0e0;
        }

        .dropdown-menu {
            display: none;
            position: absolute;
            top: 36px;
            right: 0;
            background: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.08);
            z-index: 100;
            min-width: 120px;
            padding: 6px 0;
        }

        .dropdown-menu button {
            display: block;
            width: 100%;
            padding: 10px 16px;
            background: transparent;
            border: none;
            text-align: left;
            cursor: pointer;
            font-size: 0.95rem;
            color: #333;
            transition: background-color 0.15s ease;
            border-radius: 0;
        }

        .dropdown-menu button:hover {
            background-color: #f5f5f5;
        }

        /* === Modal Styling === */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 2000;
        }

        .modal-box {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            width: 400px;
        }

    </style>

</head>

<body>

<%--NAVIGATION BAR --%>
<div class="fullscreen">
    <nav class=" bg-body-tertiary navbar">
        <div class="navstart">
            <%-- App Icon --%>
            <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor"
                 class="bi bi-prescription2" viewBox="0 -4 20 25">
                <path d="M7 6h2v2h2v2H9v2H7v-2H5V8h2z"></path>
                <path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1v10.5a1.5 1.5 0 0 1-1.5 1.5h-7A1.5 1.5 0 0 1 3 14.5V4a1 1 0 0 1-1-1zm2 3v10.5a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5V4zM3 3h10V1H3z"></path>
            </svg>

            <a class="navstart homePage" style="font-weight: bold;" href="index.jsp">PharmaFinder</a>
        </div>

        <div class="navend" >
            <%--TAKE ADDRESS--%>

            <input type="text" id="location"  placeholder="Enter your location">
            <button id="submitBtnLocation">Submit</button>

        <div class="navend">
            <%-- Welcome message + Logout for logged-in users --%>
            <%
                String customerName = (String) session.getAttribute("username1");
                String pharmName = (String) session.getAttribute("username2");
                if (session != null && session.getAttribute("user_id") != null) {
                    if(customerName!=null && pharmName==null){
            %>
            <span class="me-2">Welcome, <strong><%= (pharmName != null) ? pharmName : customerName %></strong></span>

            <span class="navend " style="margin:0;padding-right: 20px;"> <a  class="formPath" href="custDashboard.jsp"><%= customerName %></a></span>
            <a href="logout" class="btn btn-outline-danger">Logout</a>
            <%
            }else if(customerName==null && pharmName!=null){
            %>
            <span class="navend" style="margin:0;padding-right: 20px;"><a class="formPath" href="loginPharmacySuccess.jsp"> <%= pharmName %></a></span>
            <a href="logout" class="btn btn-outline-danger">Logout</a>
            <%
                    }
                }
            %>

        </div>

    </nav>

    <%-- Pharmacy Data --%>
    <%
        int userId = Integer.parseInt(request.getParameter("p"));
        PharmacyDao pharmacyDao = new PharmacyDao();
        Pharmacy pharmacy = pharmacyDao.getPharmacyDashboard(userId);
    %>

    <%-- Pharmacy Info Card --%>
    <div class="card" style="margin: 1.8rem;">
        <div class="card-header">
            <h2 class="card-title" style="margin: 0.5rem; text-align: left;"><%=pharmacy.getPharmacyName()%>-<h5 class="distDisplay" style="color:green;"></h5>
            </h2>
        </div>
        <%
            String phoneNumber = pharmacy.getPhoneNumber();
            String faxNumber = pharmacy.getFaxNumber();
            String webUrl = pharmacy.getWebURL();

        %>
        <div class="card-body">
            <table>
                <tr>
                    <th class="table_header">Address</th>
                <td class="pharmDist"><%=pharmacy.getAddress()%></td>
                </tr>

                <tr>
                    <th class="table_header">Website</th>
                    <td><%
                        if (webUrl == null || webUrl.isEmpty()) {
                            webUrl = "N/A";
                    %>
                        <%=webUrl%>
                        <% } else {%>
                        <a href="<%= pharmacy.getWebURL() %>"><%= pharmacy.getWebURL() %>
                        </a>
                        <%}%>
                    </td>
                </tr>
                <tr>
                    <th class="table_header">Phone Number</th>
                    <td><%
                        if (phoneNumber == null || phoneNumber.isEmpty())
                            phoneNumber = "N/A";
                    %><%=phoneNumber%>
                    </td>
                </tr>
                <tr>
                    <th class="table_header">Fax Number</th>
                    <td><%
                        if (faxNumber == null || faxNumber.isEmpty())
                            faxNumber = "N/A";
                    %><%=faxNumber%>
                    </td>
                </tr>
                <tr>
                    <th class="table_header">Operating Hours</th>
                    <td>
                    <table>
                        <%
                            String hours = pharmacy.getOperatingHours();
                            String timings[] = hours.split(",");
                            String daysOfWeek[] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
                            for (int i = 0, j = 0; i < timings.length && j < daysOfWeek.length; i++, j++) {
                        %>
                        <tr>
                            <td><%=daysOfWeek[j]%>
                            </td>
                            <td><%=timings[i]%>
                            </td>
                        </tr>
                        <%}%>
                    </table>
                </tr>
            </table>
        </div>
    </div>

    <%-- Stock Card --%>
    <div class="card" style="margin: 1.8rem;">
        <div class="card-header">
            <h2 class="card-title" style="margin: 0.5rem; text-align: left;">Stock</h2>
        </div>
        <div class="card-body">
            <%
                String SEARCH_SOLD_MEDS = "SELECT name, quantity, price FROM medication NATURAL JOIN sells WHERE user_id = ?";
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/pharmafinder",
                            Utilities.getdbvar("user"),
                            Utilities.getdbvar("pass")
                    );
                    PreparedStatement ps = con.prepareStatement(SEARCH_SOLD_MEDS, PreparedStatement.RETURN_GENERATED_KEYS);
                    ps.setInt(1, userId);
                    ResultSet rs = ps.executeQuery();

                    // Display each medication if available
                    if (rs.isBeforeFirst()) {
                        while (rs.next()) {
                            String medName = rs.getString(1);
                            int quantity = rs.getInt(2);
                            double price = rs.getDouble(3);

                            out.println(String.format(
                                    "<div class=\"card\" style=\"width: 26rem; margin: 1.2rem;\">\n" +
                                            "<div class=\"card-body\">\n" +
                                            "<h4 class=\"card-title\">%s</h4>\n" +
                                            "<p style=\"font-size: x-large\" class=\"card-text\">$%.2f - " +
                                            "<span style=\"color: red\">%d</span> in stock</p>\n" +
                                            "</div>\n</div>", medName, price, quantity));
                        }
                    }
                    con.close();
                } catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                }
            %>
        </div>
    </div>

    <%-- Rating Card --%>
    <div class="card" style="margin: 1.8rem;">
        <div class="card-header">
            <h2 class="card-title" style="margin: 0.5rem; text-align: left;">Rating</h2>
        </div>
        <div class="card-body">
            <%
                ReviewDao reviewDao = new ReviewDao();
                double rating = reviewDao.getAverageRating(userId);
                int roundedRating = (int) Math.round(rating);

                for (int rate = 1; rate <= 5; rate++) {
                    if (rate <= roundedRating) {
                        out.println("<span class=\"fa fa-star checked\"></span>");
                    } else {
                        out.println("<span class=\"fa fa-star\"></span>");
                    }
                }
                out.println(String.format(
                        "<p style=\"font-size: x-large; margin-top: 0.5rem;\">Average Rating: %.2f</p>", rating));
            %>

            <%-- Review Form For Customers --%>
            <%
                CustomerDao customerDao = new CustomerDao();
                if (session != null && session.getAttribute("user_id") != null && customerName != null && pharmName == null) {
                    Customer currentCustomer = customerDao.getCustomerDashboard((Integer) session.getAttribute("user_id"));

                    // Only show review form if customer hasn't already posted
                    if (reviewDao.hasPostedReview(pharmacy.getUserId(), currentCustomer.getUserId()) == 0) {
            %>
            <form class="comment-box" id="commentForm" method="POST" action="postReview">
                <img class="avatar" src="<%= currentCustomer.getAvatarDirectory() %>" alt="User Avatar">

                <div class="comment-content">
                    <div class="comment-meta">
                        <div class="comment-header">
                            <div class="user-name"><%= currentCustomer.getUsername() %></div>

                            <div class="star-rating" id="star-rating">
                                <span class="fa fa-star" data-value="1"></span>
                                <span class="fa fa-star" data-value="2"></span>
                                <span class="fa fa-star" data-value="3"></span>
                                <span class="fa fa-star" data-value="4"></span>
                                <span class="fa fa-star" data-value="5"></span>
                            </div>

                            <input type="hidden" name="rating" id="rating-value">
                            <input type="hidden" name="pharmacyId" value="<%= pharmacy.getUserId() %>">
                            <input type="hidden" name="customerId" value="<%= currentCustomer.getUserId() %>">

                            <textarea class="comment-textarea" name="content" id="review-text"
                                      placeholder="Write your comment..." required></textarea>

                            <div class="comment-footer">
                                <button type="submit" class="comment-submit" onclick="return validateReview()">Post</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <%
                    }
                }
            %>

            <%-- Display all reviews --%>
            <%
                ArrayList<Review> reviews = reviewDao.getAllReviews(userId);
                Collections.sort(reviews, (r1, r2) -> r2.getLastDate().compareTo(r1.getLastDate()));

                for (Review review : reviews) {
                    Customer customer = customerDao.getCustomerDashboard(review.getCustomerId());
            %>
            <div class="comment-container">
                <img class="avatar" src="<%= customer.getAvatarDirectory() %>" alt="User Avatar">
                <div class="comment-content">
                    <div class="comment-meta">
                        <div class="username"><%= customer.getUsername() %></div>

                        <%-- Show 3-dots menu only if current user is the review owner --%>
                        <%
                            Integer currentUserId = (Integer) session.getAttribute("user_id");
                            if (currentUserId != null && currentUserId.equals(review.getCustomerId())) {
                        %>
                        <div class="dropdown">
                            <button type="button" class="dots-button" onclick="toggleDropdown(this)">
                                &#x22EE;
                            </button>
                            <div class="dropdown-menu">
                                <button type="button" class="open-edit-modal"
                                        data-review-id="<%= review.getReviewId() %>"
                                        data-review-content="<%= review.getContent().replace("\"", "&quot;") %>"
                                        data-review-rating="<%= review.getRating() %>">
                                    ✏️ Edit
                                </button>


                                <form action="deleteReview" method="POST" onsubmit="return confirm('Are you sure you want to delete this review?');">
                                    <input type="hidden" name="pharmacyId" value="<%= pharmacy.getUserId() %>">
                                    <input type="hidden" name="customerId" value="<%= currentUserId %>">
                                    <button type="submit">🗑 Delete️</button>
                                </form>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <div class="timestamp">Last updated: <%= review.getLastDate() %></div>

                    <div class="comment-text">
                        <p><%= review.getContent() %></p>
                        <div class="rating">
                            <%
                                for (int rate = 1; rate <= 5; rate++) {
                                    if (rate <= review.getRating()) {
                                        out.println("<span class=\"fa fa-star checked\"></span>");
                                    } else {
                                        out.println("<span class=\"fa fa-star\"></span>");
                                    }
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>
<% if (session != null && session.getAttribute("user_id") != null) { %>

<div id="editModal" class="modal-overlay" style="display:none;">
    <form class="comment-box" id="editForm" method="POST" action="editReview">
        <% Customer currentCustomer = customerDao.getCustomerDashboard((Integer) session.getAttribute("user_id")); %>
        <img class="avatar" src="<%= currentCustomer.getAvatarDirectory() %>" alt="User Avatar">

        <div class="comment-content">
            <div class="comment-meta">
                <div class="comment-header">
                    <div class="user-name"><%= currentCustomer.getUsername() %></div>

                    <div class="star-rating" id="modal-star-rating">
                        <span class="fa fa-star" data-value="1"></span>
                        <span class="fa fa-star" data-value="2"></span>
                        <span class="fa fa-star" data-value="3"></span>
                        <span class="fa fa-star" data-value="4"></span>
                        <span class="fa fa-star" data-value="5"></span>
                    </div>

                    <input type="hidden" name="rating" id="modal-rating-value">
                    <input type="hidden" name="pharmacyId" value="<%= pharmacy.getUserId() %>">
                    <input type="hidden" name="customerId" value="<%= currentCustomer.getUserId() %>">
</div>
<%-- jQuery--%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>

                    <textarea class="comment-textarea" name="content" id="modal-review-content"
                              placeholder="Edit your comment..." required></textarea>

                    <div class="comment-footer">
                        <button type="submit" class="comment-submit">Save</button>
                        <button type="button" class="comment-submit" onclick="closeModal()">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<% } %>

<%-- Dynamic Tab Title --%>
<script>
    if ((q = "<%= pharmacy.getPharmacyName() %>") !== "null") {
        document.getElementById("title").innerText = q;
    } else {
        document.getElementById("title").innerText = "Invalid Search";
    }


</script>
<script src="distancePharmacy.js"></script>

<%-- Star Rating and Form Validation JS --%>
<script>
    let selectedRating = 0;

    document.querySelectorAll('#star-rating .fa-star').forEach(star => {
        star.addEventListener('click', () => {
            selectedRating = parseInt(star.getAttribute('data-value'));
            updateStarDisplay(selectedRating);
            document.getElementById('rating-value').value = selectedRating;
        });
    });

    function updateStarDisplay(rating) {
        document.querySelectorAll('#star-rating .fa-star').forEach(star => {
            const val = parseInt(star.getAttribute('data-value'));
            star.classList.toggle('checked', val <= rating);
        });
    }

    function validateReview() {
        const comment = document.getElementById('review-text').value.trim();
        if (selectedRating === 0 || comment === "") {
            alert("Please select a rating and enter a comment.");
            return false;
        }
        return true;
    }
</script>

<script>
    function toggleDropdown(button) {
        const menu = button.nextElementSibling;
        const allMenus = document.querySelectorAll('.dropdown-menu');
        allMenus.forEach(m => {
            if (m !== menu) m.style.display = 'none';
        });
        menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
    }

    // Close dropdown if clicked outside
    document.addEventListener('click', function(event) {
        if (!event.target.closest('.dropdown')) {
            document.querySelectorAll('.dropdown-menu').forEach(menu => {
                menu.style.display = 'none';
            });
        }
    });
</script>

<script>
    // Open modal with review data
    document.querySelectorAll('.open-edit-modal').forEach(button => {
        button.addEventListener('click', () => {
            const reviewId = button.getAttribute('data-review-id');
            const content = button.getAttribute('data-review-content');
            const rating = parseInt(button.getAttribute('data-review-rating'));

            document.getElementById('modal-review-content').value = content;
            document.getElementById('modal-rating-value').value = rating;
            modalSelectedRating = rating;
            updateModalStars(rating);

            document.getElementById('editModal').style.display = 'flex';
        });
    });

    function closeModal() {
        document.getElementById('editModal').style.display = 'none';
    }

    // Optional: close modal on outside click
    window.addEventListener('click', (event) => {
        const modal = document.getElementById('editModal');
        if (event.target === modal) {
            closeModal();
        }
    });
</script>
<script>
    let modalSelectedRating = 0;

    document.querySelectorAll('#modal-star-rating .fa-star').forEach(star => {
        star.addEventListener('click', () => {
            modalSelectedRating = parseInt(star.getAttribute('data-value'));
            updateModalStars(modalSelectedRating);
            document.getElementById('modal-rating-value').value = modalSelectedRating;
        });
    });

    function updateModalStars(rating) {
        document.querySelectorAll('#modal-star-rating .fa-star').forEach(star => {
            const val = parseInt(star.getAttribute('data-value'));
            star.classList.toggle('checked', val <= rating);
        });
    }
</script>

</body>


</html>
