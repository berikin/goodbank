<%-- 
    Document   : addclient
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
<c:import url="dbinfo.jsp"/>
<c:if test="${not empty bankManager && bankManagerRange<3}">
    <c:if test="${not empty param.clientPwdSend}">
	<c:import url="header.jsp" charEncoding="UTF-8"/>
	<%-- INSTANCIAMOS EL BEAN DE AUTENTICACIÓN --%>
	<jsp:useBean id="client"  scope="session" class="es.bancobueno.beans.Auth" />
	<%-- ASIGNAMOS LA CLAVE SIN CIFRAR AL BEAN --%>
	<jsp:setProperty name="client" property="rawString" value="${param.clientPassword}" />
	<%-- CIFRAMOS LA CLAVE --%>
	${client.calculateSHA512()}
	<sql:setDataSource var="db"
			   driver="${jdbcdriver}"
			   url="${sqlurl}"
			   user="${sqluser}"
			   password="${sqlpwd}" />
	<sql:update var="insert" dataSource="${db}">
	    UPDATE clients SET password=? WHERE id_card=?
	    <sql:param value="${client.getshaString()}" />
	    <sql:param value="${param.clientPwdIdCard}" />
	</sql:update>
	<article class="container">
	    <div class="sixteen columns">
		<div class="two-thirds column">
		    <h2>Cliente con DNI ${param.clientPwdIdCard} actualizado correctamente</h2>
		    &nbsp;
		</div>
		<div class="one-third column">
		    <c:import url="dashboard.jsp"/>
		</div>
		<c:import url="footer.jsp" charEncoding="UTF-8"/>
	    </c:if>
	    <c:if test="${not empty param.clientSend}">
		<c:import url="header.jsp" charEncoding="UTF-8"/>
		<%-- DATOS DE CONEXIÓN SQL --%>
		<sql:setDataSource var="db"
				   driver="${jdbcdriver}"
				   url="${sqlurl}"
				   user="${sqluser}"
				   password="${sqlpwd}" />
		<%
		    SimpleDateFormat date = new SimpleDateFormat("dd/MM/yyyy");
		    SimpleDateFormat date2 = new SimpleDateFormat("yyyy-MM-dd");
		    Date newDate = date.parse(request.getParameter("clientBirthDate"));
		    pageContext.setAttribute("newDate", date2.format(newDate));
		%>
		<sql:update var="insert" dataSource="${db}">
		    UPDATE clients SET name=?,lastname_first=?,lastname_second=?,birth_date=?,street_type=?,address=?,province=?,community=?,phone_number=?,client_range=? WHERE id_card=?
		    <sql:param value="${param.clientName}" />
		    <sql:param value="${param.clientLastNameFirst}" />
		    <sql:param value="${param.clientLastNameSecond}" />
		    <sql:param value="${newDate}" />
		    <sql:param value="${param.clientStreetType}" />
		    <sql:param value="${param.clientAddress}" />
		    <sql:param value="${param.clientProvince}" />
		    <sql:param value="${param.clientCommunity}" />
		    <sql:param value="${param.clientPhone}" />
		    <sql:param value="${param.clientRange}" />
		    <sql:param value="${param.clientIdCard}" />
		</sql:update>
		<sql:query var="StreetType" dataSource="${db}">
		    SELECT * FROM street_types WHERE type_id=?
		    <sql:param value="${param.clientStreetType}" />
		</sql:query>
		<sql:query var="Community" dataSource="${db}">
		    SELECT * FROM communities WHERE community_id=?
		    <sql:param value="${param.clientCommunity}" />
		</sql:query>
		<sql:query var="Province" dataSource="${db}">
		    SELECT * FROM provinces WHERE province_id=?
		    <sql:param value="${param.clientProvince}" />
		</sql:query>
		<sql:query var="Range" dataSource="${db}">
		    SELECT * FROM client_ranges WHERE range_id=?
		    <sql:param value="${param.clientRange}" />
		</sql:query>
		<article class="container">
		    <div class="sixteen columns">
			<div class="two-thirds column">
			    <h2>Cliente con DNI ${param.clientIdCard} actualizado correctamente</h2>
			    <div class="headerSpace"></div>
			    <p>
				Detalles:
			    </p>
			    <ul>
				<li>DNI: ${param.clientIdCard}</li>  
				<li>Nombre: ${param.clientName}</li>  
				<li>Primer apellido: ${param.clientLastNameFirst}</li>  
				<li>Segundo apellido: ${param.clientLastNameSecond}</li>  
				<li>Fecha de nacimiento: ${param.clientBirthDate}</li>  
				    <c:forEach var="row" items="${StreetType.rows}">
				    <li>Tipo de vía: ${row.type}</li>  
				    </c:forEach>
				<li>Resto de la dirección: ${param.clientAddress}</li>  
				    <c:forEach var="row" items="${Province.rows}">
				    <li>Provincia: ${row.province}</li>  
				    </c:forEach>
				    <c:forEach var="row" items="${Community.rows}">
				    <li>Comunidad autónoma: ${row.community}</li>  
				    </c:forEach>
				<li>Teléfono: ${param.clientPhone}</li>  
				    <c:forEach var="row" items="${Range.rows}">
				    <li>Rango del cliente: ${row.title}</li>  
				    </c:forEach>
			    </ul>
			</div>
			<div class="one-third column">
			    <c:import url="dashboard.jsp"/>
			</div>
			<c:import url="footer.jsp" charEncoding="UTF-8"/>
		    </c:if>
		    <c:if test="${empty param.clientSend && empty param.clientPwdSend}">

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
			<c:import url="header.jsp" charEncoding="UTF-8"/>
			<article class="container">
			    <div class="sixteen columns">
				<div class="two-thirds colum">
				    <h2>Edita un cliente</h2>
				</div>
				<div class="two-thirds column clearfix">
				    <div class="headerSpace"></div>
				    <div id="selectAdminDiv" class="two-thirds column clearfix">
					<sql:setDataSource var="db"
							   driver="${jdbcdriver}"
							   url="${sqlurl}"
							   user="${sqluser}"
							   password="${sqlpwd}" />
					<sql:query var="cdr" dataSource="${db}">
					    SELECT clients.client_id,clients.id_card,clients.name,clients.lastname_first,clients.lastname_second,client_ranges.title,clients.client_range FROM clients,client_ranges WHERE clients.client_range=client_ranges.range_id;
					</sql:query>
					<c:if test="${cdr.rowCount>1}">
					    <form name="selectClient">
						<label for="editClientSwitch">Cliente a editar</label>
						<select class="widthtotal" name="editClientSwitch" id="editClientSwitch">
						    <c:forEach var="row" items="${cdr.rows}">
							<c:if test="${bankClientRange!=2}">
							    <c:if test="${row.client_id!=1}">
								<option value="${row.client_id}">(${row.id_card}) ${row.name} ${row.lastname_first} ${row.lastname_second} (nivel ${row.title})</option>
							    </c:if>
							</c:if>
							<c:if test="${bankClientRange==2}">
							    <c:if test="${row.client_id!=1 && row.client_range<2}">
								<option value="${row.client_id}">(${row.id_card}) ${row.name} ${row.lastname_first} ${row.lastname_second} (nivel ${row.title})</option>
							    </c:if>
							</c:if>
						    </c:forEach>
						</select>
						<script>$('#editClientSwitch').prop('selectedIndex', -1);</script>
					    </form>
					    <form name="selectClientPwd">
						<label for="editClientSwitchPwd">Cambio de clave del cliente</label>
						<select class="widthtotal" name="editClientSwitchPwd" id="editClientSwitchPwd">
						    <c:forEach var="row" items="${cdr.rows}">
							<c:if test="${bankClientRange!=2}">
							    <c:if test="${row.client_id!=1}">
								<option value="${row.client_id}">(${row.id_card}) ${row.name} ${row.lastname_first} ${row.lastname_second} (nivel ${row.title})</option>
							    </c:if>
							</c:if>
							<c:if test="${bankClientRange==2}">
							    <c:if test="${row.client_id!=1 && row.client_range<2}">
								<option value="${row.client_id}">(${row.id_card}) ${row.name} ${row.lastname_first} ${row.lastname_second} (nivel ${row.title})</option>
							    </c:if>
							</c:if>
						    </c:forEach>
						</select>
						<script>
						    $('#editClientSwitch').prop('selectedIndex', -1);
						    $('#editClientSwitchPwd').prop('selectedIndex', -1);
						</script>
					    </form>
					    <p></p>
					    <script src="scripts/editclient.js"></script>
					    <script>
						    $("#editClientSwitch").change(function() {
							editClient($('#editClientSwitch').val());
							$("div:hidden").show("slow");
							$("#selectAdminDiv").hide("slow");
							$("#editClientSwitch").attr("disabled", "disabled");
							$("#editClientSwitchPwd").attr("disabled", "disabled");
						    });
						    $("#editClientSwitchPwd").change(function() {
							editClient($('#editClientSwitchPwd').val());
							$("section:hidden").show("slow");
							$("#selectAdminDiv").hide("slow");
							$("#editClientSwitch").attr("disabled", "disabled");
							$("#editClientSwitchPwd").attr("disabled", "disabled");
						    });
					    </script>
					</div>
					<form name="editClientForm" id="editClientForm" action="editclient.jsp" method="POST">
					    <div class="one-semithird column invisible">
						<label for="clientIdCard">DNI</label><input readonly="readonly" type="text" placeholder="DNI del cliente" name="clientIdCard" id="clientIdCard" required="required" />
						<label for="clientName">Nombre</label><input type="text" placeholder="Nombre de cliente" name="clientName" id="clientName" required="required" />
						<label for="clientLastNameFirst">Primer apellido</label><input type="text" placeholder="Primer apellido del cliente" name="clientLastNameFirst" id="clientLastNameFirst" required="required" />
						<label for="clientLastNameSecond">Segundo apellido</label><input type="text" placeholder="Segundo apellido del cliente" name="clientLastNameSecond" id="clientLastNameSecond" required="required" />
						<c:choose>
						    <c:when test="${bankUserAgent=='chrome' }">
							<label for="clientBirthDate">Fecha de nacimiento</label><input type="date" placeholder="fecha de nacimiento del cliente" name="clientBirthDate" id="clientBirthDate" required="required" />
						    </c:when>
						    <c:otherwise>
							<script>
							    $(function() {
								$("#clientBirthDate").datepicker({yearRange: "1930:1998", changeYear: true, defaultDate: new Date(1988, 4, 16)});
							    });
							</script>
							<label for="clientBirthDate">Fecha de nacimiento</label><input type="text" placeholder="fecha de nacimiento del cliente" name="clientBirthDate" id="clientBirthDate" required="required" />
						    </c:otherwise>
						</c:choose>
						<sql:setDataSource var="db"
								   driver="${jdbcdriver}"
								   url="${sqlurl}"
								   user="${sqluser}"
								   password="${sqlpwd}" />
						<sql:query var="cdr" dataSource="${db}">
						    SELECT * FROM street_types;
						</sql:query>
						<label for="clientStreetType">Tipo de vía</label>
						<select name="clientStreetType" id="clientStreetType">
						    <c:forEach var="row" items="${cdr.rows}">
							<c:if test="${row.type_id==8}">
							    <option value="${row.type_id}" selected="selected">${row.type}</option>
							</c:if>
							<c:if test="${row.type_id!=8}">
							    <option value="${row.type_id}">${row.type}</option>
							</c:if>
						    </c:forEach>
						</select>
					    </div>
					    <div class="one-semithird column invisible">
						<label for="clientAddress">Dirección</label><input type="text" placeholder="Resto de la dirección" name="clientAddress" id="clientAddress" required="required" />
						<sql:query var="cdr" dataSource="${db}">
						    SELECT * FROM provinces;
						</sql:query>
						<label for="clientProvince">Provincia</label>
						<select name="clientProvince" id="clientProvince">
						    <c:forEach var="row" items="${cdr.rows}">
							<c:if test="${row.province_id==47}">
							    <option value="${row.province_id}" selected="selected">${row.province}</option>
							</c:if>
							<c:if test="${row.province_id!=47}">
							    <option value="${row.province_id}">${row.province}</option>
							</c:if>
						    </c:forEach>
						</select>
						<sql:query var="cdr" dataSource="${db}">
						    SELECT * FROM communities;
						</sql:query>
						<label for="clientCommunity">Comunidad</label>
						<select name="clientCommunity" id="clientCommunity">
						    <c:forEach var="row" items="${cdr.rows}">
							<c:if test="${row.community_id==7}">
							    <option value="${row.community_id}" selected="selected">${row.community}</option>
							</c:if>
							<c:if test="${row.community_id!=7}">
							    <option value="${row.community_id}">${row.community}</option>
							</c:if>
						    </c:forEach>
						</select>
						<label for="clientPhone">Teléfono</label><input type="number" placeholder="Teléfono del cliente" name="clientPhone" id="clientPhone" value="34" required="required" />
						<sql:query var="cdr" dataSource="${db}">
						    SELECT * FROM client_ranges;
						</sql:query>
						<label for="clientRange">Rango del cliente</label>
						<select name="clientRange" id="clientRange">
						    <c:forEach var="row" items="${cdr.rows}">
							<c:if test="${row.range_id==1}">
							    <option value="${row.range_id}" selected="selected">${row.title}</option>
							</c:if>
							<c:if test="${row.range_id!=1}">
							    <option value="${row.range_id}">${row.title}</option>
							</c:if>
						    </c:forEach>
						</select>
						<input type="submit" name="clientSend" id="clientSend" value="Editar cliente" />
					    </div>
					</form>
					<section class="one-third column invisible">
					    <form name="editPwdClientForm" id="editPwdClientForm" action="editclient.jsp" method="POST">
						<label for="clientPassword">Nueva clave</label><input type="password" placeholder="Clave del cliente" name="clientPassword" id="clientPassword" required="required" />
						<input type="hidden" name="clientPwdIdCard" id="clientPwdIdCard" />
						<input type="submit" name="clientPwdSend" id="clientPwdSend" value="Cambiar clave" />
					    </form>
					</section>
				    </div>
				    <div class="one-third column">
					<c:import url="dashboard.jsp"/>
				    </div>
				    <div class="sixteen columns"><section class="two-thirds columns" id="wrong"></section></div>
					</c:if>
					<c:if test="${cdr.rowCount<1}">
					<p>No hay clientes para modificar</p>
				</div></div>
				<c:import url="dashboard.jsp"/>
			    </c:if>
			    <c:if test="${cdr.rowCount>0}">
		</div>
	    </c:if>
	</article>
	<script src="scripts/validateeditclient.js" type="text/javascript"></script>
	<script>
						    $('#editClientForm').submit(function(e) {
							checkEditClient(e);
						    });
						    $('#editPwdClientForm').submit(function(e) {
							checkEditPwdClient(e);
						    });
	</script>
	<c:import url="footer.jsp" charEncoding="UTF-8" />
    </c:if>
</c:if>
<c:if test="${empty bankManager or bankManagerRange==3}">
    <c:redirect url="index.jsp" />
</c:if>
