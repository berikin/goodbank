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
    <article class="container">
	<div class="sixteen columns">
	    <c:forEach var="row" items="${account.rows}">
		<div class="two-thirds column">
		    <h2 id="htitle">Nueva transferencia de tu ${row.type}</h2>
		    <div class="headerSpace"></div>
		    <div class="transaction sixteen columns" id="transactionDetails">
			<form name="newTransaction" id="newTransaction" action="transaction.jsp" method="POST">
			    <div class="one-third column">
				<div class="headerSpace"></div>
				<%-- DATOS DE CONEXIÓN SQL --%>
				<c:import url="dbinfo.jsp"/>
				<sql:setDataSource var="db"
						   driver="${jdbcdriver}"
						   url="${sqlurl}"
						   user="${sqluser}"
						   password="${sqlpwd}" />
				<sql:query var="cdr" dataSource="${db}">
				    SELECT account_types.type, accounts.account_id, accounts.account_number, accounts.amount FROM accounts, account_types WHERE accounts.account_type = account_types.type_id AND (accounts.client_id = ${bankClient} OR accounts.second_client_id = ${bankClient} OR accounts.third_client_id = ${bankClient});
				</sql:query>
				<label for="trasanctionOrigin">Cuenta de origen</label>
				<select name="trasanctionOrigin" id="trasanctionOrigin">
				    <c:forEach var="row" items="${cdr.rows}">
					<c:if test="${row.account_id==1}">
					    <option value="${row.account_id}" data-amount="${row.amount}" selected="selected">${row.type} (${row.account_number})</option>
					</c:if>
					<c:if test="${row.account_id!=1}">
					    <option value="${row.account_id}" data-amount="${row.amount}">${row.type} (${row.account_number})</option>
					</c:if>
				    </c:forEach>
				</select>
				<input type="submit" name="transactionSend" id="transactionSend" value="Registrar transación" />
			    </div>
			    <div class="one-third column">
				<div class="headerSpace"></div>
				<input type="hidden" value="${bankClient}" id="transactionClient" name="transactionClient" />
				<label for="trasanctionDestiny">Cuenta de destino</label><input type="text" placeholder="20 dígitos" name="trasanctionDestiny" id="trasanctionDestiny" required="required" />
				<label for="transactionAmount">Cantidad a transferir</label><input type="number" placeholder="Cantidad en euros" name="transactionAmount" id="transactionAmount" required="required" />
			    </div>
			</form>
		    </div>


		</div>
		<div class="one-third column">
		    <c:import url="dashboard.jsp"/>
		</div>
		<div class="sixteen columns"><section class="two-thirds columns" id="wrong"></section></div>
		<script>
		</script>
	    </c:forEach>
	</div>
    </article>
    <c:import url="footer.jsp"/>
</c:if>
<c:if test="${empty bankClient || empty param.account}">
    <c:redirect url="index.jsp" />
</c:if>
