<%@page import="org.apache.catalina.connector.Request"%>
<%@page import="manejadorArchivos.ArchivosController"%>
<%@ page import="dominio.Archivo"%>

<!doctype html>
<html lang="es">
    <head>
        <link rel="stylesheet"
        href="${resource(dir: 'css', file: 'estilos.css')}" type="text/css">
        <script src="${resource(dir: 'js', file: 'jquery.js')}"></script>
        <meta charset="utf-8">
        <title>Manejador de archivos</title>

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

			 <g:form method="post"  enctype="multipart/form-data">
	                <div class="dialog">
	                    <table>
	                        <tbody>
	                            <tr class="prop">
	                                <td valign="top" class="name">
	                                    <label for="fileUpload">Subir:</label>
	                                </td>
	                                <td valign="top" class="value ${hasErrors(bean:fileResourceInstance,field:'upload','errors')}">
	                                    <input type="file" id="fileUpload" name="fileUpload" />
	                                </td>
	                            </tr> 
	                        </tbody>
	                    </table>
	                </div>
	                <div class="buttons">
	                    <span class="button"><g:actionSubmit class="upload" value="Subir" action="upload" /></span>
	                </div>
	            </g:form>
        </div>
        <div class="directorioPropiedades">
            <div id="directorioActual">
                <table>
                    <tbody>
                        <g:each in="${listaDirRecorridos}" status="i" var="listaInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                <td>
                                    <label> 
                                        <g:link action='archivos'
                                            params='[ruta : "${listaInstance.replace(File.separatorChar.toString(), '#')}"]'>
                                            ${listaInstance.toString()}
                                        </g:link>
                                    </label>
                                </td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
            <div id="listaDirectorios">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="path" title="Ruta"/>
                            <g:sortableColumn property="path" title="Etiquetas"/>
                            <g:sortableColumn property="path" title="Fecha de creacion"/>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${listaDirectorios}" status="i" var="listaInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                <td><label> <g:link action='archivos'
                                            params='[ruta : "${listaInstance.replace(File.separatorChar.toString(), '#')}"]'>
                                            ${listaInstance.toString().substring(listaInstance.toString().lastIndexOf(File.separatorChar.toString())+1)}
                                        </g:link>
                                    </label></td>
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