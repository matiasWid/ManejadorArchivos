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
	<div class="directorioPropiedades">
		<div id="listaDirectorios">
			<table>
				<thead>
					<tr>
						<g:sortableColumn property="path" title="Ruta" colspan="3" />
					</tr>
				</thead>
				<tbody>
					<g:each in="${listaDirectorios}" status="i" var="listaInstance">
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							<td><label> <g:link action='archivos'
										params='[ruta : "${listaInstance.replace(File.separatorChar.toString(), '#')}"]'>
										${listaInstance.toString()}
									</g:link>
							</label></td>
						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
		<div id="listaFicheros">
			<table>
				<thead>
					<tr>
						<g:sortableColumn property="path" title="Ruta" colspan="3" />
					</tr>
				</thead>
				<tbody>
					<g:each in="${listaArchivos}" status="i" var="listaInstance">
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							<td><label> <g:checkBox id="check${i}"
										name="${listaInstance.toString().substring(listaInstance.toString().lastIndexOf(File.separatorChar.toString())+1)}" 
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
		<div id="listaPropiedades">
			<g:each in="${nombres}" status="i" var="listaInstance">
						<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
							<td><label> <g:link action='archivos'
										params='[ruta : "${listaInstance.replace(File.separatorChar.toString(), '#')}"]'>
										${listaInstance.toString()}
									</g:link>
							</label></td>
						</tr>
					</g:each>
		</div>
	</div>
</body>
<script type="text/javascript">
    function obtenerMarcados(){
    
   	var sList =[];

		$('input[type=checkbox]').each(function () {
			var nombre = $(this.name);
			if (this.checked){
		    	sList.push(nombre.selector);
	    	};
		});
		console.log (sList);
    	        
		${remoteFunction(controller: 'archivos', action:'listaPropiedades',
			params:'\'lista=\' + sList',
			update:[success:'listaPropiedades', failure:'listaPropiedades'])}
    };
</script>
</html>