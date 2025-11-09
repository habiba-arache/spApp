<%@ page import="com.model.User, com.model.WorkOut, com.model.Diet, com.model.WeightRecord" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background-color: #f5f7fa;
        }
        h2, h3, h4 {
            color: #333;
        }
        section {
            background: white;
            padding: 15px 25px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin-bottom: 25px;
        }
        table {
            border-collapse: collapse;
            width: 60%;
            text-align: center;
        }
        th, td {
            padding: 8px 12px;
            border: 1px solid #ccc;
        }
        th {
            background: #f0f0f0;
        }
        button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        input[type="number"] {
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #aaa;
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

<h2>Welcome, <%= user.getFullName() %>!</h2>

<!-- 1. Workouts -->
<section>
    <h3>Your Workouts</h3>
    <ul>
        <%
            if (workouts != null && !workouts.isEmpty()) {
                for (WorkOut w : workouts) {
        %>
        <li>
            <form action="dashboard" method="post" style="display:inline;">
                <input type="hidden" name="action" value="toggle_workout">
                <input type="hidden" name="id" value="<%= w.getId() %>">
                <input type="hidden" name="completed" value="<%= !w.isComplete() %>">
                <input type="checkbox" onchange="this.form.submit()" <%= w.isComplete() ? "checked" : "" %> >
                <strong><%= w.getName() %></strong> - <%= w.getDescription() %>
                (<%= w.isComplete() ? "✔ Done" : "Not done" %>)
            </form>
        </li>
        <%
            }
        } else {
        %>
        <li>No workouts available yet.</li>
        <% } %>
    </ul>
</section>

<!-- 2. Diets -->
<section>
    <h3>Your Diet Recommendations</h3>
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
            <strong><%= diet.getFoodName() %></strong> -
            <%= diet.getFoodDescription() %>
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
    <p>No diet recommendations available yet.</p>
    <% } %>
</section>

<!-- 3. Weight update form -->
<section>
    <h3>Update Your Weight</h3>
    <form action="dashboard" method="post">
        <input type="hidden" name="action" value="update_weight">
        <p>Current weight: <strong><%= user.getWeight() %> kg</strong></p>
        <input type="number" name="weight" step="0.1" required placeholder="Enter new weight">
        <button type="submit">Update Weight</button>
    </form>
</section>

<!-- 4. Chart + history -->
<section style="text-align:center;">
    <h3>Your Weight Progress</h3>

    <div style="width:400px; height:250px; margin:0 auto;">
        <canvas id="weightChart" width="400" height="250"></canvas>
    </div>

    <h4>Weight History</h4>
    <table style="margin: 0 auto;">
        <tr><th>Date</th><th>Weight (kg)</th></tr>
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
        <tr><td colspan="2">No weight records yet.</td></tr>
        <% } %>
    </table>
</section>

<!-- Chart.js -->
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
                    label: 'Weight over Time',
                    data: data,
                    fill: false,
                    borderColor: 'rgb(75, 192, 192)',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: { title: { display: true, text: 'Weight (kg)' } },
                    x: { title: { display: true, text: 'Date' } }
                }
            }
        });
    }
</script>

</body>
</html>
