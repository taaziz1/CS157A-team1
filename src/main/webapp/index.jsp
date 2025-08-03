<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="util.Utilities" %>

<!DOCTYPE html>
<html>
<head>

	<%--LINKS TO THE CSS PAGE--%>
	<link rel="stylesheet" href="style.css" type="text/css">

	<style>
		html,
		body {
			background: #1e93bd !important;
		}

		/*PREVENTS SCROLLING OPTION*/
		html {
			overflow: hidden;
		}


		/* Prevent search bar from going off page */
		.ui-autocomplete {
			max-height: 60%;
			overflow-y: auto;
		}

		.ui-autocomplete .ui-menu-item {
			margin-bottom: 5px !important;
			padding-left: 6px !important;
			border: 1px double black;
			border-radius: 5px;
		}

		.navbar {
			--bs-bg-opacity: 1;
			background-color: rgb(0 0 0 / 50%) !important;
		}

		body {
			height: 100%;
			overflow-y: hidden;
		}

		/*CARD*/
		.card {
			width: fit-content;
			padding:5px;
			white-space: normal;
			text-align: center;
			border-radius: 10%;
			white-space: pre-line;
		}

		.btn {
			padding:20px;
		}

		/*SEARCH BAR*/
		.searchdiv {
			margin:20px 175px;
			display: flex;
			justify-content: center;
			align-items:center;
		}

		/*SEARCH CATEGORIES*/
		.ui-autocomplete-category {
			font-weight: bold;
			padding: .2em .4em 0.05em;
			margin: .1em 0 .2em;
			line-height: 1.5;
		}

		/*CARDS DROPDOWN*/
		.customer-card,.pharm-card{
			position:relative;
			margin:1em;
		}

		.pharm, .customer {
			display: none;
			position: absolute;
			z-index: 10;
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

	<%--TAB NAME--%>
	<title>PharmaFinder</title>

	<%--TO LINK AND STYLE JQUERY--%>
	<link rel = "stylesheet" href = "https://code.jquery.com/ui/1.10.4/themes/cupertino/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>

	<%--TO LINK BOOTSTRAP--%>
	<link
			href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css"
			rel="stylesheet"
			integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp"
			crossorigin="anonymous">

</head>

<body>

<%--Pop ups--%>
<%
	String success = request.getParameter("success");
	if (success != null) {
%>
<div id="successPopup">
	✅
</div>
<%
	if("log_in".equals(success)) {
%>
<script> document.getElementById("successPopup").innerHTML = "✅ Successfully logged in." </script>
<%
} else if ("registration".equals(success)) {

%>
<script> document.getElementById("successPopup").innerHTML = "✅ Account has been created successfully." </script>
<%
} else if ("log_out".equals(success)) {
%>
<script> document.getElementById("successPopup").innerHTML = "✅ Successfully logged out." </script>
<%
		}
	}

%>
<script>
	setTimeout(() => {
		const popup = document.getElementById('successPopup');
		if (popup) popup.style.display = 'none';
	}, 3000); // 3 seconds
</script>

<%--NAVIGATION BAR --%>
<div class="fullscreen">
	<nav class="navbar">
		<div class="navstart">
			<%--ICON--%>
			<svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-prescription2" viewBox="0 -4 20 25">
				<path d="M7 6h2v2h2v2H9v2H7v-2H5V8h2z"></path>
				<path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1v10.5a1.5 1.5 0 0 1-1.5 1.5h-7A1.5 1.5 0 0 1 3 14.5V4a1 1 0 0 1-1-1zm2 3v10.5a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5V4zM3 3h10V1H3z"></path>
			</svg>

			<span class="navstart homePage">PharmaFinder</span>
		</div>

		<div class="navend">
			<%
				String customerName = (String) session.getAttribute("avatar");
				String pharmName = (String) session.getAttribute("username2");
				if (session != null && session.getAttribute("user_id") != null) {
					if(customerName!=null && pharmName==null){

			%>

			<span class="navend" style="margin:0;">
				<a class="formPath" style="color:white; text-decoration: none;" href="custDashboard.jsp"><img src="<%= customerName %>" style="width:36px;height:36px;top:-2px;"></a>
			</span>
			<a href="logout" class="btn btn-outline-danger" style="margin-right:8px;">Logout</a>
			<%
			}else if(customerName==null && pharmName!=null){
			%>
			<span class="navend" style="margin:0; padding-right:6px; padding-top:4px;">
				<a class="formPath" style="text-decoration: none; color:white;" href="pharmDashboard.jsp"> <%= pharmName %></a>
			</span>
			<a href="logout" class="btn btn-outline-danger" style="margin-right:8px;">Logout</a>
			<%
					}
				}
			%>

		</div>


		<% if (session.getAttribute("user_id") == null) { %>

		<div class="navend" style="margin-top:-14px;">

			<%--Customer Card--%>
			<div class="pharm-card">
				<p class="formPath" style="color:white;">Customers</p>
				<div class="pharm">
					<div class="card" style="margin-top:5px">

						<p>Create an account or log in.</p>
						<a href="custLogIn.jsp" class="btn btn-primary">Log in</a>

						<a href="registerCust.jsp" class="btn btn-primary" style="margin-top:5px">Register</a>
					</div>

				</div>
			</div>

			<%--Pharmacy Card--%>
			<div class="customer-card">
				<p class="formPath" style="color:white;">Pharmacies</p>
				<div class="customer">
					<div class="card" style="margin-top:5px">

						<p>Register your pharmacy or log in.</p>
						<a href="pharmLogIn.jsp" class="btn btn-primary">Log in</a>
						<a href="registerPharm.jsp" class="btn btn-primary" style="margin-top:5px">Register</a>
					</div>

				</div>
			</div>
		</div>
		<% } %>
	</nav>
	<%--HEADING--%>
	<h1 style="color:white; opacity: 95%; text-shadow: 1px 1px 12px darkblue; padding-top:8%; font-size: 4.0em;">PharmaFinder</h1>

	<%--SEARCH BAR--%>
	<div class="searchdiv">
		<form class="w-100 me-3" role="search">
			<input id="mainSearch" type="search" class="form-control" placeholder="Search..." aria-label="Search">
		</form>
	</div>

</div>

<%--Functionality for Search--%>
<script>
	$( function() {

		//Custom widget based on JQuery autocomplete that adds support for categories
		$.widget( "custom.catComplete", $.ui.autocomplete, {
			_create: function() {
				this._super();
				this.widget().menu( "option", "items", "> :not(.ui-autocomplete-category)" );
			},
			_renderMenu: function( ul, items ) {
				var that = this,
						currentCategory = "";
				$.each( items, function( index, item ) {
					var li;
					if ( item.category != currentCategory ) {
						ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
						currentCategory = item.category;
					}
					li = that._renderItemData( ul, item );
					if ( item.category ) {
						li.attr( "aria-label", item.category + " : " + item.label );
					}
				});
			}
		});

		//Prepare list of pharmacy and medication names
		var queryResult = [<%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pharmafinder",
                        Utilities.getdbvar("user"), Utilities.getdbvar("pass"));

                    Statement stmt = con.createStatement();

					ResultSet rs = stmt.executeQuery("SELECT name FROM medication");
                    while(rs.next()) {
                        out.print("{label: \"" + rs.getString(1) + "\", " +
                         "category: \"Medication\"},");
                    }

					rs = stmt.executeQuery("SELECT name, zip_code, user_id FROM pharmacy JOIN address USING(address_id)");
					while(rs.next()) {
                        out.print("{label: \"" + rs.getString(1) + " - " + rs.getInt(2) +
                        	"\", user_id: \"" + rs.getInt(3) +
                        	"\", category: \"Pharmacies\"},");
                    }

					rs = stmt.executeQuery("SELECT name FROM type");
					while(rs.next()) {
						out.print("{label: \"" + rs.getString(1) + "\", " +
                         "category: \"Type\"},");
					}

                    con.close();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            %>];

		//Initialize JQuery autocomplete for search bar
		$( "#mainSearch" ).catComplete({
			source: queryResult,

			//Redirect to search page on click
			select: function( event, ui ) {
				event.preventDefault();
				if(ui.item.category === "Pharmacies") {
					location.href="/PharmaFinder/pharmacy.jsp?p=" + ui.item.user_id;
				} else {
					location.href="/PharmaFinder/search.jsp?query=" + ui.item.label +
							"&cat=" + ui.item.category;
				}
			}
		})
	});
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r134/three.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vanta@latest/dist/vanta.fog.min.js"></script>
<script>
	VANTA.FOG({
		el: "body",
		mouseControls: true,
		touchControls: true,
		gyroControls: false,
		minHeight: 200.00,
		minWidth: 200.00,
		highlightColor: 0x113858,
		midtoneColor: 0x493cae,
		lowlightColor: 0x3112b6,
		baseColor: 0x202b3d,
		blurFactor: 0.45
	})
</script>

</body>
</html>
