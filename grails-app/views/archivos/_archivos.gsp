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
        <g:hiddenField name="id" value="${bookInstance?.id}" />
        <%if (nombres.size() == 1){%>
	        <input id="nombreArchivo" 
	        type= "text" 
	        placeholder= "Nombre del archivo"
	        value = ${nombres[0].toString()} ></input>
	    <%}%>
        <input id="etiquetas"
        type="text"
        placeholder = "Etiquetas"></input>
        <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
        <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
</g:form>
<%}%>