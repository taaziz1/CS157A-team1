<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="style.css" type="text/css">
    <title>Pharmacy Sign In</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">

<style>
	/* Prevent scrolling */
	body {
		overflow: hidden;
	}

	.formPath{
		background-image: linear-gradient(#575555 50%, #2500ff 50%) !important
	}
</style>
</head>

<body>

<%--Invalid credentials pop up--%>
<%
	String error = request.getParameter("error");
	if ("invalid_credentials".equals(error)) {
%>
<div id="errorPopup">
	❌ Invalid credentials. Please try again.
</div>
<%
	}
%>
<script>
	setTimeout(() => {
		const popup = document.getElementById('errorPopup');
		if (popup) popup.style.display = 'none';
	}, 3000); // 3 seconds
</script>


<%--NAVIGATION BAR--%>
<nav class="bg-body-tertiary navbar">
		<div class="navstart">
			<%--ICON--%>
			<svg xmlns="http://www.w3.org/2000/svg" width="35" height="35"
				fill="currentColor" class="bi bi-prescription2" viewBox="0 -4 20 25">
             <path d="M7 6h2v2h2v2H9v2H7v-2H5V8h2z"></path>
             <path
					d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1v10.5a1.5 1.5 0 0 1-1.5 1.5h-7A1.5 1.5 0 0 1 3 14.5V4a1 1 0 0 1-1-1zm2 3v10.5a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5V4zM3 3h10V1H3z"></path>
            </svg>
				<a class="navstart homePage" href="index.jsp">PharmaFinder</a>
		</div>
	</nav>
	<%--LOG IN--%>
	<main class="form-signin w-100 m-auto" >
	<div class="bubble">
		<form action="<%=request.getContextPath()%>/loginPharmacy" method="post" style="background-color: white;  padding:20px; border-radius:20px;">
			<h3 class="h3" style="font-size: 2.2em; text-align: center; padding: 0.2rem">Sign in</h3>

			<div class="form-floating" style="margin: 10px 0">
				<input type="text" class="form-control" id="floatingInput"
					placeholder="Username" data-listener-added_c045737e="true" name="username">
				<label for="floatingInput">Username</label>
			</div>

			<div class="form-floating" style="margin: 10px 0">
				<input type="password" class="form-control" id="floatingPassword" name="password"
					placeholder="Password">
					<a onclick="passwordFunction()" style="position: absolute; z-index:2; top:15px; right: 20px;">
							<span id="passwordImage">
									<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
										<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z"/>
										<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0"/>
									</svg>
							</span>
					</a>
				<label for="floatingPassword">Password</label>


			</div>

			<button class="btn btn-primary w-100 py-2 " type="submit" value="submit">Sign
				in</button>

			<div style="margin:auto; width: 50%; text-align: center; padding-top: 0.35rem;">
				<a class="formPath" href="index.jsp">Cancel</a>
			</div>

		</form>

	</div>
</main>
	<script src="index.js">
	</script>
</body>
</html>