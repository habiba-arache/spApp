<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Inscription - SportsProgress</title>
    <style>
        /* ====== GLOBAL ====== */
        body {
            font-family: "Poppins", sans-serif;
            background: linear-gradient(135deg, #0D0D0D, #1A1A1A);
            margin: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px;
            color: #EAEAEA;
        }

        /* ====== CONTAINER ====== */
        .signup-container {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            padding: 40px 50px;
            border-radius: 18px;
            box-shadow: 0 10px 30px rgba(140, 82, 255, 0.3);
            width: 400px;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }

        .signup-container:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 40px rgba(140, 82, 255, 0.5);
        }

        /* ====== TITLE ====== */
        h1 {
            text-align: center;
            color: #B388FF;
            font-size: 28px;
            margin-bottom: 30px;
            letter-spacing: 0.5px;
            white-space: nowrap;
        }

        /* ====== LABELS & INPUTS ====== */
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #E0E0E0;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-bottom: 18px;
            border-radius: 10px;
            border: 1px solid #3C3C3C;
            background-color: #1C1C1C;
            color: #F5F5F5;
            font-size: 14px;
            outline: none;
            transition: all 0.3s ease;
        }

        input:focus {
            border-color: #B388FF;
            box-shadow: 0 0 6px rgba(179, 136, 255, 0.4);
        }

        /* ====== BUTTON ====== */
        button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #7C4DFF, #B388FF);
            color: #fff;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        button:hover {
            background: linear-gradient(135deg, #6A3DE8, #A177FF);
            transform: translateY(-2px);
        }

        /* ====== ERROR MESSAGE ====== */
        .error-message {
            color: #FF8A80;
            background-color: rgba(255, 82, 82, 0.1);
            border: 1px solid #FF5252;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 15px;
            text-align: center;
        }

        /* ====== FOOTER LINK ====== */
        .footer-link {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #CCCCCC;
        }

        .footer-link a {
            color: #B388FF;
            text-decoration: none;
            font-weight: 600;
        }

        .footer-link a:hover {
            text-decoration: underline;
        }

        @media (max-width: 480px) {
            .signup-container {
                width: 90%;
                padding: 30px 25px;
            }
        }
    </style>

    <script>
        function validateForm() {
            const weight = document.getElementById("weight").value;
            const goalWeight = document.getElementById("goalWeight").value;
            if (weight < 0 || goalWeight < 0) {
                alert("❌ Weight values cannot be negative!");
                return false;
            }
            return true;
        }
    </script>
</head>

<body>
<div class="signup-container">
    <h1>CREATE ACCOUNT✨</h1>

    <% String error = (String) request.getAttribute("errorMessage"); %>
    <% if (error != null) { %>
    <div class="error-message"><%= error %></div>
    <% } %>

    <form action="auth?action=register" method="post" onsubmit="return validateForm()">
        <label for="fullName">Full Name</label>
        <input name="fullName" id="fullName" type="text" required>

        <label for="email">Email</label>
        <input name="email" id="email" type="email" required>

        <label for="password">Password</label>
        <input name="password" id="password" type="password" required>

        <label for="weight">Current Weight (kg)</label>
        <input name="weight" id="weight" type="number" step="0.1" min="0" required>

        <label for="goalWeight">Goal Weight (kg)</label>
        <input name="goalWeight" id="goalWeight" type="number" step="0.1" min="0" required>

        <button type="submit">Create account</button>
    </form>

    <div class="footer-link">
        <p>Already registered?<a href="index.jsp">Login</a></p>
    </div>
</div>
</body>
</html>
