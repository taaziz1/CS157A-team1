<%@ page import="usermanagement.dao.CustomerDao" %>
<%@ page import="usermanagement.model.Customer" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="usermanagement.dao.ReviewDao" %>
<%@ page import="usermanagement.model.Review" %>
<%@ page import="java.util.List" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="style.css" type="text/css">
  <title>Customer Login Page</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">

  <style>

    /* middle slot for buttons */
    .navcenter {
      flex: 1;
      display: flex;
      justify-content: center;
      gap: 25px;
      margin-right: 45px;
    }

  .custDashBorder {

  background-color: whitesmoke;
  border-radius: 25px;
  width: fit-content;
  height: fit-content;
  padding: 20px;
  box-shadow: 10px 5px 5px grey;
    margin-left: 30px;

  }

/*Review boxes*/
.reviewBox{
background-color:whitesmoke;
padding:20px;
border-radius:20px;
width:900px;
margin: 5px auto;
}

.reviewBox:hover {
  transform: scale(1.03);
}

    /* container flex so avatars wrap */
    .avatar-container {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
    }

    /* hide the native radio */
    .avatar-option input {
      position: absolute;
      opacity: 0;
      width: 0;
      height: 0;
    }

    /* the circular “frame” around each image */
    .avatar-option img {
      display: block;
      width: 100px;
      height: 100px;
      border-radius: 50%;
      object-fit: cover;
      border: 2px solid transparent;
      transition: background‐color 0.2s, border‐color 0.2s;
      cursor: pointer;
    }

    /* when the radio is checked, style the img */
    .avatar-option input:checked + img {
      background-color: #eee;
      border: 2px solid #007bff;
    }

  </style>
</head>

<body>
<%
  CustomerDao customerDao = new CustomerDao();
  int userId =(int)session.getAttribute("user_id");
  Customer customer = customerDao.getCustomerDashboard(userId);
%>

<%--Pop ups--%>
<%
  String error = request.getParameter("error");
  String success = request.getParameter("success");
  if(error != null) {

%>
<div id="errorPopup">
  ❌ An unknown error has occurred. Please try again.
</div>
<%
  if ("delete_failed".equals(error)) {
%>
  <script>document.getElementById("errorPopup").innerHTML = "❌ Account could not be deleted. Please try again.";</script>
<%
  } else if ("invalid_password".equals(error)) {
%>
  <script>document.getElementById("errorPopup").innerHTML = "❌ Password is incorrect. Please try again.";</script>
<%
  } else if ("update_fail".equals(error)) {
%>
  <script>document.getElementById("errorPopup").innerHTML = "❌ Account information could not be updated. Please try again.";</script>
<%
  } else if ("identical_pass".equals(error)) {
%>
  <script>document.getElementById("errorPopup").innerHTML = "❌ New password cannot be the same as the current password. Please try again.";</script>
<%
  } else if ("incorrect_pass".equals(error)) {
%>
  <script>document.getElementById("errorPopup").innerHTML = "❌ Current password is incorrect. Please try again.";</script>
<%
  }
}

else if ("updated_info".equals(success)) {
%>
<div id="successPopup">
  ✅ Successfully updated account information.
</div>
<%
  }
%>

<script>
  setTimeout(() => {
    const popup1 = document.getElementById('errorPopup');
    const popup2 = document.getElementById('successPopup');
    if (popup1) popup1.style.display = 'none';
    if (popup2) popup2.style.display = 'none';
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

  <div class="navcenter">
    <button type="button" class="btn btn-primary" onclick="openUpdateModal()">
      ✏️ Change Avatar
    </button>
    <!-- Reset Password Button -->
    <button type="button" onclick="openResetModal()" class="btn btn-warning">🔒 Reset Password</button>
    <!-- Delete Account Button -->
    <button type="button" onclick="openDeleteModal()" class="btn btn-danger">🗑 Delete Account</button>
  </div>

  <div class="navend">
    <a href="logout" class="btn btn-outline-danger" style="margin-right:8px;">Logout</a>
  </div>
</nav>

<!-- Update Customer Modal -->
<div id="updateCustomerModal"
     style="display:none;
            position: fixed;
            top: 0; left: 0;
            width: 100vw; height: 100vh;
            background-color: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
            z-index: 9999;
            ">
  <form action="updateCustomer"
        method="post"
        class="needs-validation"
        novalidate
        style="background: white;
               padding: 30px;
               border-radius: 10px;
               box-shadow: 0 0 10px #333;
               width: 500px;">

    <input type="hidden" name="userId" value="<%= userId %>">
      <h3 style="margin-bottom: 20px;">✏️ Choose Your Avatar</h3>

    <div class="avatar-container">
      <%
        CustomerDao customerdao = new CustomerDao();
        List<String> avList = customerdao.avatarList();
        for (String avatar : avList) {
          String[] split      = avatar.split("\\|");
          String  avatarId    = split[0];
          String  avatarPath  = split[1];
          boolean isChecked = (avatarPath.equals(customer.getAvatarDirectory())); // Check if this avatar is selected
      %>
      <label class="avatar-option">
        <input  type="radio"
                    name="avatarId"
                    value="<%= avatarId %>"
              <% if (isChecked) {%> checked="checked"<% } %>
        >

            <img src="<%= avatarPath %>"
                 alt="Avatar <%= avatarId %>"
                 style="width:90px;height:90px; display:block; margin-top:5px;" />
        </label>
      <% } %>
    </div>

    <div style="display:flex; justify-content:flex-end; gap:10px; margin-top:20px;">
      <button type="submit" class="btn btn-primary">Update Customer</button>
      <button type="button"
              class="btn btn-secondary"
              onclick="closeUpdateModal()">
        Cancel
      </button>
    </div>
  </form>
</div>

<!-- Reset Password Modal -->
<div id="resetPasswordModal" style="display:none; position: fixed; top: 0; left: 0; width: 100vw; height: 100vh;
  background-color: rgba(0, 0, 0, 0.5); justify-content: center; align-items: center; z-index: 9999;">

  <form action="custResetPassword" method="post" class="needs-validation" novalidate=""
        style="background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px #333; width: 400px;"
        class="needs-validation" novalidate>

    <h3 style="margin-bottom: 20px;">🔒 Reset Your Password</h3>

    <input type="hidden" name="user_id" value="<%= session.getAttribute("user_id") %>">

    <!-- Current Password -->
    <label for="current_password" style="font-weight: bold;">Current Password</label>
    <input type="password" id="current_password" name="current_password" required
           placeholder="Enter Current Password"
           style="padding: 8px; width: 100%; margin: 8px 0 16px 0;">

    <!-- New Password -->
    <label for="new_password" style="font-weight: bold;">New Password</label>
    <input
            type="password"
            id="new_password"
            name="new_password"
            required
            pattern="(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}"
            title="Password must contain at least one uppercase letter, one lowercase letter, one number, one special character, and be at least 8 characters long."
            placeholder="Enter New Password"
            style="padding: 8px; width: 100%; margin: 8px 0 20px 0;">
    <div class="invalid-feedback">
      Password must contain at least one uppercase, one lowercase, one number, one special character (@, $, !, %, *, ?, &), and be 8+ characters long.
    </div>

    <!-- Buttons -->
    <div style="display: flex; justify-content: flex-end; gap: 10px;">
      <button type="submit" class="comment-submit" style="background-color: #0d6efd; color: white;">Change Password</button>
      <button type="button" class="comment-submit" onclick="closeResetModal()">Cancel</button>
    </div>
  </form>
</div>


<h2 style="width: fit-content; font-size: 2.5rem; background-color: white; margin:20px auto 0; padding:10px 25px; border-radius:80px; justify-content:center;">Welcome, <%=customer.getUsername()%></h2>

<div style="display:flex; justify-content:center; padding:20px;margin-bottom:20px;">
  <div class="custDashBorder" >
  <table>
    <tr>
      <td ><img  src="<%=customer.getAvatarDirectory()%>"  alt="Avatar" width="100" height="100"></td>
    </tr>
    <tr>
      <th>User Id</th>
      <td><%=customer.getUserId()%></td>
    </tr>
    <tr>
      <th>Username</th>
      <td><%=customer.getUsername()%></td>
    </tr>

    <tr>
      <th>Email</th>
      <td><%=customer.getEmailAddress()%></td>
    </tr>

    </table>

  </div>
  </div>
<hr style=" width: 90%; margin: 0 auto;">
<h2 style="width: fit-content; font-size: 2.5rem; background-color: white; margin:20px auto 0; padding:10px 25px; border-radius:80px; justify-content:center; margin-bottom: 20px">Your Reviews</h2>
<%

ReviewDao reviewdao = new ReviewDao();
ArrayList<Review> reviews = reviewdao.getReviewList(userId);
for(Review review: reviews){
%>

<div  class="reviewBox card-body  mb-4 shadow-sm "onclick="pharmacyRedirectFunction(<%=review.getPharmacyId()%>);" >

<p style="font-size:30px;"><%=review.getPharmacy()%></p>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
 <p class="rating">
                    <span class="fa fa-star-o star1<%=review.getReviewId()%> checked"></span>
                    <span class="fa fa-star-o star2<%=review.getReviewId()%> checked"></span>
                    <span class="fa fa-star-o star3<%=review.getReviewId()%> checked"></span>
                    <span class="fa fa-star-o star4<%=review.getReviewId()%> checked"></span>
                    <span class="fa fa-star-o star5<%=review.getReviewId()%> checked"></span>
     </p>
<p><%=review.getContent()%></p>

<p style="color:grey; display:flex; justify-content:right;"><%=review.getLastDate()%></p>
<script>
function pharmacyRedirectFunction(userIdPharm){
location.href = "pharmacy.jsp?p="+userIdPharm;
console.log("test");
console.log(userIdPharm);
}

(function() {
let starRating = "<%=review.getRating()%>";

    for (let i = 1; i <= starRating; i++) {
        let star = document.querySelector(".star" + i+<%=review.getReviewId()%>);
        star.setAttribute("class", "fa fa-star checked");
        console.log("stars"+i+<%=review.getReviewId()%>);
    }

})();
</script>

</div>
<br>
<%
}
%>


<!-- Modal -->
<div id="deleteModal" style="display:none; position: fixed; top: 0; left: 0; width: 100vw; height: 100vh;
  background-color: rgba(0, 0, 0, 0.5); justify-content: center; align-items: center; z-index: 9999;">
  <form action="deleteCustomerAccount" method="POST"
        style="background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px #333;"
        onsubmit="return confirm('Are you sure you want to delete your account? This action cannot be undone.')">
    <h4>Please enter your password to confirm:</h4>
    <input type="hidden" name="user_id" value="<%= userId %>">
    <input type="password" name="password" required placeholder="Enter password"
           style="padding: 8px; width: 100%; margin-top: 10px; margin-bottom: 20px;">

    <div style="display: flex; justify-content: flex-end; gap: 10px;">
      <button type="submit" class="comment-submit" style="background-color: #dc3545;">Confirm Delete</button>
      <button type="button" class="comment-submit" onclick="closeDeleteModal()">Cancel</button>
    </div>
  </form>
</div>

<script>
  function openDeleteModal() {
    document.getElementById("deleteModal").style.display = "flex";
  }

  function closeDeleteModal() {
    document.getElementById("deleteModal").style.display = "none";
  }
</script>

<script>
  function openResetModal() {
    document.getElementById("resetPasswordModal").style.display = "flex";
  }
  function closeResetModal() {
    document.getElementById("resetPasswordModal").style.display = "none";
  }
</script>

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

<script>
  function openUpdateModal() {
    document
            .getElementById('updateCustomerModal')
            .style.display = 'flex';
  }
  function closeUpdateModal() {
    document
            .getElementById('updateCustomerModal')
            .style.display = 'none';
  }
</script>

</body>
</html>
