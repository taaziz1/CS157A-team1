<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="style.css" type="text/css">
<title>Login Page</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-aFq/bzH65dt+w6FI2ooMVUpc+21e0SRygnTpmBvdBgSdnuTN7QbdgL+OapgHtvPp" crossorigin="anonymous">
</head>

<body>

	<main class="form-signin w-100 m-auto">
	<div class="bubble">
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

			<button class="btn btn-primary w-100 py-2 " type="submit" value="submit">Sign
				in</button>
			
		</form>
	</div>
</main>
	
</body>
</html>