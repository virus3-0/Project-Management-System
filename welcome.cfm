<!--- <cfapplication name="MyApplication" sessionmanagement="yes"> --->
<cfif NOT structKeyExists(session, "loggedin") OR NOT session.loggedin>
<cflocation url="login.cfm" addToken = "false">
<cfelse>
<style>
  body {
    background-color: #f7f7f7;
    font-family: 'Segoe UI', sans-serif;
    font-size: 16px;
    line-height: 1.5;
    color: #333;
  }

  .container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100vh;
  }
  
  h1 {
    font-size: 48px;
    color: #333;
    margin-top: 50px;
    margin-bottom: 30px;
    text-align: center;
  }
  
  p {
    font-size: 24px;
    color: #666;
    margin-bottom: 50px;
    text-align: center;
  }

  form {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 50px;
  }

  input[type="submit"], .view_project {
    background-color: #333;
    color: #fff;
    border: none;
    padding: 15px 30px;
    font-size: 18px;
    border-radius: 5px;
    cursor: pointer;
    margin-left: 20px;
    text-transform: uppercase;
    transition: all 0.3s ease-in-out;
  }

  input[type="submit"]:hover, .view_project:hover {
    background-color: #666;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  }
  
  .view_project {
    background-color: #f7f7f7;
    color: #333;
    border: 2px solid #333;
    transition: all 0.3s ease-in-out;
  }

  .view_project:hover {
    background-color: #333;
    color: #fff;
    border: 2px solid #fff;
  }
</style>

<div class="container">
  <!--- User is authenticated, show the welcome message --->
  <h1>Welcome, <cfoutput>#session.username#</cfoutput>!</h1>
  <p>You have successfully logged in.</p>

  <!---logout button to the form --->
  <form method="post" action="">
    <input type="hidden" name="logout" value="true">
    <input type="submit" value="Logout">
    <button class="view_project" type="button" onclick="location.href='projectlist.cfm'">View Projects</button> 
  </form>
</div>

<cfif structKeyExists(form, "logout")>
  <!--- User has clicked "Logout" button. Set session variables to log user out. --->
  <cfset session.username = "">
  <cfset session.loggedin = false>
  
  <!--- Redirect user to login page --->
  <cflocation url="login.cfm" addtoken="false">
</cfif>
</cfif>