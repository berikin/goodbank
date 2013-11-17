<%-- 
    Document   : logout
    Created on : 16-nov-2013, 0:12:35
    Author     : berik
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="bankClientLogged" value="${null}" scope="session"/>
<c:set var="bankClient" value="${null}" scope="session"/>
<c:set var="bankClientRange" value="${null}" scope="session"/>
<c:remove var="bankClientLogged" scope="session"/>
<c:remove var="bankClient" scope="session"/>
<c:remove var="bankClientRange" scope="session"/>
<c:set var="bankManagerLogged" value="${null}" scope="session"/>
<c:set var="bankManager" value="${null}" scope="session"/>
<c:set var="bankManagerRange" value="${null}" scope="session"/>
<c:remove var="bankManagerLogged" scope="session"/>
<c:remove var="bankManager" scope="session"/>
<c:remove var="bankManagerRange" scope="session"/>
<c:redirect url="index.jsp" />