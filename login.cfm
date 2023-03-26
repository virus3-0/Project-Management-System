<!--- <cfapplication name="MyApplication" sessionmanagement="Yes"> --->
<cfif isDefined("session.loggedin") and session.loggedin>
  <cflocation url="welcome.cfm" addToken = "false">
  <cfabort>
<cfelse>
<cfset username = "" >
<cfset password = "" >
<cfset error = "" >


<cfif cgi.request_method EQ "POST">
    <cfquery name="getUser" datasource="arjyaTest">
        SELECT id, username FROM users WHERE username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.username)#"> 
            AND password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Hash(trim(form.password))#">
    </cfquery>
    <cfif getUser.recordcount EQ 0>
        <cfset error = "Username Not Found">
    <cfelse>
        <cfset session.username = getUser.username>
        <cfset session.user_id = getUser.id>
        <cfset session.loggedin = true>
        <cflocation url="welcome.cfm" addToken = "false">
    </cfif>
</cfif>
</cfif>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <style>
        body {
            background-color: #f2f2f2;
            font-family: Arial, Helvetica, sans-serif;
        }
        .form {
            width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 0 5px #ccc;
        }
        .heading {
            text-align: center;
            font-size: 30px;
            margin-bottom: 30px;
            color: #333;
        }
        input[type=text],
        input[type=password] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
            font-size: 16px;
        }
        input[type=submit] {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 16px;
        }
        a {
            color: #007bff;
            text-decoration: none;
            font-size: 16px;
        }
        p.error {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
<cfoutput>
<form action="" method="post">
    <div class="form" >
        <h1 class="heading">Login</h1>
        <cfif error NEQ "">
            <p class="error">#error#</p>
        </cfif>
        <input type="text" placeholder="username" autocomplete="off" class="username" name="username" <cfif error NEQ "">value="#(form.username)#"</cfif> required> <br><br>
        <input type="password" placeholder="password" autocomplete="off" name="password" required> <br><br>
        <button class="submit-btn">Login</button><br><br>
            <a href="register.cfm" class="link">Don't have an account? Register here</a>
</div>
</form>
</cfoutput>
</body>
</html> 