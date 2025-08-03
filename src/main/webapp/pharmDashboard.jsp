<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="usermanagement.dao.PharmacyDao" %>
<%@ page import="usermanagement.model.Pharmacy" %>
<%@ page import="usermanagement.dao.MedicationDao" %>
<%@ page import="usermanagement.model.Medication" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="style.css" type="text/css">
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    >
    <title>Pharmacy Dashboard</title>


    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp"
            crossorigin="anonymous">
    <style>
        /* ==================== Resets & Globals ==================== */
        *,
        *::before,
        *::after {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            overflow-x: hidden; /* guard against stray overflow */
        }

        /* ===================== Navigation Bar ==================== */

        /* middle slot for buttons */
        .navcenter {
            flex: 1;
            display: flex;
            justify-content: center;
            gap: 25px;
            margin-right: 45px;
        }


        /* ==================== Layout Wrappers ==================== */
        /* Center the card wrapper */
        .center1 {
            display: flex;
            justify-content: center;
            padding: 1rem;
            width: auto; /* allow it to shrink */
        }

        /* Card container */
        .pharmDashBorder {
            background-color: #fff;
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
            width: 100%;
            max-width: 1450px;  /* cap width */
            margin: 1rem auto;  /* vertical spacing + center */
        }

        /* ==================== Table Styling ==================== */
        .info-table {
            border-collapse: collapse;
            table-layout: fixed; /* equal-width columns */
            word-wrap: break-word;
            background-color: #fff;
        }

        .info-table thead th {
            background-color: #fff;
            color: #333;
            font-weight: bold;
            border-bottom: 2px solid #dee2e6;
            text-align: center;
            padding: 0.75rem 1.25rem;
        }

        .info-table th,
        .info-table td {
            padding: 0.75rem 1.25rem;
            border-top: none;
            border-bottom: 1px solid #e9ecef;
            vertical-align: middle;
        }

        .info-table tbody tr:last-child th,
        .info-table tbody tr:last-child td {
            border-bottom: none;
        }

        /* Remove Bootstrap row/col gutters inside <dl class="row"> */
        .info-table dl.row {
            margin-left: 0 !important;
            margin-right: 0 !important;
        }
        .info-table dl.row .col-sm-4,
        .info-table dl.row .col-sm-8 {
            padding-left: 0 !important;
            padding-right: 0 !important;
        }
        .info-table dl.row dt,
        .info-table dl.row dd {
            margin: 0;
            padding: 0.25rem 0;
        }

        /* ==================== Hours List ==================== */
        .hours-list {
            list-style: none;
            margin: 0;
            padding: 0;
        }
        .hours-list li {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            border-bottom: 1px solid #e9ecef;
        }
        .hours-list li:last-child {
            border-bottom: none;
        }

        /* ==================== Stars & Ratings ==================== */
        .checked {
            color: orange; /* orange stars */
        }

        /* ==================== Utility Classes ==================== */
        .align-middle {
            vertical-align: middle !important;
        }
        .table_header {
            text-align: right;
            font-size: large;
            padding: 0.75rem 1rem;
        }
        .table_data {
            text-align: left;
            font-size: medium;
        }

        /*medication table style*/

        .medDashBorder {
            background-color: whitesmoke;
            border-radius: 25px;
            width: fit-content;
            padding: 20px;
            box-shadow: 10px 5px 5px grey;
        }

        .medStyle {
            list-style-type: none;
            display: flex;
            width: 90vw;
            padding: 20px;
            justify-content: space-between;
        }

        /* force text for each medication listing to line up*/
        .medStyle li {
            display: inline-block;
        }
        .medStyle li:nth-child(1) {
            width: 40%;
        }
        .medStyle li:nth-child(2) {
            width: 30%;
        }
        .medStyle li:nth-child(3) {
            width: 20%;
        }
        .medStyle li:nth-child(4) {
            width: 10%;
        }

        /*for delete and edit button*/

        .functionOptions {
            display: flex;
            justify-content: space-around;
            width: 70px;
        }

    </style>
</head>


<body>
<%--NAVIGATION BAR --%>
<nav class="bg-body-tertiary navbar">
    <div class="navstart">
        <%--ICON--%>
        <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-prescription2" viewBox="0 -4 20 25">
            <path d="M7 6h2v2h2v2H9v2H7v-2H5V8h2z"></path>
            <path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1v10.5a1.5 1.5 0 0 1-1.5 1.5h-7A1.5 1.5 0 0 1 3 14.5V4a1 1 0 0 1-1-1zm2 3v10.5a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5V4zM3 3h10V1H3z"></path>
        </svg>
        <a class="homePage" href="index.jsp">PharmaFinder</a>
    </div>

    <div class="navcenter">
        <a href="pharmInfoUpdate.jsp" class="btn btn-primary">✏️ Edit Info</a>
        <button type="button" onclick="openResetModal()" class="btn btn-warning">🔒 Reset Password</button>
        <button type="button" onclick="openDeleteModal()" class="btn btn-danger">🗑 Delete Account</button>
    </div>

    <div class="navend">
        <a class="btn btn-outline-danger" style="margin-right:8px;" href="logout">Logout</a>
    </div>
</nav>



<%-- DASHBOARD CONTENT --%>


<%
    int userId = (int) session.getAttribute("user_id");
    PharmacyDao pharmacyDao = new PharmacyDao();
    Pharmacy pharmacy = pharmacyDao.getPharmacyDashboard(userId);
    MedicationDao medicationDao = new MedicationDao();
    List<Medication> medication = medicationDao.getMedication(userId);
%>

<!-- Reset Password Modal -->
<div id="resetPasswordModal" style="display:none; position: fixed; top: 0; left: 0; width: 100vw; height: 100vh;
  background-color: rgba(0, 0, 0, 0.5); justify-content: center; align-items: center; z-index: 9999;">

    <form action="pharmResetPassword" method="post" class="needs-validation" novalidate=""
          style="background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px #333; width: 400px;"
          class="needs-validation" novalidate>

        <h3 style="margin-bottom: 20px;">🔒 Reset Your Password</h3>

        <input type="hidden" name="user_id" value="<%= session.getAttribute("user_id") %>">

        <!-- Tax Number -->
        <label for="tax_Number" style="font-weight: bold;">Tax Number</label>
        <input type="text" id="tax_Number" name="tax_Number" required
               placeholder="Enter Tax Number"
               style="padding: 8px; width: 100%; margin: 8px 0 16px 0;">

        <!-- Current Password -->
        <label for="current_password" style="font-weight: bold;">Current Password</label>
        <input type="password" id="current_password" name="current_password" required
               placeholder="Enter Current Password"
               style="padding: 8px; width: 100%; margin: 8px 0 16px 0;">

        <!-- New Password -->
        <label for="new_password" style="font-weight: bold;">New Password</label>
        <input
                type="password"
                id="new_password"
                name="new_password"
                required
                pattern="(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}"
                title="Password must contain at least one uppercase letter, one lowercase letter, one number, one special character, and be at least 8 characters long."
                placeholder="Enter New Password"
                style="padding: 8px; width: 100%; margin: 8px 0 20px 0;">
        <div class="invalid-feedback">
            Password must contain at least one uppercase, one lowercase, one number, one special character (@, $, !, %, *, ?, &), and be 8+ characters long.
        </div>

        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
        <div style="color: red; font-weight: bold; margin-bottom: 16px;"><%= errorMessage %></div>
        <% } %>

        <!-- Buttons -->
        <div style="display: flex; justify-content: flex-end; gap: 10px;">
            <button type="submit" class="comment-submit" style="background-color: #0d6efd; color: white;">Change Password</button>
            <button type="button" class="comment-submit" onclick="closeResetModal()">Cancel</button>
        </div>
    </form>
</div>

<!-- Modal -->
<div id="deleteModal" style="display:none; position: fixed; top: 0; left: 0; width: 100vw; height: 100vh;
  background-color: rgba(0, 0, 0, 0.5); justify-content: center; align-items: center; z-index: 9999;">
    <form action="deletePharmacyAccount" method="POST"
          style="background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px #333;"
          onsubmit="return confirm('Are you sure you want to delete your account? This action cannot be undone.')">
        <h4>Please enter your tax number to confirm:</h4>
        <input type="hidden" name="user_id" value="<%= pharmacy.getUserId() %>">
        <input type="text" name="taxNumber" required placeholder="Enter Tax Number"
               style="padding: 8px; width: 100%; margin-top: 10px; margin-bottom: 20px;">
        <h4>Please enter your password to confirm:</h4>
        <input type="password" name="password" required placeholder="Enter password"
               style="padding: 8px; width: 100%; margin-top: 10px; margin-bottom: 20px;">

        <div style="display: flex; justify-content: flex-end; gap: 10px;">
            <button type="submit" class="comment-submit" style="background-color: #dc3545;">Confirm Delete</button>
            <button type="button" class="comment-submit" onclick="closeDeleteModal()">Cancel</button>
        </div>
    </form>
</div>

<h1 style="width: fit-content; font-size: 2.5rem; background-color: white; margin:20px auto 0; padding:10px 25px; border-radius:80px;">Welcome, <%=pharmacy.getPharmacyName()%></h1>

<div class="center1">
    <div class="pharmDashBorder">
        <table class="table table-hover table-borderless mb-0 info-table align-middle">
            <thead class="table-light">
            <tr>
                <th colspan="2" class="text-center">
                    <h2 class="mb-0">Pharmacy Details</h2>
                </th>
            </tr>
            </thead>
            <tbody>
            <%
                String phoneNumber = pharmacy.getPhoneNumber();
                if (phoneNumber == null || phoneNumber.isEmpty()) phoneNumber = "N/A";
                String faxNumber = pharmacy.getFaxNumber();
                if (faxNumber == null || faxNumber.isEmpty()) faxNumber = "N/A";
                String webUrl = pharmacy.getWebURL();
                String hours = pharmacy.getOperatingHours();
                String[] timings = (hours != null) ? hours.split(",") : new String[0];
                String[] daysOfWeek = {
                        "Monday","Tuesday","Wednesday",
                        "Thursday","Friday","Saturday", "Sunday"
                };
            %>
            <tr>
                <th>Phone Number</th>
                <td><%= phoneNumber %></td>
            </tr>
            <tr>
                <th>Fax Number</th>
                <td><%= faxNumber %></td>
            </tr>
            <tr>
                <th>Website</th>
                <td>
                    <% if (webUrl == null || webUrl.isEmpty()) { %>
                    N/A
                    <% } else { %>
                    <a href="<%= webUrl %>" target="_blank" rel="noopener"><%= webUrl %></a>
                    <% } %>
                </td>
            </tr>
            <tr>
                <th>Operating Hours</th>
                <td>
                    <dl class="row mb-0">
                        <% for (int i = 0; i < timings.length && i < daysOfWeek.length; i++) { %>
                        <dt class="col-sm-4"><%= daysOfWeek[i] %></dt>
                        <dd class="col-sm-8"><%= timings[i] %></dd>
                        <% } %>
                    </dl>
                </td>
            </tr>
            <tr>
                <th>Address</th>
                <td><%= pharmacy.getAddress() %></td>
            </tr>
            <tr>
                <th>Rating</th>
                <td class="rating">
                    <span class="fa fa-star-o star1 checked"></span>
                    <span class="fa fa-star-o star2 checked"></span>
                    <span class="fa fa-star-o star3 checked"></span>
                    <span class="fa fa-star-o star4 checked"></span>
                    <span class="fa fa-star-o star5 checked"></span>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<%
    String error = request.getParameter("error");
    if ("invalid_credentials".equals(error)) {
%>
<div id="errorPopup">
    ❌ Incorrect credentials. Please try again.
</div>
<%
    }
%>



<div style="display: block;">
    <hr style="width: 90%;  margin:30px ;">
    <%--medication display--%>
    <div style="margin-left: 20px;">
        <div>
            <h4 class="navstart"> Medications</h4>
            <%--add medication--%>
            <div class="navend" style="margin-right:50px;">
                <form method="get" action="addMeds.jsp" style="display: inline;">
                    <input type="hidden" name="user_id" value="<%=userId%>"/>
                    <button type="submit"  style="background: none; border: none; padding: 0;"><strong>
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                     class="bi bi-plus-square" viewBox="0 0 16 16">
                    <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z"/>
                    <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
                </svg>
                        </strong>
                    </button>
                    </form>
            </div>

            <%
                for (int i = 0; i < medication.size(); i++) {
                    Medication meds = medication.get(i);
            %>

            <ul class="medDashBorder medStyle">
                <li>Manufacturer: <%=meds.getManufName()%>
                </li>
                <li>Medicine: <%=meds.getMedName()%>
                </li>
                <li>Price: $<%=String.format("%.2f", meds.getPrice()) %>
                </li>
                <li>Qty: <%=meds.getQuantity()%>
                </li>
                <div class="functionOptions">
                    <%--edit function--%>
                    <li>
                        <form method="get" action="medEditPage.jsp" style="display: inline;">
                            <input type="hidden" name="med_id" value="<%=meds.getMedId()%>"/>
                            <input type="hidden" name="user_id" value="<%=userId%>"/>
                            <button type="submit" style="background: none; border: none; padding: 0;">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                     class="bi bi-pen-fill" viewBox="0 0 16 16">
                                    <path d="m13.498.795.149-.149a1.207 1.207 0 1 1 1.707 1.708l-.149.148a1.5 1.5 0 0 1-.059 2.059L4.854 14.854a.5.5 0 0 1-.233.131l-4 1a.5.5 0 0 1-.606-.606l1-4a.5.5 0 0 1 .131-.232l9.642-9.642a.5.5 0 0 0-.642.056L6.854 4.854a.5.5 0 1 1-.708-.708L9.44.854A1.5 1.5 0 0 1 11.5.796a1.5 1.5 0 0 1 1.998-.001"/>
                                </svg>
                            </button>
                        </form>
                    </li>

                    <%--delete function--%>
                    <li>
                        <form method="post" action="deleteMedication" style="background:none;border:none;"
                              onsubmit="return confirmDelete();">
                            <input type="hidden" name="med_id" value="<%=meds.getMedId()%>"/>
                            <input type="hidden" name="user_id" value="<%=userId%>"/>
                            <button type="submit" style="background: none; border: none; padding: 0;">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                     class="bi bi-trash3-fill" viewBox="0 0 16 16">
                                    <path d="M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06m6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528M8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5"/>
                                </svg>
                            </button>
                        </form>
                    </li>

                </div>
            </ul>

            <%
                }
            %>
        </div>
    </div>
</div>


<script>
    //Display stars for rating
    let starRating = "<%=pharmacy.getRating()%>";

    let i;
    for (i = 1; i <= starRating; i++) {
        let star = document.querySelector(".star" + i);
        star.setAttribute("class", "fa fa-star checked");
    }

    if(starRating - Math.floor(starRating) >= 0.5) {
        let star = document.querySelector(".star" + i);
        star.setAttribute("class", "fa fa-star-half-full checked");
    }

    //deletion Confirmation
    function confirmDelete() {
        return confirm("Are you sure you want to delete this medication?")
    }

</script>

<script>
    function openDeleteModal() {
        document.getElementById("deleteModal").style.display = "flex";
    }

    function closeDeleteModal() {
        document.getElementById("deleteModal").style.display = "none";
    }
</script>

<script>
    function openResetModal() {
        document.getElementById("resetPasswordModal").style.display = "flex";
    }
    function closeResetModal() {
        document.getElementById("resetPasswordModal").style.display = "none";
    }
</script>

<script>
    setTimeout(() => {
        const popup = document.getElementById('errorPopup');
        if (popup) popup.style.display = 'none';
    }, 3000); // 3 seconds
</script>

<%
    Boolean openResetModal = (Boolean) request.getAttribute("openResetModal");
%>

<script>
    window.onload = function () {
        <% if (openResetModal != null && openResetModal) { %>
        openResetModal(); // Call your JS function to show the modal
        <% } %>
    }
</script>

<script>
    // Bootstrap form validation
    (function () {
        'use strict'
        const forms = document.querySelectorAll('.needs-validation')
        Array.from(forms).forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()
</script>

</body>
</html>
