<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Inscription</title>

    <style>
        body {
            font-family: "Poppins", sans-serif;
            background: linear-gradient(135deg, #4A90E2, #50C9C3);
            margin: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start; /* 🔹 Alignement en haut */
            overflow-y: auto; /* 🔹 Permet le défilement si la page est longue */
            padding: 40px 0;
        }

        .signup-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 40px 50px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            width: 380px;
            box-sizing: border-box;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #444;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #4A90E2;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #357ABD;
        }

        .error-message {
            color: #D32F2F;
            background-color: #FFEBEE;
            border: 1px solid #D32F2F;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 15px;
            text-align: center;
        }

        .footer-link {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .footer-link a {
            color: #4A90E2;
            text-decoration: none;
            font-weight: 600;
        }

        .footer-link a:hover {
            text-decoration: underline;
        }

        @media (max-height: 700px) {
            body {
                align-items: flex-start;
                padding: 20px;
            }
        }
    </style>

    <script>
        function validateForm() {
            const weight = document.getElementById("weight").value;
            const goalWeight = document.getElementById("goalWeight").value;
            if (weight < 0 || goalWeight < 0 ) {
                alert("❌ Les valeurs de poids  ne peut pas être négative !");
                return false;
            }
            return true;
        }
    </script>
</head>

<body>
<div class="signup-container">
    <h1>Créer un compte</h1>

    <% String error = (String) request.getAttribute("errorMessage"); %>
    <% if (error != null) { %>
        <div class="error-message"><%= error %></div>
    <% } %>

    <form action="auth?action=register" method="post" onsubmit="return validateForm()">
        <label for="fullName">Nom complet</label>
        <input name="fullName" id="fullName" type="text" required>

        <label for="email">Email</label>
        <input name="email" id="email" type="email" required>

        <label for="password">Mot de passe</label>
        <input name="password" id="password" type="password" required>

        <label for="weight">Poids (kg)</label>
        <input name="weight" id="weight" type="number" step="0.1" min="0" required>

        <label for="goalWeight">Poids cible (kg)</label>
        <input name="goalWeight" id="goalWeight" type="number" step="0.1" min="0" required>

        <button type="submit">Créer un compte</button>
    </form>

    <div class="footer-link">
        <p>Déjà inscrit ? <a href="index.jsp">Se connecter</a></p>
    </div>
</div>
</body>
</html>
