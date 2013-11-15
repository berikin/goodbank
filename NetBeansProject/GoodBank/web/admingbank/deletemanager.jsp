<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:if test="${not empty bankManager}">
    <c:if test="${not empty param.delManagerSwitch}">
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
		    DELETE FROM managers WHERE manager_id=?
		    <sql:param value="${param.delManagerSwitch}" />
		</sql:update>
		<div class="two-thirds column">
		    <h2>Administrador eliminado definitivamente</h2>
		    &nbsp;
		</div>
		<div class="one-third column">
		    <c:import url="dashboard.jsp"/>
		</div>
	    </div>
	</article>
	<c:import url="footer.jsp"/>
    </c:if>
    <c:if test="${empty param.delManagerSwitch}">
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
		    SELECT managers.manager_id,managers.id_card,managers.name,managers.lastname_first,managers.lastname_second,manager_ranges.title FROM managers,manager_ranges WHERE managers.manager_range=manager_ranges.range_id;
		</sql:query>
		<c:if test="${cdr.rowCount>1}">
		    <div class="two-thirds column">
			<div class="headerSpace"></div>
			<form method="POST" name="delManagerForm" id="delManagerForm" action="deletemanager.jsp">
			    <label for="delManagerSwitch">Administrador a eliminar</label>
			    <select class="widthtotal" name="delManagerSwitch" id="delManagerSwitch">
				<c:forEach var="row" items="${cdr.rows}">
				    <c:if test="${row.manager_id!=1}">
					<option value="${row.manager_id}">(${row.id_card}) ${row.name} ${row.lastname_first} ${row.lastname_second} (nivel ${row.title})</option>
				    </c:if>
				</c:forEach>
			    </select>
			    <input type="submit" value="Eliminar" name="delManagerSend" />
			</form>
		    </div>
		    <div class="one-third column">
			<c:import url="dashboard.jsp"/>
		    </div>
		</c:if>
		<c:if test="${cdr.rowCount<2}">
		    <div class="two-thirds column">
			<div class="headerSpace"></div>
			<p>No hay administradores para eliminar</p>
		    </div>
		    <div class="one-third column">
			<c:import url="dashboard.jsp"/>
		    </div>
		</c:if>
	    </div>
	</article>
	<div id="dialog-confirm" class="confirmation" title="¿Eliminar el administrador seleccionado?">
	    <p><span class="ui-icon ui-icon-alert"></span>El administrador será permanentemente eliminado de la base de datos, ¿Continuar?</p>
	</div>
	<script src="scripts/validatedeletemanager.js"></script>
	<c:import url="footer.jsp"/>
    </c:if>
</c:if>
<c:if test="${empty bankManager}">
</c:if>