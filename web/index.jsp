<%-- 
    Document   : index
    Created on : 5 janv. 2020, 00:20:30
    Author     : mouss
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="gestion_p.Article"%>
<%
    //Vérifie si une session est active
    if (session.getAttribute("email") != null) {
        response.sendRedirect("connecte/");
    }
    ResultSet art = Article.listeArticles();
%>
<!DOCTYPE html>
<html lang="fr">
	<head>
		<title>Accueil APPS-JAVA</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="css/style.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	</head>
	<body> 
		<!-- La barre de menu -->
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
                                            <li><a href="inscription.jsp">S'inscrire <span class="glyphicon glyphicon-user"></span></a></li>
						<li><a href="panier.jsp"><span class="glyphicon glyphicon-shopping-cart"></span><span class="badge">0</span></a></li>
					</ul>
				</div>
			</div>
		</nav>
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
			</ol>
			<!-- Wrapper for slides -->
			<div class="carousel-inner" role="listbox">
				<div class="item active">
					<img src="images/pub1.jpg" alt="Image">
					<div class="carousel-caption">
						<h3>biscuits LU</h3>
					</div>
				</div>
				<div class="item">
					<img src="images/pub2.jpg" alt="Image">
					<div class="carousel-caption">
						<h3>Brand Yogurt</h3>
					</div>
				</div>
			</div>
			<!-- Les controles de défilements pour les images de header -->
			<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				<span class="sr-only">Précédent</span>
			</a>
			<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Suivant</span>
			</a>
		</div>
		<div class="container text-center">
			<h3>Nos produits</h3>
			<br>
			<div class="row">
				<!-- Parcourir les articles -->
				<% while(art.next()){%>
					<div class="col-sm-4">
						<div class="panel panel-primary">
	                        <div class="panel-heading"><%=art.getString("libelle")%><span style="float: right; font-size: 16px;"><strong><%=art.getString("prix")%>€</strong></span></div>
	                        <div class="panel-body">
	                        	<img src="<%=art.getString("photo")%>"  class="img-responsive" style="max-height: 220px;" alt="Image">
	                        </div>
	                        <div class="panel-footer"><button class="btn btn-primary" onclick="AjoutPanier();">Ajouter au panier</button></div>
	                    </div>
					</div>
				<%}%>
			</div>
		</div>
		<br>
		<footer class="container-fluid text-center">
			<p>
				Site crée par Moussa
			</p>
		</footer>


		<script type="text/javascript">
			function AjoutPanier(){
				swal("", "Connectez-vous pour ajouter ce produit dans le panier", "warning");
			}
		</script>
	</body>
</html>
