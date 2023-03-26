<cfquery name="getProject" datasource="arjyaTest">
    SELECT pid, project_name, project_description, start_date, end_date
    FROM projects
    WHERE pid = <cfqueryparam value="#url.project_id#" cfsqltype="CF_SQL_INTEGER">
</cfquery>
<cfset project_id = getproject.pid>


<cfoutput>
<form name="editProjectForm" method="post" action="updateProject.cfm">
    <input type="hidden" name="project_id" value="#getProject.pid#">
    <label for="project_name">Project Name:</label>
    <input type="text" name="project_name" value="#getProject.project_name#" required>
    <br><br>
    <label for="project_description">Project Description:</label>
    <textarea name="project_description" required>#getProject.project_description#</textarea>
    <br><br>
    <label for="start_date">Start Date:</label>
    <input type="date" name="start_date" value="#dateFormat(getProject.start_date, 'yyyy-mm-dd')#" required>
    <br><br>
    <label for="end_date">End Date:</label>
    <input type="date" name="end_date" value="#dateFormat(getProject.end_date, 'yyyy-mm-dd')#" required>
    <br><br>
    <button type="submit">Update Project</button>
</form>
</cfoutput>
<div style="text-align: left; margin-top: 10px;">
    <button class="project-list-btn" type="button" onclick="location.href='projectList.cfm'">Back to Project List</button>
</div>
