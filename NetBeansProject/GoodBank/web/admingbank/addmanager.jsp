<%-- 
    Document   : addmanager
    Created on : 13-nov-2013, 13:31:07
    Author     : José Antonio Yáñez Jiménez
    Portfolio  : http://www.jimenezfrontend.es
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:if test="${not empty bankManager}">
    <c:choose>
	<c:when test="${fn:contains(header['User-Agent'],'MSIE')}">
	    <c:set var="bankUserAgent" value="msie" scope="session" />
	</c:when>
	<c:when test="${fn:contains(header['User-Agent'],'Chrome')}">
	    <c:set var="bankUserAgent" value="chrome" scope="session" />
	</c:when>
	<c:when test="${fn:contains(header['User-Agent'],'Firefox')}">
	    <c:set var="bankUserAgent" value="firefox" scope="session" />
	</c:when>
	<c:when test="${fn:contains(header['User-Agent'],'Safari') && !fn:contains(header['User-Agent'],'Chrome')}">
	    <c:set var="bankUserAgent" value="safari" scope="session" />
	</c:when>
	<c:otherwise>
	    <c:set var="bankUserAgent" value="other" scope="session" />
	</c:otherwise>
    </c:choose>


    <c:import url="header.jsp"/>
    <article class="container">
	<div class="sixteen columns">
	    <h2>Agrega un administrador</h2>
	    <div class="headerSpace"></div>
	    <form name="newManagerForm" id="newManagerForm" action="addmanager.jsp" method="POST">
		<div class="one-third column">
		    <label for="managerIdCard">DNI</label><input type="text" placeholder="DNI del administrador" name="managerIdCard" id="managerIdCard" required="required" />
		    <label for="managerName">Nombre</label><input type="text" placeholder="Nombre de administrador" name="managerName" id="managerName" required="required" />
		    <label for="managerLastNameFirst">Primer apellido</label><input type="text" placeholder="Primer apellido del administrador" name="managerLastNameFirst" id="managerLastNameFirst" required="required" />
		    <label for="managerLastNameSecond">Segundo apellido</label><input type="text" placeholder="Segundo apellido del administrador" name="managerLastNameSecond" id="managerLastNameSecond" required="required" />
		</div>
		<div class="one-third column">
		    <c:choose>
			<c:when test="${bankUserAgent=='chrome' }">
			    <label for="managerBirthDate">Fecha de nacimiento</label><input type="date" placeholder="fecha de nacimiento del administrador" name="managerBirthDate" id="managerBirthDate" required="required" />
			</c:when>
			<c:otherwise>
			    <script>
				$(function() {
				    $("#managerBirthDate").datepicker();
				});
			    </script>
			    <label for="managerBirthDate">Fecha de nacimiento</label><input type="text" placeholder="fecha de nacimiento del administrador" name="managerBirthDate" id="managerBirthDate" required="required" />
			</c:otherwise>
		    </c:choose>
		    <%-- DATOS DE CONEXIÓN SQL --%>
		    <c:import url="dbinfo.jsp"/>
		    <sql:setDataSource var="db"
				       driver="${jdbcdriver}"
				       url="${sqlurl}"
				       user="${sqluser}"
				       password="${sqlpwd}" />
		    <sql:query var="cdr" dataSource="${db}">
			SELECT * FROM street_types;
		    </sql:query>
		    <label for="managerStreetType">Tipo de vía</label>
		    <select name="managerStreetType" id="managerStreetType">
			<c:forEach var="row" items="${cdr.rows}">
			    <c:if test="${row.type_id==8}">
				<option value="${row.type_id}" selected="selected">${row.type}</option>
			    </c:if>
			    <c:if test="${row.type_id!=8}">
				<option value="${row.type_id}">${row.type}</option>
			    </c:if>
			</c:forEach>
		    </select>
		    <label for="managerAddress">Dirección</label><input type="text" placeholder="Resto de la dirección" name="managerAddress" id="managerAddress" required="required" />
		    <sql:query var="cdr" dataSource="${db}">
			SELECT * FROM provinces;
		    </sql:query>
		    <label for="managerProvince">Provincia</label>
		    <select name="managerProvince" id="managerProvince">
			<c:forEach var="row" items="${cdr.rows}">
			    <c:if test="${row.province_id==47}">
				<option value="${row.province_id}" selected="selected">${row.province}</option>
			    </c:if>
			    <c:if test="${row.province_id!=47}">
				<option value="${row.province_id}">${row.province}</option>
			    </c:if>
			</c:forEach>
		    </select>
		    <input type="submit" name="managerSend" id="managerSend" value="Registrar administrador" />
		</div>
		<div class="one-third column">
		    <sql:query var="cdr" dataSource="${db}">
			SELECT * FROM communities;
		    </sql:query>
		    <label for="managerCommunity">Comunidad</label>
		    <select name="managerCommunity" id="managerCommunity">
			<c:forEach var="row" items="${cdr.rows}">
			    <c:if test="${row.community_id==7}">
				<option value="${row.community_id}" selected="selected">${row.community}</option>
			    </c:if>
			    <c:if test="${row.community_id!=7}">
				<option value="${row.community_id}">${row.community}</option>
			    </c:if>
			</c:forEach>
		    </select>
		    <label for="managerPhone">Teléfono</label><input type="number" placeholder="Teléfono del administrador" name="managerPhone" id="managerPhone" value="34" required="required" />
		    <sql:query var="cdr" dataSource="${db}">
			SELECT * FROM manager_ranges;
		    </sql:query>
		    <label for="managerRange">Rango del administrador</label>
		    <select name="managerRange" id="managerRange">
			<c:forEach var="row" items="${cdr.rows}">
			    <c:if test="${row.range_id==1}">
				<option value="${row.range_id}" selected="selected">${row.title}</option>
			    </c:if>
			    <c:if test="${row.range_id!=1}">
				<option value="${row.range_id}">${row.title}</option>
			    </c:if>
			</c:forEach>
		    </select>
		    <label for="managerPassword">Clave</label><input type="password" placeholder="Clave del administrador" name="managerPassword" id="managerPassword" required="required" />
		</div>
	    </form>
	</div>
    </article>
    <script src="scripts/validatenewmanager.js" type="text/javascript"></script>
    <script>
	$('#newManagerForm').submit(function(e) {
	    checkNewManager(e);
	});
    </script>
    <c:import url="footer.jsp"/>
</c:if>
<c:if test="${empty bankManager}">
    <c:redirect url="index.jsp" />
</c:if>
