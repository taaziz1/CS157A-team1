<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css" type="text/css">
<title>Customer Registration</title>

	<%-- To link Bootstrap --%>
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp"
		crossorigin="anonymous">

	<style>
		/* Prevent scrolling */
		body {
			overflow: hidden;
		}

		.button {
			display: flex;
			padding: 20px 30px 10px;
		}
	</style>
</head>

<body>

<%--Pop ups--%>
<%
	String error = request.getParameter("error");
	if (error != null) {
%>
<div id="errorPopup">
	❌ An unknown error has occurred. Please try again.
</div>
<%
		if("duplicate_account".equals(error)) {
%>
			<script> document.getElementById("errorPopup").innerHTML = "❌ Username or email address already exists. Please try again." </script>
<%
		} else if ("invalid_form".equals(error)) {

%>
			<script> document.getElementById("errorPopup").innerHTML = "❌ One or more fields are invalid. Please try again." </script>
<%
		} else if ("creation_error".equals(error)) {
%>
			<script> document.getElementById("errorPopup").innerHTML = "❌ An error occurred while creating the account. Please try again." </script>
<%
		} else {}
	}

%>
<script>
	setTimeout(() => {
		const popup = document.getElementById('errorPopup');
		if (popup) popup.style.display = 'none';
	}, 3000); // 3 seconds
</script>

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
	</nav>

	<%-- REGISTRATION CARD --%>
	<div class="center">
			<form class="needs-validation" action="registerCustomer" method="post" novalidate=""
				  style="background-color: white; margin:20px 32%; padding:12px 30px; border-radius:20px;">
				<h1>Create an Account</h1>
				<div class="row">

                   <%-- USERNAME--%>
					<div class="col-sm-12" style="margin: 0 0 4px">
						<label for="username" class="form-label">Username</label>
						<div class="input-group has-validation">
							<span class="input-group-text">@</span> <input type="text"
								class="form-control" id="username" name="username" placeholder="Username"
								required="">
							<div class="invalid-feedback">Your username is required.</div>
						</div>
					</div>

                    <%-- PASSWORD --%>
					   <div class="col-sm-12" style="margin: 8px 0 4px">
						   <label for="password" class="form-label">Password</label>
						   <input
								   type="password"
								   class="form-control"
								   id="password"
								   name="password"
								   required
								   pattern="(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}"
								   title="Password must contain at least one uppercase letter, one lowercase letter, one number, one special character, and be at least 8 characters long.">
						   <div class="invalid-feedback">
							   Password must contain at least one uppercase, one lowercase, one number, one special character (@, $, !, %, *, ?, &), and be 8+ characters long.
						   </div>
					   </div>


					<%-- EMAIL --%>
					<div class="col-md-12" style="margin: 8px 0 4px">
						<label for="emailAddress" class="form-label">Email Address</label> <input
							type="email" class="form-control" id="emailAddress" name="emailAddress"
							placeholder="" required="">
						<div class="invalid-feedback">Email required.</div>
					</div>

					<%-- BUTTON --%>
					<div class="button">
						<button class="w-100 btn btn-primary btn-lg" type="submit">Create</button>
					</div>

				<%-- CANCEL --%>
				<div style="margin:auto; width: 50%; text-align: center;">
					<a class="formPath" href="index.jsp">Cancel</a>
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