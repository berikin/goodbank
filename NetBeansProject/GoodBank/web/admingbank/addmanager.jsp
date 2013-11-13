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
    </c:choose>


    <c:import url="header.jsp"/>
    <article class="container">
	<div class="sixteen columns">
	    <h2>Agrega un administrador</h2>
	    <div class="headerSpace"></div>
	    <form name="newManagerForm" action="addmanager.jsp" method="POST">
		<div class="one-third column">
		    ${bankUserAgent}
		    <label for="managerIdCard">DNI</label><input type="text" placeholder="DNI del administrador" name="managerIdCard" id="managerIdCard" required="required" />
		    <label for="managerName">Nombre</label><input type="text" placeholder="Nombre de administrador" name="managerName" id="managerName" required="required" />
		    <label for="managerLastNameFirst">Primer apellido</label><input type="text" placeholder="Primer apellido del administrador" name="managerLastNameFirst" id="managerLastNameFirst" required="required" />
		    <label for="managerLastNameSecond">Segundo apellido</label><input type="text" placeholder="Segundo apellido del administrador" name="managerLastNameSecond" id="managerLastNameSecond" required="required" />
		</div>
		<div class="one-third column">
		    <label for="managerBirthDate">Fecha de nacimiento</label><input type="date" placeholder="fecha de nacimiento del administrador" name="managerIdCard" id="managerIdCard" required="required" />
		    <label for="managerName">Nombre</label><input type="text" placeholder="Nombre de administrador" name="managerName" id="managerName" required="required" />
		    <label for="managerLastNameFirst">Primer apellido</label><input type="text" placeholder="Primer apellido del administrador" name="managerLastNameFirst" id="managerLastNameFirst" required="required" />
		    <label for="managerLastNameSecond">Segundo apellido</label><input type="text" placeholder="Segundo apellido del administrador" name="managerLastNameSecond" id="managerLastNameSecond" required="required" />
		</div>
	    </form>
	</div>
    </article>
    <c:import url="footer.jsp"/>
</c:if>
<c:if test="${empty bankManager}">
    <c:redirect url="index.jsp" />
</c:if>
