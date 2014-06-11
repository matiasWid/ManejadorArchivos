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

<g:formRemote name="tagsFrm" on404="alert('not found!')" update="listaPropiedades"
              url="[controller: 'archivos', action:'removerTag']">
	<p>Etiquetas</p>
        <div id="etiquetas">
		<g:each in="${tags}" status = "a" var="tagsIterator">
			<label>
				${tagsIterator.palabraClave.toString()} 
				<g:textField name="id" 
				hidden = "true" value="${tagsIterator.id}"/>
				<span class="button"><g:actionSubmit class="edit" value="X"/></span>

			</label>
		</g:each>
        </div>
</g:formRemote>
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
        <span class="button"><g:actionSubmit 
            class="edit" controller="archivos" action="editarAtributos" 
            value="Editar"/></span>
</g:form>
<%}%>


