<cfif NOT structKeyExists(session, "loggedin") OR NOT session.loggedin>
<cflocation url="login.cfm" addToken = "false">
<cfelse>
<cfparam name="form.project_name" default="">
<cfparam name="form.project_description" default="">
<cfparam name="form.start_date" default="">
<cfparam name="form.end_date" default="">

<cfif cgi.request_method EQ "POST">
	<cfset errors = []>

	<!--- Validate input fields --->
	<cfif trim(form.project_name) EQ "">
		<cfset arrayAppend(errors, "Please enter a project name")>
	</cfif>
	<cfif trim(form.project_description) EQ "">
		<cfset arrayAppend(errors, "Please enter a project description")>
	</cfif>
	<cfif trim(form.start_date) EQ "" OR not isDate(form.start_date)>
  <cfset arrayAppend(errors, "Please enter a valid start date (mm/dd/yyyy)")>
</cfif>
<cfif trim(form.end_date) EQ "" OR not isDate(form.end_date)>
  <cfset arrayAppend(errors, "Please enter a valid end date (mm/dd/yyyy)")>
</cfif>


	<!--- If there are no validation errors, insert the new project into the database --->
  <cfif arrayLen(errors) EQ 0>
    <cfquery name="getUser" datasource="arjyaTest">
        SELECT id FROM users WHERE username = <cfqueryparam value="#session.username#" cfsqltype="CF_SQL_VARCHAR">
    </cfquery>
    <cfset user_id = getUser.id>
    <cfquery name="insertProject" datasource="arjyaTest">
        INSERT INTO projects (project_name, project_description, start_date, end_date, user_id)
        VALUES (
            <cfqueryparam value="#form.project_name#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.project_description#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.start_date#" cfsqltype="cf_sql_date">,
            <cfqueryparam value="#form.end_date#" cfsqltype="cf_sql_date">,
            <cfqueryparam value="#user_id#" cfsqltype="CF_SQL_INTEGER">
        )
    </cfquery>
    <cfset message = "Project added successfully">
      <script>alert('Project added successfully');</script>
</cfif>
</cfif>
</cfif>


<!DOCTYPE html>
<html>
<head>
  <title>Add Project</title>
  <style>
    /* Basic reset */
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    /* Center content vertically and horizontally */
    html, body {
      height: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    /* Container for the form */
    .container {
      max-width: 500px;
      padding: 30px;
      background-color: #f5f5f5;
      border-radius: 10px;
      box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    /* Form header */
    .form-header {
      font-size: 28px;
      font-weight: bold;
      margin-bottom: 30px;
      text-align: center;
    }

    /* Form inputs */
    form {
      width: 100%;
      display: flex;
      flex-direction: column;
      align-items: flex-start;
    }

    label {
      font-size: 18px;
      font-weight: bold;
      margin-bottom: 10px;
    }

    input, textarea {
      width: 100%;
      padding: 10px;
      margin-bottom: 20px;
      border-radius: 5px;
      border: none;
      background-color: #e6e6e6;
      font-size: 16px;
    }

    button[type="submit"] {
      padding: 10px;
      border-radius: 5px;
      border: none;
      background-color: #4CAF50;
      color: white;
      font-size: 18px;
      cursor: pointer;
      transition: background-color 0.2s ease;
    }

    button[type="submit"]:hover {
      background-color: #3e8e41;
    }

    .project-list-btn {
      margin-top: 20px;
      padding: 10px;
      border-radius: 5px;
      border: none;
      background-color: #e6e6e6;
      color: black;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.2s ease;
    }

    .project-list-btn:hover {
      background-color: #d4d4d4;
    }
  </style>
</head>
<body>
  
  <!--- Display the form to add a new project --->
  <div class="container">
    <div class="form-header">Add New Project</div>
    <form method="post">
      <label>Project Name:</label>
      <input type="text" name="project_name" required>
      
      <label>Project Description:</label>
      <textarea name="project_description" required></textarea>
      
      <label>Start Date:</label>
      <input type="date" name="start_date" required min="#dateFormat(now(), 'yyyy-mm-dd')#">
      
      <label>End Date:</label>
      <input type="date" name="end_date" required min="#form.start_date#">

      <button type="submit">Add Project</button>
    </form>
    <button class="project-list-btn" type="button" onclick="location.href='projectlist.cfm'">Project List</button> 
  </div>

</body>
</html>