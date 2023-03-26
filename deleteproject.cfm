<cfparam name="url.project_id" default="">
<cfif url.project_id eq "">
    <cfset errorMsg = "No project ID specified.">
    <cflocation url="projectList.cfm?errorMsg=#errorMsg#" addtoken="no">
</cfif>

<cfquery name="getProject" datasource="arjyaTest">
    SELECT project_name, user_id
    FROM projects
    WHERE pid = <cfqueryparam value="#url.project_id#" cfsqltype="CF_SQL_INTEGER">
</cfquery>

<cfif getProject.recordCount eq 0>
    <cfset errorMsg = "Project not found.">
    <cflocation url="projectList.cfm?errorMsg=#errorMsg#" addtoken="no">
</cfif>

<cfif getProject.user_id neq session.user_id>
    <cfset errorMsg = "You are not authorized to delete this project.">
    <cflocation url="projectList.cfm?errorMsg=#errorMsg#" addtoken="no">
</cfif>

<cfquery name="deleteProject" datasource="arjyaTest">
    DELETE FROM projects
    WHERE pid = <cfqueryparam value="#url.project_id#" cfsqltype="CF_SQL_INTEGER">
</cfquery>

<cflocation url="projectList.cfm?successMsg=Project successfully deleted." addtoken="no">
