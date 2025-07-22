<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css" type="text/css">
<title>Customer Create Account</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp"
	crossorigin="anonymous">
	<style>
	.button{
	display:flex;
	padding:30px;
	  }
	  .btn{
	  margin:20px;}
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
	</nav>

	<h1>Create Account</h1>

	<%-- REGISTRATION --%>

	<div class="center">
		<div class="col-md-7 col-lg-8">
			<form class="needs-validation" action="registerCustomer" method="post" novalidate="">
				<div class="row">
                  	
                   <%-- USERNAME--%>
					<div class="col-sm-12">
						<label for="username" class="form-label">Username</label>
						<div class="input-group has-validation">
							<span class="input-group-text">@</span> <input type="text"
								class="form-control" id="username" name="username" placeholder="Username"
								required="">
							<div class="invalid-feedback">Your username is required.</div>
						</div>
					</div>
					
                    <%-- PASSWORD --%>
					<div class="col-sm-12">
						<label for="password" class="form-label">Password</label> <input
							type="password" class="form-control" id="password" name="password" placeholder=""
							value="" required="">
					</div>
					
					<%-- EMAIL --%>
					<div class="col-md-12">
						<label for="emailAddress" class="form-label">Email Address</label> <input
							type="email" class="form-control" id="emailAddress" name="emailAddress"
							placeholder="" required="">
						<div class="invalid-feedback">Email required.</div>
					</div>
						   <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
						   <% if (errorMessage != null) { %>
					   <div style="color: red; font-weight: bold;"><%= errorMessage %></div>
						   <% } %>
					
					
<%-- BUTTON --%>
<div class="button">
            
					<button class="w-100 btn btn-primary btn-lg" type="submit">Create</button>
		        	
			
			</div>
			 <a href="index.jsp"style="text-decoration:none; color:gray;">Cancel</a></form>
		</div>
	</div>

</body>
</html>