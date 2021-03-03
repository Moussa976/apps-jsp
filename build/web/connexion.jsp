<%-- 
    Document   : connexion
    Created on : 5 janv. 2020, 14:03:32
    Author     : mouss
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="gestion_p.Client"%>
<%@page import="MD5.*"%>
<%
    
    boolean envoyer = Boolean.parseBoolean(request.getParameter("envoyer"));
    String message="";
    String refreshPage = "";
    boolean connexion = false;

    //Si on a envoyer le formulaire
    if(envoyer==true){

        //On récupère les données saisies sur le formulaire
        String lemail=request.getParameter("email");
        String lemdp=request.getParameter("pwd");
        lemdp = Md5_MDP.MD5(lemdp);

        // On envoie l'adresse email saisie dans la base de données
        boolean email_bdd = Client.getEmail(lemail);

        //Si l'adresse email existe (true)
        if(email_bdd==true){
            ResultSet leClient = Client.getClientEmail(lemail);

            // Si ça retourne une résultat
            if(leClient.next()){
                //Si le mot de passe est la même
                if(leClient.getString("mdp").equals(lemdp)){
                    session.setAttribute( "email", leClient.getString("email"));
                    message="<div class='alert alert-success'><strong>Connexion établie ! Vous êtes maintenant connecté!</strong></div>";
                    connexion=true;
                }
                // Sinon
                else{
                    message="<div class='alert alert-warning'><strong>Votre mot de passe n'est pas correct !</strong></div>";
                }
            }
        }
        // Sinon 
        else{ 
            message="<div class='alert alert-danger'><strong>L'adresse email n'existe pas dans notre base de données !</strong></div>";
        }
    }
%>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <title>Connexion APPS-JAVA</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <%
            if(connexion==true){
                refreshPage ="<meta http-equiv='refresh' content='2;URL=connecte/'> ";
                out.print(refreshPage);
            }else{
                //Vérifie si une session est active
                if (session.getAttribute("email") != null) {
                        response.sendRedirect("connecte/");
                }
            }
        %>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <style type="text/css">
            #lecontenu{
                margin-bottom: 18%;
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
                        <li class="active"><a href="connexion.jsp">Se connecter <span class="glyphicon glyphicon-log-in"></span></a></li>
                        <li><a href="inscription.jsp">S'inscrire <span class="glyphicon glyphicon-user"></span></a></li>
                        <li><a href="panier.jsp"><span class="glyphicon glyphicon-shopping-cart"></span><span class="badge">0</span></a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container text-center" id="lecontenu">
            <h1>Connexion</h1>
            <br>
            <div class="row">
                <%= message %>
                <div class="well col-sm-offset-3 col-sm-6">
                    <form action="connexion.jsp">
                        <div class="form-group">
                            <label for="email">Adresse email :</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Votre adresse email">
                        </div>
                        <div class="form-group">
                            <label for="pwd">Mot de passe :</label>
                            <input type="password" class="form-control" id="pwd" name="pwd" placeholder="Votre mot de passe">
                        </div>
                        <input type="hidden" name="envoyer" value="true">
                        <button type="submit" class="btn btn-default" name="seconnecter">Se connecter</button>
                    </form>
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