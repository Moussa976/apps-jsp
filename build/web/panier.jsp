<%-- 
    Document   : panier
    Created on : 5 janv. 2020, 14:01:42
    Author     : mouss
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //Vérifie si une session est active
    if (session.getAttribute("email") != null) {
            response.sendRedirect("connecte/panier.jsp");
    }
%>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <title>Panier APPS-JAVA</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <style type="text/css">
            #lecontenu{
                margin-bottom: 25%;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="./"><span class="glyphicon glyphicon-home"></span> Accueil</a>
                </div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="connexion.jsp">Se connecter <span class="glyphicon glyphicon-log-in"></span></a></li>
                        <li ><a href="inscription.jsp">S'inscrire <span class="glyphicon glyphicon-user"></span></a></li>
                        <li class="active"><a href="panier.jsp"><span class="glyphicon glyphicon-shopping-cart"></span><span class="badge">0</span></a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container text-center" id="lecontenu">
            <h1>Panier</h1>
            <br>
            <div class="row">
                <div class="col-sm-offset-3 col-sm-6">
                    <div class="alert alert-info">
                        Aucun produit dans le panier !  
                    </div>
                    <div class="alert alert-warning">
                        
                        Veuillez vous <a href="connexion.jsp" class="alert-link"><strong>connecter</strong></a> pour ajouter un produit dans le panier.  
                    </div>
                </div>
            </div>
        </div>
        <br>
        <footer class="container-fluid text-center">
            <p>
                Site crée par Moussa
            </p>
        </footer>
    </body>
</html>