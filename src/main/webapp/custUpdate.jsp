<%@ page import="usermanagement.model.Customer" %>
<%@ page import="usermanagement.dao.CustomerDao" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Customer</title>
    <%--LINKS TO THE CSS PAGE--%>
    <link rel="stylesheet" href="style.css" type="text/css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
<style>
    .pharmDashBorder {


        background-color: whitesmoke;
        border-radius: 25px;
        width: fit-content;
        height: fit-content;
        padding: 5px;
        box-shadow: 10px 5px 5px grey;


    }
    .boxSize {
        display:flex;

        height: 120px;

    }

</style>
</head>
<body>

<%
    int userId = Integer.parseInt(request.getParameter("userId"));
    CustomerDao customerdao = new CustomerDao();
    Customer customer = customerdao.getCustomerDashboard(userId);
%>
<main class="form-signin w-100 m-auto">

<div class="bubble">
<form action="updateCustomer" method="post">
    <input type="hidden" name="userId" value="<%= userId %>">
    <h1 class="h3 mb-3 fw-normal">Update Customer Details</h1>
    <label  class="form-label">Avatar</label><br>
    <div class="boxSize" style="padding:20px;">

        <%
           List<String> avList =customerdao.avatarList();
           for(String avatar: avList){
               String[] split = avatar.split("\\|");
               String avatarId = split[0];
               String avatarPath = split[1];
        %>
        <div class="pharmDashBorder" >
        <input  type="radio" name="avatarId" value="<%= avatarId %>">
<img  src="<%= avatarPath %>"style="width:40px;height:40px;">
        </div>
        <%}%>

    </div>


    <div class="form-floating">
        <input type="text" class="form-control"   pattern="^(?!.*@).*"
               placeholder="Username"   value="<%= customer.getUsername() %>" name="username">
        <label >Username</label>
    </div>




    <div class="form-floating">
    <input type="email" id="emailAddress"  class="form-control" name="emailAddress" placeholder="Email Address"
           pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{3}$" title="Please enter valid email"
           value="<%= customer.getEmailAddress() %>" required>
        <label for="emailAddress">Email Address:</label>
    </div>
    <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
    <% if (errorMessage != null) { %>
    <div style="color: red; font-weight: bold;"><%= errorMessage %></div>
    <% } %>
    <input type="submit" class="w-100 btn btn-primary btn-lg" value="Update Customer">

    <a href="custDashboard.jsp">
        Back to Dashboard
    </a>
</form>
    </main>



</body>
</html>
