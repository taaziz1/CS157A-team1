<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css" type="text/css">
<title>PharmaFinder</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp"
	crossorigin="anonymous">



</head>
<body>
	<%--navigation bar--%>
	<nav class="navbar bg-body-tertiary ">
		<div>
			<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25"
				fill="currentColor" class="bi bi-prescription2" viewBox="0 0 25 25">
  <path d="M7 6h2v2h2v2H9v2H7v-2H5V8h2z" />
  <path
					d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1v10.5a1.5 1.5 0 0 1-1.5 1.5h-7A1.5 1.5 0 0 1 3 14.5V4a1 1 0 0 1-1-1zm2 3v10.5a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5V4zM3 3h10V1H3z" />
</svg>
			<a class="navbar-brand font"> PharmaFinder </a>

		</div>
	</nav>

<div>
			<%--heading--%>
			<h1>Welcome to PharmaFinder</h1>
		</div>
	<div class="fullscreen">
		
		<div>
			<%--Cards of user and Pharmacy Page--%>
			<div class="row container">
				<div class="col-sm-6 mb-3 mb-sm-0">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Users</h5>
							<p class="card-text">Click here to find the nearest Pharmacy.</p>
							<a href="#" class="btn btn-primary">User Page</a>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Pharmacies</h5>
							<p class="card-text">Register your Pharmacy or log in.</p>
							<a href="pharmacyPage.jsp" class="btn btn-primary">Pharmacy
								Page</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</body>
</html>