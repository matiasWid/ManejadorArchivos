<head>
    <script src="${resource(dir: 'js', file: 'funcionesJs.js')}" type="text/javascript"></script>
</head>            
<div id="listaDirectoriosBuscado">
    <table>
        <thead>
            <tr>
                <th class="sortable"><input name="checktodos" type="checkbox" />Ruta</th>
                <th class="sortable">Etiquetas</th>
                <th class="sortable">Fecha de creación</th>
            </tr>
        </thead>
        <tbody>
            <!--se listan los directorios-->
            <%def pos=0
%>
            <g:formRemote name="archivosBuscadosFrm" on404="alert('not found!')" update="archivosSeleccionados"
                url="[controller: 'archivos', action:'listaPropiedades']">
                <g:each in="${listaDirBuscado}" status="i" var="listaInstance">
                    <%
if ((listaInstance.ruta.toString()+File.separatorChar.toString()).size()!=grailsApplication.config.images.location.toString().size()){
def nombreCarpeta = listaInstance.ruta.toString().substring(grailsApplication.config.images.location.toString().size())
    %>
                    <tr class="${(pos % 2) == 0 ? 'odd' : 'even'}">
                        <td>
                            <label> 
                                <g:link action='archivos'
                                    params='[ruta : "${nombreCarpeta.replace(File.separatorChar.toString(), '|')}"]'>
                                    <img src="../images/skin/folder-icon.png">
                                    </img>           
                                    ${listaInstance.ruta.toString().substring(listaInstance.ruta.toString().lastIndexOf(File.separatorChar.toString())+1)}
                                </g:link>      
                                <%pos=pos+1%>
                            </label>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <%
}else{
    %>
                    <tr class="${(pos % 2) == 0 ? 'odd' : 'even'}">
                        <td>
                            <label> 
                                <g:link action='archivos'
                                    params='[ruta : ""]'>
                                    <img src="../images/skin/folder-icon.png">
                                    </img>Inicio     
                                </g:link>      
                                <%pos=pos+1%>
                            </label>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                    <%
}
%>
                    <!--se listan los archivos-->
                    <%def archivos = listaInstance.archivos%>

                    <g:each in="${archivos}" var="listaArchivos">

                        <tr class="${(pos % 2) == 0 ? 'odd' : 'even'}">
                            <td>
                                <label> 
                                    <g:checkBox id="${pos}"
                                    value="${listaArchivos.nombre.toString()}"
                                        name='check.${pos}'
                                        onchange="hacerClic()"
                                    checked="${false}"/> 
                                    <g:link action='archivos'
                                        params='[ruta : "${listaArchivos.nombre.toString().replace(File.separatorChar.toString(), '|')}"]'>
                                        ${listaArchivos.nombre.toString().substring(listaArchivos.nombre.toString().lastIndexOf(File.separatorChar.toString())+1)}
                                    </g:link>
                                </label>
                            </td>
                            <td></td>
                            <td></td>
                        </tr>

                        <%pos=pos+1%>
                    </g:each>

                    <%pos=pos+1%>
                </g:each>
                <g:actionSubmit id="botonSubmit" class="edit" value="x"/>
            </g:formRemote>
        
    </tbody>
</table>
</div>
