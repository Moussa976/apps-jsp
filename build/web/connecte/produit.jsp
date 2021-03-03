<%-- 
    Document   : produit
    Created on : 9 janv. 2020, 14:10:26
    Author     : moussa
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
            response.sendRedirect("../connexion.jsp");
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
        response.sendRedirect("./");
    }
    int idProduit = 0;
    // On récupère après la suppression à effectuer
    boolean supprimer = Boolean.parseBoolean(request.getParameter("supprimer"));
    if(supprimer==true){
        //Suppression 
        idProduit =Integer.parseInt(request.getParameter("Id_Article"));
        String ajoutArticle = Article.SuppProduit(idProduit);
    }else{}
%>

<!DOCTYPE html>
<html lang="fr">
	<head>
		<title>Produit APPS-JAVA</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
                <%  
                    if(supprimer==true){
                        out.print("<meta http-equiv='refresh' content='2;URL=produit.jsp'> ");
                    }else{}
                %>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="../css/style.css">
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
                    <a class="navbar-brand" href="./"><span class="glyphicon glyphicon-home"></span> Accueil</a>
				</div>
				<div class="collapse navbar-collapse" id="myNavbar">
					<ul class="nav navbar-nav navbar-right">
            <%
              if (roleUser==1) {
                out.print("<li class='active'><a href='produit.jsp'> Gestion des produits <span class='glyphicon glyphicon-cog'></span></a></li>");
              }
            %>
            <li><a href="#"><% out.print(nomUser+" "+prenomUser); %> <span class="glyphicon glyphicon-user"></span><br><% if(roleUser == 1){out.print("Administrateur");}else{} %></a></li>
            <li><a href="deconnexion.jsp">Se déconnecter <span class="glyphicon glyphicon-log-out"></span></a></li>
            <li><a href="panier.jsp">
              <span class="glyphicon glyphicon-shopping-cart"></span>
              <span class="badge"><%= nbArtPanier%></span>
            </a></li>
					</ul>
				</div>
			</div>
		</nav>


                <div class="container text-center" id="lecontenu">
                   <h2>Liste des produits</h2>
                   <br><br><br>
                   <a href="produit/ajout_produit.jsp" role="button" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-plus"></span> Ajouter un produit</a>
                   <br><br><br>
                   <input class="form-control" id="myInput" type="text" placeholder="Rechercher...">
                   <br>
                   <table class="table table-bordered table-striped">
                      <thead>
                         <tr>
                            <th>#ID</th>
                            <th>Nom du produit</th>
                            <th>Prix</th>
                            <th>Photo</th>
                            <th>Actions</th>
                         </tr>
                      </thead>
                      <tbody id="myTable">
                         <% while(art.next()){%>
                          <tr>
                            <td><%=art.getString("id_article")%></td>
                            <td><%=art.getString("libelle")%></td>
                            <td><%=art.getString("prix")%>€</td>
                            <td><img title="<%=art.getString("libelle")%>" alt="<%=art.getString("libelle")%>" width="80" height="70" src="<%=art.getString("photo")%>"></td>
                            <td>
                                <a role="button" href="produit/modif_produit.jsp?id_article=<%=art.getString("id_article")%>&modification=true" class="btn btn-success" title="Modifier ?"><span class="glyphicon glyphicon-edit"></span></a>
                                <button type="button" onclick="supprimerArt(<%=art.getString("id_article")%>);" class="btn btn-danger" title="Supprimer ?"><span class="glyphicon glyphicon-trash"></span></button>
                            </td>
                         </tr>
                         <%}%>
                      </tbody>
                   </table>
                </div>
		<br>
		<footer class="container-fluid text-center">
			<p>
				Site crée par Moussa
			</p>
		</footer>


    <script type="text/javascript">
        $(document).ready(function(){
            $("#myInput").on("keyup", function() {
                var value = $(this).val().toLowerCase();
                $("#myTable tr").filter(function() {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        });
        function supprimerArt(art)
        {       
            if (confirm("Voulez-vous supprimer le produit N°"+art+" ?")) {
                // Clic sur OK
                window.location = "produit.jsp?supprimer=true&Id_Article="+art;
            }
        }
    </script>
    <%
        if(supprimer==true && idProduit != 0){
            out.print("<script>swal('Supprimé', 'Le produit n°"+idProduit+" a bien été supprimer !', 'success')</script>");
        }
    %>
    </body>
</html>
