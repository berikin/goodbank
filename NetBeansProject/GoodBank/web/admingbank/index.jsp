<%-- 
    Document   : index
    Created on : 13-nov-2013, 10:03:22
    Author     : José Antonio Yáñez Jiménez
    Portfolio  : http://www.jimenezfrontend.es
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<c:if test="${not empty param.loginSend}">
    <%-- DATOS DE CONEXIÓN SQL --%>
    <c:import url="dbinfo.jsp"/>
    <%-- INSTANCIAMOS EL BEAN DE AUTENTICACIÓN --%>
    <jsp:useBean id="manager"  scope="session" class="es.bancobueno.beans.Auth" />
    <%-- ASIGNAMOS LA CLAVE SIN CIFRAR AL BEAN --%>
    <jsp:setProperty name="manager" property="rawString" value="${param.loginPassword}" />
    <%-- CIFRAMOS LA CLAVE --%>
    ${manager.calculateSHA512()}
    <%-- BUSCAMOS AL USUARIO EN LA BASE DE DATOS --%>
    <sql:setDataSource var="db"
		       driver="${jdbcdriver}"
		       url="${sqlurl}"
		       user="${sqluser}"
		       password="${sqlpwd}" />
    <sql:query var="cdr" dataSource="${db}">
	SELECT * FROM managers WHERE id_card=? AND password=?;
	<sql:param value="${param.loginManagerName}" />
	<sql:param value="${manager.getshaString()}" />
    </sql:query>
    <c:if test="${cdr.rowCount==1}">
	<%-- EL USUARIO EXISTE, REDIRIGIMOS AL PANEL DE CONTROL --%>
	<c:forEach var="row" items="${cdr.rows}">
	    <c:set var="bankManager" value="${row.manager_id}" scope="session" />
	    <c:set var="bankManagerRange" value="${row.manager_range}" scope="session" />
	</c:forEach>
	<c:redirect url="controlpanel.jsp" />
    </c:if>
    <%--
    SI NO SE HA PRODUCIDO LA REDIRECCIÓN ES PORQUE EL USUARIO NO EXISTE
    POR TANTO INSTANCIAMOS EL ERROR DE LOGIN
    --%>
    <c:set var="logged" value="${false}" scope="session" />
</c:if>
<c:if test="${empty param.loginSend || logged==false}">
    <c:import url="header.jsp"/>
    <c:import url="dbinfo.jsp"/>
    <article class="container">
	<div class="sixteen columns">
	    <c:if test="${logged==false}">
		<h2>Has intentado acceder con unos datos incorrectos</h2>
		<div class="headerSpace"></div>
		<c:set var="logged" value="${null}" scope="session" />
	    </c:if>
	    <div class="sixteen columns">
		<form method="POST" action="index.jsp">
		    <p>
			<label for="loginManagerName"> DNI: </label><input type="text" name="loginManagerName" id="loginManagerName" placeholder="DNI administrador" /><br />
			<label for="loginPassword">Clave: </label><input type="password" name="loginPassword" id="loginPassword" placeholder="Clave de usuario" /><br />
			<input type="submit" value="Acceder" name="loginSend" />
		    </p>
		</form>
	    </div>
	</div>
    </article>
    <c:import url="footer.jsp"/>
</c:if>
