<%-- 
    Document   : inscription
    Created on : 5 janv. 2020, 14:03:18
    Author     : mouss
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="gestion_p.Client"%>
<%@page import="MD5.*"%>
<%
    //Vérifie si une session est active
    if (session.getAttribute("email") != null) {
            response.sendRedirect("connecte/");
    }
    String message = "", lestyle = "";
    boolean inscription = true;
    boolean envoyer = Boolean.parseBoolean(request.getParameter("envoyer"));

    if (envoyer == true) {
        int le_role = Integer.parseInt(request.getParameter("lerole"));
        String l_nom = request.getParameter("nom");
        String l_prenom = request.getParameter("prenom");
        String l_email = request.getParameter("email");
        String l_mdp = Md5_MDP.MD5(request.getParameter("pwd"));
        // Si l'adresse email n'existe pas dans la base de données
        if(Client.getEmail(l_email) == false){
            //Insertion du nouveau utilisateur dans la base
            message = Client.ajoutClient(le_role, l_nom, l_prenom, l_email, l_mdp);
            
        }
        // Sinon
        else{
            message = "<div class='alert alert-danger'><strong>L'adresse email existe déjà ! Veuillez choisir un autre !</strong></div>";
            inscription = false;
        }
    }
    
%>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <title>Inscription APPS-JAVA</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <style type="text/css">
            #lecontenu{
                margin-bottom: 8%;
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
                        <li class="active"><a href="inscription.jsp">S'inscrire <span class="glyphicon glyphicon-user"></span></a></li>
                        <li><a href="panier.jsp"><span class="glyphicon glyphicon-shopping-cart"></span><span class="badge">0</span></a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container text-center" id="lecontenu">
            <h1>Inscription</h1>
            <br>
            <div class="row">
                <%=message%>
                <div class="well col-sm-offset-3 col-sm-6">
                    <form action="inscription.jsp" method="POST">
                        <div class="form-group">
                            <label class="radio-inline">
                                <input type="radio" name="lerole" value="0" checked>Client
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="lerole" value="1">Administrateur
                            </label>
                        </div>
                        <div class="form-group">
                            <label for="nom">Nom :</label>
                            <input type="text" class="form-control" id="nom" name="nom" value='<% if(inscription==false){out.print(request.getParameter("nom"));} %>'  placeholder="Votre nom" required>
                        </div>
                        <div class="form-group">
                            <label for="prenom">Prénom :</label>
                            <input type="text" class="form-control" id="prenom" name="prenom" value='<% if(inscription==false){out.print(request.getParameter("prenom"));} %>'  placeholder="Votre prénom" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Adresse email :</label>
                            <input type="email" class="form-control" id="email" name="email" value='<% if(inscription==false){out.print(request.getParameter("email"));} %>'  placeholder="Votre adresse email" required>
                        </div>
                        <div class="form-group">
                            <label for="pwd">Mot de passe :</label>
                            <input type="password" class="form-control" id="pwd" name="pwd" placeholder="Votre mot de passe" required>
                        </div>
                        <input type="hidden" name="envoyer" value="true">
                        <button type="submit" class="btn btn-default" name="sinscrire">S'inscrire</button>
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
        <%
            if(inscription==false){
                out.print("<script type='text/javascript'>document.getElementById('email').style.border = '3px solid red';</script>");
            }
        %>
        <script type="text/javascript">$('#email').keydown(function(){document.getElementById('email').style.border = '1px solid #CCCCCC';});</script>
    </body>
</html>