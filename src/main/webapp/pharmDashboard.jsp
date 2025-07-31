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
    <title>Pharmacy Dashboard</title>


    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp"
            crossorigin="anonymous">
    <style>
        /*table containers*/
        .pharmDashBorder {


            background-color: whitesmoke;
            border-radius: 25px;
            width: fit-content;
            height: fit-content;
            padding: 20px;
            box-shadow: 10px 5px 5px grey;


        }

        /*centers main information*/
        .center1 {
            display: flex;
            align-items: flex-start;
            justify-content: center;
            width: 100vw;
        }

        /*medication table style*/


        .medStyle {
            list-style-type: none;
            display: flex;
            width: 90vw;
            padding: 20px;
            justify-content: space-between;
        }

        /*for delete and edit button*/

        .functionOptions {
            display: flex;
            justify-content: space-around;
            width: 70px;
        }

        /* for stars */
        .checked {
            color: #f7d792;
        }
    </style>
</head>


<body>
<%--NAVIGATION BAR --%>
<nav class=" bg-body-tertiary navbar">
    <div class="navstart">
        <%--ICON--%>
        <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35"
             fill="currentColor" class="bi bi-prescription2" viewBox="0 -4 20 25">
            <path d="M7 6h2v2h2v2H9v2H7v-2H5V8h2z"></path>
            <path
                    d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1v10.5a1.5 1.5 0 0 1-1.5 1.5h-7A1.5 1.5 0 0 1 3 14.5V4a1 1 0 0 1-1-1zm2 3v10.5a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5V4zM3 3h10V1H3z"></path>
        </svg>


        <a class="navstart homePage" href="index.jsp">PharmaFinder</a>


    </div>
    <div class="navend">
        <a class="formPath logoutButton" href="logout">Log Out</a>
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


<h1>Welcome, <%=pharmacy.getPharmacyName()%>
</h1>

<div style="width: 100vw; display: flex; justify-content: flex-end; gap: 20px; padding-right: 80px; margin-top: 20px;">
    <!-- Edit Info Button -->
    <a href="pharmInfoUpdate.jsp" class="btn btn-primary">
        ✏️ Edit Info
    </a>

    <!-- Reset Password Button -->
    <a href="pharmResetPassword.jsp" class="btn btn-warning">
        🔒 Reset Password
    </a>

    <!-- Delete Account Button with Confirmation -->
    <button type="button" class="btn btn-danger" onclick="openDeleteModal()">
        🗑 Delete Account
    </button>

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



<div class="center1">

    <div class=" pharmDashBorder">
        <%--information display--%>

        <table>
            <tr>
                <th>User ID</th>
                <td><%=pharmacy.getUserId()%>
                </td>

            </tr>
            <tr>
                <th>Tax Number</th>
                <td><%=pharmacy.getTaxNum()%>
                </td>
            </tr>

            <%
                String phoneNumber = pharmacy.getPhoneNumber();
                String faxNumber = pharmacy.getFaxNumber();
                String webUrl = pharmacy.getWebURL();

            %>
            <tr>
                <th>Phone Number</th>
                <td><%
                    if (phoneNumber == null || phoneNumber.isEmpty())
                        phoneNumber = "N/A";
                %><%=phoneNumber%>
                </td>
            </tr>
            <tr>
                <th>Fax Number</th>
                <td><%
                    if (faxNumber == null || faxNumber.isEmpty())
                        faxNumber = "N/A";
                %><%=faxNumber%>
                </td>
            </tr>
            <tr>
                <th>Website</th>
                <td><%
                    if (webUrl == null || webUrl.isEmpty()) {
                        webUrl = "N/A";
                %>
                    <%=webUrl%>
                    <% } else {%>
                    <a href="<%=pharmacy.getWebURL()%>"><%=pharmacy.getWebURL()%>
                    </a>
                    <%}%>
                </td>
            </tr>
            <tr>
                <th>Operating Hours</th>
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
                </td>
            </tr>
            <tr>
                <th>Address</th>
                <td><%=pharmacy.getAddress()%>
                </td>
            </tr>
            <tr>
                <th>Rating</th>
                <td>
                    <!-- Library for star-->
                    <link rel="stylesheet"
                          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
                    <span class="fa fa-star-o star1 checked"></span>
                    <span class="fa fa-star-o star2 checked"></span>
                    <span class="fa fa-star-o star3 checked"></span>
                    <span class="fa fa-star-o star4 checked"></span>
                    <span class="fa fa-star-o star5 checked"></span>
                </td>
            </tr>
        </table>
    </div>
</div>
<%
    String error = request.getParameter("error");
    if ("invalid_credentials".equals(error)) {
%>
<div style="background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb;
                padding: 10px; margin: 20px auto; width: fit-content; border-radius: 6px;">
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

            <ul class="pharmDashBorder medStyle">
                <li>Manufacturer: <%=meds.getManufName()%>
                </li>
                <li>Medication Id: <%=meds.getMedId()%>
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
    for (i = 1; i < starRating; i++) {
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
    setTimeout(function () {
        const alertBox = document.querySelector("div[style*='f8d7da']");
        if (alertBox) alertBox.style.display = 'none';
    }, 2500);
</script>

</body>
</html>
