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

	<style>
	/*PREVENTS SCROLLING OPTION*/
	.html {
		overflow:hidden;
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
		margin:20px 100px;
		display:flex;
		justify-content: center;
		align-items:center;
	}

	/*SEARCH CATEGORIES*/
	.ui-autocomplete-category {
		font-weight: bold;
		padding: .2em .4em;
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

	<%--LINKS TO THE CSS PAGE--%>
	<link rel="stylesheet" href="style.css" type="text/css">

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
				 <%
					 String pharmacyName = (String) session.getAttribute("username");
					 if (session != null && session.getAttribute("user_id") != null) {
				 %>
				 <span class="me-2">Welcome, <strong><%= pharmacyName %></strong></span>
				 <a href="logout" class="btn btn-outline-danger">Logout</a>
				 <%
					 }
				 %>
			 </div>


	<% if (session.getAttribute("user_id") == null) { %>
		 <%--PHARMACY CARD--%>
	  <div class="pharm-card">
			<p class="formPath">Customers</p>
			<div class="pharm">
			<div class="card">

					<p>Make an account or log in.</p>
					<a href="custLogIn.jsp" class="btn btn-primary">Log in</a>
					<a href="registerCust.jsp" class="btn btn-primary">Register</a>
				</div>

		</div>
	</div>
	<%--USER CARD--%>
		<div class="customer-card">
			<p class="formPath">Pharmacies</p>
			<div class="customer">
			<div class="card">

					<p>Register your pharmacy or log in.</p>
					<a href="pharmLogIn.jsp" class="btn btn-primary">Log in</a>
					<a href="registerPharm.jsp" class="btn btn-primary">Register</a>
				</div>

		</div>
	</div>
	<% } %>
	</nav>
		<%--HEADING--%>
		<h1>Welcome to PharmaFinder</h1>

		<%--PHARMACY CARD--%>

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
						window.location.href = window.location.origin +
								"/pharmacy.jsp?p=" + ui.item.user_id;
					} else {
						window.location.href = window.location.origin +
								"/search.jsp?query=" + ui.item.label +
								"&cat=" + ui.item.category;
					}
				}
			})

			.data( "ui-autocomplete" )._renderItem = function( ul, item ) {
				return $( "<li>" )
					.append( "<a>" + item.label + "<br>" + "</a>" )
					.appendTo( ul );
			};

		});
	</script>
</body>
</html>