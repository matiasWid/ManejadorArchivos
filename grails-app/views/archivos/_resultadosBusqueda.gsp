            <div id="listaDirectorios">
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
                        <%def pos=0%>
                        <g:each in="${listaDirBuscado}" status="i" var="listaInstance">
                            
                            <tr class="${(pos % 2) == 0 ? 'odd' : 'even'}">
                                <td>
                                    <label> 
                                        <g:link action='archivos'
                                                        params='[ruta : "${listaInstance.directorio.replace(File.separatorChar.toString(), '|')}"]'>
                                             <img src="../images/skin/folder-icon.png">
                                            </img>           
                                            ${listaInstance.directorio.toString().substring(listaInstance.directorio.toString().lastIndexOf(File.separatorChar.toString())+1)}
                                        </g:link>      
                                        <%pos=pos+1%>
                                    </label>
                                </td>
                                <td></td>
                                <td></td>
                            </tr>
                            <%def archivos = listaInstance.archivos%>
                            <g:each in="${archivos}" var="listaArchivos">
                            
                                <tr class="${(pos % 2) == 0 ? 'odd' : 'even'}">
                                    <td>
                                        <label> 

                                            ${listaArchivos.toString().substring(listaArchivos.toString().lastIndexOf(File.separatorChar.toString())+1)}

                                        </label>
                                    </td>
                                    <td></td>
                                    <td></td>
                                </tr>

                                <%pos=pos+1%>
                            </g:each>
                            <%pos=pos+1%>
                        </g:each>
                       
                        <!--se listan los archivos en el directorio-->
                        <g:formRemote name="archivosFrm" on404="alert('not found!')" update="archivosSeleccionados"
                            url="[controller: 'archivos', action:'listaPropiedades']">
                            
                            <g:actionSubmit id="botonSubmit" class="edit" value="x" hidden="true"/>
                            </g:formRemote>
                    </tbody>
                </table>
            </div>