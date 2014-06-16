<g:if test="${flash.message}">
   ${flash.message}
</g:if>
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


	<p>Etiquetas</p>
       		<g:each in="${tags}" status = "a" var="tagsIterator">
			<label>
				${tagsIterator.palabraClave.toString()} 
			</label>
                        <g:formRemote name="tagsFrm" on404="alert('not found!')" update="archivosSeleccionados"
              url="[controller: 'archivos', action:'removerTag']">
                                <g:textField name="id" 
				 value="${tagsIterator.id}" hidden="true"/>
				<span class="button"><g:actionSubmit class="edit" value="X"/></span>
                        </g:formRemote>
		</g:each>

<g:formRemote name="tagsFrm" on404="alert('not found!')" update="archivosSeleccionados"
              url="[controller: 'archivos', action:'editarAtributos']">
        <%if (nombres.size() == 1){%>
	        <g:textField 
	        name= "nombreArchivo"
	        id="nombreArchivo" 
	        type= "text" 
	        placeholder= "Nombre del archivo"
	        value = "${nombres[0].toString().substring(0,nombres[0].toString().lastIndexOf('.'))}"/>
	    <%}%>
        <g:textField name="etiquetas"
        placeholder = "Etiquetas"/>
        <span class="button"><g:actionSubmit 
            class="edit" value="Editar"/></span>
</g:formRemote>
<%}%>


