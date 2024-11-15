<%@ page import="java.util.*, com.rapifuzz.assign.entity.Incident" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Incident</title>
</head>
<body>
    <h2>Create Incident</h2>

    <form action="/api/create" method="post">
        <input type="hidden" name="userId" value="<%= session.getAttribute("userId") %>"/>

        <!-- Incident ID (auto-generated) -->
        <label for="incidentId">Incident ID (auto-generated):</label>
        <input type="text" name="incidentId" id="incidentId" value="RMG<%= (int)(Math.random() * 100000) + 2022 %>" readonly/><br/><br/>

        <!-- Incident Details -->
        <label for="details">Incident Details:</label><br/>
        <textarea name="details" id="details" required></textarea><br/><br/>

        <!-- Priority -->
        <label for="priority">Priority:</label>
        <select name="priority" id="priority" required>
            <option value="High">High</option>
            <option value="Medium">Medium</option>
            <option value="Low">Low</option>
        </select><br/><br/>

        <!-- Status -->
        <label for="status">Status:</label>
        <select name="status" id="status" required>
            <option value="Open">Open</option>
            <option value="Closed">Closed</option>
        </select><br/><br/>

        <!-- Report Name -->
        <label for="reportname">Report Name:</label>
        <input type="text" name="nameReport" id="nameReport" required/><br/><br/>

        <!-- Submit Button -->
        <button type="submit" onclick="showSuccessMessage()">Create Incident</button>
    </form>

</body>
</html>
