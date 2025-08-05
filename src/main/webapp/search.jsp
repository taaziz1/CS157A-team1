<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>


<%@ page import="util.Utilities" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>


<!DOCTYPE html>
<html>
<head>

    <%--TO LINK BOOTSTRAP--%>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp"
            crossorigin="anonymous">

    <%--LINKS TO THE CSS PAGE--%>
    <link rel="stylesheet" href="style.css" type="text/css">

    <title id="title"></title>
<style>
  #flexbox {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      margin: auto;
      width: 80%;
  }

  .navcenter {
      flex: 1;
      display: flex;
      position: absolute;
      align-items: center;
      justify-content: center;
      left: 40%;
      gap: 8px;
      list-style-type: none;
      margin: 0;
  }

  .pharmCard {
      width: 26rem;
      cursor: pointer;
      margin: 1.2rem;
  }
  .pharmCard:hover,.card:hover {
    transform: scale(1.03);

  }

  .pr{
    margin-bottom: 0.2rem;
  }

  .exponent1{
      font-size: 1.3rem;
      margin-left: 10px;
  }

  .price {
      font-size: 2.2rem;
      font-weight: 600;
  }
  .exponent2 {
      padding-left: 0.1rem;
      font-size: 1.3rem;
  }
  .distDisplay{
      color: grey;
      font-size: 1.2rem;
  }
</style>
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
<div>
    <nav class=" bg-body-tertiary navbar">
        <div class="navstart">
            <%--ICON--%>
            <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor"
                 class="bi bi-prescription2" viewBox="0 -4 20 25">
                <path d="M7 6h2v2h2v2H9v2H7v-2H5V8h2z"></path>
                <path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1v10.5a1.5 1.5 0 0 1-1.5 1.5h-7A1.5 1.5 0 0 1 3 14.5V4a1 1 0 0 1-1-1zm2 3v10.5a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5V4zM3 3h10V1H3z"></path>
            </svg>

            <a class="navstart homePage" style="font-weight:bold;" href="index.jsp">PharmaFinder</a>
        </div>


        <%--TAKE ADDRESS--%>
        <div class="navcenter">
            <input type="text" class="form-control me-2" id="location"  placeholder="Enter your location" style="width: 60%;">
            <button id="submitBtnLocation" style="padding:5px; background: none; border:1px solid grey; border-radius:15px; color:white;">Search</button>
        </div>


        <div class="navend">
            <%
                String customerName = (String) session.getAttribute("avatar");
                String pharmName = (String) session.getAttribute("username2");
                if (session != null && session.getAttribute("user_id") != null) {
                    if(customerName != null && pharmName == null){
            %>

            <span class="navend" style="margin:0; ">
                <a class="formPath" style="text-decoration: none;" href="custDashboard.jsp"><img src="<%= customerName %>" style="width:36px;height:36px;"></a>
            </span>
            <a href="logout" class="btn btn-outline-danger" style="margin-right:8px;">Logout</a>
            <%
            } else if (customerName == null && pharmName != null){
            %>
            <span class="navend" style="margin:0; padding-right:6px; padding-top:4px;">
                <a class="formPath" style="text-decoration: none; color: white;" href="pharmDashboard.jsp"> <%= pharmName %></a>
            </span>
            <a href="logout" class="btn btn-outline-danger" style="margin-right:23px;">Logout</a>
            <%
                    }
                }
            %>

        </div>


    </nav>


    <%--Print out search results for a given medication or type--%>
    <%


        String searchQuery = request.getParameter("query");
        String searchCategory = request.getParameter("cat");


        //If the search was for a medication
        if ("Medication".equals(searchCategory) && searchQuery != null) {

            //Query the database for the user_id, pharmacy name, address, quantity, and price for the desired medication
            String SEARCH_MED_SQL = "SELECT user_id, pharmacy.name, " +
                    "CONCAT(street_address, ', ', city, ', ', state, ', ', zip_code), " +
                    "quantity, price " +
                    "FROM pharmacy NATURAL JOIN sells NATURAL JOIN address " +
                    "JOIN medication USING(med_id)" +
                    "WHERE medication.name = ? AND quantity > 0";
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                        Utilities.getdbvar("user"), Utilities.getdbvar("pass"));
                PreparedStatement ps = con.prepareStatement(SEARCH_MED_SQL, PreparedStatement.RETURN_GENERATED_KEYS);
                ps.setString(1, searchQuery);

                ResultSet rs = ps.executeQuery();

                //If the query returned nothing
                if (!rs.isBeforeFirst()) {
                    out.println(String.format("<h3 style=\"margin: 0.4rem; text-align: center; color: white;\">No pharmacies found for %s.</h3>", searchQuery));
                }

                //If at least one pharmacy was returned by the query
                else {
                    out.println(String.format("<h2 style=\"margin: 0.8rem auto auto auto; color: white; " +
                            "text-align: center; width: fit-content; text-shadow: 5px 2px 5px black; " +
                            "border-radius: 10px; padding: 4px 8px;\">Pharmacies for %s</h2>", searchQuery));
                    out.println("<div id=\"flexbox\">");

                    while (rs.next()) {
                        int pharmId = rs.getInt(1);
                        String name = rs.getString(2);
                        String address = rs.getString(3);
                        int quantity = rs.getInt(4);
                        double price = rs.getDouble(5);
                        String priceString = String.format("%.2f", price);
                        String priceDecimal = priceString.substring(priceString.indexOf('.') + 1);

                        //Create a hyperlinked box for each pharmacy
                        out.println(String.format("<div class=\"card pharmCard\" onclick=\"location.href='/PharmaFinder/pharmacy.jsp?p=%d';\" " +
                                "style=\"order: 0; box-shadow: 6px 6px 5px black;\" data-dist=\"0\">\n" +
                                "<div class=\"card-body\" style=\"display: flex; flex-direction: column;\">\n" +
                                "<h4 class=\"card-title\">%s<span class=\"distDisplay\"></span></h4>\n" +
                                "<h6 class=\"card-title pharmDist\" style=\"margin-bottom: 2px;\">%s</h6>\n" +
                                "<div style=\"flex: 1; display: flex; align-items:center;\">\n" +
                                "<p class=\"card-text pr\">\n" +
                                    "<sup class=\"exponent1\">$</sup>" +
                                    "<span class=\"price\">%.0f</span>" +
                                    "<sup class=\"exponent2\">%s</sup>" +
                                    "<span style=\"font-size: 1.6em; font-weight: 600; margin-left: 16px;\">%d</span>" +
                                    "<span style=\"font-size: 1em;\"> in stock</span>" +
                                "</p>\n" +
                                "</div>\n" +
                                "</div>\n" +
                                "</div>", pharmId, name, address, Math.floor(price), priceDecimal, quantity));

                    }
                }

                out.println("</div>");

                con.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        }

        //If the query was for a type
        else if ("Type".equals(searchCategory) && searchQuery != null) {

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
                    out.println(String.format("<h3 style=\"margin: 0.4rem; text-align: center; color: white; text-shadow: 5px 2px 5px black;\">No medications found for %s.</h3>", searchQuery));
                }

                //If at least one medication was returned by the query
                else {
                    out.println(String.format("<h2 style=\"margin: 0.8rem auto auto auto; " +
                            "text-align: center; color: white; width: fit-content; text-shadow: 5px 2px 5px black; " +
                            "border-radius: 10px; padding: 4px 8px;\">%ss</h2>", searchQuery));
                    out.println("<div id=\"flexbox\">");

                    while (rs.next()) {
                        String medName = rs.getString(1);

                        //Create a hyperlinked box for each medication
                        out.println(String.format("<div class=\"card\" onclick=\"location.href='/PharmaFinder/search.jsp?query=%s&cat=Medication';\" " +
                                "style=\"width: auto; cursor: pointer; text-align: center; margin: 1.2rem; " +
                                    "padding: 0 0.4rem; box-shadow: 6px 6px 5px black;\">\n" +
                                "<div class=\"card-body\">\n" +
                                "<h3 class=\"card-title\">%s</h3>\n" +
                                "</div>\n" +
                                "</div>", medName, medName));
                    }
                }

                out.println("</div>");

                con.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        }

        //If the url search query parameters are invalid
        else {
            out.println("<h3 style=\"margin: 0.4rem; text-align: center; color: white; text-shadow: 5px 2px 5px black;\">Invalid Search</h3>");
        }
    %>
</div>
<script>

    fetch('<%=request.getContextPath()%>/getApiKey')
        .then(response => response.text())
        .then(apiKey => {

            const script = document.createElement('script');
            script.src = "https://maps.googleapis.com/maps/api/js?key=" + apiKey + "&callback=initMap&v=weekly";
            script.async = true;
            script.defer = true;
            document.head.appendChild(script);
        })
        .catch(err => console.error('Error fetching API key:', err));
</script>

<script src="distancePharmacy.js"></script>
</body>
</html>
