<%@ page import="usermanagement.dao.CustomerDao" %>
<%@ page import="usermanagement.model.Customer" %>
<%@ page import="usermanagement.web.CustomerLoginServlet" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="style.css" type="text/css">
  <title>Customer Login Page</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">

  <style>

  .custDashBorder {

  background-color: whitesmoke;
  border-radius: 25px;
  width: fit-content;
  height: fit-content;
  padding: 20px;
  box-shadow: 10px 5px 5px grey;
    margin-left: 30px;

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

    <a  class="navstart homePage"
        href="index.jsp">PharmaFinder</a>
  </div>

  <a  class="formPath" href="logout" >Logout</a>

</nav>
<%
  CustomerDao customerDao = new CustomerDao();
  int userId =(int)session.getAttribute("user_id");
  Customer customer = customerDao.getCustomerDashboard(userId);
%>
<h1 style="margin-top:40px;"> Customer Dashboard</h1>

  <div class="custDashBorder">
  <table>
    <tr>

      <td ><img src="<%=customer.getAvatarDirectory()%>"  alt="Avatar" width="100" height="100"></td>
    </tr>
    <tr>
      <th>User Id</th>
      <td><%=customer.getUserId()%></td>
    </tr>
    <tr>
      <th>Username</th>
      <td><%=customer.getUsername()%></td>
    </tr>

    <tr>
      <th>Email</th>
      <td><%=customer.getEmailAddress()%></td>
    </tr>

    </table>
</div>



</body>
</html>