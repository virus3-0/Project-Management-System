<cfif structKeyExists(form, "project_id") AND isNumeric(form.project_id)>
    <cfquery name="updateProject" datasource="arjyaTest">
        UPDATE projects
        SET project_name = <cfqueryparam value="#form.project_name#" cfsqltype="CF_SQL_VARCHAR">,
            project_description = <cfqueryparam value="#form.project_description#" cfsqltype="CF_SQL_VARCHAR">,
            start_date = <cfqueryparam value="#form.start_date#" cfsqltype="CF_SQL_TIMESTAMP">,
            end_date = <cfqueryparam value="#form.end_date#" cfsqltype="CF_SQL_TIMESTAMP">
        WHERE pid = <cfqueryparam value="#form.project_id#" cfsqltype="CF_SQL_INTEGER">
    </cfquery>
        <p>Project updated successfully!</p>
        <button type="button" onclick="location.href='projectList.cfm'">Back to Project List</button>
    <cfelse>
        <p>Failed to update project!</p>
        <button type="button" onclick="history.back()">Go Back</button>
</cfif>
