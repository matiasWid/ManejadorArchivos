<g:each in="${nombres}" status="i" var="nombresInstance">
		<%if(nombres.size() == 1){%>
			<label>
			${nombresInstance.toString()}
			</label>
		<%}else if(i==nombres.size() -1){%>
			<label>
			${nombresInstance.toString()}
			</label>
		<%}else{%>
			<label>
			${nombresInstance.toString() + ", "}
			</label>
		<%}%>	
</g:each>

<%if (nombres){%>

<g:form>
	<p>Etiquetas</p>

		<g:each in="${tags}" status = "a" var="tagsIterator">
			<label>
				${tagsIterator.palabraClave.toString()} 
				<g:textField name="id" 
				hidden = "true" value="${tagsIterator.id}"/>
				<span class="button" onclick= "${remoteFunction(controller: 'archivos', action:'listaPropiedades',
			update:[success:'archivosSeleccionados', failure:'archivosSeleccionados'])}"><g:actionSubmit class="edit" controller="archivos" 
					action="removerTag" value="X"/></span>

			</label>
		</g:each>

        <%if (nombres.size() == 1){%>
	        <g:textField 
	        name= "nombreArchivo"
	        id="nombreArchivo" 
	        type= "text" 
	        placeholder= "Nombre del archivo"
	        value = "${nombres[0].toString()}"/>
	    <%}%>
        <g:textField name="etiquetas"
        placeholder = "Etiquetas"/>
        <span class="button"><g:actionSubmit class="edit" controller="archivos" action="editarAtributos" value="Editar" /></span>
        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
</g:form>
<%}%>