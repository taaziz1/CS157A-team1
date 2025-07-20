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

	<%-- DASHBOARD CONTENT --%>

	<%
		Pharmacy pharmacy = null;
			int userId = (int) session.getAttribute("user_id");
			PharmacyDao pharmacyDao = new PharmacyDao();
			pharmacy = pharmacyDao.getPharmacyDashboard(userId);

	%>

	<h1>Welcome, <%=pharmacy.getPharmacyName()%></h1>
<div class="center">
	<table class="phramDashBorder">
		<tr>
			<th>User ID</th>
			<td><%=pharmacy.getUserId()%></td>
		</tr>
		<tr>
			<th>Tax Number</th>
			<td><%=pharmacy.getTaxNum()%></td>
		</tr>
		<%--make it so it doesnt display null if info not there--%>
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
			<td><a href="<%=pharmacy.getWebURL()%>"><%=pharmacy.getWebURL()%></>a></td>
		</tr>
		<tr>
			<th>Operating Hours</th>
			<td>
				<table>
					<%
						String hours =pharmacy.getOperatingHours();
					String timings[] =hours.split(",");
					String daysOfWeek[] ={"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};
					for(int i=0,j=0; i<timings.length && j < daysOfWeek.length;i++,j++){
						%>
					<tr>
						<td><%=daysOfWeek[j]%></td>
					<td><%=timings[i]%></td>

					</tr>
              <%}%>
				</table>
			</td>
		</tr>
		<tr>
			<th>Address</th>
			<td><%=pharmacy.getAddress()%></td>
		</tr>

	</table>

	<!-- Library for star-->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

	<span class="fa fa-star star1"></span>
	<span class="fa fa-star star2"></span>
	<span class="fa fa-star star3"></span>
	<span class="fa fa-star star4"></span>
	<span class="fa fa-star star5"></span>
	</div>


	<script>
		let starRating = "<%=pharmacy.getRating()%>";

		for (let i = 0; i < starRating; i++) {
			let star = document.querySelector(".star" + (i+1));
			star.style.color="#f7d792";
		}
	</script>

	<div class="button">
		<a href="pharmInfoUpdate.jsp"><button class="w-100 btn btn-primary btn-lg"
			type="submit">Update Info</button></a>

</body>
</html>