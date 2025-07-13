<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css" type="text/css">
<title>Login Page</title>

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
		</div>
	</nav>
	
	<%-- REGISTRATION --%>

    <div class=" container">
    	<h1>Register your Pharmacy</h1>
	
			<form action="registerPharmacy" method="post" class="needs-validation" novalidate="">
				<div class="row">
					<%-- TAX NUMBER --%>
					<div class="col-sm-6">
						<label for="tax_Number" class="form-label">Tax Number</label> <input
							type="text" class="form-control" id="tax_Number" name="tax_Number" placeholder=""
							value="" required="">
					</div>
					<%-- PHARMACY NAME --%>
					<div class="col-sm-6">
						<label for="pharmacy_name" class="form-label">Pharmacy
							Name</label> <input type="text" class="form-control" id="pharmacy_name" name="pharmacy_name"
							placeholder="" value="" required="">
					</div>
					<%-- USERNAME--%>
					<div class="col-sm-12">
						<label for="username" class="form-label">Username</label>
						<div class="input-group has-validation">
							<span class="input-group-text">@</span> <input type="text"
								class="form-control" id="username" name ="username" placeholder="Username"
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

					<%-- ADDRESS --%>
					<div class="col-12">
						<label for="address" class="form-label">Address</label> <input
							type="text" class="form-control" id="address" name="address"
							placeholder="1234 Main St" required="">
						<div class="invalid-feedback">Please enter your shipping
							address.</div>
					</div>
					<%-- CITY --%>
					<div class="col-12">
						<label for="city" class="form-label">City</label> <input type="text"
							class="form-control" id="city" name="city" placeholder="" required="">
						<div class="invalid-feedback">Please provide a valid city.</div>
					</div>

					<%-- STATE --%>
					<div class="col-md-6">
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
						<div class="invalid-feedback">Please provide a valid state.</div>
					</div>

					<%-- ZIPCODE --%>
					<div class="col-md-6">
						<label for="zip" class="form-label">Zip Code</label> <input
							type="number" class="form-control" id="zip" name="zip" placeholder=""
							required="">
						<div class="invalid-feedback">Zip code required.</div>
					</div>


					<%-- PHONE NUMBER --%>
					<div class="col-sm-12">
						<label for="phone" class="form-label">Phone Number</label> <span
							class="text-body-secondary">(Optional)</span><input type="text"
							class="form-control" id="phone" name="phone" placeholder="" value="">
					</div>
					<%-- FAX NUMBER --%>
					<div class="col-sm-12">
						<label for="fax" class="form-label">Fax Number</label><span
							class="text-body-secondary">(Optional)</span> <input type="text"
							class="form-control" id="fax" name="fax" placeholder="" value="">
					</div>
					<%-- URL --%>
					<div class="col-12">
						<label for="url" class="form-label"> URL <span
							class="text-body-secondary">(Optional)</span></label> <input type="url"
							class="form-control" id="url" name="url" placeholder="https://example.com">
						<div class="invalid-feedback">Please enter a valid URL
							(e.g., https://example.com)</div>
					</div>
					<%--OPERATING HOURS --%>
					<div class="col-sm-12">
						<label class="form-label">Operating Hours</label> 
						<span class="text-body-secondary"> In military time-format</span></div>
						<br>
						<label>Sunday</label><input type="text" class="form-control" name="operating_hours"
							placeholder="e.g., 09:00-17:00">
						 <label>Monday</label> <input type="text" class="form-control" name="operating_hours"
							placeholder="e.g., 09:00-17:00"> 
							<label>Tuesday</label> <input type="text" class="form-control" name="operating_hours"
							placeholder="e.g., 09:00-17:00"> 
							<label>Wednesday</label> <input type="text" class="form-control" name="operating_hours"
							placeholder="e.g., 09:00-17:00"> 
							<label>Thursday</label> <input type="text" class="form-control" name="operating_hours"
							placeholder="e.g., 09:00-17:00"> 
							<label>Friday</label> <input type="text" class="form-control" name="operating_hours"
							placeholder="e.g., 09:00-17:00">
							 <label>Saturday</label><input type="text" class="form-control" name="operating_hours"
							placeholder="e.g., 09:00-17:00">
					</div>



					<%-- BUTTON --%>
					<div class="button">

						<button class="w-100 btn btn-primary btn-lg" type="submit">Register</button>


					</div>
					<a href="index.jsp" style="text-decoration: none; color: gray;">Cancel</a>
			</form>
		</div>
	
		
</body>
</html>