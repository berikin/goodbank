<%-- 
    Document   : controlpanel.jsp
    Created on : 13-nov-2013, 12:26:10
    Author     : José Antonio Yáñez Jiménez
    Portfolio  : http://www.jimenezfrontend.es
--%>

<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<c:if test="${not empty bankClient}">
    <c:if test="${not empty param.transactionSend}">
	<c:import url="header.jsp" charEncoding="UTF-8"/>
	<%-- DATOS DE CONEXIÓN SQL --%>
	<c:import url="dbinfo.jsp"/>
	<sql:setDataSource var="db"
			   driver="${jdbcdriver}"
			   url="${sqlurl}"
			   user="${sqluser}"
			   password="${sqlpwd}" />
	<%
	    Date newDate = new Date();
	    pageContext.setAttribute("newDate", newDate);
	    BigDecimal newAmount = new BigDecimal(request.getParameter("transactionAmount")).negate();
	    pageContext.setAttribute("newAmount", newAmount);
	%>
	<sql:query var="cdruser" dataSource="${db}">
	    SELECT name, lastname_first, lastname_second FROM clients WHERE client_id = ?
	    <sql:param value="${bankClient}" />
	</sql:query>
	<c:forEach var="client" items="${cdruser.rows}">   
	    <sql:update var="insert" dataSource="${db}">
		INSERT INTO transactions (account,transaction_date,amount,applicant,concept) VALUES (?,?,?,?,?)
		<sql:param value="${param.transactionOrigin}" />
		<sql:param value="${newDate}" />
		<sql:param value="${newAmount}" />
		<sql:param value="${client.name} ${client.lastname_first} ${client.lastname_second}" />
		<sql:param value="${empty param.transactionConcept?null:param.transactionConcept}" />
	    </sql:update>
	    <sql:query var="cdr" dataSource="${db}">
		SELECT amount FROM accounts WHERE account_id = ?
		<sql:param value="${transactionOrigin}" />
	    </sql:query>
	    <sql:update var="update" dataSource="${db}">
		UPDATE accounts SET amount=amount+? WHERE account_id = ?
		<sql:param value="${newAmount}" />
		<sql:param value="${param.transactionOrigin}" />
	    </sql:update>
	</c:forEach>

	<article class="container">
	    <div class="sixteen columns">
		<h2>Transacción realizada</h2>
		<div class="headerSpace"></div>
		<div class="two-thirds column">
		</div>
		<div class="one-third column">
		    <c:import url="dashboard.jsp"/>
		</div>
		<c:import url="footer.jsp" charEncoding="UTF-8"/>
	    </c:if>
	    <c:if test="${empty param.transactionSend}">
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
					    <label for="transactionOrigin">Cuenta de origen</label>
					    <select name="transactionOrigin" id="transactionOrigin">
						<c:forEach var="row" items="${cdr.rows}">
						    <c:if test="${row.account_id==1}">
							<option value="${row.account_id}" data-amount="${row.amount}" selected="selected">${row.type} (${row.account_number})</option>
						    </c:if>
						    <c:if test="${row.account_id!=1}">
							<option value="${row.account_id}" data-amount="${row.amount}">${row.type} (${row.account_number})</option>
						    </c:if>
						</c:forEach>
					    </select>
					    <label for="trasanctionDestiny">Cuenta de destino</label><input type="text" placeholder="20 dígitos" name="trasanctionDestiny" id="trasanctionDestiny" required="required" />
					    <input type="submit" name="transactionSend" id="transactionSend" value="Registrar transación" />
					</div>
					<div class="one-third column">
					    <div class="headerSpace"></div>
					    <input type="hidden" value="${bankClient}" id="transactionClient" name="transactionClient" />
					    <label for="transactionAmount">Cantidad a transferir</label><input type="number" placeholder="Cantidad en euros" name="transactionAmount" id="transactionAmount" required="required" />
					    <label for="transactionConcept">Concepto</label><input type="text" placeholder="Concepto" name="transactionConcept" id="transactionConcept" />
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
	</c:if>
	<c:if test="${empty bankClient}">
	    <c:redirect url="index.jsp" />
	</c:if>
