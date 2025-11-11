<%@ page import="com.model.User, com.model.WorkOut, com.model.Diet, com.model.WeightRecord" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de bord</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* === GLOBAL === */
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #e3f2fd, #ffffff);
            margin: 0;
            padding: 0;
            color: #333;
        }

        header {
            background: #1976d2;
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.15);
        }

        header h2 {
            margin: 0;
            font-size: 24px;
        }

        header button {
            background: white;
            color: #1976d2;
            border: none;
            padding: 8px 15px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        header button:hover {
            background: #e3f2fd;
        }

        .container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* === CARD STYLE === */
        section {
            background: white;
            border-radius: 15px;
            padding: 25px 30px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.2s ease;
        }

        section:hover {
            transform: translateY(-3px);
        }

        h3 {
            color: #1976d2;
            border-bottom: 2px solid #e3f2fd;
            padding-bottom: 8px;
            margin-bottom: 20px;
        }

        /* === TABLE === */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        th {
            background: #f0f4f8;
            color: #333;
        }

        tr:hover {
            background: #f9f9f9;
        }

        /* === FORM === */
        form {
            display: inline-block;
        }

        input[type="number"], input[type="text"], input[type="email"], input[type="password"], select {
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            width: 180px;
            font-family: inherit;
        }

        button {
            background-color: #1976d2;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #1565c0;
        }

        /* === WEIGHT CHART === */
        .chart-container {
            max-width: 600px;
            margin: 20px auto;
        }

        /* === CHECKBOX === */
        input[type="checkbox"] {
            transform: scale(1.3);
            margin-right: 10px;
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        ul li {
            background: #f8f9fa;
            margin-bottom: 10px;
            padding: 10px 15px;
            border-radius: 8px;
            display: flex;
            align-items: center;
        }

        strong {
            color: #1565c0;
        }

        /* === RESPONSIVE === */
        @media (max-width: 768px) {
            .container {
                padding: 0 10px;
            }

            table, th, td {
                font-size: 13px;
            }

            button, input[type="number"] {
                width: 100%;
                margin-top: 5px;
            }

            ul li {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<WorkOut> workouts = (List<WorkOut>) request.getAttribute("workouts");
    List<Diet> diets = (List<Diet>) request.getAttribute("diets");
    List<WeightRecord> weights = (List<WeightRecord>) request.getAttribute("weights");
%>

<header>
    <h2>Bienvenue, <%= user.getFullName() %> 👋</h2>
    <form action="logout.jsp" method="post">
        <button type="submit">Se déconnecter</button>
    </form>
</header>

<div class="container">

    <!-- Workouts -->
    <section>
        <h3>🏋️‍♂️ Vos entraînements</h3>
        <ul>
            <%
                if (workouts != null && !workouts.isEmpty()) {
                    for (WorkOut w : workouts) {
            %>
            <li>
                <form action="dashboard" method="post">
                    <input type="hidden" name="action" value="toggle_workout">
                    <input type="hidden" name="id" value="<%= w.getId() %>">
                    <input type="hidden" name="completed" value="<%= !w.isComplete() %>">
                    <input type="checkbox" onchange="this.form.submit()" <%= w.isComplete() ? "checked" : "" %> >
                    <span><strong><%= w.getName() %></strong> — <%= w.getDescription() %>
                        (<%= w.isComplete() ? "✔ Terminé" : "⏳ En cours" %>)</span>
                </form>
            </li>
            <%
                    }
                } else {
            %>
            <li>Aucun entraînement pour le moment.</li>
            <% } %>
        </ul>
    </section>

    <!-- Diet -->
    <section>
        <h3>🥗 Vos recommandations alimentaires</h3>
        <%
            if (diets != null && !diets.isEmpty()) {
                String[] types = {"breakfast", "lunch", "dinner"};
                for (String type : types) {
        %>
        <h4><%= type.substring(0,1).toUpperCase() + type.substring(1) %></h4>
        <ul>
            <%
                for (Diet diet : diets) {
                    if (diet.getType().equalsIgnoreCase(type)) {
            %>
            <li>
                <strong><%= diet.getFoodName() %></strong> — <%= diet.getFoodDescription() %>
                (<%= diet.getCalories() %> kcal)
            </li>
            <%
                    }
                }
            %>
        </ul>
        <%
            }
        } else {
        %>
        <p>Aucune recommandation disponible.</p>
        <% } %>
    </section>

    <!-- Weight Update -->
    <section>
        <h3>⚖️ Mettre à jour votre poids</h3>
        <form action="dashboard" method="post">
            <input type="hidden" name="action" value="update_weight">
            <p>Poids actuel : <strong><%= user.getWeight() %> kg</strong></p>
            <input type="number" name="weight" step="0.1" placeholder="Entrer le nouveau poids" required>
            <button type="submit">Mettre à jour</button>
        </form>
    </section>

<%-- SECTION: Vérification du poids et messages personnalisés --%>
<%
    double currentWeight = user.getWeight();
    double goalWeight = user.getGoalWeight();
    double diff = currentWeight - goalWeight;
%>

<% if (Math.abs(diff) < 0.5) { %>
    <!-- 🟢 Cas 1 : Poids parfait -->
    <section style="background: #e8f5e9; border-left: 6px solid #43a047; padding: 20px; border-radius: 10px;">
        <h3 style="color: #2e7d32;">🎉 Félicitations <%= user.getFullName() %> !</h3>
        <p style="font-size: 16px; color: #333;">
            Vous avez atteint votre poids idéal de
            <strong><%= goalWeight %> kg</strong> ! 🏆
        </p>
        <p style="font-size: 15px; color: #555;">
            Continuez à suivre le même programme d’entraînement et le même régime alimentaire
            pour <strong>maintenir</strong> votre forme actuelle. 👏
        </p>
    </section>

<% } else if (diff > 0.5) { %>
    <!-- 🟠 Cas 2 : En surpoids -->
    <section style="background: #fff8e1; border-left: 6px solid #fbc02d; padding: 20px; border-radius: 10px;">
        <h3 style="color: #f57c00;">⚖️ Objectif en cours...</h3>
        <p style="font-size: 16px; color: #333;">
            Votre poids actuel est de <strong><%= currentWeight %> kg</strong>.<br>
            Il vous reste <strong><%= String.format("%.1f", diff) %> kg</strong> à perdre pour atteindre votre objectif de
            <strong><%= goalWeight %> kg</strong>.
        </p>
        <p style="font-size: 15px; color: #555;">
            Continuez vos efforts 💪 — votre discipline vous rapproche de votre objectif jour après jour.
        </p>
    </section>

<% } else { %>
    <!-- 🔵 Cas 3 : En sous-poids -->
    <section style="background: #e3f2fd; border-left: 6px solid #2196f3; padding: 20px; border-radius: 10px;">
        <h3 style="color: #1565c0;">🍽️ Attention <%= user.getFullName() %> !</h3>
        <p style="font-size: 16px; color: #333;">
            Votre poids actuel est de <strong><%= currentWeight %> kg</strong>, soit environ
            <strong><%= String.format("%.1f", -diff) %> kg</strong> en dessous de votre poids cible de
            <strong><%= goalWeight %> kg</strong>.
        </p>
        <p style="font-size: 15px; color: #555;">
            Pensez à <strong>augmenter légèrement votre apport calorique</strong> et à consulter un diététicien si nécessaire
            pour stabiliser votre poids. 🌿
        </p>
    </section>
<% } %>


    <!-- Chart -->
    <section>
        <h3>📈 Évolution de votre poids</h3>
        <div class="chart-container">
            <canvas id="weightChart"></canvas>
        </div>

        <h4>Historique</h4>
        <table>
            <tr><th>Date</th><th>Poids (kg)</th></tr>
            <%
                if (weights != null && !weights.isEmpty()) {
                    for (WeightRecord w : weights) {
            %>
            <tr>
                <td><%= w.getDate() %></td>
                <td><%= w.getWeight() %></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr><td colspan="2">Aucun enregistrement pour l’instant.</td></tr>
            <% } %>
        </table>
    </section>

</div>



<!-- Chart.js Script -->
<script>
    const labels = [
        <% if (weights != null && !weights.isEmpty()) {
            for (WeightRecord w : weights) { %>
        "<%= w.getDate() %>",
        <% } } %>
    ];

    const data = [
        <% if (weights != null && !weights.isEmpty()) {
            for (WeightRecord w : weights) { %>
        <%= w.getWeight() %>,
        <% } } %>
    ];

    if (labels.length > 0) {
        const ctx = document.getElementById('weightChart').getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Poids (kg)',
                    data: data,
                    fill: true,
                    borderColor: '#1976d2',
                    backgroundColor: 'rgba(25,118,210,0.2)',
                    tension: 0.3,
                    pointRadius: 5,
                    pointBackgroundColor: '#1976d2'
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { display: true },
                },
                scales: {
                    y: { title: { display: true, text: 'Poids (kg)' } },
                    x: { title: { display: true, text: 'Date' } }
                }
            }
        });
    }
</script>

</body>
</html>
