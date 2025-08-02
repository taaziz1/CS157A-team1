<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="usermanagement.dao.PharmacyDao"%>
<%@ page import="usermanagement.model.Pharmacy"%>
<%@ page import="usermanagement.model.Address" %>
<%@ page import="java.util.Arrays" %>


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

  </div>
</nav>

<%-- DASHBOARD CONTENT --%>

<%
  Pharmacy pharmacy = null;
  int userId = (int) session.getAttribute("user_id");
  PharmacyDao pharmacyDao = new PharmacyDao();
  pharmacy = pharmacyDao.getPharmacyDashboard(userId);
  Address address = pharmacy.getAddress();

%>

<div class="container">
  <h1>Update Pharmacy Information</h1>

  <form action="updatePharmacy" method="post" class="needs-validation" novalidate="">
    <input type="hidden" name="user_id" value="<%= pharmacy.getUserId() %>">
    <input type="hidden" name="address_id" value="<%= address.getAddressId() %>">

    <div class="row">
      <%-- TAX NUMBER --%>
      <div class="col-sm-6">
        <label for="tax_Number" class="form-label">Tax Number</label> <input
              type="text" class="form-control" id="tax_Number" name="tax_Number"
              value="<%=pharmacy.getTaxNum()%>" required="">
        <div class="invalid-feedback">Your tax number is required.</div>
      </div>
      <%-- PHARMACY NAME --%>
      <div class="col-sm-6">
        <label for="pharmacy_name" class="form-label">Pharmacy
          Name</label> <input type="text" class="form-control" id="pharmacy_name" name="pharmacy_name"
                              value="<%=pharmacy.getPharmacyName()%>" required="">
        <div class="invalid-feedback">Your pharmacy name is required.</div>
      </div>
      <%-- ADDRESS --%>
      <div class="col-12">
        <label for="address" class="form-label">Address</label> <input
              type="text" class="form-control" id="address" name="address"
              value="<%=address.getStreetName()%>" required="">
        <div class="invalid-feedback">Please enter your shipping
          address.</div>
      </div>
      <%-- CITY --%>
      <div class="col-12">
        <label for="city" class="form-label">City</label> <input type="text"
                                                                 class="form-control" id="city" name="city" value="<%= address.getCity()%>" required="">
        <div class="invalid-feedback">Please provide a valid city.</div>
      </div>

      <%-- STATE --%>
      <div class="col-md-6">
        <label for="state" class="form-label">State</label> <select
              class="form-select" id="state" name="state" required="">
        <option disabled <%= (address.getState() == null || address.getState().isEmpty()) ? "selected" : "" %>>Choose...</option>

        <option value="Alabama" <%= "Alabama".equals(address.getState()) ? "selected" : "" %>>Alabama</option>
        <option value="Alaska" <%= "Alaska".equals(address.getState()) ? "selected" : "" %>>Alaska</option>
        <option value="Arizona" <%= "Arizona".equals(address.getState()) ? "selected" : "" %>>Arizona</option>
        <option value="Arkansas" <%= "Arkansas".equals(address.getState()) ? "selected" : "" %>>Arkansas</option>
        <option value="California" <%= "California".equals(address.getState()) ? "selected" : "" %>>California</option>
        <option value="Colorado" <%= "Colorado".equals(address.getState()) ? "selected" : "" %>>Colorado</option>
        <option value="Connecticut" <%= "Connecticut".equals(address.getState()) ? "selected" : "" %>>Connecticut</option>
        <option value="Delaware" <%= "Delaware".equals(address.getState()) ? "selected" : "" %>>Delaware</option>
        <option value="Florida" <%= "Florida".equals(address.getState()) ? "selected" : "" %>>Florida</option>
        <option value="Georgia" <%= "Georgia".equals(address.getState()) ? "selected" : "" %>>Georgia</option>
        <option value="Hawaii" <%= "Hawaii".equals(address.getState()) ? "selected" : "" %>>Hawaii</option>
        <option value="Idaho" <%= "Idaho".equals(address.getState()) ? "selected" : "" %>>Idaho</option>
        <option value="Illinois" <%= "Illinois".equals(address.getState()) ? "selected" : "" %>>Illinois</option>
        <option value="Indiana" <%= "Indiana".equals(address.getState()) ? "selected" : "" %>>Indiana</option>
        <option value="Iowa" <%= "Iowa".equals(address.getState()) ? "selected" : "" %>>Iowa</option>
        <option value="Kansas" <%= "Kansas".equals(address.getState()) ? "selected" : "" %>>Kansas</option>
        <option value="Kentucky" <%= "Kentucky".equals(address.getState()) ? "selected" : "" %>>Kentucky</option>
        <option value="Louisiana" <%= "Louisiana".equals(address.getState()) ? "selected" : "" %>>Louisiana</option>
        <option value="Maine" <%= "Maine".equals(address.getState()) ? "selected" : "" %>>Maine</option>
        <option value="Maryland" <%= "Maryland".equals(address.getState()) ? "selected" : "" %>>Maryland</option>
        <option value="Massachusetts" <%= "Massachusetts".equals(address.getState()) ? "selected" : "" %>>Massachusetts</option>
        <option value="Michigan" <%= "Michigan".equals(address.getState()) ? "selected" : "" %>>Michigan</option>
        <option value="Minnesota" <%= "Minnesota".equals(address.getState()) ? "selected" : "" %>>Minnesota</option>
        <option value="Mississippi" <%= "Mississippi".equals(address.getState()) ? "selected" : "" %>>Mississippi</option>
        <option value="Missouri" <%= "Missouri".equals(address.getState()) ? "selected" : "" %>>Missouri</option>
        <option value="Montana" <%= "Montana".equals(address.getState()) ? "selected" : "" %>>Montana</option>
        <option value="Nebraska" <%= "Nebraska".equals(address.getState()) ? "selected" : "" %>>Nebraska</option>
        <option value="Nevada" <%= "Nevada".equals(address.getState()) ? "selected" : "" %>>Nevada</option>
        <option value="New Hampshire" <%= "New Hampshire".equals(address.getState()) ? "selected" : "" %>>New Hampshire</option>
        <option value="New Jersey" <%= "New Jersey".equals(address.getState()) ? "selected" : "" %>>New Jersey</option>
        <option value="New Mexico" <%= "New Mexico".equals(address.getState()) ? "selected" : "" %>>New Mexico</option>
        <option value="New York" <%= "New York".equals(address.getState()) ? "selected" : "" %>>New York</option>
        <option value="North Carolina" <%= "North Carolina".equals(address.getState()) ? "selected" : "" %>>North Carolina</option>
        <option value="North Dakota" <%= "North Dakota".equals(address.getState()) ? "selected" : "" %>>North Dakota</option>
        <option value="Ohio" <%= "Ohio".equals(address.getState()) ? "selected" : "" %>>Ohio</option>
        <option value="Oklahoma" <%= "Oklahoma".equals(address.getState()) ? "selected" : "" %>>Oklahoma</option>
        <option value="Oregon" <%= "Oregon".equals(address.getState()) ? "selected" : "" %>>Oregon</option>
        <option value="Pennsylvania" <%= "Pennsylvania".equals(address.getState()) ? "selected" : "" %>>Pennsylvania</option>
        <option value="Rhode Island" <%= "Rhode Island".equals(address.getState()) ? "selected" : "" %>>Rhode Island</option>
        <option value="South Carolina" <%= "South Carolina".equals(address.getState()) ? "selected" : "" %>>South Carolina</option>
        <option value="South Dakota" <%= "South Dakota".equals(address.getState()) ? "selected" : "" %>>South Dakota</option>
        <option value="Tennessee" <%= "Tennessee".equals(address.getState()) ? "selected" : "" %>>Tennessee</option>
        <option value="Texas" <%= "Texas".equals(address.getState()) ? "selected" : "" %>>Texas</option>
        <option value="Utah" <%= "Utah".equals(address.getState()) ? "selected" : "" %>>Utah</option>
        <option value="Vermont" <%= "Vermont".equals(address.getState()) ? "selected" : "" %>>Vermont</option>
        <option value="Virginia" <%= "Virginia".equals(address.getState()) ? "selected" : "" %>>Virginia</option>
        <option value="Washington" <%= "Washington".equals(address.getState()) ? "selected" : "" %>>Washington</option>
        <option value="West Virginia" <%= "West Virginia".equals(address.getState()) ? "selected" : "" %>>West Virginia</option>
        <option value="Wisconsin" <%= "Wisconsin".equals(address.getState()) ? "selected" : "" %>>Wisconsin</option>
        <option value="Wyoming" <%= "Wyoming".equals(address.getState()) ? "selected" : "" %>>Wyoming</option>

      </select>
        <div class="invalid-feedback">Please provide a valid state.</div>
      </div>

      <%-- ZIPCODE --%>
      <div class="col-md-6">
        <label for="zip" class="form-label">Zip Code</label> <input
              type="number" class="form-control" id="zip" name="zip" value="<%=address.getZipcode()%>"
              required="">
        <div class="invalid-feedback">Zip code required.</div>
      </div>


      <%-- PHONE NUMBER --%>
      <div class="col-sm-12">
        <label for="phone" class="form-label">Phone Number</label> <span
              class="text-body-secondary">(Optional)</span><input type="text"
                                                                  class="form-control" id="phone" name="phone" value="<%=pharmacy.getPhoneNumber()%>">
      </div>
      <%-- FAX NUMBER --%>
      <div class="col-sm-12">
        <label for="fax" class="form-label">Fax Number</label><span
              class="text-body-secondary">(Optional)</span> <input type="text"
                                                                   class="form-control" id="fax" name="fax" value="<%=pharmacy.getFaxNumber()%>">
      </div>
      <%-- URL --%>
      <div class="col-12">
        <label for="url" class="form-label"> URL <span
                class="text-body-secondary">(Optional)</span></label> <input type="url"
                                                                             class="form-control" id="url" name="url" value="<%=pharmacy.getWebURL()%>">
        <div class="invalid-feedback">Please enter a valid URL
          (e.g., https://example.com)</div>
      </div>
      <%--OPERATING HOURS --%>
        <%
          String hours = pharmacy.getOperatingHours();
          String timings[] =hours.split(",");
          if (timings.length == 0) {
            // create a 7-element array and fill with "N/A"
            timings = new String[7];
            Arrays.fill(timings, "N/A");
          }
          String daysOfWeek[] ={"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};
        %>
        <div class="col-sm-12">
          <label class="form-label">Operating Hours</label>
          <span class="text-body-secondary"> In military time-format</span>
        </div>
        <br>
          <%
            for (int i = 0; i < timings.length && i < daysOfWeek.length; i++) {
          %>
        <label><%= daysOfWeek[i] %></label>
        <input type="text" class="form-control" name="operating_hours" value="<%= timings[i] %>" required="">
          <% } %>
        <div class="invalid-feedback">Please fill in every day’s operating hours. If you’re closed (or it doesn’t apply), enter **N/A**.</div>



        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
    <% if (errorMessage != null) { %>
    <div style="color: red; font-weight: bold;"><%= errorMessage %></div>
    <% } %>
    <%-- BUTTON --%>
        <%-- BUTTONS: Update and Cancel --%>
        <div class="d-flex justify-content-start gap-2 mt-3">
          <button class="btn btn-primary btn-lg" type="submit">Update</button>
          <a href="pharmDashboard.jsp" class="btn btn-secondary btn-lg">Cancel</a>
        </div>
  </form>
</div>
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