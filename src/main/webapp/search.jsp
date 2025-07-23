<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>


<%@ page import="util.Utilities" %>
<%@ page import="java.sql.*" %>

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

    <%--Set tab title as the search query--%>
    <script>
        const paramsString = window.location.search;
        const searchParams = new URLSearchParams(paramsString);
        if ((q = searchParams.get("query")) != null) {
            document.getElementById("title").innerText = q + " - Search Results";
        } else {
            document.getElementById("title").innerText = "Invalid Search";
        }
    </script>

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

        <%--Print out search results for a given medication or type--%>
        <%
            String searchQuery = request.getParameter("query");
            String searchCategory = request.getParameter("cat");

            //If the search was for a medication
            if("Medication".equals(searchCategory) && searchQuery != null) {

                //Query the database for the user_id, pharmacy name, address, quantity, and price for the desired medication
                String SEARCH_MED_SQL = "SELECT user_id, pharmacy.name, " +
                        "CONCAT(street_address, ', ', city, ', ', state, ', ', zip_code), " +
                        "quantity, price " +
                        "FROM pharmacy NATURAL JOIN sells NATURAL JOIN address " +
                        "JOIN medication USING(med_id) WHERE medication.name = ?";
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                            Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
                    PreparedStatement ps = con.prepareStatement(SEARCH_MED_SQL, PreparedStatement.RETURN_GENERATED_KEYS);
                    ps.setString(1, searchQuery);

                    ResultSet rs = ps.executeQuery();

                    //If the query returned nothing
                    if (!rs.isBeforeFirst()) {
                        out.println(String.format("<h3 style=\"margin: 0.4rem; text-align: center;\">No pharmacies found for %s.</h3>", searchQuery));
                    }

                    //If at least one pharmacy was returned by the query
                    else {
                        out.println(String.format("<h3 style=\"margin: 0.6rem;\">Pharmacies for %s</h3>", searchQuery));

                        while (rs.next()) {
                            int pharmId = rs.getInt(1);
                            String name = rs.getString(2);
                            String address = rs.getString(3);
                            int quantity = rs.getInt(4);
                            double price = rs.getDouble(5);

                            //Create a hyperlinked box for each pharmacy
                            out.println(String.format("<div class=\"card\" onclick=\"location.href='/PharmaFinder/pharmacy.jsp?p=%d';\" " +
                                    "style=\"width: 26rem; cursor: pointer; margin: 1.2rem;\">\n" +
                                    "<div class=\"card-body\">\n" +
                                    "<h4 class=\"card-title\">%s</h4>\n" +
                                    "<h6 class=\"card-title\">%s</h6>\n" +
                                    "<p class=\"card-text\">Quantity: %d, Price: %.2f</p>\n" +
                                    "</div>\n" +
                                    "</div>", pharmId, name, address, quantity, price));
                        }
                    }

                    con.close();
                } catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                }
            }

            //If the query was for a type
            else if("Type".equals(searchCategory) && searchQuery != null) {

                //Query the database for medication names matching the desired type
                String SEARCH_TYPE_SQL = "SELECT medication.name FROM medication NATURAL JOIN categorized_as " +
                        "JOIN type USING(type_id) WHERE type.name = ?";
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                            Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
                    PreparedStatement ps = con.prepareStatement(SEARCH_TYPE_SQL, PreparedStatement.RETURN_GENERATED_KEYS);
                    ps.setString(1, searchQuery);

                    ResultSet rs = ps.executeQuery();

                    //If the query returned nothing
                    if (!rs.isBeforeFirst()) {
                        out.println(String.format("<h3 style=\"margin: 0.4rem; text-align: center;\">No medications found for %s.</h3>", searchQuery));
                    }

                    //If at least one medication was returned by the query
                    else {
                        out.println(String.format("<h3 style=\"margin: 0.6rem;\">%ss</h3>", searchQuery));

                        while (rs.next()) {
                            String medName = rs.getString(1);

                            //Create a hyperlinked box for each medication
                            out.println(String.format("<div class=\"card\" onclick=\"location.href='/PharmaFinder/search.jsp?query=%s&cat=Medication';\" " +
                                    "style=\"width: 12rem; cursor: pointer; text-align: center; margin: 1.2rem;\">\n" +
                                    "<div class=\"card-body\">\n" +
                                    "<h4 class=\"card-title\">%s</h4>\n" +
                                    "</div>\n" +
                                    "</div>", medName, medName));
                        }
                    }

                    con.close();
                } catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                }
            }

            //If the url search query parameters are invalid
            else {
                out.println("<h3 style=\"margin: 0.4rem; text-align: center;\">Invalid Search</h3>");
            }
        %>
    </div>

</body>
</html>
