<%@ page import="dominio.Archivo"%>

<!doctype html>
<html lang="es">
<head>
<link rel="stylesheet"
	href="${resource(dir: 'css', file: 'estilos.css')}" type="text/css">
<script src="${resource(dir: 'js', file: 'jquery-1.3.2.min.js')}" type="text/javascript"></script>
<script src="${resource(dir: 'js', file: 'colapsarDirectorios.js')}" type="text/javascript"></script>
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
			<ul>
				<li><a href="#" class="folder_link" id="folder_link_1">Folder
						1</a>
					<div class="folder_content" id="folder_content_1">
						<p>This is the content that goes in the folder. Text is added
							for the purpose of taking up space. Nothing special here. This is
							the content that goes in the folder. Text is added for the
							purpose of taking up space. Nothing special here. This is the
							content that goes in the folder. Text is added for the purpose of
							taking up space. Nothing special here. This is the content that
							goes in the folder. Text is added for the purpose of taking up
							space. Nothing special here. This is the content that goes in the
							folder. Text is added for the purpose of taking up space. Nothing
							special here. This is the content that goes in the folder. Text
							is added for the purpose of taking up space. Nothing special
							here. This is the content that goes in the folder. Text is added
							for the purpose of taking up space. Nothing special here.</p>
					</div></li>
				<li><a href="#" class="folder_link" id="folder_link_2">Folder
						2</a>
					<div class="folder_content" id="folder_content_2">
						<p>This is the content that goes in the folder. Text is added
							for the purpose of taking up space. Nothing special here. This is
							the content that goes in the folder. Text is added for the
							purpose of taking up space. Nothing special here. This is the
							content that goes in the folder. Text is added for the purpose of
							taking up space. Nothing special here. This is the content that
							goes in the folder. Text is added for the purpose of taking up
							space. Nothing special here. This is the content that goes in the
							folder. Text is added for the purpose of taking up space. Nothing
							special here. This is the content that goes in the folder. Text
							is added for the purpose of taking up space. Nothing special
							here. This is the content that goes in the folder. Text is added
							for the purpose of taking up space. Nothing special here.</p>
					</div></li>
				<li><a href="#" class="folder_link" id="folder_link_3">Folder
						3</a>

					<div class="folder_content" id="folder_content_3">
						<p>This is the content that goes in the folder. Text is added
							for the purpose of taking up space. Nothing special here. This is
							the content that goes in the folder. Text is added for the
							purpose of taking up space. Nothing special here. This is the
							content that goes in the folder. Text is added for the purpose of
							taking up space. Nothing special here. This is the content that
							goes in the folder. Text is added for the purpose of taking up
							space. Nothing special here. This is the content that goes in the
							folder. Text is added for the purpose of taking up space. Nothing
							special here. This is the content that goes in the folder. Text
							is added for the purpose of taking up space. Nothing special
							here. This is the content that goes in the folder. Text is added
							for the purpose of taking up space. Nothing special here.</p>
					</div></li>
				<li><a href="#" class="folder_link" id="folder_link_4">Folder
						4</a>
					<div class="folder_content" id="folder_content_4">
						<p>This is the content that goes in the folder. Text is added
							for the purpose of taking up space. Nothing special here. This is
							the content that goes in the folder. Text is added for the
							purpose of taking up space. Nothing special here. This is the
							content that goes in the folder. Text is added for the purpose of
							taking up space. Nothing special here. This is the content that
							goes in the folder. Text is added for the purpose of taking up
							space. Nothing special here. This is the content that goes in the
							folder. Text is added for the purpose of taking up space. Nothing
							special here. This is the content that goes in the folder. Text
							is added for the purpose of taking up space. Nothing special
							here. This is the content that goes in the folder. Text is added
							for the purpose of taking up space. Nothing special here.</p>
					</div></li>
				<li><a href="#" class="folder_link" id="folder_link_5">Folder
						5</a>
					<div class="folder_content" id="folder_content_5">
						<p>This is the content that goes in the folder. Text is added
							for the purpose of taking up space. Nothing special here. This is
							the content that goes in the folder. Text is added for sthe
							purpose of taking up space. Nothing special here. This is the
							content that goes in the folder. Text is added for the purpose of
							taking up space. Nothing special here. This is the content that
							goes in the folder. Text is added for the purpose of taking up
							space. Nothing special here. This is the content that goes in the
							folder. Text is added for the purpose of taking up space. Nothing
							special here. This is the content that goes in the folder. Text
							is added for the purpose of taking up space. Nothing special
							here. This is the content that goes in the folder. Text is added
							for the purpose of taking up space. Nothing special here.</p>
					</div></li>
			</ul>

		</div>
		<div id="listaFicheros"></div>
		<div id="listaPropiedades"></div>
	</div>
</body>
</html>