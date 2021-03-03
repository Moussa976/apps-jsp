<%-- 
    Document   : ajout_produit
    Created on : 13 janv. 2020, 08:49:19
    Author     : mouss
--%>


<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="gestion_p.*"%>
<%
   ResultSet art = Article.listeArticles();
    

    //Initialisation des valeurs 
    String nomUser = "", prenomUser = "", emailUser="";
    int idUser = 0, roleUser = -1;

    
    int nbArtPanier =  0;
    
    if (session.getAttribute("email") == null) {
            response.sendRedirect("../../connexion.jsp");
    } else {
        emailUser = (String) session.getAttribute("email");
        
        ResultSet leClient = Client.getClientEmail(emailUser);
        
        if (leClient.next()) {
            idUser = leClient.getInt("id_cli");
            nomUser = leClient.getString("nom");
            prenomUser = leClient.getString("prenom");
            emailUser = leClient.getString("email");
            roleUser = leClient.getInt("role");
        }
        
	ResultSet nbArticlePanier  = Panier.getNbPanierClient(idUser);
        if (nbArticlePanier.next()) {
            nbArtPanier = nbArticlePanier.getInt("nbP");
        }
    }
    
    if(roleUser != 1){
        response.sendRedirect("../");
    }
    
    // On récupère après l'ajout effectuée
    boolean ajouter = Boolean.parseBoolean(request.getParameter("ajouter"));
    if(ajouter==true){
        String lenom = request.getParameter("nomP");
        float leprix =Float.parseFloat(request.getParameter("prixP"));
        String laphoto = request.getParameter("photo");
        String ajoutArticle = Article.ajoutProduit(lenom, leprix, laphoto);
    }else{}
%>

<!DOCTYPE html>
<html lang="fr">
	<head>
		<title>Produit APPS-JAVA</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
                <%  
                    if(ajouter==true){
                        out.print("<meta http-equiv='refresh' content='2;URL=../produit.jsp'> ");
                    }else{}
                %>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="../../css/style.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
                <style type="text/css">
                    #lecontenu{
                        margin-bottom: 25%;
                    }
                </style>
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
                    <a class="navbar-brand" href="../"><span class="glyphicon glyphicon-home"></span> Accueil</a>
				</div>
				<div class="collapse navbar-collapse" id="myNavbar">
					<ul class="nav navbar-nav navbar-right">
            <%
              if (roleUser==1) {
                out.print("<li class='active'><a href='../produit.jsp'> Gestion des produits <span class='glyphicon glyphicon-cog'></span></a></li>");
              }
            %>
            <li><a href="#"><% out.print(nomUser+" "+prenomUser); %> <span class="glyphicon glyphicon-user"></span><br><% if(roleUser == 1){out.print("Administrateur");}else{} %></a></li>
            <li><a href="../deconnexion.jsp">Se déconnecter <span class="glyphicon glyphicon-log-out"></span></a></li>
            <li><a href="../panier.jsp">
              <span class="glyphicon glyphicon-shopping-cart"></span>
              <span class="badge"><%= nbArtPanier%></span>
            </a></li>
					</ul>
				</div>
			</div>
		</nav>


                <div class="container text-center" id="lecontenu">
                    <h1>Ajout d'un produit</h1>
                    <br>
                    <div class="row">
                        <div class="well col-sm-offset-3 col-sm-6">
                            <form >
                                <div class="form-group">
                                    <label for="nomP">Nom du produit :</label>
                                    <input type="text" class="form-control" id="nomP" name="nomP" placeholder="Entrez le nom du produit">
                                </div>
                                <div class="form-group">
                                    <label for="prixP">Montant :</label>
                                    <input type="number" step="0.01" class="form-control" id="prixP" name="prixP" placeholder="Entrez le montant">
                                </div>
                                <div class="form-group">
                                    <label for="photo">Photo : <a href="#" data-toggle="tooltip" title="Pour la photo de votre produit, veuillez insérer le chemin de la photo se trouvant uniquement sur internet."><span class="glyphicon glyphicon-info-sign"></span></a></label>
                                    <textarea type="text" class="form-control" id="photo" name="photo" placeholder="Entrez le lien pour la photo du produit"></textarea>
                                </div>
                                <input type="hidden" name="ajouter" value="true">
                                <button type="submit" class="btn btn-default">Ajouter</button>
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
                <script>
                        $(document).ready(function(){
                          $('[data-toggle="tooltip"]').tooltip();   
                        });
                </script>
                <%
                    if(ajouter==true){
                        out.print("<script>swal('Ajouté', 'Votre produit a bien été ajouter !', 'success');</script>");
                    }
                %>
	</body>
</html>
