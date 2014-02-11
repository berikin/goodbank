<%-- 
    Document   : dashboard
    Created on : 04-nov-2013, 16:54:48
    Author     : berik
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="one-third column">
    <h2>DashBoard</h2>
    <div class="headerSpace"></div>
    <nav>
	<a href="index.jsp">Vuelta al inicio</a>
	<hr />
	<c:if test="${bankManagerRange>1}">
	    <a href="addmanager.jsp">Agrega un administrador</a>
	    <a href="editmanager.jsp">Modifica un administrador</a>
	    <a href="deletemanager.jsp">Elimina un administrador</a>
	    <hr />
	</c:if>
	<c:if test="${bankManagerRange<3}">
	    <a href="addclient.jsp">Agrega un cliente</a>
	    <a href="editclient.jsp">Modifica un cliente</a>
	    <a href="deleteclient.jsp">Elimina un cliente</a>
	    <hr />
	</c:if>
	<c:if test="${bankManagerRange<3}">
	    <a href="addaccount.jsp">Agrega una cuenta</a>
	    <hr />
	</c:if>
    </nav>
</div>
