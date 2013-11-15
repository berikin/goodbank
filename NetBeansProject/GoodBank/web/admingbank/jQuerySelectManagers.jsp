<%-- 
    Document   : jQuerySelectManagers
    Created on : 15-nov-2013, 16:06:53
    Author     : berik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<c:if test="${empty param.edit}">
    <c:if test="${not empty param.dni}">
	${param.dni}$
    </c:if>
    <c:import url="dbinfo.jsp"/>
    <sql:setDataSource var="db"
		       driver="${jdbcdriver}"
		       url="${sqlurl}"
		       user="${sqluser}"
		       password="${sqlpwd}" />
    <sql:query var="cdr" dataSource="${db}">
	SELECT * FROM managers WHERE manager_id!=1
    </sql:query>
    <c:forEach var="row" items="${cdr.rows}">
	${row.manager_id},${row.id_card},${row.name},${row.lastname_first},${row.lastname_second},${row.birth_date},${row.street_type},${row.address},${row.province},${row.community},${row.phone_number},${row.manager_range}#
    </c:forEach>
</c:if>
<c:if test="${not empty param.edit}">
    <c:import url="dbinfo.jsp"/>
    <sql:setDataSource var="db"
		       driver="${jdbcdriver}"
		       url="${sqlurl}"
		       user="${sqluser}"
		       password="${sqlpwd}" />
    <sql:query var="cdr" dataSource="${db}">
	SELECT * FROM managers WHERE manager_id=?
	<sql:param value="${param.edit}" />
    </sql:query>
    <c:forEach var="row" items="${cdr.rows}">
	${row.manager_id},${row.id_card},${row.name},${row.lastname_first},${row.lastname_second},${row.birth_date},${row.street_type},${row.address},${row.province},${row.community},${row.phone_number},${row.manager_range}
    </c:forEach>
</c:if>