<!--- <cfif not isDefined("session")> 
  <cfset session = "">
</cfif>--->

<cfset StructClear(session)>
<cflocation url="login.cfm" addToken="false">
