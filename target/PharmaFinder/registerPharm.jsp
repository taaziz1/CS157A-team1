<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pharmacy Registration</title>

	<%--TO LINK BOOTSTRAP--%>
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp"
		crossorigin="anonymous">

	<%--TO LINK STYLESHEET--%>
	<link rel="stylesheet" href="style.css" type="text/css">

	<style>
		/* Prevent scrolling */
		body {
			overflow: hidden;
		}

		.button {
			display: flex;
			padding: 20px 30px 10px;
		}

		.entry-field {
			margin: 8px 0;
		}

		.day-div {
			width: 14.2857%;
		}

		.day {
			margin: 0 0 4px;
			text-align: center;
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
<script> document.getElementById("errorPopup").innerHTML = "❌ Username or tax number already exists. Please try again." </script>
<%
} else if ("invalid_form".equals(error)) {

%>
<script> document.getElementById("errorPopup").innerHTML = "❌ One or more fields are invalid. Please try again." </script>
<%
} else if ("creation_error".equals(error)) {
%>
<script> document.getElementById("errorPopup").innerHTML = "❌ An error occurred while creating the account. Please try again." </script>
<%
		}
	}

%>
<script>
	setTimeout(() => {
		const popup = document.getElementById('errorPopup');
		if (popup) popup.style.display = 'none';
	}, 3000); // 3 seconds
</script>

	<%--NAVIGATION BAR --%>
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

	<%-- REGISTRATION CARD --%>

    <div class="container">
			<form action="registerPharmacy" method="post" class="needs-validation" novalidate=""
				  style="background-color: white; margin:25px 10%; padding:12px 30px; border-radius:20px;">
				<h1>Register Your Pharmacy</h1>
				<div class="row">

					<%-- PHARMACY NAME --%>
					<div class="col-sm-4 entry-field">
						<label for="pharmacy_name" class="form-label">Pharmacy
							Name</label> <input type="text" class="form-control" id="pharmacy_name" name="pharmacy_name"
												placeholder="Joe's Pharmacy" value="" required="">
						<div class="invalid-feedback">Your pharmacy name is required.</div>
					</div>

					<%-- TAX NUMBER --%>
					<div class="col-sm-2 entry-field">
						<label for="tax_Number" class="form-label">Tax Number</label> <input
							type="text" class="form-control" id="tax_Number" name="tax_Number" placeholder="XX-XXXXXXX"
							value="" required="" pattern="\d{2}-\d{7}">
						<div class="invalid-feedback">A valid tax number is required.</div>

					</div>

					<%-- USERNAME--%>
					<div class="col-sm-3 entry-field">
						<label for="username" class="form-label">Username</label>
						<div class="input-group has-validation">
							<span class="input-group-text">@</span> <input type="text"
								class="form-control" id="username" name ="username" placeholder="Username"
								required="">
							<div class="invalid-feedback">Your username is required.</div>
						</div>
					</div>

					<%-- PASSWORD --%>
					<div class="col-sm-3 entry-field" style="position:relative;">
						<label class="form-label">Password</label>
                     <%-- View password --%>
                      <div style=" z-index:2; position:absolute; top:38px;right:25px;">
						   <a onclick="passwordFunction()" >
                              <span id="passwordImage">
   									<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
                			      <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z"/>
                   			       <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0"/>
									</svg>
                            		</span>
                                  		</a>
                                  		</div>
						<input
								type="password"
								class="form-control"
								id="floatingPassword"
								name="password"
								placeholder="Password"
								required
								pattern="(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}"
								title="Password must contain at least one uppercase letter, one lowercase letter, one number, one special character, and be at least 8 characters long.">
						<div class="invalid-feedback">
							Password must contain at least one uppercase, one lowercase, one number, one special character (@, $, !, %, *, ?, &), and be 8+ characters long.
						</div>
					</div>

					<%-- ADDRESS --%>
					<div class="col-md-5 entry-field">
						<label for="address" class="form-label">Street Address</label> <input
							type="text" class="form-control" id="address" name="address"
							placeholder="1234 Main St" required="">
						<div class="invalid-feedback">Please enter your street
							address.</div>
					</div>

					<%-- CITY --%>
					<div class="col-md-2 entry-field">
						<label for="city" class="form-label">City</label> <input type="text"
							class="form-control" id="city" name="city" placeholder="San Jose" required="">
						<div class="invalid-feedback">Please provide a valid city.</div>
					</div>

					<%-- STATE --%>
					<div class="col-md-3 entry-field">
						<label for="state" class="form-label">State</label> <select
							class="form-select" id="state" name="state" required="">
							<option value="">Choose...</option>

							<option>Alabama</option>
							<option>Alaska</option>
							<option>Arizona</option>
							<option>Arkansas</option>
							<option>California</option>
							<option>Colorado</option>
							<option>Connecticut</option>
							<option>Delaware</option>
							<option>Florida</option>
							<option>Georgia</option>
							<option>Hawaii</option>
							<option>Idaho</option>
							<option>Illinois</option>
							<option>Indiana</option>
							<option>Iowa</option>
							<option>Kansas</option>
							<option>Kentucky</option>
							<option>Louisiana</option>
							<option>Maine</option>
							<option>Maryland</option>
							<option>Massachusetts</option>
							<option>Michigan</option>
							<option>Minnesota</option>
							<option>Mississippi</option>
							<option>Missouri</option>
							<option>Montana</option>
							<option>Nebraska</option>
							<option>Nevada</option>
							<option>New Hampshire</option>
							<option>New Jersey</option>
							<option>New Mexico</option>
							<option>New York</option>
							<option>North Carolina</option>
							<option>North Dakota</option>
							<option>Ohio</option>
							<option>Oklahoma</option>
							<option>Oregon</option>
							<option>Pennsylvania</option>
							<option>Rhode Island</option>
							<option>South Carolina</option>
							<option>South Dakota</option>
							<option>Tennessee</option>
							<option>Texas</option>
							<option>Utah</option>
							<option>Vermont</option>
							<option>Virginia</option>
							<option>Washington</option>
							<option>West Virginia</option>
							<option>Wisconsin</option>
							<option>Wyoming</option>

						</select>
						<div class="invalid-feedback">Please choose a valid state.</div>
					</div>

					<%-- ZIPCODE --%>
						<div class="col-md-2 entry-field">
							<label for="zip" class="form-label">Zip Code</label>
							<input
									type="text"
									class="form-control"
									id="zip"
									name="zip"
									placeholder=""
									required
									pattern="\d{5}"
									maxlength="5"
									title="Zip code must be exactly 5 digits">
							<div class="invalid-feedback">Zip code must be exactly 5 digits.</div>
						</div>



					<%-- PHONE NUMBER --%>
					<div class="col-sm-3 entry-field">
						<label for="phone" class="form-label">Phone Number</label> <span
							class="text-body-secondary">(Optional)</span><input type="text"
							class="form-control" id="phone" name="phone" placeholder="" value="">
					</div>

					<%-- FAX NUMBER --%>
					<div class="col-sm-3 entry-field">
						<label for="fax" class="form-label">Fax Number</label><span
							class="text-body-secondary"> (Optional)</span> <input type="text"
							class="form-control" id="fax" name="fax" placeholder="" value="">
					</div>

					<%-- URL --%>
					<div class="col-sm-6 entry-field">
						<label for="url" class="form-label"> URL <span
							class="text-body-secondary">(Optional)</span></label> <input type="url"
							class="form-control" id="url" name="url" placeholder="https://www.example.com">
						<div class="invalid-feedback">Please enter a valid URL
							(e.g., https://www.example.com)</div>
					</div>

					<%--OPERATING HOURS --%>
					<div class="col-sm-12" style="margin: 8px 0 2px">
						<label class="form-label">Operating Hours</label>
						<span class="text-body-secondary"> (e.g., 09:00-17:00)</span></div>

						 <div class="col-sm-1 day-div">
							 <label class="day">Monday</label>
							 <input type="text" class="form-control col-sm-3" name="operating_hours"
									placeholder="xx:xx-xx:xx" required="">
						 </div>
						<div class="col-sm-1 day-div">
							<label class="day">Tuesday</label>
							<input type="text" class="form-control" name="operating_hours"
								   placeholder="xx:xx-xx:xx" required="">
						</div>
						<div class="col-sm-2 day-div">
							<label class="day">Wednesday</label>
							<input type="text" class="form-control" name="operating_hours"
								   placeholder="xx:xx-xx:xx" required="">
						</div>
						<div class="col-sm-2 day-div">
							<label class="day">Thursday</label>
							<input type="text" class="form-control" name="operating_hours"
								   placeholder="xx:xx-xx:xx" required="">
						</div>
						<div class="col-sm-2 day-div">
							<label class="day">Friday</label>
							<input type="text" class="form-control" name="operating_hours"
								   placeholder="xx:xx-xx:xx" required="">
						</div>
						<div class="col-sm-2 day-div">
							<label class="day">Saturday</label>
							<input type="text" class="form-control" name="operating_hours"
								   placeholder="xx:xx-xx:xx" required="">
						</div>
						<div class="col-sm-2 day-div">
							<label class="day">Sunday</label>
							<input type="text" class="form-control" name="operating_hours"
								   placeholder="xx:xx-xx:xx" required="">
						</div>
						<div class="invalid-feedback">Please fill in each day’s operating hours. If you’re closed (or it doesn’t apply), enter **N/A**.
						</div>
				</div>

					<%-- BUTTON --%>
					<div class="button" style="width:100%; margin:auto">
						<button class="w-100 btn btn-primary btn-lg" type="submit">Register</button>
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
	<script src="index.js">
    </script>
</body>
</html>
