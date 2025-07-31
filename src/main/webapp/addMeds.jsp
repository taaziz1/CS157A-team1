<%@ page import="usermanagement.dao.MedicationDao" %>
<%@ page import="usermanagement.model.Medication" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: anilgm
  Date: 7/25/25
  Time: 1:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%--LINKS TO THE CSS PAGE--%>
    <link rel="stylesheet" href="style.css" type="text/css">

    <%--TO LINK BOOTSTRAP--%>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp"
            crossorigin="anonymous">

    <title>Add Medication</title>
</head>
<body>
<%--NAVIGATION BAR--%>
<nav class=" bg-body-tertiary navbar">
    <div class="navstart">
        <%--ICON--%>
        <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35"
             fill="currentColor" class="bi bi-prescription2" viewBox="0 -4 20 25">
            <path d="M7 6h2v2h2v2H9v2H7v-2H5V8h2z"></path>
            <path
                    d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1v10.5a1.5 1.5 0 0 1-1.5 1.5h-7A1.5 1.5 0 0 1 3 14.5V4a1 1 0 0 1-1-1zm2 3v10.5a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5V4zM3 3h10V1H3z"></path>
        </svg>

        <a  class="navstart homePage" href="index.jsp">PharmaFinder</a>
    </div>
</nav>
<%
String userId =request.getParameter("user_id");
%>
<%--LOG IN--%>
<main class="form-signin w-100 m-auto">
    <div class="bubble">
        <form action="addMed" method="post">
            <input type="hidden" name="user_id" value="<%= userId %>" />
            <h1 class="h3 mb-3 fw-normal">Add medication</h1>
            <div> <label for="med" class="form-label">Medication Name </label> <select class="form-select" id="med" name="med_id" required/>
                <option value="">Choose...</option>
                <%
                    MedicationDao medicationDao = new MedicationDao();
                    List<Medication> medications = medicationDao.listMeds();
                    for(int i =0;i<medications.size();i++){
                        Medication med = medications.get(i);
                %>

                <option value="<%= med.getMedId() %>"><%=med.getMedName()%></option>
<%}%>
                 </select>
               </div>
            <div class="form-floating">
                <input type="text" class="form-control" id="Price" title="Please add valid price, #.##" pattern="^\d+\.\d{2}$" name="price" required > <label for="Price">Price</label>
            </div>
            <div class="form-floating">
                <input type="number" class="form-control" id="Quantity"  min="0" name="quantity" required> <label for="Quantity">Quantity</label>
            </div>
            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) { %>
            <div style="color: red; font-weight: bold;"><%= errorMessage %></div>
            <% } %>

            <input class="btn btn-primary w-100 py-2 " type="submit" value="Add Medication ">
            <a href="loginPharmacySuccess.jsp"class="btn  w-100 py-2 ">Cancel<a>

        </form>
    </div>
</main>

</body>
</html>
