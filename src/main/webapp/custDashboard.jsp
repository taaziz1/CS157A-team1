<%@ page import="usermanagement.dao.CustomerDao" %>
<%@ page import="usermanagement.model.Customer" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="usermanagement.dao.ReviewDao" %>
<%@ page import="usermanagement.model.Review" %>

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
    <!-- Delete Account Button -->
      <button type="button" onclick="openDeleteModal()" class="btn btn-danger">🗑 Delete Account</button>
    <!-- Update Account Button -->
      <form action="custUpdate.jsp" method="get">
        <input type="hidden" name="userId" value="<%= userId %>">
        <input type="hidden" name="avatarID" value="<%=customer.getAvatarId()%>">
        <a href="custUpdate.jsp?userId=<%= userId %>&avatarID=<%=customer.getAvatarId()%>" type="submit" class="btn btn-primary">
          ✏️ Update Account
        </a>
      </form>
  </div>

<div class="navend">
  <a href="logout" class="btn btn-outline-danger" style="margin-right:8px;">Logout</a>
</div>



</nav>


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

</body>
</html>
