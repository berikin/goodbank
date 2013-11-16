<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:if test="${not empty bankManager && bankManagerRange==2}">
    <c:if test="${not empty param.delClientSwitch}">
	<c:import url="header.jsp"/>
	<c:import url="dbinfo.jsp"/>
	<article class="container">
	    <div class="sixteen columns">
		<sql:setDataSource var="db"
				   driver="${jdbcdriver}"
				   url="${sqlurl}"
				   user="${sqluser}"
				   password="${sqlpwd}" />
		<sql:update var="del" dataSource="${db}">
		    DELETE FROM clients WHERE client_id=?
		    <sql:param value="${param.delClientSwitch}" />
		</sql:update>
		<div class="two-thirds column">
		    <h2>Cliente eliminado definitivamente</h2>
		    &nbsp;
		</div>
		<div class="one-third column">
		    <c:import url="dashboard.jsp"/>
		</div>
	    </div>
	</article>
	<c:import url="footer.jsp"/>
    </c:if>
    <c:if test="${empty param.delClientSwitch}">
	<c:import url="header.jsp"/>
	<c:import url="dbinfo.jsp"/>
	<article class="container">
	    <div class="sixteen columns">
		<sql:setDataSource var="db"
				   driver="${jdbcdriver}"
				   url="${sqlurl}"
				   user="${sqluser}"
				   password="${sqlpwd}" />
		<sql:query var="cdr" dataSource="${db}">
		    SELECT clients.client_id,clients.id_card,clients.name,clients.lastname_first,clients.lastname_second,client_ranges.title,clients.client_range FROM clients,client_ranges WHERE clients.client_range=client_ranges.range_id;
		</sql:query>
		<c:if test="${cdr.rowCount>0}">
		    <div class="two-thirds column">
			<div class="headerSpace"></div>
			<form method="POST" name="delClientForm" id="delClientForm" action="deleteclient.jsp">
			    <label for="delClientSwitch">Cliente a eliminar</label>
			    <select class="widthtotal" name="delClientSwitch" id="delClientSwitch">
				<c:forEach var="row" items="${cdr.rows}">
				    <option value="${row.client_id}">(${row.id_card}) ${row.name} ${row.lastname_first} ${row.lastname_second} (nivel ${row.title})</option>
				</c:forEach>
			    </select>
			    <script>
				$('#delClientSwitch').prop('selectedIndex', -1);
			    </script>
			    <input type="submit" value="Eliminar" name="delClientSend" />
			</form>
		    </div>
		    <div class="one-third column">
			<c:import url="dashboard.jsp"/>
		    </div>
		</c:if>
		<c:if test="${cdr.rowCount<1}">
		    <div class="two-thirds column">
			<h2>Eliminar un cliente</h2>
			<div class="headerSpace"></div>
			<p>No hay clientes para eliminar</p>
		    </div>
		    <div class="one-third column">
			<c:import url="dashboard.jsp"/>
		    </div>
		</c:if>
	    </div>
	</article>
	<div id="dialog-confirm" class="confirmation" title="¿Eliminar el cliente seleccionado?">
	    <p><span class="ui-icon ui-icon-alert"></span>El cliente será permanentemente eliminado de la base de datos, ¿Continuar?</p>
	</div>
	<script src="scripts/validatedeleteclient.js"></script>
	<c:import url="footer.jsp"/>
    </c:if>
</c:if>
<c:if test="${empty bankManager or bankManagerRange!=2}">
    <c:redirect url="index.jsp" />
</c:if>