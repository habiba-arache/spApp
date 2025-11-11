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
            background: linear-gradient(135deg, #0d0d0d, #1a1a1a);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #f5f5f5;
        }

        /* ====== LOGIN CONTAINER ====== */
        .login-container {
            background: #111;
            padding: 45px 50px;
            border-radius: 18px;
            box-shadow: 0 0 25px rgba(128, 0, 255, 0.3);
            width: 380px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .login-container:hover {
            transform: translateY(-4px);
            box-shadow: 0 0 35px rgba(157, 78, 221, 0.6);
        }

        /* ====== TITLE ====== */
        h1 {
            color: #bb86fc; /* soft purple */
            margin-bottom: 30px;
            font-size: 26px;
            letter-spacing: 1px;
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
            color: #ddd;
        }

        input {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #333;
            background: #1e1e1e;
            color: #f5f5f5;
            font-size: 14px;
            outline: none;
            transition: all 0.2s ease;
        }

        input::placeholder {
            color: #999;
        }

        input:focus {
            border-color: #9b5de5;
            box-shadow: 0 0 6px rgba(155, 93, 229, 0.4);
        }

        /* ====== BUTTONS ====== */
        button {
            background: linear-gradient(135deg, #9b5de5, #6a00f4);
            color: #fff;
            border: none;
            padding: 12px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }

        button:hover {
            background: linear-gradient(135deg, #b85cff, #8a2be2);
            box-shadow: 0 0 15px rgba(155, 93, 229, 0.5);
        }

        /* ====== FOOTER LINKS ====== */
        .register-link {
            display: block;
            margin-top: 15px;
            color: #bb86fc;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s ease;
        }

        .register-link:hover {
            color: #d6b3ff;
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
