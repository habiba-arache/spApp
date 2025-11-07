<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
</head>
<body >
<h1  >hello from login page </h1>
<form action="auth?action=login" method="post" >
    <div >
        <div  >
            <label for="email">email:</label><input name="email" id="email" type="email" required  >
        </div>
        <div >
            <label for="password">pass:</label><input name="password" id="password" type="password" required >
        </div>
        <button type="submit" >log in</button>
    </div>
</form>
<a href="register.jsp">
    <button>create acc</button>
</a>
</body>
</html>
