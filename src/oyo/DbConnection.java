/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package oyo;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DbConnection {
    
    static Connection con=null;
    public static String sid,token;
    
    public static Connection getConnection()
    {
        if (con != null) return con;
        // get db, user, pass from settings file
        String db="",user="",pass="";
        try{
            FileInputStream fis=new FileInputStream("/home/sparsh/Documents/RUP Lab OYO/oyo/src/oyo/dbsettings.properties"); 
            Properties p=new Properties (); 
            p.load(fis); 
            db=(String)p.getProperty("db");
            user=(String)p.getProperty("user");
            pass=(String)p.getProperty("password");
            sid=(String)p.getProperty("sid");
            token=(String)p.getProperty("token");
        }catch(Exception e){
            e.printStackTrace();
        }
        return getConnection(db, user, pass);
    }

    private static Connection getConnection(String db_name,String user_name,String password)
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost/"+db_name+"?user="+user_name+"&password="+password);
            System.out.println("Connected to database successfully...");
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }

        return con;        
    }
    
} 
       
    
