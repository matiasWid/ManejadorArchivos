<%@ page import="dominio.Archivo"%>

<!doctype html>
<html lang="es">
<head>
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'estilos.css')}" type="text/css">
<script src="${resource(dir: 'js', file: 'jquery-1.3.2.min.js')}"
	type="text/javascript"></script>
<script src="${resource(dir: 'js', file: 'colapsarDirectorios.js')}"
	type="text/javascript"></script>
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
							<td>
								<label>
								
									<g:link action='archivos' params='[ruta : "${listaInstance.replace(File.separatorChar.toString(), '#')}"]'>
									${listaInstance.toString()}
									</g:link>
								</label>
							</td>
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
							<td>
								<label>
								<g:checkBox name="${listaInstance.replace(File.separatorChar.toString(), '#')}" value="${false}" />
									<g:link action='archivos' params='[ruta : "${listaInstance.replace(File.separatorChar.toString(), '#')}"]'>
									${listaInstance.toString().substring(listaInstance.toString().lastIndexOf(File.separatorChar.toString())+1)}
									</g:link>
								</label>
							</td>
						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
		<div id="listaPropiedades"></div>
	</div>
</body>
</html>