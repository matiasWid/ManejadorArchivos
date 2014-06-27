<%@page import="org.apache.catalina.connector.Request"%>
<%@page import="manejadorArchivos.ArchivosController"%>
<%@ page import="dominio.Archivo"%>
<%@page expressionCodec="raw" %>

<!doctype html>
<html lang="es">
    <head>
        <link rel="stylesheet"
        href="${resource(dir: 'css', file: 'estilos.css')}" type="text/css">
        <script src="${resource(dir: 'js', file: 'jquery.js')}"></script>
        <script src="${resource(dir: 'js', file: 'funcionesJs.js')}" type="text/javascript"></script>
        <meta charset="utf-8">
        <title>Manejador de archivos</title>
    </head>
    <body>
        <header>
            <div class="botonesAccion">
                <nav id="listaAcciones">
                    <ul>
                        <li>
                            <g:formRemote name="busquedaFrm" on404="alert('not found!')" update="listaDirectorios"
                            url="[controller: 'archivos', action:'comenzarRecursivo']">
                                <g:textField name="busqueda" value=""
                                placeholder="Ingrese el texto a buscar" required="true"/>
                                     <span class="button"><g:actionSubmit class="upload" value="Buscar"/></span>
                            </g:formRemote>        
                        </li>
                        <li><a id="botonSubir">Subir</a></li>
                        <li><a id="botonCarpeta">Crear carpeta</a></li>
                        <li><a href="" id="botonCortar">Cortar</a></li>
                        <li><a href="" id="botonCopiar">Copiar</a></li>
                        <li><a href="" id="botonPegar">Pegar</a></li>
                        <li><a href="" id="botonMisArchivos">Mis archivos</a></li>
                        <li><a href="" id="userName">Usuario: ${session.user.nick}</a></li>
                    </ul>
                </nav>
            </div>

        </header>
       
        <div id="divSubir" class="sliders">
            <h1>Subir archivo:</h1><br>
            <g:form method="post"  enctype="multipart/form-data">
                <div class="dialog">
                    <label for="fileUpload">Subir:</label>
                    <input type="file" id="filesUpload" name="filesUpload" multiple="multiple"/>
                    <input type="text" id="tags" name="etiquetas"  placeholder= "Etiquetas"/>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="upload" value="Subir" action="upload" /></span>
                </div>
           </g:form>
        </div>
        <div id="directorioNuevo"  class="sliders">
            <h1>Crear una nueva carpeta</h1><br>
            <g:form method="post">
                <div class="dialog">
                    <input placeholder = "nombre de carptea" required
                    type="text" id="nombreCarpeta" name="dirName"/>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="upload" value="Crear" action="nuevaCarpeta" /></span>
                
                </div>
           </g:form>
        </div>
        <div id="directorioActual">
            <img id="imgCarga" src="../images/spinner.gif"/>
            <span class="directorio">
                <g:link action='archivos'>
                    Inicio
                </g:link>
            </span> 
            <span class="separador">
                /
            </span>
            <!--se muestra la ruta actual y la posibilidad de navegar en las mismas-->
            <g:set var="dir"/>
                <g:each in="${listaDirRecorridos}" status="i" var="listaInstance">
                    <span class="directorio">
                        <%
                            if(dir!=null){
                                dir=dir+File.separatorChar.toString()+listaInstance
                            }else{
                                dir=listaInstance
                            }                        
                        %>
                        <g:link action='archivos'
                                params='[ruta : "${dir.replace(File.separatorChar.toString(), '|')}"]'>
                                ${listaInstance.toString().substring(listaInstance.toString().lastIndexOf(File.separatorChar.toString())+1)}
                        </g:link>
                    </span>
                    <span class="separador">
                        /
                    </span>
                </g:each>
        </div>
        <div class="directorioPropiedades">
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
                        <g:each in="${listaDirectorios}" status="i" var="listaInstance">
                            
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                <td>
                                    <label> 
                                        <g:link action='archivos'
                                                        params='[ruta : "${listaInstance.replace(File.separatorChar.toString(), '|')}"]'>
                                             <img src="../images/skin/folder-icon.png">
                                            </img>           
                                            ${listaInstance.toString().substring(listaInstance.toString().lastIndexOf(File.separatorChar.toString())+1)}
                                        </g:link>
                                    </label>
                                </td>
                                <td></td>
                                <td></td>
                            </tr>
                            <%pos=i+1%>
                        </g:each>
                       
                        <!--se listan los archivos en el directorio-->
                        <g:formRemote name="archivosFrm" on404="alert('not found!')" update="archivosSeleccionados"
                            url="[controller: 'archivos', action:'listaPropiedades']">
                            <g:each in="${listaArchivos}" status="i" var="listaInstance">
                                
                                <tr class="${(pos % 2) == 0 ? 'odd' : 'even'}">
                                    <td>
                                        <label> 
                                            <%
                                            def nombre = listaInstance.nombre.toString().substring(listaInstance.nombre.toString().lastIndexOf(File.separatorChar.toString())+1)
                                            
                                            %>
                                            <g:checkBox id="${i}"
                                            value="${nombre}"
                                            name='check.${i}'
                                            onchange="hacerClic()"
                                            checked="${false}"/> 
                                            <g:link action='archivos'
                                                params='[ruta : "${listaInstance.nombre.replace(File.separatorChar.toString(), '|')}"]'>
                                                ${listaInstance.nombre.toString().substring(listaInstance.nombre.toString().lastIndexOf(File.separatorChar.toString())+1)}
                                            </g:link>
                                        </label>
                                    </td>
                                        <td></td>
                                        <td>
                                            <label> 
                                                <%
                                                def fecha = listaInstance.fecha

                                                %>
                                                ${fecha.format( 'dd-MMM-yyyy HH:mm')}
                                            </label>
                                             
                                        </td>
                                </tr>
                                <%pos=pos+1%>
                            </g:each>
                            <g:actionSubmit id="botonSubmit" class="edit" value="x" hidden="true"/>
                            </g:formRemote>
                    </tbody>
                </table>
            </div>
            <div id="listaPropiedades">
                <p>Archivos Seleccionados</p>
                <div id="archivosSeleccionados">
                    <g:render template="listaPropiedades"/>
                </div>
            </div>
        </div>
    </body>
</html>