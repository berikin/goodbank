/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.bancobueno.background;

import java.math.BigDecimal;
import java.util.TimerTask;
import java.sql.*;
import java.text.SimpleDateFormat;

/**
 *
 * @author berik
 */
public class UpdateSavesAccounts extends TimerTask
    {

    @Override
    public void run()
	{
	try
	    {
	    Connection conn = null;
	    Statement queryST = null;
	    PreparedStatement query = null;
	    ResultSet cdr = null;
	    Class.forName("com.mysql.jdbc.Driver").newInstance();
	    String dbLoc = "jdbc:mysql://127.0.0.1:3306/goodbank";
	    String dbUser = "goodbank";
	    String dbPwd = "goodbank";
	    conn = java.sql.DriverManager.getConnection(dbLoc, dbUser, dbPwd);
	    queryST = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	    String queryString = "INSERT INTO transactions (account, transaction_date, amount, applicant, concept) VALUES (?,?,?,?,?)";
	    java.util.Date today = new java.util.Date();
	    java.sql.Timestamp timestamp = new java.sql.Timestamp(today.getTime());
	    SimpleDateFormat dateStr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    BigDecimal amount = new BigDecimal(570.0);
	    query = conn.prepareStatement(queryString);
	    query.setInt(1, 3);
	    query.setTimestamp(2, timestamp);
	    query.setBigDecimal(3, amount);
	    query.setString(4, "Juan Benito");
	    query.setString(5, "Ingreso en efectivo");
	    query.executeUpdate();
	    queryString = "UPDATE accounts SET amount=amount+? WHERE account_id=?";
	    query = conn.prepareStatement(queryString);
	    query.setBigDecimal(1, amount);
	    query.setInt(2, 3);
	    query.executeUpdate(); 
	    System.out.println("Salario de cuenta 3 actualizado a las: "+dateStr.format(timestamp));
	    }
	catch (ClassNotFoundException ex)
	    {
	    System.out.println("Error de clase no encontrada: "+ex.toString());
	    }
	catch (InstantiationException ex)
	    {
	    System.out.println(ex.toString());
	    }
	catch (IllegalAccessException ex)
	    {
	    System.out.println(ex.toString());
	    }
	catch (SQLException ex)
	    {
	    System.out.println("Error sql: "+ex.toString());
	    }
	}
    }
