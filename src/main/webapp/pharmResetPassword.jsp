<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="usermanagement.dao.PharmacyDao"%>
<%@ page import="usermanagement.model.Pharmacy"%>
<%@ page import="usermanagement.model.Address" %>


<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="style.css" type="text/css">
  <title>Pharmacy Information Update</title>

  <link
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp"
          crossorigin="anonymous">
  <style>
    .phramDashBorder{
      border-radius:50%;
      border:solid black;
    }
    .center{
      display:flex;
      align-items:flex-start;
    }
    .test{
      margin-right: 20px;
      text-decoration:none;
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

    <a class="navstart homePage">PharmaFinder</a>
    <%-- NEED TO CHANGE THIS LATER ON FOR IT TO LOG OUT --%>

  </div>
  <div class="navend ">
    <a   class="test" href="logout" style="color:grey;" >Log Out</a>
  </div>
</nav>

<%-- FORM CONTENT --%>
<div class=" container">
  <h1>Reset your Password</h1>

  <form action="pharmResetPassword"" method="post" class="needs-validation" novalidate="">
    <input type="hidden" name="user_id" value="<%= session.getAttribute("user_id") %>">

    <div class="row">
      <%-- TAX NUMBER --%>
      <div class="col-sm-6">
        <label for="tax_Number" class="form-label">Tax Number</label> <input
              type="text" class="form-control" id="tax_Number" name="tax_Number" placeholder=""
              value="" required="">
      </div>
        <%-- CURRENT PASSWORD --%>
        <div class="col-sm-12">
          <label for="current_password" class="form-label">Current Password</label> <input
                type="password" class="form-control" id="current_password" name="current_password" placeholder=""
                value="" required="">
        </div>
        <%-- NEW PASSWORD --%>
        <div class="col-sm-12">
          <label for="new_password" class="form-label">New Password</label> <input
                type="password" class="form-control" id="new_password" name="new_password" placeholder=""
                value="" required="">
        </div>
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
      <div style="color: red; font-weight: bold;"><%= errorMessage %></div>
        <% } %>
      <%-- BUTTON --%>
      <%-- BUTTONS: Update and Cancel --%>
      <div class="d-flex justify-content-start gap-2 mt-3">
        <button class="btn btn-primary btn-lg" type="submit">Change Password</button>
        <a href="loginPharmacySuccess.jsp" class="btn btn-secondary btn-lg">Cancel</a>
      </div>
  </form>
</div>

</body>
</html>