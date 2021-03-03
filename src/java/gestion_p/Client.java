package gestion_p;
import java.sql.*;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *Cette classe représente les clients
 * @author mouss
 */
public class Client {

    /**
    * Ajout d'un client
    */
    public static String ajoutClient(int role, String nom, String prenom, String email, String mdp){
        Connection conn=null;
        Statement st=null;

        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion_p","root","");
            st=conn.createStatement();

            String req="INSERT INTO client (nom, prenom, email, mdp, role) VALUES ('"+nom+"','"+prenom+"','"+email+"','"+mdp+"', "+role+")";

            st.executeUpdate(req);
            
            return "<div class='alert alert-success'>Inscription effectuée ! <strong><a href='connexion.jsp' class='alert-link'>Se connecter ?</a></strong></div>";
        }catch(Exception e){
            
            return "Erreur : "+e.getMessage();//"Erreur : "
        }
    }

    /**
    * Vérification du mail
    */
    public static boolean getEmail(String email){
        Connection conn=null;
        Statement st=null;
        ResultSet result=null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion_p","root","");
            st=conn.createStatement();

            String req="SELECT * FROM client WHERE email='"+email+"'LIMIT 1";

            result = st.executeQuery(req);
            
            if(result.next()){
                return true;// Adresse email existe
            }else{
                return false;// Adresse email n'existe pas
            }
        }catch(Exception e){
            e.getMessage();
            return false;
        }
    }


    /**
    * Retourne le résultat d'un client dont le mail est email
    */
    public static  ResultSet getClientEmail(String email){
        Connection conn=null;
        Statement st=null;
        ResultSet result=null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn=(Connection)DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion_p","root","");
            st=conn.createStatement();

            String req="SELECT * FROM client WHERE email='"+email+"'LIMIT 1";
            
            result = st.executeQuery(req);
            
            return result;
        }catch(Exception e){
            return null;
        }
    }

}
