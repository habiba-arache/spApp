<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign-up</title>
</head>
<body>
<h1>hello from signup page </h1>
<% String error = (String) request.getAttribute("errorMessage"); %>
<% if (error != null) { %>
<div style="color: red; margin-bottom: 10px;">
    <%= error %>
</div>
<% } %>
<form action="auth?action=register" method="post">
    <div>
        <label for="fullName">fullName:</label><input name="fullName" id="fullName" type="text" required>
    </div>
    <div>
        <label for="email">email:</label><input name="email" id="email" type="email" required>
    </div>
    <div>
        <label for="password">pass:</label><input name="password" id="password" type="password" required>
    </div>
    <div>
        <label for="weight">weigh(kg):</label><input name="weight" id="weight" type="number" required>
    </div>
    <div>
        <label for="goalWeight">goal weight(kg):</label><input name="goalWeight" id="goalWeight" type="number" required>
    </div>
    <div>
        <label for="length">length(cm):</label><input name="length" id="length" type="number" required>
    </div>
    <div>
        <label for="age">age:</label><input name="age" id="age" type="number" required>
    </div>
    <div>
        <label for="gender">gender:</label><select name="gender" id="gender" required>
        <option>male</option>
        <option>female</option>
    </select>
    </div>
    <button type="submit">create account</button>
</form>
</body>
</html>
