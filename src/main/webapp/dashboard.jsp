<%@ page import="com.model.User, com.model.WorkOut, com.model.Diet, com.model.WeightRecord" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Tableau de bord - SportsProgress</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* === GLOBAL === */
        body {
            font-family: "Poppins", sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #0D0D0D, #1A1A1A);
            color: #EAEAEA;
        }

        /* === HEADER === */
        header {
            background: linear-gradient(90deg, #7C4DFF, #B388FF);
            padding: 20px 40px;
            max-height: 80px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 4px 20px rgba(140, 82, 255, 0.3);
            position: relative;
        }

        header img {
            height: 110px;
            width: 120px;
            border-radius: 50%;
            margin-left: -30px;
            border: #5E35B1 solid 2px;
        }

        header h2 {
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            margin: 0;
            font-size: 24px;
            color: #fff;
            letter-spacing: 0.5px;
        }

        header button {
            background: #fff;
            color: #7C4DFF;
            border: none;
            padding: 10px 18px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        header button:hover {
            background: #EAEAEA;
            color: #5E35B1;
        }

        /* === MAIN CONTAINER === */
        .container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* === CARD STYLE === */
        section {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 25px 30px;
            margin-bottom: 30px;
            box-shadow: 0 8px 25px rgba(140, 82, 255, 0.15);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        section:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 35px rgba(179, 136, 255, 0.3);
        }

        h3 {
            color: #B388FF;
            border-bottom: 2px solid rgba(179, 136, 255, 0.2);
            padding-bottom: 8px;
            margin-bottom: 20px;
            font-size: 20px;
        }

        h4 {
            color: #D1C4E9;
            margin-top: 10px;
        }

        /* === TABLE === */
        table {
            width: 100%;
            border-collapse: collapse;
            color: #EAEAEA;
        }

        th, td {
            padding: 12px 15px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            text-align: center;
        }

        th {
            background: rgba(140, 82, 255, 0.2);
        }

        tr:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        /* === BUTTON === */
        button {
            background: linear-gradient(135deg, #7C4DFF, #B388FF);
            color: #fff;
            border: none;
            padding: 10px 16px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        button:hover {
            background: linear-gradient(135deg, #6A3DE8, #A177FF);
            transform: translateY(-2px);
        }

        /* === INPUTS === */
        input[type="number"], input[type="text"], input[type="email"], input[type="password"] {
            padding: 10px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            background-color: rgba(255, 255, 255, 0.05);
            color: #fff;
            width: 200px;
            margin-right: 10px;
        }

        input:focus {
            border-color: #B388FF;
            box-shadow: 0 0 5px rgba(179, 136, 255, 0.5);
            outline: none;
        }

        /* === LIST === */
        ul {
            list-style: none;
            padding: 0;
        }

        ul li {
            background: rgba(255, 255, 255, 0.05);
            padding: 10px 15px;
            border-radius: 10px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        ul li strong {
            color: #B388FF;
        }

        input[type="checkbox"] {
            transform: scale(1.3);
            accent-color: #B388FF;
            margin-right: 10px;
        }

        /* === CHART === */
        .chart-container {
            max-width: 600px;
            margin: 20px auto;
        }

        /* === RESPONSIVE === */
        @media (max-width: 768px) {
            header h2 {
                position: static;
                transform: none;
                text-align: center;
                margin: 10px 0;
            }

            .container {
                padding: 0 10px;
            }

            button, input {
                width: 100%;
                margin-top: 10px;
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
    <img src="images/logo.png" alt="Logo">
    <h2>Bienvenue, <%= user.getFullName() %> 👋</h2>
    <a href="auth?action=logout"><button>Se déconnecter</button></a>
</header>

<div class="container">

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
            <li>Aucun entraînement pour le moment</li>
            <% } %>
        </ul>
    </section>

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
            <li><strong><%= diet.getFoodName() %></strong> — <%= diet.getFoodDescription() %> (<%= diet.getCalories() %> kcal)</li>
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

    <section>
        <h3>⚖️ Mettre à jour votre poids</h3>
        <form action="dashboard" method="post">
            <input type="hidden" name="action" value="update_weight">
            <p>Poids actuel : <strong><%= user.getWeight() %> kg</strong></p>
            <input type="number" name="weight" step="0.1" placeholder="Entrer le nouveau poids" required>
            <button type="submit">Mettre à jour</button>
        </form>
    </section>

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
                    borderColor: '#B388FF',
                    backgroundColor: 'rgba(179,136,255,0.2)',
                    tension: 0.3,
                    pointRadius: 5,
                    pointBackgroundColor: '#B388FF'
                }]
            },
            options: {
                plugins: { legend: { display: true, labels: { color: "#EAEAEA" } } },
                scales: {
                    x: { ticks: { color: "#CCC" }, title: { display: true, text: "Date", color: "#B388FF" } },
                    y: { ticks: { color: "#CCC" }, title: { display: true, text: "Poids (kg)", color: "#B388FF" } }
                }
            }
        });
    }
</script>

</body>
</html>
