<%-- 
    Document   : controlpanel.jsp
    Created on : 13-nov-2013, 12:26:10
    Author     : José Antonio Yáñez Jiménez
    Portfolio  : http://www.jimenezfrontend.es
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<c:if test="${not empty bankClient}">
    <%-- DATOS DE CONEXIÓN SQL --%>
    <c:import url="dbinfo.jsp"/>
    <sql:setDataSource var="db"
		       driver="${jdbcdriver}"
		       url="${sqlurl}"
		       user="${sqluser}"
		       password="${sqlpwd}" />
    <sql:query var="cdr" dataSource="${db}">
	SELECT * FROM clients WHERE client_id=?;
	<sql:param value="${bankClient}" />
    </sql:query>
    <sql:query var="accountsFirst" dataSource="${db}">
	SELECT	accounts.account_number,
	branches.branch_code,
	branches.street_type,
	branches.address,
	branches.province,
	branches.community,
	branches.phone_number,
	account_types.type
	FROM 
	accounts,
	branches,
	account_types
	WHERE 
	client_id=? 
	AND 
	branches.branch_id=accounts.branch 
	AND 
	account_types.type_id=accounts.account_type
	<sql:param value="${bankClient}" />
    </sql:query>
    <sql:query var="accountsSecond" dataSource="${db}">
	SELECT	accounts.account_number,
	branches.branch_code,
	branches.street_type,
	branches.address,
	branches.province,
	branches.community,
	branches.phone_number,
	account_types.type
	FROM 
	accounts,
	branches,
	account_types
	WHERE 
	second_client_id=? 
	AND 
	branches.branch_id=accounts.branch 
	AND 
	account_types.type_id=accounts.account_type
	<sql:param value="${bankClient}" />
    </sql:query>
    <sql:query var="accountsThird" dataSource="${db}">
	SELECT	accounts.account_number,
	branches.branch_code,
	branches.street_type,
	branches.address,
	branches.province,
	branches.community,
	branches.phone_number,
	account_types.type
	FROM 
	accounts,
	branches,
	account_types
	WHERE 
	third_client_id=? 
	AND 
	branches.branch_id=accounts.branch 
	AND 
	account_types.type_id=accounts.account_type
	<sql:param value="${bankClient}" />
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
	    <c:if test="${accountsFirst.rowCount>0}">
		<div class="sixteen columns centered">
		    <section class="sixteen columns centered">
			<c:forEach var="row" items="${accountsFirst.rows}" varStatus="theCount">
				    <c:if test="${row.type=='Cuenta morada'}">
					<a href="#" id="link${theCount.index}" class="accountFirst context-menu-one" acctype="morada" accid="${row.account_number}">
					<div class="four columns centered box">
					<img src="img/purpleaccount.png" alt="Añadir" /><br />
					Cuenta morada
				    </c:if>
				    <c:if test="${row.type=='Cuenta nómina plus'}">
					<a href="#" id="link${theCount.index}" class="accountFirst context-menu-one" acctype="nomina" accid="${row.account_number}">
					<div class="four columns centered box-plus">
					<img src="img/salaryaccount.png" alt="Añadir" /><br />
					Cuenta nómina plus
				    </c:if>
				    <c:if test="${row.type=='Cuenta ahorro platino'}">
					<a href="#" id="link${theCount.index}" class="accountFirst context-menu-one" acctype="platino" accid="${row.account_number}">
					<div class="four columns centered box-platinum">
					<img src="img/savesaccount.png" alt="Añadir" /><br />
					Cuenta ahorro platino
				    </c:if>
				</div>
			    </a>
			</c:forEach>
		    </section>
		</div>
	    </c:if>
	</div>
    </article>
    <div id="dialog" style="display:none;"></div>
    <c:import url="footer.jsp"/>
</c:if>
<c:if test="${empty bankClient}">
    <c:redirect url="index.jsp" />
</c:if>
