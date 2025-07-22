<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>


<%@ page import="util.Utilities" %>
<%@ page import="java.sql.*" %>
<%@ page import="usermanagement.dao.PharmacyDao" %>
<%@ page import="usermanagement.model.Pharmacy" %>



<!DOCTYPE html>
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

    <title id="title"> </title>

    <style>
        .table_header{
            text-align: right;
            font-size: large;
            padding: 0.75rem 1rem 0.75rem;
        }
        .table_data{
            text-align: left;
            font-size: medium;
        }
    </style>

</head>

<body>

<%--NAVIGATION BAR --%>
<div class="fullscreen">
    <nav class=" bg-body-tertiary navbar">
        <div class="navstart">
            <%--ICON--%>
            <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-prescription2" viewBox="0 -4 20 25">
                <path d="M7 6h2v2h2v2H9v2H7v-2H5V8h2z"></path>
                <path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1v10.5a1.5 1.5 0 0 1-1.5 1.5h-7A1.5 1.5 0 0 1 3 14.5V4a1 1 0 0 1-1-1zm2 3v10.5a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5V4zM3 3h10V1H3z"></path>
            </svg>

            <a class="navstart homePage" style = "font-weight:bold;" href="index.jsp">PharmaFinder</a>
        </div>

        <div class="navend">
            <%
                String pharmacyName = (String) session.getAttribute("username");
                if (session != null && session.getAttribute("user_id") != null) {
            %>
            <span class="me-2">Welcome, <strong><%= pharmacyName %></strong></span>
            <a href="logout" class="btn btn-outline-danger">Logout</a>
            <%
                }
            %>
        </div>
    </nav>

    <%
        Pharmacy pharmacy = null;
        int userId = Integer.parseInt(request.getParameter("p"));
        PharmacyDao pharmacyDao = new PharmacyDao();
        pharmacy = pharmacyDao.getPharmacyDashboard(userId);
    %>

    <div class="card" style="margin: 1.8rem;">
        <div class="card-header">
            <h2 class="card-title" style="margin: 0.5rem; text-align: left;"><%=pharmacy.getPharmacyName()%> - <%=pharmacy.getAddress()%></h2>
        </div>
        <div class="card-body">
            <table>
                <tr>
                    <th class="table_header">Website</th>
                    <td class="table_data"><a href="<%=pharmacy.getWebURL()%>"><%=pharmacy.getWebURL()%></a></td>
                </tr>
                <tr>
                    <th class="table_header">Phone Number</th>
                    <td class="table_data"><%=pharmacy.getPhoneNumber()%></td>
                </tr>
                <tr>
                    <th class="table_header">Fax Number</th>
                    <td class="table_data"><%=pharmacy.getFaxNumber()%></td>
                </tr>
                <tr>
                    <th class="table_header">Operating Hours</th>
                    <td class="table_data"><%=pharmacy.getOperatingHours()%></td>
                </tr>
            </table>
        </div>
    </div>

    <div class="card" style="margin: 1.8rem;">
        <div class="card-header">
            <h2 class="card-title" style="margin: 0.5rem; text-align: left;">Stock</h2>
        </div>
        <div class="card-body">
            <%
                String SEARCH_SOLD_MEDS = "SELECT name, quantity, price " +
                        "FROM medication NATURAL JOIN sells WHERE user_id = ?";
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                            Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
                    PreparedStatement ps = con.prepareStatement(SEARCH_SOLD_MEDS, PreparedStatement.RETURN_GENERATED_KEYS);
                    ps.setInt(1, userId);

                    ResultSet rs = ps.executeQuery();

                    //If the pharmacy sells any medications
                    if (rs.isBeforeFirst()) {
                        while (rs.next()) {
                            String medName = rs.getString(1);
                            int quantity = rs.getInt(2);
                            double price = rs.getDouble(3);

                            //Create a box for each medication listing
                            out.println(String.format("<div class=\"card\" style=\"width: 26rem; margin: 1.2rem;\">\n" +
                                    "<div class=\"card-body\">\n" +
                                    "<h4 class=\"card-title\">%s</h4>\n" +
                                    "<p style=\"font-size: x-large\" class=\"card-text\">$%.2f - <span style=\"color: red\">%d</span> in stock</p>\n" +
                                    "</div>\n" +
                                    "</div>", medName, price, quantity));
                        }
                    }

                    con.close();
                } catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                }
            %>
        </div>
    </div>
</div>

<%--Set tab title as the search query--%>
<script>
    if ((q = "<%=pharmacy.getPharmacyName()%>") !== "null") {
        document.getElementById("title").innerText = q;
    } else {
        document.getElementById("title").innerText = "Invalid Search";
    }
</script>

</body>

</html>