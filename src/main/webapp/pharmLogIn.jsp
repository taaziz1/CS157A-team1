<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1256">
<title>Login Page</title>
<link rel="stylesheet" href="style.css" type="text/css">
</head>

<body>

	<main class="form-signin w-100 m-auto">
		<form action="LoginServlet">
			<h1 class="h3 mb-3 fw-normal">Please sign in</h1>
			<div class="form-floating">
				<input type="text" class="form-control" id="floatingInput"
					placeholder="Username" data-listener-added_c045737e="true" name="un">
				<label for="floatingInput">Username</label>
			</div>
			<div class="form-floating">
				<input type="text" class="form-control" id="floatingPassword"
					placeholder="Password"> <label for="floatingPassword" name="pw">Password</label>
			</div>

			<button class="btn btn-primary w-100 py-2 buttonPharm" type="submit" value="submit">Sign
				in</button>
			
		</form>
	
</main>


	

		

	</form>
</body>
</html>