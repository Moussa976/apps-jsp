<%-- 
    Document   : deconnexion
    Created on : 9 janv. 2020, 14:10:53
    Author     : moussa
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="gestion_p.*"%>
<%
    if (session.getAttribute("email") == null) {
            response.sendRedirect("../connexion.jsp");
    } else {}
%>
<!DOCTYPE html>
<html lang="fr">
	<head>
		<title>Déconnexion APPS-JAVA</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
                <meta http-equiv='refresh' content='2;URL=../'>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="../css/style.css">
                <style type="text/css">
                    #lecontenu{
                        margin-bottom: 25%;
                    }
                </style>
	</head>
	<body>
                <div class="container text-center" id="lecontenu">
                    <h1>Déconnexion en cours ...</h1>
                    <%
                        session.invalidate();
                    %>
		</div>
	</body>
</html>
