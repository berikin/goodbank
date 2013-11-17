<%-- 
    Document   : jQueryTransactions
    Created on : 15-nov-2013, 16:06:53
    Author     : berik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<c:if test="${not empty param.account}">
    <c:import url="dbinfo.jsp"/>
    <sql:setDataSource var="db"
		       driver="${jdbcdriver}"
		       url="${sqlurl}"
		       user="${sqluser}"
		       password="${sqlpwd}" />
    <sql:query var="cdr" dataSource="${db}">
	SELECT * FROM transactions WHERE account=? ORDER BY transaction_date DESC
	<sql:param value="${param.account}" />
    </sql:query>
    <c:forEach var="row" items="${cdr.rows}">
	${row.transaction_id},${row.account},${row.transaction_date},${row.amount},${row.applicant},${row.concept}#
    </c:forEach>
</c:if>