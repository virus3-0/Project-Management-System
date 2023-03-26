<cfif NOT structKeyExists(session, "loggedin") OR NOT session.loggedin>
<cflocation url="login.cfm" addToken = "false">
</cfif>

<cfquery name="getProjects" datasource="arjyaTest">
    SELECT pid, project_name, project_description, start_date, end_date 
    FROM projects
    WHERE user_id = <cfqueryparam value="#session.user_id#" cfsqltype="CF_SQL_INTEGER">
</cfquery>

<!DOCTYPE html>
<html>
<head>
	<title>Project List</title>
	<style>
		table {
			border-collapse: collapse;
			width: 100%;
			margin-bottom: 20px;
			font-family: Arial, Helvetica, sans-serif;
		}
		table th {
			background-color: #0077b6;
			color: white;
			padding: 12px;
			text-align: center;
		}
		table td {
			border: 1px solid #ddd;
			padding: 8px;
			text-align: left;
		}
		table tr:nth-child(even) {
			background-color: #f2f2f2;
		}
		table tr:hover {
			background-color: #e2e2e2;
		}
		.project-list-btn {
			background-color: #0077b6;
			border: none;
			color: white;
			padding: 12px 24px;
			text-align: center;
			text-decoration: none;
			display: inline-block;
			font-size: 16px;
			margin: 4px 2px;
			cursor: pointer;
			border-radius: 5px;
		}
		.project-list-btn:hover {
			background-color: #005d8f;
		}
		.project-list-btn:active {
			background-color: #004d73;
		}
	</style>
</head>
<body>
	<table border="1" cellpadding="5" cellspacing="0">
	    <tr>
	        <th>Serial No</th>
	        <th>Project Name</th>
	        <th>Project Description</th>
	        <th>Start Date</th>
	        <th>End Date</th>
	        <th>Action</th>
	    </tr>
	    <cfset index = 1>
	    <cfoutput query="getProjects">
	        <tr>
	            <td align="center">#index#</td>
	            <td>#project_name#</td>
	            <td>#project_description#</td>
	            <td>#dateFormat(start_date, 'mm/dd/yyyy')#</td>
	            <td>#dateFormat(end_date, 'mm/dd/yyyy')#</td>
	            <td>
	                <a href="editProject.cfm?project_id=#pid#">Edit</a>/
	                <a href="deleteProject.cfm?project_id=#pid#">Delete</a>
	            </td>
	        </tr>
	        <cfset index++>
	    </cfoutput>
	</table>

	<div style="text-align: left; margin-bottom: 10px;">
	    <button class="project-list-btn" type="button" onclick="location.href='addProject.cfm'">Add Project</button>
	</div>

	<div style="text-align: right; margin-top: 10px;">
	    <button class="project-list-btn" type="button" onclick="location.href='logout.cfm'">Log Out</button>
	</div>
</body>
</html>
