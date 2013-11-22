<%-- 
    Document   : controlpanel.jsp
    Created on : 13-nov-2013, 12:26:10
    Author     : José Antonio Yáñez Jiménez
    Portfolio  : http://www.jimenezfrontend.es
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<c:if test="${not empty bankClient && not empty param.account}">
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
    <sql:query var="account" dataSource="${db}">
	SELECT	accounts.account_id,
	accounts.account_number,
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
	account_number=? 
	AND 
	branches.branch_id=accounts.branch 
	AND 
	account_types.type_id=accounts.account_type
	<sql:param value="${param.account}" />
    </sql:query>
    <%--********************************************************
    **
    ** WEB CODE
    **
    ********************************************************--%>
    <c:import url="header.jsp"/>
    <script type="text/javascript" src="scripts/jquery.tablesorter.min.js"></script>
    <script src="scripts/jquery.tablesorter.widgets.min.js"></script>
    <article class="container">
	<div class="sixteen columns centered">
	    <c:forEach var="row" items="${account.rows}">
		<div class="two-thirds column">
		    <h2 id="htitle">Movimientos de tu ${row.type}</h2>
		    <div class="headerSpace"></div>
		    <div class="movements" id="movementDetails"></div>
		    <h3 id="totalMoney"></h3>
		</div>
		<script src="scripts/transactionhistory.js"></script>
		<script>
		    var total=0;
		    $(document).ready(function() {
		    total=getTransactions(${row.account_id},total);
		    setInterval(function(){total=getTransactions(${row.account_id},total);}, (30000));
		    });
		</script>
		<c:import url="dashboard.jsp" charEncoding="UTF-8" />
	    </c:forEach>
	</div>
    </article>
    <c:import url="footer.jsp"/>
</c:if>
<c:if test="${empty bankClient || empty param.account}">
    <c:redirect url="index.jsp" />
</c:if>
