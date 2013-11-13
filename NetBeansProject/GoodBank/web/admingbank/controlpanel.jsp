<%-- 
    Document   : controlpanel.jsp
    Created on : 13-nov-2013, 12:26:10
    Author     : José Antonio Yáñez Jiménez
    Portfolio  : http://www.jimenezfrontend.es
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<c:if test="${not empty bankManager}">
    <%-- DATOS DE CONEXIÓN SQL --%>
    <c:import url="dbinfo.jsp"/>
    <sql:setDataSource var="db"
		       driver="${jdbcdriver}"
		       url="${sqlurl}"
		       user="${sqluser}"
		       password="${sqlpwd}" />
    <sql:query var="cdr" dataSource="${db}">
	SELECT * FROM managers WHERE manager_id=?;
	<sql:param value="${bankManager}" />
    </sql:query>
    <%--********************************************************
    **
    ** WEB CODE
    **
    ********************************************************--%>
    <c:import url="header.jsp"/>
    <article class="container">
	<div class="sixteen columns centered">
	    <c:forEach var="row" items="${cdr.rows}">
		<h2>Hola <c:out value="${row.name}" /> <c:out value="${row.lastname_first}" /> <c:out value="${row.lastname_second}" /></h2>
		<div class="headerSpace"></div>
	    </c:forEach>
	    <c:choose>
		<c:when test="${bankManagerRange==1}">
		    <section class="sixteen columns centered">
			<a href="#3">
			    <div class="four columns centered box">
				<img src="img/adduser.png" alt="Añadir" /><br />
				Agrega un cliente
			    </div>
			</a>
			<a href="#2">
			    <div class="four columns centered box">
				<img src="img/alteruser.png" alt="Añadir" /><br />
				Modifica un cliente
			    </div>
			</a>
			<a href="#1">
			    <div class="four columns centered box">
				<img src="img/lessuser.png" alt="Añadir" /><br />
				Elimina un cliente
			    </div>
			</a>
		    </section>
		</c:when>
		<c:when test="${bankManagerRange==2}">

		</c:when>
		<c:when test="${bankManagerRange==3}">
		    <section class="sixteen columns centered">
			<a href="addmanager.jsp">
			    <div class="four columns centered box">
				<img src="img/adduser.png" alt="Añadir" /><br />
				Agrega un administrador
			    </div>
			</a>
			<a href="#2">
			    <div class="four columns centered box">
				<img src="img/alteruser.png" alt="Añadir" /><br />
				Modifica un administrador
			    </div>
			</a>
			<a href="#1">
			    <div class="four columns centered box">
				<img src="img/lessuser.png" alt="Añadir" /><br />
				Elimina un administrador
			    </div>
			</a>
		    </section>
		</c:when>
		<c:otherwise>

		</c:otherwise>
	    </c:choose>
	</div>
    </article>
    <c:import url="footer.jsp"/>
</c:if>
<c:if test="${empty bankManager}">
    <c:redirect url="index.jsp" />
</c:if>
