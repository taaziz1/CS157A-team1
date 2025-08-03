<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>

  <%--LINKS TO THE CSS PAGE--%>
  <link rel="stylesheet" href="style.css" type="text/css">

  <%--TO LINK BOOTSTRAP--%>
  <link
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp"
          crossorigin="anonymous">

  <title>Edit Medication </title>

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
  if("missing_fields".equals(error)) {
%>
<script> document.getElementById("errorPopup").innerHTML = "❌ One or more fields are missing. Please try again." </script>
<%
} else if ("update_failed".equals(error)) {
%>
<script> document.getElementById("errorPopup").innerHTML = "❌ Could not update the medication listing. Please try again." </script>
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

<%--NAVIGATION BAR--%>
<nav class=" bg-body-tertiary navbar">
  <div class="navstart">
    <%--ICON--%>
    <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35"
         fill="currentColor" class="bi bi-prescription2" viewBox="0 -4 20 25">
      <path d="M7 6h2v2h2v2H9v2H7v-2H5V8h2z"></path>
      <path
              d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1v10.5a1.5 1.5 0 0 1-1.5 1.5h-7A1.5 1.5 0 0 1 3 14.5V4a1 1 0 0 1-1-1zm2 3v10.5a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5V4zM3 3h10V1H3z"></path>
    </svg>

      <a  class="navstart homePage" href="index.jsp"><strong>PharmaFinder</strong></a>
  </div>
</nav>
<%
  String medIdParam = request.getParameter("med_id");
  String userIdParam = request.getParameter("user_id");

%>


<main class="form-signin w-100 m-auto" >
  <div class="bubble" style="background-color:white;padding:20px;border-radius:20px;">
  <h3>Edit Medication</h3>
<form method="post" action="updateMedication" class="needs-validation" novalidate>

  <input type="hidden" name="med_id" value="<%= medIdParam %>" />
  <input type="hidden" name="user_id" value="<%= userIdParam %>" />

  <div class="form-floating" styLe="margin:5px;">
  <input type="text"  pattern="^\d+\.\d{2}$" title="Must be valid price" name="price" id="price" required  class="form-control">
  <label for="price">Price:</label>
  <div class="invalid-feedback">
          Must be a valid price (eg:0.99,34.66)
        </div>
  </div>


    <div class="form-floating" styLe="margin:5px;">
  <input type="number" min="0" name="qty" id="qty" class="form-control" required >
    <label for="qty">Quantity:</label>
    <div class="invalid-feedback">
          Quantity must be a positive number.
        </div>
  </div>
  <div styLe="margin:5px;">
  <input class="btn btn-primary w-100 py-2 " type="submit" value="Update Medication" />
    <a href="pharmDashboard.jsp" style="color:grey;text-decoration:none; display:flex;justify-content:center;">Cancel</a>
</div>
</form>
  </div>
</main>

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
