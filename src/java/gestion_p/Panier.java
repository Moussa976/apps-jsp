package gestion_p;
import java.sql.*;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *Cette classe représente le panier
 * @author mouss
 */
public class Panier {
    
    
    /**
    * Ajout d'un produit
    */
    public static String ajoutProduitPanier(int id_article, int id_client){
        Connection conn=null;
        Statement st=null;

        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion_p","root","");
            st=conn.createStatement();

            String req="INSERT INTO panier (id_article, id_cli, date_panier) VALUES ('"+id_article+"','"+id_client+"', NOW())";

            st.executeUpdate(req);
            
            return "";
        }catch(Exception e){
            
            return "Erreur : "+e.getMessage();//"Erreur : "
        }
    }


    /**
    * Retourne le nombre de produit dans le panier pour un seul client
    */
    public static  ResultSet getNbPanierClient(int client){
        Connection conn=null;
        Statement st=null;
        ResultSet result=null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion_p","root","");
            st=conn.createStatement();

            String req="SELECT count(P.id_article) nbP, sum(prix) AS leprixTotal FROM article A INNER JOIN panier P ON A.id_article = P.id_article WHERE id_cli = "+client;
            
            result = st.executeQuery(req);
            
            return result;
        }catch(Exception e){
            return null;
        }
    }
    
    /**
    * Retourne la quantité et le prix total d'un produit dans le panier pour un seul client
    */
    public static  ResultSet getPanierClientGroupArticle(int client){
        Connection conn=null;
        Statement st=null;
        ResultSet result=null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion_p","root","");
            st=conn.createStatement();

            String req="SELECT *, P.id_article AS p_article, count(P.id_article) AS nbP, sum(prix) AS leprixTotal FROM article A INNER JOIN panier P ON A.id_article = P.id_article WHERE id_cli = "+client+" GROUP BY P.id_article";
            
            result = st.executeQuery(req);
            
            return result;
        }catch(Exception e){
            return null;
        }
    }


    /**
    * Retourne les produits dans le panier pour un seul client
    */
    public static  ResultSet getPanierClient(int client){
        Connection conn=null;
        Statement st=null;
        ResultSet result=null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion_p","root","");
            st=conn.createStatement();

            String req="SELECT * FROM article A INNER JOIN panier R ON A.id_article = R.id_article INNER JOIN client C ON R.id_cli = C.id_client WHERE id_client = "+client;
            
            result = st.executeQuery(req);
            
            return result;
        }catch(Exception e){
            return null;
        }
    }
    
    /**
    * Suppression d'un produit dans le panier pour un client
    */
    public static String SuppProduitPanier(int id_art, int id_cli){
        Connection conn=null;
        Statement st=null;

        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion_p","root","");
            st=conn.createStatement();

            String req="DELETE FROM panier WHERE id_article = "+id_art+" AND id_cli = "+id_cli;

            st.executeUpdate(req);
            
            return "";
        }catch(Exception e){
            
            return "Erreur : "+e.getMessage();//"Erreur : "
        }
    }
    
    /**
    * Suppression de tous les produits pour un client 
    */
    public static String SuppToutProduitPanier(int id_cli){
        Connection conn=null;
        Statement st=null;

        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion_p","root","");
            st=conn.createStatement();

            String req="DELETE FROM panier WHERE id_cli = "+id_cli;

            st.executeUpdate(req);
            
            return "";
        }catch(Exception e){
            
            return "Erreur : "+e.getMessage();//"Erreur : "
        }
    }


}
