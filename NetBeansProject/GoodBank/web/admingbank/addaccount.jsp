<%-- 
    Document   : addmanager
    Created on : 13-nov-2013, 13:31:07
    Author     : José Antonio Yáñez Jiménez
    Portfolio  : http://www.jimenezfrontend.es
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:requestEncoding value="UTF-8"/>
<c:if test="${not empty bankManager}">
    <c:if test="${not empty param.accountSend}">
	<c:import url="header.jsp" charEncoding="UTF-8"/>
	<%-- DATOS DE CONEXIÓN SQL --%>
	<c:import url="dbinfo.jsp"/>
	<sql:setDataSource var="db"
			   driver="${jdbcdriver}"
			   url="${sqlurl}"
			   user="${sqluser}"
			   password="${sqlpwd}" />
	<%
	    SimpleDateFormat date2 = new SimpleDateFormat("yyyy-MM-dd");
	    Date newDate = new Date();
	    pageContext.setAttribute("newDate", date2.format(newDate));
	%>
	<sql:update var="insert" dataSource="${db}">
	    INSERT INTO accounts (account_number,branch,creation_date,account_type,client_id,second_client_id,third_client_id,amount) VALUES (?,?,?,?,?,?,?,?)
	    <sql:param value="${param.accountNumber}" />
	    <sql:param value="${param.accountBranch}" />
	    <sql:param value="${newDate}" />
	    <sql:param value="${param.accountType}" />
	    <sql:param value="${param.accountMainClient}" />
	    <sql:param value="${empty param.accountSecondayClient?null:param.accountSecondayClient}" />
	    <sql:param value="${empty param.accountTernaryClient?null:param.accountTernaryClient}" />
	    <sql:param value="${param.accountAmount}" />
	</sql:update>
	<article class="container">
	    <div class="sixteen columns">
		<h2>Cuenta número ${param.accountNumber} creada correctamente</h2>
		<div class="headerSpace"></div>
		<div class="two-thirds column">
		</div>
		<div class="one-third column">
		    <c:import url="dashboard.jsp"/>
		</div>
		<c:import url="footer.jsp" charEncoding="UTF-8"/>
	    </c:if>
	    <c:if test="${empty param.accountSend}">

		<c:import url="header.jsp" charEncoding="UTF-8"/>
		<article class="container">
		    <div class="sixteen columns">
			<div class="two-thirds colum">
			    <h2>Agrega una cuenta</h2>
			</div>
			<form name="newAccountForm" id="newAccountForm" action="addaccount.jsp" method="POST">
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
				    SELECT branches.branch_id, branches.address, street_types.type, provinces.province FROM branches, provinces, street_types WHERE branches.province = provinces.province_id AND branches.street_type = street_types.type_id;
				</sql:query>
				<label for="accountBranch">Oficina</label>
				<select name="accountBranch" id="accountBranch">
				    <c:forEach var="row" items="${cdr.rows}">
					<c:if test="${row.branch_id==1}">
					    <option value="${row.branch_id}" selected="selected">${row.type} ${row.address}, ${row.province}</option>
					</c:if>
					<c:if test="${row.branch_id!=1}">
					    <option value="${row.branch_id}">${row.type} ${row.address}, ${row.province}</option>
					</c:if>
				    </c:forEach>
				</select>
				<c:set var="rand"><%= 1000000000 + (long)(java.lang.Math.round(java.lang.Math.random() * 999999999)) %></c:set>
				<label for="accountNumber">Número de cuenta</label><input type="text" placeholder="10 dígitos" name="accountNumber" id="accountNumber" readonly="readonly" value="${rand}" required="required" />
				<label for="accountAmount">Ingreso inicial</label><input type="number" placeholder="Cantidad en euros" name="accountAmount" id="accountAmount" required="required" />
				<input type="submit" name="accountSend" id="accountSend" value="Registrar cliente" />
			    </div>
			    <div class="one-third column">
				<div class="headerSpace"></div>
				<sql:query var="cdr" dataSource="${db}">
				    SELECT * FROM account_types;
				</sql:query>
				<label for="accountType">Tipo de cuenta</label>
				<select name="accountType" id="accountType">
				    <c:forEach var="row" items="${cdr.rows}">
					<c:if test="${row.type_id==1}">
					    <option value="${row.type_id}" selected="selected">${row.type}</option>
					</c:if>
					<c:if test="${row.type_id!=1}">
					    <option value="${row.type_id}">${row.type}</option>
					</c:if>
				    </c:forEach>
				</select>
				<sql:query var="cdr" dataSource="${db}">
				    SELECT * FROM clients;
				</sql:query>
				<label for="accountMainClient">Cliente</label>
				<select name="accountMainClient" id="accountMainClient">
				    <c:forEach var="row" items="${cdr.rows}">
					<c:if test="${row.client_id==1}">
					    <option value="${row.client_id}" selected="selected">${row.name} ${row.lastname_first} ${row.lastname_second}</option>
					</c:if>
					<c:if test="${row.client_id!=1}">
					    <option value="${row.client_id}">${row.name} ${row.lastname_first} ${row.lastname_second}</option>
					</c:if>
				    </c:forEach>
				</select>
				<sql:query var="cdr" dataSource="${db}">
				    SELECT * FROM clients;
				</sql:query>
				<label for="accountSecondaryClient">Segundo titular</label>
				<select name="accountSecondaryClient" id="accountSecondaryClient">
				    <option value="" selected="selected">Ninguno</option>
				    <c:forEach var="row" items="${cdr.rows}">
					<option value="${row.client_id}">${row.name} ${row.lastname_first} ${row.lastname_second}</option>
				    </c:forEach>
				</select>
				<sql:query var="cdr" dataSource="${db}">
				    SELECT * FROM clients;
				</sql:query>
				<label for="accountTernaryClient">Tercer titular</label>
				<select name="accountTernaryClient" id="accountTernaryClient">
				    <option value="" selected="selected">Ninguno</option>
				    <c:forEach var="row" items="${cdr.rows}">
					<option value="${row.client_id}">${row.name} ${row.lastname_first} ${row.lastname_second}</option>
				    </c:forEach>
				</select>
			    </div>
			    <div class="one-third column">
				<c:import url="dashboard.jsp"/>
			    </div>
			    <div class="sixteen columns"><section class="two-thirds columns" id="wrong"></section></div>
			</form>
		    </div>
		</article>
		<script src="scripts/validatenewaccount.js" type="text/javascript"></script>
		<script>
					    $('#newAccountForm').submit(function(e) {
						checkNewAccount(e);
					    });
		</script>
		<c:import url="footer.jsp" charEncoding="UTF-8" />
	    </c:if>
	</c:if>
	<c:if test="${empty bankManager}">
	    <c:redirect url="index.jsp" />
	</c:if>
