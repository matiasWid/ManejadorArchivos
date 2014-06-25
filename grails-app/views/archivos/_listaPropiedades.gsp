<g:if test="${flash.message}">
   ${flash.message}
</g:if>
<g:each in="${nombres}" status="i" var="nombresInstance">
		<%if(nombres.size() == 1){%>
			<label>
			${nombresInstance.toString()}
			</label><br> 
		<%}else if(i==nombres.size() -1){%>
			<label>
			${nombresInstance.toString()}
			</label><br> 
		<%}else{%>
			<label>
			${nombresInstance.toString() + ", "}
			</label><br> 
		<%}%>	
</g:each>
<%if(nombres){%>
    <div id="descargarArchivosMarcados">
        <g:link controller="archivos" action="multipleFileDownload">Descargar</g:link></li>
    </div>
<%}%>
<%if (nombres){%>
    <p>Etiquetas</p>
       		<g:each in="${tags}" status = "a" var="tagsIterator">
                        <div class="etiquetas">
                            
                            <g:formRemote name="tagsFrm" on404="alert('not found!')" update="archivosSeleccionados" 
                  url="[controller: 'archivos', action:'removerTag']">
                                    <label>
                                        ${tagsIterator.palabraClave.toString()} 
                                    </label>
                                    <g:textField name="id" 
                                     value="${tagsIterator.id}" hidden="true"/>
                                    <span class="button"><g:actionSubmit class="botonesTag" value="X"/></span>
                            </g:formRemote>
                    </div>
                </g:each>
<%if (nombres.size() == 1){%>
    <g:form name="atributosFrm">

        <g:textField 
        name= "nombreArchivo"
        id="nombreArchivo" 
        type= "text" 
        placeholder= "Nombre del archivo"
        value = "${nombres[0].toString().substring(0,nombres[0].toString().lastIndexOf('.'))}"/>
        <span class="button">
            <g:actionSubmit class="edit" value="Cambiar nombre" controller='archivos' action='editarNombre'/>
        </span>
    </g:form>
 <%}%>                
<g:formRemote name="atributosFrm" on404="alert('not found!')" update="archivosSeleccionados"
              url="[controller: 'archivos', action:'editarTags']">
        
        <g:textField name="etiquetas"
        placeholder = "Etiquetas"/>
        <span class="button">
            <g:actionSubmit class="edit" value="Agregar etiquetas"/>
        </span>
</g:formRemote>
<%}%>


