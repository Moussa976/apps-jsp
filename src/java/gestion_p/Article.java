package gestion_p;
import java.sql.*;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Cette classe représente les articles
 * @author mouss
 */
public class Article {
    
    
    /*
    * Liste de tous les articles
    */
    public static ResultSet listeArticles(){
        Connection conn=null;
        Statement st=null;
        ResultSet result=null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion_p","root","");
            st=conn.createStatement();

            String req="SELECT * FROM article";

            result = st.executeQuery(req);
            
            return result;  
            
        }catch(Exception e){
            e.getMessage();
            return null;
        }
    }
    
    
    /*
    * Liste de tous les articles
    */
    public static ResultSet unArticle( int id_art){
        Connection conn=null;
        Statement st=null;
        ResultSet result=null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion_p","root","");
            st=conn.createStatement();

            String req="SELECT * FROM article WHERE id_article = "+id_art;

            result = st.executeQuery(req);
            
            return result;  
            
        }catch(Exception e){
            e.getMessage();
            return null;
        }
    }
    
    /**
    * Ajout d'un produit
    */
    public static String ajoutProduit(String lenom, float leprix, String laphoto){
        Connection conn=null;
        Statement st=null;

        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion_p","root","");
            st=conn.createStatement();

            String req="INSERT INTO article (libelle, prix, photo) VALUES ('"+lenom+"','"+leprix+"','"+laphoto+"')";

            st.executeUpdate(req);
            
            return "";
        }catch(Exception e){
            
            return "Erreur : "+e.getMessage();//"Erreur : "
        }
    }
    
    /**
    * Modification d'un produit
    */
    public static String modifProduit(int id_art, String lenom, float leprix, String laphoto){
        Connection conn=null;
        Statement st=null;

        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion_p","root","");
            st=conn.createStatement();

            String req="UPDATE article SET libelle = '"+lenom+"', prix = '"+leprix+"', photo='"+laphoto+"' WHERE id_article = "+id_art;

            st.executeUpdate(req);
            
            return "";
        }catch(Exception e){
            
            return "Erreur : "+e.getMessage();//"Erreur : "
        }
    }
    
    /**
    * Suppression d'un produit
    */
    public static String SuppProduit(int id_art){
        Connection conn=null;
        Statement st=null;

        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion_p","root","");
            st=conn.createStatement();

            String req="DELETE FROM article WHERE id_article = "+id_art;

            st.executeUpdate(req);
            
            return "";
        }catch(Exception e){
            
            return "Erreur : "+e.getMessage();//"Erreur : "
        }
    }
    
   
}
