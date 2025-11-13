<%@ page import="com.model.User, com.model.WorkOut, com.model.Diet, com.model.WeightRecord" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  <!-- core JSTL tags -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  <!-- string functions -->
<%@ page isELIgnored="false" %>
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
%>

<header>
    <img src="images/logo.png" alt="Logo">
    <h2>Bienvenue, <%= user.getFullName() %> 👋</h2>
    <a href="auth?action=logout"><button>Se déconnecter</button></a>
</header>

<div class="container">
    <section>
        <h3>🏋️‍♂️ Vos entraînements</h3>

        <c:choose>
            <c:when test="${not empty workouts}">
                <ul>
                    <c:forEach var="w" items="${workouts}">
                        <li>
                            <form action="dashboard" method="post">
                                <input type="hidden" name="action" value="toggle_workout">
                                <input type="hidden" name="id" value="${w.id}">
                                <input type="hidden" name="completed" value="${not w.complete}">

                                <input
                                        type="checkbox"
                                        onchange="this.form.submit()"
                                        <c:if test="${w.complete}">checked</c:if>
                                >

                                <span>
                                <strong>${w.name}</strong> — ${w.description}
                                <c:choose>
                                    <c:when test="${w.complete}">✔ Terminé</c:when>
                                    <c:otherwise>⏳ En cours</c:otherwise>
                                </c:choose>
                            </span>
                            </form>
                        </li>
                    </c:forEach>
                </ul>
            </c:when>

            <c:otherwise>
                <ul>
                    <li>Aucun entraînement pour le moment</li>
                </ul>
            </c:otherwise>
        </c:choose>
    </section>


    <section>
        <h3>🥗 Vos recommandations alimentaires</h3>

        <c:choose>
            <c:when test="${not empty diets}">
                <c:set var="types" value="breakfast,lunch,dinner" />
                <c:forEach var="type" items="${fn:split(types, ',')}">
                    <h4>${fn:toUpperCase(fn:substring(type, 0, 1))}${fn:substring(type, 1, fn:length(type))}</h4>
                    <ul>
                        <c:forEach var="diet" items="${diets}">
                            <c:if test="${fn:toLowerCase(diet.type) eq fn:toLowerCase(type)}">
                                <li>
                                    <strong>${diet.foodName}</strong> — ${diet.foodDescription} (${diet.calories} kcal)
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </c:forEach>
            </c:when>

            <c:otherwise>
                <p>Aucune recommandation disponible.</p>
            </c:otherwise>
        </c:choose>
    </section>

    <section>
        <h3>⚖️ Mettre à jour votre poids</h3>
        <form action="dashboard" method="post">
            <input type="hidden" name="action" value="update_weight">
            <p>Poids actuel : <strong>${ user.getWeight()} kg</strong></p>
            <input type="number" name="weight" step="0.1" placeholder="Entrer le nouveau poids" required>
            <button type="submit">Mettre à jour</button>
        </form>
    </section>


    <%-- SECTION: Vérification du poids et messages personnalisés (green/yellow/red theme) --%>
    <%
        double currentWeight = user.getWeight();
        double goalWeight = user.getGoalWeight();
        double diff = currentWeight - goalWeight;
    %>

    <% if (Math.abs(diff) < 0.5) { %>
    <!-- 🟢 Cas 1 : Poids idéal -->
    <section style="background: #e8f5e9; border-left: 6px solid #2e7d32; padding: 20px; border-radius: 10px;">
        <h3 style="color: #1b5e20;">🎉 Félicitations <%= user.getFullName() %> !</h3>
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
    <!-- 🟡 Cas 2 : En surpoids -->
    <section style="background: #fffde7; border-left: 6px solid #fbc02d; padding: 20px; border-radius: 10px;">
        <h3 style="color: #f57f17;">⚖ Objectif en cours...</h3>
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
    <!-- 🔴 Cas 3 : En sous-poids -->
    <section style="background: #ffebee; border-left: 6px solid #d32f2f; padding: 20px; border-radius: 10px;">
        <h3 style="color: #b71c1c;">🍽 Attention <%= user.getFullName() %> !</h3>
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

    <section>
        <h3>📈 Évolution de votre poids</h3>

        <div class="chart-container">
            <canvas id="weightChart"></canvas>
        </div>

        <h4>Historique</h4>
        <table>
            <tr>
                <th>Date</th>
                <th>Poids (kg)</th>
            </tr>
             <c:choose>
                <c:when test="${not empty weights}">
                    <c:forEach var="w" items="${weights}">
                        <tr>
                            <td>${w.date}</td>
                            <td>${w.weight}</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="2">Aucun enregistrement pour l’instant.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </table>
    </section>

    <!-- ============= chart script ============== -->
    <script>
        const labels = [
            <c:forEach var="w" items="${weights}" varStatus="loop">
            "${w.date}"<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ];

        const data = [
            <c:forEach var="w" items="${weights}" varStatus="loop">
            ${w.weight}<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
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
                    plugins: {
                        legend: { display: true, labels: { color: "#EAEAEA" } }
                    },
                    scales: {
                        x: {
                            ticks: { color: "#CCC" },
                            title: { display: true, text: "Date", color: "#B388FF" }
                        },
                        y: {
                            ticks: { color: "#CCC" },
                            title: { display: true, text: "Poids (kg)", color: "#B388FF" }
                        }
                    }
                }
            });
        }
    </script>


</body>
</html>
