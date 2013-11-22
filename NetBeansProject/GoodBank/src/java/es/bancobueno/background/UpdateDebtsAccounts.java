/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.bancobueno.background;

import java.math.BigDecimal;
import java.util.TimerTask;
import java.sql.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.Random;

/**
 *
 * @author berik
 */
public class UpdateDebtsAccounts extends TimerTask
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
	    /************************************************************************************************
	     ************************************************************************************************
	     *
	     * INGRESOS POR EMPLEO PÚBLICO
	     * 
	     ************************************************************************************************
	     ***********************************************************************************************/
	    java.util.Date today = new java.util.Date();
	    java.sql.Timestamp timestamp = new java.sql.Timestamp(today.getTime());
	    BigDecimal amount = new BigDecimal(573.320);
	    SimpleDateFormat dateStr = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    String queryString = "INSERT INTO transactions (account, transaction_date, amount, applicant, concept) VALUES (?,?,?,?,?)";
	    query = conn.prepareStatement(queryString);
	    query.setInt(1, 4);
	    query.setTimestamp(2, timestamp);
	    query.setBigDecimal(3, amount);
	    query.setString(4, "Servicio Público de Empleo Estatal");
	    query.setString(5, "Prestación por desempleo");
	    query.executeUpdate();
	    queryString = "UPDATE accounts SET amount=amount+? WHERE account_id=?";
	    query = conn.prepareStatement(queryString);
	    query.setBigDecimal(1, amount);
	    query.setInt(2, 4);
	    query.executeUpdate();
	    /************************************************************************************************
	     ************************************************************************************************
	     *
	     * ADEUDO DE IBERDROLA
	     * 
	     ************************************************************************************************
	     ***********************************************************************************************/
	    timestamp = new java.sql.Timestamp(today.getTime());
	    Random newR = new Random();
	    double numb = 60.0 + (newR.nextDouble() * (91.0 - 60.0));
	    NumberFormat nf = NumberFormat.getNumberInstance(Locale.ENGLISH);
	    DecimalFormat df = (DecimalFormat) nf;
	    df.applyPattern("#.##");
	    String result = String.format("%.2f", numb);
	    amount = new BigDecimal(numb);
	    amount = amount.negate();
	    queryString = "INSERT INTO transactions (account, transaction_date, amount, applicant, concept) VALUES (?,?,?,?,?)";
	    query = conn.prepareStatement(queryString);
	    query.setInt(1, 4);
	    query.setTimestamp(2, timestamp);
	    query.setBigDecimal(3, amount);
	    query.setString(4, "Iberdrola Generación SA");
	    query.setString(5, "Adeudo de Iberdrola");
	    query.executeUpdate();
	    queryString = "UPDATE accounts SET amount=amount-? WHERE account_id=?";
	    query = conn.prepareStatement(queryString);
	    query.setBigDecimal(1, amount);
	    query.setInt(2, 4);
	    query.executeUpdate();
	    /************************************************************************************************
	     ************************************************************************************************
	     *
	     * ADEUDO DE AGUA
	     * 
	     ************************************************************************************************
	     ***********************************************************************************************/
	    timestamp = new java.sql.Timestamp(today.getTime());
	    numb = 10.0 + (newR.nextDouble() * (21.0 - 10.0));
	    result = String.format("%.2f", numb);
	    amount = new BigDecimal(numb);
	    amount = amount.negate();
	    queryString = "INSERT INTO transactions (account, transaction_date, amount, applicant, concept) VALUES (?,?,?,?,?)";
	    query = conn.prepareStatement(queryString);
	    query.setInt(1, 4);
	    query.setTimestamp(2, timestamp);
	    query.setBigDecimal(3, amount);
	    query.setString(4, "Aguas de Valladolid");
	    query.setString(5, "Adeudo de agua");
	    query.executeUpdate();
	    queryString = "UPDATE accounts SET amount=amount-? WHERE account_id=?";
	    query = conn.prepareStatement(queryString);
	    query.setBigDecimal(1, amount);
	    query.setInt(2, 4);
	    query.executeUpdate();
	    /************************************************************************************************
	     ************************************************************************************************
	     *
	     * ADEUDO DE GAS
	     * 
	     ************************************************************************************************
	     ***********************************************************************************************/
	    timestamp = new java.sql.Timestamp(today.getTime());
	    numb = 50.0 + (newR.nextDouble() * (101.0 - 50.0));
	    result = String.format("%.2f", numb);
	    amount = new BigDecimal(numb);
	    amount = amount.negate();
	    queryString = "INSERT INTO transactions (account, transaction_date, amount, applicant, concept) VALUES (?,?,?,?,?)";
	    query = conn.prepareStatement(queryString);
	    query.setInt(1, 4);
	    query.setTimestamp(2, timestamp);
	    query.setBigDecimal(3, amount);
	    query.setString(4, "Gas Natural SDG SA");
	    query.setString(5, "Adeudo de Gas Natural Fenosa");
	    query.executeUpdate();
	    queryString = "UPDATE accounts SET amount=amount-? WHERE account_id=?";
	    query = conn.prepareStatement(queryString);
	    query.setBigDecimal(1, amount);
	    query.setInt(2, 4);
	    query.executeUpdate();
	    /************************************************************************************************
	     ************************************************************************************************
	     *
	     * TODO ACTUALIZADO
	     * 
	     ************************************************************************************************
	     ***********************************************************************************************/
	    System.out.println("Salario de cuenta 4 actualizado a las: " + dateStr.format(timestamp));
	    }
	catch (ClassNotFoundException ex)
	    {
	    System.out.println("Error de clase no encontrada: " + ex.toString());
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
	    System.out.println("Error sql: " + ex.toString());
	    }
	}
    }
