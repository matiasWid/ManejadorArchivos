<%@page import="org.apache.catalina.connector.Request"%>
<%@page import="manejadorArchivos.ArchivosController"%>
<%@ page import="dominio.Archivo"%>
<%@page expressionCodec="raw" %>
<%

def downloads = grailsApplication.config.images.location.toString()
def path1 = new File("${downloads}/myFirstUploadr")

%>
<!doctype html>
<html lang="es">
    <head>
        <link rel="stylesheet"
        href="${resource(dir: 'css', file: 'estilos.css')}" type="text/css">
        <script src="${resource(dir: 'js', file: 'jquery.js')}"></script>
        <meta charset="utf-8">
        <title>Manejador de archivos</title>
        <r:require modules="uploadr"/>
        <r:layoutResources/>
    </head>
    <body>
        <header>
            <div class="botonesAccion">
                <nav id="listaAcciones">
                    <ul>
                        <li><g:textField name="busqueda" value=""
                                placeholder="Ingrese el texto a buscar" /></li>
                        <li><a href="" id="botonSubir">Subir</a></li>
                        <li><a href="" id="botonDescargar">Descargar</a></li>
                        <li><a href="" id="botonCortar">Cortar</a></li>
                        <li><a href="" id="botonCopiar">Copiar</a></li>
                        <li><a href="" id="botonPegar">Pegar</a></li>
                        <li><a href="" id="botonMisArchivos">Mis archivos</a></li>
                    </ul>
                </nav>
            </div>

        </header>
        <div id="divSubir">
            <h1>Subir archivo:</h1><br>
            <uploadr:add name="myUploadrName" path="/my/upload/path" direction="up" maxVisible="8" unsupported="/my/controller/action" rating="true" voting="true" colorPicker="true" maxSize="204800" />
            <g:form method="post"  enctype="multipart/form-data">
                <div class="dialog">
                    <label for="fileUpload">Subir:</label>
                    <input type="file" id="fileUpload" name="fileUpload" />
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="upload" value="Subir" action="upload" /></span>
                </div>
           </g:form>
        </div>
        <div id="directorioActual">
            <span class="directorio">
                <g:link action='archivos'>
                    Inicio
                </g:link>
            </span> 
            <span class="separador">
                /
            </span>
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
                                params='[ruta : "${dir.replace(File.separatorChar.toString(), '#')}"]'>
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
                            <th class="sortable">Ruta</th>
                            <th class="sortable">Etiquetas</th>
                            <th class="sortable">Fecha de creación</th>
                            <!--<g:sortableColumn property="path" title="Ruta"/>
                            <g:sortableColumn property="path" title="Etiquetas"/>
                            <g:sortableColumn property="path" title="Fecha de creacion"/>-->
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${listaDirectorios}" status="i" var="listaInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                <td>
                                    <label> 
                                        <g:link action='archivos'
                                                        params='[ruta : "${listaInstance.replace(File.separatorChar.toString(), '#')}"]'>
                                             <img src="../images/skin/folder-icon.png">
                                            </img>           
                                            ${listaInstance.toString().substring(listaInstance.toString().lastIndexOf(File.separatorChar.toString())+1)}
                                        </g:link>
                                    </label>
                                </td>
                            </tr>
                        </g:each>
                        <g:each in="${listaArchivos}" status="i" var="listaInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                <td><label> <g:checkBox id="check${i}"
                                        name='${listaInstance.toString().substring(listaInstance.toString().lastIndexOf(File.separatorChar.toString())+1)}' 
                                        value="${false}"
                                            onchange="obtenerMarcados()" /> <g:link action='archivos'
                                            params='[ruta : "${listaInstance.replace(File.separatorChar.toString(), '#')}"]'>
                                            ${listaInstance.toString().substring(listaInstance.toString().lastIndexOf(File.separatorChar.toString())+1)}
                                        </g:link>
                                    </label></td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
           <!-- <div id="listaFicheros">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="path" title="Ruta" colspan="3" />
                        </tr>
                    </thead>
                    <tbody>
                        
                    </tbody>
                </table>
            </div>-->
            <div id="listaPropiedades">
                <p>Archivos Seleccionados</p>
                <div id="archivosSeleccionados">
                    <g:render template="listaPropiedades"/>
                </div>
            </div>
        </div>
    </body>
    <script type="text/javascript">
        onComplete:obtenerMarcados();
        function obtenerMarcados(){

        var sList =[];

        $("input:checked").each(function () {
        console.log ($(this.name));
        
        var nombre =  $(this.name);
        
        sList.push(nombre.selector);
        
        });
        console.log (sList);

        ${remoteFunction(controller: 'archivos', action:'listaPropiedades',
                        params:'\'lista=\' + sList',
                        update:[success:'archivosSeleccionados', failure:'archivosSeleccionados'])}
        };
        
    </script>
</html>