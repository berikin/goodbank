<%-- 
    Document   : header
    Created on : 31-oct-2013, 16:39:49
    Author     : José Antonio Yáñez Jiménez
    Portfolio  : http://www.jimenezfrontend.es
--%>

<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>El banco bueno - Administración</title>
	<link rel="stylesheet" href="stylesheets/style.css" type="text/css"/>
	<link rel="stylesheet" href="stylesheets/jquery-ui.css" type="text/css"/>
	<script src="scripts/jquery-1.9.1.js"></script>
	<script src="scripts/jquery-ui.js"></script>
	<script src="scripts/script.js"></script>
    </head>
    <body>
	<header>
	    <h1>El banco bueno - Administración</h1>
	</header>
	<c:if test="${logged==true}">
	    <img src="img/exit.png" alt="Salir" class="exitIcon" />
	    <a href="logout.jsp"><img src="img/exit_hover.png" alt="Salir" class="exitIconH" /></a>
	</c:if>