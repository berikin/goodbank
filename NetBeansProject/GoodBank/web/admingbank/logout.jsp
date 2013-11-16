<%-- 
    Document   : logout
    Created on : 16-nov-2013, 0:12:35
    Author     : berik
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:remove var="logged"/>
<c:remove var="bankManager"/>
<c:remove var="bankManagerRange"/>
<c:redirect url="index.jsp" />
