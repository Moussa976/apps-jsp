<%-- 
    Document   : panier
    Created on : 5 janv. 2020, 14:01:42
    Author     : mouss
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="gestion_p.*"%>
<%
    ResultSet art = Article.listeArticles();
    //Les articles du panier
    ResultSet ArticlePanier = null;
    

    //Initialisation des valeurs 
    String nomUser = "", prenomUser = "", emailUser="", nomProduit = "", laPhoto="";
    int idUser = 0, Qte = 0 , roleUser = -1, idArticle = 0;
    float PrixTotal=0, PrixTotalArticle = 0, Prix=0;

    
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
            PrixTotal = nbArticlePanier.getFloat("leprixTotal");
        }
        
        

    }
    ArticlePanier  = Panier.getPanierClientGroupArticle(idUser);
    // On récupère après la suppression à effectuer
    boolean supprimerPanier = Boolean.parseBoolean(request.getParameter("supprimerUnArticle"));
    if(supprimerPanier==true){
        //Suppression 
        idArticle =Integer.parseInt(request.getParameter("Id_Article"));
        //Suppresion d'un article dans le panier
        String suppUnarticlePanier = Panier.SuppProduitPanier(idArticle,idUser);
    }
    
    
    // On récupère après la suppression à effectuer
    boolean supprimerTout = Boolean.parseBoolean(request.getParameter("supprimerTout"));
    if(supprimerTout==true){
        //Suppresion d'un article dans le panier
        String suppToutPanier = Panier.SuppToutProduitPanier(idUser);
    }
    
%>

<!DOCTYPE html>
<html lang="fr">
    <head>
        <title>Panier APPS-JAVA</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <%  
            if(supprimerPanier==true || supprimerTout==true){
                out.print("<meta http-equiv='refresh' content='2;URL=panier.jsp'> ");
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
                                out.print("<li><a href='produit.jsp'> Gestion des produits <span class='glyphicon glyphicon-cog'></span></a></li>");
                            }
                        %>
                        <li><a href="#"><% out.print(nomUser+" "+prenomUser); %> <span class="glyphicon glyphicon-user"></span><br><% if(roleUser == 1){out.print("Administrateur");}else{} %></a></li>
                        <li><a href="deconnexion.jsp">Se déconnecter <span class="glyphicon glyphicon-log-out"></span></a></li>
                        <li class="active"><a href="panier.jsp">
                            <span class="glyphicon glyphicon-shopping-cart"></span>
                            <span class="badge"><%= nbArtPanier%></span>
                        </a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container text-center" id="lecontenu">
            <h1>Panier</h1>
            <br>
            <div class="row">
                <table class="table table-striped text-center">
                  <thead>
                    <tr>
                        <th></th>
                        <th class="text-center">Produit</th>
                        <th class="text-center">Prix unitaire</th>
                        <th class="text-center">Quantité</th>
                        <th class="text-center">Prix total</th>
                    </tr>
                  </thead>
                  <tfoot>
                  <th class="text-center info" colspan="4"><h3>Montant total des produits</h3></th>
                  <th class="text-center info"><h2><%=PrixTotal%>€</h2></th>
                  <th class="text-center info"><button type="button" onclick="supprimerPanier_art();" class="btn btn-primary" title="Tout effacer ?">Tout effacer</button></th>
                  </tfoot>
                  <tbody>
                    <%
                        while (ArticlePanier.next()) {
                            idArticle = ArticlePanier.getInt("p_article");
                            nomProduit = ArticlePanier.getString("libelle");
                            Qte = ArticlePanier.getInt("nbP");
                            Prix = ArticlePanier.getFloat("prix");
                            PrixTotalArticle = ArticlePanier.getFloat("leprixTotal");
                            laPhoto = ArticlePanier.getString("photo");
                    %>
                    <tr>
                      <td><img title="<%=nomProduit%>" alt="<%=nomProduit%>" width="80" height="70" src="<%=laPhoto%>"></td>
                      <td><%=nomProduit%></td>
                      <td><%=Prix%>€</td>
                      <td><%=Qte%></td>
                      <td><strong><%=PrixTotalArticle%>€</strong></td>
                      <td>
                              <button type="button" onclick="supprimerPanier(<%=idArticle%>);" class="btn btn-info" title="Effacer ?">Effacer</button>
                      </td>
                    </tr>
                    <% } %>
                  </tbody>
                </table>
            </div>
        </div>
        <br>
        <footer class="container-fluid text-center">
            <p>
                Site crée par Moussa
            </p>
        </footer>
        <script type="text/javascript">
            function supprimerPanier(art)
            {       
                if (confirm("Voulez-vous supprimer le produit du panier ?")) {
                    // Clic sur OK
                    window.location = "panier.jsp?supprimerUnArticle=true&Id_Article="+art;
                }
            }
            
            function supprimerPanier_art()
            {       
                if (confirm("Voulez-vous supprimer le produit du panier ?")) {
                    // Clic sur OK
                    window.location = "panier.jsp?supprimerTout=true";
                }
            }
        </script>
        <%
            if(supprimerPanier==true && idUser != 0){
                out.print("<script>swal('Effacé', 'Le produit a bien été effacer du panier !', 'success')</script>");
            }
            if(supprimerTout==true && idUser != 0){
                out.print("<script>swal('Tout est effacé', 'Le panier est vide !', 'success')</script>");
            }
        %>
    </body>
</html>