<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="usermanagement.model.Medication" %>
<html>
<head>
  <title>Edit Medication</title>
</head>
<body>
<%

  String medIdParam = request.getParameter("med_id");
  String userIdParam = request.getParameter("user_id");

%>

<h2>Edit Medication Display::</h2>

<form method="post" action="updateMedication">
  <input type="hidden" name="med_id" value="<%= medIdParam %>" />
  <input type="hidden" name="user_id" value="<%= userIdParam %>" />

  <label for="price">Price:</label>
  <input type="text" name="price" id="price" required /><br><br>

  <label for="qty">Quantity:</label>
  <input type="number" name="qty" id="qty" required /><br><br>

  <input type="submit" value="Update Medication" />
</form>
</body>
</html>
