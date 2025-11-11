<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - SportsProgress</title>
    <style>
        /* ====== GLOBAL ====== */
        body {
            margin: 0;
            padding: 0;
            font-family: "Poppins", sans-serif;
            background: linear-gradient(135deg, #1a73e8, #4a90e2);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* ====== LOGIN CONTAINER ====== */
        .login-container {
            background-color: #ffffff;
            padding: 40px 50px;
            border-radius: 16px;
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.15);
            width: 380px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .login-container:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        /* ====== TITLE ====== */
        h1 {
            color: #1a73e8;
            margin-bottom: 30px;
            font-size: 26px;
        }

        /* ====== FORM ELEMENTS ====== */
        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        label {
            display: block;
            text-align: left;
            margin-bottom: 6px;
            font-weight: 500;
            color: #333;
        }

        input {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #ccc;
            outline: none;
            font-size: 14px;
            transition: all 0.2s ease;
        }

        input:focus {
            border-color: #1a73e8;
            box-shadow: 0 0 4px rgba(26, 115, 232, 0.3);
        }

        /* ====== BUTTONS ====== */
        button {
            background-color: #1a73e8;
            color: #fff;
            border: none;
            padding: 12px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: background 0.3s ease;
        }

        button:hover {
            background-color: #155ab6;
        }

        /* ====== FOOTER LINKS ====== */
        .register-link {
            display: block;
            margin-top: 15px;
            color: #1a73e8;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s ease;
        }

        .register-link:hover {
            color: #0f4fa8;
        }

        /* ====== RESPONSIVE ====== */
        @media (max-width: 480px) {
            .login-container {
                width: 90%;
                padding: 30px 25px;
            }
        }
    </style>
</head>

<body>
<div class="login-container">
    <h1>Welcome Back 👋</h1>
    <form action="auth?action=login" method="post">
        <div>
            <label for="email">Email</label>
            <input name="email" id="email" type="email" placeholder="Enter your email" required>
        </div>

        <div>
            <label for="password">Password</label>
            <input name="password" id="password" type="password" placeholder="Enter your password" required>
        </div>

        <button type="submit">Log In</button>
    </form>

    <a class="register-link" href="register.jsp">Don’t have an account? Create one</a>
</div>
</body>
</html>
