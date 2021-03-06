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
<c:import url="dbinfo.jsp"/>
<c:if test="${not empty bankManager && bankManagerRange>1}">
    <c:if test="${not empty param.managerPwdSend}">
	<c:import url="header.jsp" charEncoding="UTF-8"/>
	<%-- INSTANCIAMOS EL BEAN DE AUTENTICACIÓN --%>
	<jsp:useBean id="manager"  scope="session" class="es.bancobueno.beans.Auth" />
	<%-- ASIGNAMOS LA CLAVE SIN CIFRAR AL BEAN --%>
	<jsp:setProperty name="manager" property="rawString" value="${param.managerPassword}" />
	<%-- CIFRAMOS LA CLAVE --%>
	${manager.calculateSHA512()}
	<sql:setDataSource var="db"
			   driver="${jdbcdriver}"
			   url="${sqlurl}"
			   user="${sqluser}"
			   password="${sqlpwd}" />
	<sql:update var="insert" dataSource="${db}">
	    UPDATE managers SET password=? WHERE id_card=?
	    <sql:param value="${manager.getshaString()}" />
	    <sql:param value="${param.managerPwdIdCard}" />
	</sql:update>
	<article class="container">
	    <div class="sixteen columns">
		<div class="two-thirds column">
		    <h2>Administrador con DNI ${param.managerPwdIdCard} actualizado correctamente</h2>
		    &nbsp;
		</div>
		<div class="one-third column">
		    <c:import url="dashboard.jsp"/>
		</div>
		<c:import url="footer.jsp" charEncoding="UTF-8"/>
	    </c:if>
	    <c:if test="${not empty param.managerSend}">
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
		    Date newDate = date.parse(request.getParameter("managerBirthDate"));
		    pageContext.setAttribute("newDate", date2.format(newDate));
		%>
		<sql:update var="insert" dataSource="${db}">
		    UPDATE managers SET name=?,lastname_first=?,lastname_second=?,birth_date=?,street_type=?,address=?,province=?,community=?,phone_number=?,manager_range=? WHERE id_card=?
		    <sql:param value="${param.managerName}" />
		    <sql:param value="${param.managerLastNameFirst}" />
		    <sql:param value="${param.managerLastNameSecond}" />
		    <sql:param value="${newDate}" />
		    <sql:param value="${param.managerStreetType}" />
		    <sql:param value="${param.managerAddress}" />
		    <sql:param value="${param.managerProvince}" />
		    <sql:param value="${param.managerCommunity}" />
		    <sql:param value="${param.managerPhone}" />
		    <sql:param value="${param.managerRange}" />
		    <sql:param value="${param.managerIdCard}" />
		</sql:update>
		<sql:query var="StreetType" dataSource="${db}">
		    SELECT * FROM street_types WHERE type_id=?
		    <sql:param value="${param.managerStreetType}" />
		</sql:query>
		<sql:query var="Community" dataSource="${db}">
		    SELECT * FROM communities WHERE community_id=?
		    <sql:param value="${param.managerCommunity}" />
		</sql:query>
		<sql:query var="Province" dataSource="${db}">
		    SELECT * FROM provinces WHERE province_id=?
		    <sql:param value="${param.managerProvince}" />
		</sql:query>
		<sql:query var="Range" dataSource="${db}">
		    SELECT * FROM manager_ranges WHERE range_id=?
		    <sql:param value="${param.managerRange}" />
		</sql:query>
		<article class="container">
		    <div class="sixteen columns">
			<div class="two-thirds column">
			    <h2>Administrador con DNI ${param.managerIdCard} actualizado correctamente</h2>
			    <div class="headerSpace"></div>
			    <p>
				Detalles:
			    </p>
			    <ul>
				<li>DNI: ${param.managerIdCard}</li>  
				<li>Nombre: ${param.managerName}</li>  
				<li>Primer apellido: ${param.managerLastNameFirst}</li>  
				<li>Segundo apellido: ${param.managerLastNameSecond}</li>  
				<li>Fecha de nacimiento: ${param.managerBirthDate}</li>  
				    <c:forEach var="row" items="${StreetType.rows}">
				    <li>Tipo de vía: ${row.type}</li>  
				    </c:forEach>
				<li>Resto de la dirección: ${param.managerAddress}</li>  
				    <c:forEach var="row" items="${Province.rows}">
				    <li>Provincia: ${row.province}</li>  
				    </c:forEach>
				    <c:forEach var="row" items="${Community.rows}">
				    <li>Comunidad autónoma: ${row.community}</li>  
				    </c:forEach>
				<li>Teléfono: ${param.managerPhone}</li>  
				    <c:forEach var="row" items="${Range.rows}">
				    <li>Rango del administrador: ${row.title}</li>  
				    </c:forEach>
			    </ul>
			</div>
			<div class="one-third column">
			    <c:import url="dashboard.jsp"/>
			</div>
			<c:import url="footer.jsp" charEncoding="UTF-8"/>
		    </c:if>
		    <c:if test="${empty param.managerSend && empty param.managerPwdSend}">

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
				    <h2>Edita un administrador</h2>
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
					    SELECT managers.manager_id,managers.id_card,managers.name,managers.lastname_first,managers.lastname_second,manager_ranges.title,managers.manager_range FROM managers,manager_ranges WHERE managers.manager_range=manager_ranges.range_id;
					</sql:query>
					<c:if test="${cdr.rowCount>1}">
					    <form name="selectManager">
						<label for="editManagerSwitch">Administrador a editar</label>
						<select class="widthtotal" name="editManagerSwitch" id="editManagerSwitch">
						    <c:forEach var="row" items="${cdr.rows}">
							<c:if test="${bankManagerRange!=2}">
							    <c:if test="${row.manager_id!=1}">
								<option value="${row.manager_id}">(${row.id_card}) ${row.name} ${row.lastname_first} ${row.lastname_second} (nivel ${row.title})</option>
							    </c:if>
							</c:if>
							<c:if test="${bankManagerRange==2}">
							    <c:if test="${row.manager_id!=1 && row.manager_range<2}">
								<option value="${row.manager_id}">(${row.id_card}) ${row.name} ${row.lastname_first} ${row.lastname_second} (nivel ${row.title})</option>
							    </c:if>
							</c:if>
						    </c:forEach>
						</select>
						<script>$('#editManagerSwitch').prop('selectedIndex', -1);</script>
					    </form>
					    <form name="selectManagerPwd">
						<label for="editManagerSwitchPwd">Cambio de clave del administrador</label>
						<select class="widthtotal" name="editManagerSwitchPwd" id="editManagerSwitchPwd">
						    <c:forEach var="row" items="${cdr.rows}">
							<c:if test="${bankManagerRange!=2}">
							    <c:if test="${row.manager_id!=1}">
								<option value="${row.manager_id}">(${row.id_card}) ${row.name} ${row.lastname_first} ${row.lastname_second} (nivel ${row.title})</option>
							    </c:if>
							</c:if>
							<c:if test="${bankManagerRange==2}">
							    <c:if test="${row.manager_id!=1 && row.manager_range<2}">
								<option value="${row.manager_id}">(${row.id_card}) ${row.name} ${row.lastname_first} ${row.lastname_second} (nivel ${row.title})</option>
							    </c:if>
							</c:if>
						    </c:forEach>
						</select>
						<script>
						    $('#editManagerSwitch').prop('selectedIndex', -1);
						    $('#editManagerSwitchPwd').prop('selectedIndex', -1);
						</script>
					    </form>
					    <p></p>
					    <script src="scripts/editmanager.js"></script>
					    <script>
						    $("#editManagerSwitch").change(function() {
							editManager($('#editManagerSwitch').val());
							$("div:hidden").show("slow");
							$("#selectAdminDiv").hide("slow");
							$("#editManagerSwitch").attr("disabled", "disabled");
							$("#editManagerSwitchPwd").attr("disabled", "disabled");
						    });
						    $("#editManagerSwitchPwd").change(function() {
							editManager($('#editManagerSwitchPwd').val());
							$("section:hidden").show("slow");
							$("#selectAdminDiv").hide("slow");
							$("#editManagerSwitch").attr("disabled", "disabled");
							$("#editManagerSwitchPwd").attr("disabled", "disabled");
						    });
					    </script>
					</div>
					<form name="editManagerForm" id="editManagerForm" action="editmanager.jsp" method="POST">
					    <div class="one-semithird column invisible">
						<label for="managerIdCard">DNI</label><input readonly="readonly" type="text" placeholder="DNI del administrador" name="managerIdCard" id="managerIdCard" required="required" />
						<label for="managerName">Nombre</label><input type="text" placeholder="Nombre de administrador" name="managerName" id="managerName" required="required" />
						<label for="managerLastNameFirst">Primer apellido</label><input type="text" placeholder="Primer apellido del administrador" name="managerLastNameFirst" id="managerLastNameFirst" required="required" />
						<label for="managerLastNameSecond">Segundo apellido</label><input type="text" placeholder="Segundo apellido del administrador" name="managerLastNameSecond" id="managerLastNameSecond" required="required" />
						<c:choose>
						    <c:when test="${bankUserAgent=='chrome' }">
							<label for="managerBirthDate">Fecha de nacimiento</label><input type="date" placeholder="fecha de nacimiento del administrador" name="managerBirthDate" id="managerBirthDate" required="required" />
						    </c:when>
						    <c:otherwise>
							<script>
							    $(function() {
								$("#managerBirthDate").datepicker({yearRange: "1930:1998", changeYear: true, defaultDate: new Date(1988, 4, 16)});
							    });
							</script>
							<label for="managerBirthDate">Fecha de nacimiento</label><input type="text" placeholder="fecha de nacimiento del administrador" name="managerBirthDate" id="managerBirthDate" required="required" />
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
					    </div>
					    <div class="one-semithird column invisible">
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
						<input type="submit" name="managerSend" id="managerSend" value="Editar administrador" />
					    </div>
					</form>
					<section class="one-third column invisible">
					    <form name="editPwdManagerForm" id="editPwdManagerForm" action="editmanager.jsp" method="POST">
						<label for="managerPassword">Nueva clave</label><input type="password" placeholder="Clave del administrador" name="managerPassword" id="managerPassword" required="required" />
						<input type="hidden" name="managerPwdIdCard" id="managerPwdIdCard" />
						<input type="submit" name="managerPwdSend" id="managerPwdSend" value="Cambiar clave" />
					    </form>
					</section>
				    </div>
				    <div class="one-third column">
					<c:import url="dashboard.jsp"/>
				    </div>
				    <div class="sixteen columns"><section class="two-thirds columns" id="wrong"></section></div>
					</c:if>
					<c:if test="${cdr.rowCount<2}">
				    <p>No hay administradores para eliminar</p>
				</div></div>
				<c:import url="dashboard.jsp"/>
			    </c:if>
			    <c:if test="${cdr.rowCount>0}">
		</div>
	    </c:if>
	</article>
	<script src="scripts/validateeditmanager.js" type="text/javascript"></script>
	<script>
							    $('#editManagerForm').submit(function(e) {
								checkEditManager(e);
							    });
							    $('#editPwdManagerForm').submit(function(e) {
								checkEditPwdManager(e);
							    });
	</script>
	<c:import url="footer.jsp" charEncoding="UTF-8" />
    </c:if>
</c:if>
<c:if test="${empty bankManager or bankManagerRange==1}">
    <c:redirect url="index.jsp" />
</c:if>
