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
<p>Etiquetas</p>
		<g:each in="${tags}" status = "a" var="tagsIterator">
			<label>
				${tagsIterator.palabraClave.toString()}
			</label>
		</g:each>
<%if (nombres){%>
<g:form>
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