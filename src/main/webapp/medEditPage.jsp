<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="usermanagement.model.Medication" %>
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

  <title >Edit Medication </title>

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
  String medIdParam = request.getParameter("med_id");
  String userIdParam = request.getParameter("user_id");
%>

<h1>Edit Medication </h1>

<form method="post" action="updateMedication">
  <input type="hidden" name="med_id" value="<%= medIdParam %>" />
  <input type="hidden" name="user_id" value="<%= userIdParam %>" />

  <label for="price">Price:</label>
  <input type="text" name="price" id="price" required /><br><br>

  <label for="qty">Quantity:</label>
  <input type="number" name="qty" id="qty" required /><br><br>

  <input type="submit" style="" value="Update Medication" />

</form>

</body>
</html>
