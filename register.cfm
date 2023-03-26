<!--- <cfapplication name="MyApplication" sessionmanagement="Yes"> --->
<cfif isDefined("session.loggedin") and session.loggedin>
  <cflocation url="welcome.cfm" addToken = "false">
  <cfabort>
</cfif>
<cfset username = "" >
<cfset password = "" >
<cfset confirm_password = "" >
<cfset email = "" >
<cfset username_err = "" >
<cfset password_err = "" >
<cfset confirm_password_err = "" >
<cfset email_err = "" >
<cfset error = "" >

<cfif cgi.request_method EQ "POST">
    <!--- Check if username is empty --->
    <cfif trim(form.username) EQ "">
        <cfset username_err = "Username cannot be blank">
    <cfelse>
        <!--- Prepare a select statement --->
        <cfquery name="getUser" datasource="arjyaTest">
            SELECT id FROM users WHERE username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.username)#">
        </cfquery>
        <cfif getUser.recordcount NEQ 0>
            <cfset username_err = "* USERNAME already taken *">
        <cfelse>
            <cfset username = trim(form.username)>
        </cfif>
    </cfif>

    <!--- Check for email --->
    <cfif trim(form.email) EQ "">
        <cfset email_err = "Email cannot be blank">
    <cfelse>
        <cfquery name="getEmail" datasource="arjyaTest">
        SELECT id FROM users WHERE email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(form.email)#">
        </cfquery>
        <cfif getEmail.recordcount NEQ 0>
            <cfset email_err = "* Email ID already taken *">
        <cfelse>
            <cfset email = trim(form.email)>
        </cfif>
    </cfif>

    <!--- Check for password --->
    <cfif trim(form.password) EQ "">
        <cfset password_err = "Password cannot be blank">
    <cfelseif len(trim(form.password)) LT 6>
    <cfset password_err = "Password must be at least 6 characters long">
    <cfelseif not refind("(?=.*[A-Z])(?=.*[a-z])(?=.*[^a-zA-Z0-9])", form.password)>
    <cfset password_err = "Password must contain at least 1 uppercase letter, 1 lowercase letter, and 1 symbol">
<cfelse>
<cfset password = trim(form.password)>
</cfif>

    <!--- Check for confirm password field --->
    <cfif trim(form.confirm_password) EQ "">
        <cfset confirm_password_err = "Please confirm password">
    <cfelseif trim(form.password) NEQ trim(form.confirm_password)>
        <cfset password_err = "* CONFIRM_PPASSWORD should match *">
    </cfif>

    <!--- If there were no errors, go ahead and insert into the database --->
    <cfif username_err EQ "" AND email_err EQ "" AND password_err EQ "" AND confirm_password_err EQ "">
        <cfquery name="insertUser" datasource="arjyaTest">
            INSERT INTO users (username, email, password) VALUES (
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#username#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#email#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#Hash(password)#"> 
            )
        </cfquery>
        <cfoutput> * Registration Successfully Done * </cfoutput>
        <!---<cflocation url="/arjya/login.cfm"> --->


        <cfelse>
            <cfset error = "error">


    </cfif>
</cfif>





<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Page</title>
    <style>
        body {
            background-color: #f5f5f5;
            font-family: Arial, sans-serif;
            font-size: 16px;
            color: #333;
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
            color: #007bff;
        }
        input[type=text],
        input[type=email],
        input[type=password] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
            font-size: 16px;
            color: #333;
        }
        input[type=submit] {
            background-color: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type=submit]:hover {
            background-color: #0069d9;
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
        a:hover {
            color: #0056b3;
        }
    </style>
</head>
<body>
<cfoutput>
<form action="" method="post">

    <div class="form" >
        <h1 class="heading">Register</h1>
        <p style= "color: red; font-weight: bold;">#username_err# <br> #email_err# <br> #password_err# <br> #confirm_password_err# <br></p>
        <input type="text" placeholder="Username" autocomplete="off" class="username" name="username" <cfif error NEQ "">value="#(form.username)#"</cfif> required> <br><br>
        <input type="email" placeholder="Email" autocomplete="off" class="email" name="email" <cfif error NEQ "">value="#(form.email)#" </cfif> required > <br><br>
        <input type="password" placeholder="Password" autocomplete="off" name="password" required> <br><br>
        <input type="password" placeholder="Confirm Password" autocomplete="off" name="confirm_password" required> <br><br>
        <button class="submit-btn" type="submit">Register</button><br><br>
        
        <a href="login.cfm" class="link">Already have an account? Log in here</a>
    </div>
</form>
</cfoutput>
</body>
</html>
