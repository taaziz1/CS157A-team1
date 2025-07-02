<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
		<title>Login Page</title>
		<link rel="stylesheet" href="style.css" type="text/css">
	</head>

	<body>
		<form action="LoginServlet">

			Username 		
			<input type="text" name="un"/><br>		
		
			Password
			<input type="text" name="pw"/><br>
			
			<input class="buttonPharm" type="submit" value="submit">			
		
		</form>
	</body>
</html>