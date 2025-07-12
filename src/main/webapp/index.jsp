<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<style>
/*PREVENTS SCROLLING OPTION*/
.html{
overflow:hidden;
}

/*CARD*/
.card{
width: fit-content;
padding:5px;
white-space: normal;
text-align: center;
border-radius: 20px;
 white-space: nowrap;
}

.btn{
 white-space: nowrap;
 padding:12px;
 width: 100%;
  margin-bottom: 0.25rem;
}

/*SEARCH BAR*/
.searchdiv{
margin:20px 100px;
display:flex;
justify-content: center;
align-items:center;

}
/*CARDS DROPDOWN*/
 .customer-card,.pharm-card{
	position:relative;
	margin:1em;
}

.pharm, .customer{
  display: none;
  position: absolute;
  top: 100%;
  z-index: 1000;
}
@media (hover: hover) {
  .pharm-card:hover .pharm {
    display: block;
  }
  .customer-card:hover .customer {
    display: block;
  }
}

</style>

<meta charset="UTF-8">
<%--LINKS TO THE CSS PAGE--%>
<link rel="stylesheet" href="style.css" type="text/css">
<%--TAB NAME--%>
<title>PharmaFinder</title>
<%-- TO LINK BOOTSTRAP--%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp"
	crossorigin="anonymous">

</head>

<body>
	<%--NAVIGATION BAR --%>
 <div class="fullscreen">
	 <nav class=" bg-body-tertiary navbar">
		<div class="navstart">
		   <%--ICON--%>
			<svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-prescription2" viewBox="0 -4 20 25">
             <path d="M7 6h2v2h2v2H9v2H7v-2H5V8h2z"></path>
             <path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1v10.5a1.5 1.5 0 0 1-1.5 1.5h-7A1.5 1.5 0 0 1 3 14.5V4a1 1 0 0 1-1-1zm2 3v10.5a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5V4zM3 3h10V1H3z"></path>
            </svg>
           
		    <span style = "font-weight:bold;" class="navstart">PharmaFinder</span>
		</div>
		
		 <div class="navend">
		
	
  <div class="pharm-card">	
	  	<p class="formPath">Customers</p>	
		<div class="pharm">
		<div class="card">
		
				<p>Make an account or log in.</p>
				<a href="" class="btn btn-primary">Log in</a>
			    <a href="" class="btn btn-primary">Register</a>
			</div>
		
	</div>
</div>
	<div class="customer-card">	
	  	<p class="formPath">Customers</p>	
		<div class="customer">
		<div class="card">
		
				<p>Make an account or log in.</p>
				<a href="pharmLogIn.jsp" class="btn btn-primary">Log in</a>
			    <a href="registerPharm.jsp" class="btn btn-primary">Register</a>
			</div>
		
	</div>
</div>
</div>
</nav>
	<%--HEADING--%>
	<h1>Welcome to PharmaFinder</h1>
	
	<%--PHARMACY CARD--%>

	<%--SEARCH BAR--%>
    <div class="searchdiv">
	 <form class="w-100 me-3" role="search">
	  <input  type="search" class="form-control" placeholder="Search..." aria-label="Search">
	 </form>
    </div>
 
</div>

</body>
</html>