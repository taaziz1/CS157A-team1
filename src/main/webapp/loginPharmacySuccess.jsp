<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="usermanagement.dao.PharmacyDao"%>
<%@ page import="usermanagement.model.Pharmacy"%>
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
.button {
	display: flex;
	padding: 30px;
}

.btn {
	margin: 20px;
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
			<%-- NEED TO CHANGE THIS LATER ON FOR IT TO LOG OUT --%>
		</div>
	</nav>


	<h1>Pharmacy Successfully Log In</h1>
	<%-- DASHBOARD CONTENT --%>

	<%
	Pharmacy pharmacy = null;
	int userId = (int) session.getAttribute("user_id");
	PharmacyDao pharmacyDao = new PharmacyDao();
	pharmacy = pharmacyDao.getPharmacyDashboard(userId);
	%>

	<table border="1" cellpadding="10">
		<tr>
			<th>User ID</th>
			<td><%=pharmacy.getUserId()%></td>
		</tr>
		<tr>
			<th>Address ID</th>
			<td><%=pharmacy.getAddressId()%></td>
		</tr>
		<tr>
			<th>Tax Number</th>
			<td><%=pharmacy.getTaxNum()%></td>
		</tr>
		<tr>
			<th>Pharmacy Name</th>
			<td><%=pharmacy.getPharmacyName()%></td>
		</tr>
		<tr>
			<th>Phone Number</th>
			<td><%=pharmacy.getPhoneNumber()%></td>
		</tr>
		<tr>
			<th>Fax Number</th>
			<td><%=pharmacy.getFaxNumber()%></td>
		</tr>
		<tr>
			<th>Website</th>
			<td><%=pharmacy.getWebURL()%></td>
		</tr>
		<tr>
			<th>Operating Hours</th>
			<td><%=pharmacy.getOperatingHours()%></td>
		</tr>
	</table>

	<a href="logout.jsp" style="text-decoration: none; color: dodgerblue;">Log
		Out</a>

</body>
</html>