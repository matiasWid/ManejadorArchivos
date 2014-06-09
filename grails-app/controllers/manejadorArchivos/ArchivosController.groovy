package manejadorArchivos

import grails.converters.JSON
import groovy.io.FileType;

class ArchivosController {
	String rutaActual
	def listaArchivos
	def archivos= {
		def listaDirectorios = []
		def listaArchivos = []
		//primero obtengo los directorios
		if(!params.ruta){
			def f = new File(grailsApplication.config.images.location.toString())
			f.eachDir{
				dir ->listaDirectorios.add(dir.getPath().toString().substring(dir.getPath().toString().lastIndexOf(File.separatorChar.toString())+1))
			}
			rutaActual = f.getPath()
		}else{
			String ruta = params.ruta
			def f = new File(grailsApplication.config.images.location.toString() + File.separatorChar
				 + params.ruta.replace('#',File.separatorChar.toString()))
			f.eachDir { 
				dir ->listaDirectorios.add(params.ruta.replace('#',File.separatorChar.toString()) + File.separatorChar + dir.getPath().toString().substring(dir.getPath().toString().lastIndexOf(File.separatorChar.toString())+1))
				}
			rutaActual = f.getPath()
		}
		//obtengo la lista de archivos
		if(!params.ruta){
			new File (grailsApplication.config.images.location.toString()).eachFile(FileType.FILES) {
				
				dir ->listaArchivos.add(dir.getPath().toString().substring(dir.getPath().toString().lastIndexOf(File.separatorChar.toString())+1))
			}
		}else{
			String ruta = params.ruta
			def f = new File(grailsApplication.config.images.location.toString() + File.separatorChar
				 + params.ruta.replace('#',File.separatorChar.toString()))
			f.eachFile(FileType.FILES){
				dir ->listaArchivos.add(params.ruta.replace('#',File.separatorChar.toString()) + File.separatorChar + dir.getPath().toString().substring(dir.getPath().toString().lastIndexOf(File.separatorChar.toString())+1))
				}

		}
				println listaArchivos
				
				 println rutaActual
		return [ listaDirectorios: listaDirectorios, listaArchivos:listaArchivos]
	}

	def listaPropiedades= {
	
		def nombreArchivos = params.lista
		def nombres = []
		def tags = []
		//phraser para obtener una lista con los nombres de archivos
		//separados por una coma para manjearlos mas comodo en la view
		println nombreArchivos
		for(int i=0;i<nombreArchivos.size();i++)
		        {
		            if (nombreArchivos[i] == ",")
		            {
		            	println "posicion " + i
		            	nombres.add(nombreArchivos.substring(0,i).trim())
		            	println "nombre archivo " + nombreArchivos.substring(0,i).trim()
		            	nombreArchivos = nombreArchivos.substring(nombreArchivos.substring(0,i).size()+1).trim()
	            		i= 0
		            }
		        }
		        nombres.add(nombreArchivos.trim())
			println "nombre archivo " + nombres
			
			nombres.each{nombre->
				def tagArchivo =[]
				def archivo = dominio.Archivo.findByNombre(nombre)
				if(archivo!=null){

					tagArchivo= archivo.palabrasClave.findAll()
				}
				println "etiquetas: " + tags.palabraClave
				println "lista nombres " + nombre
				tagArchivo.each{tag->
					boolean encontro = false
					tags.each{iterador->
						if(iterador.palabraClave==tag.palabraClave){
							encontro=true
						}
					}
					if (!encontro){
						tags.add(tag)
					}
				}
			}

			println "FIN..."
			listaArchivos= nombres
		 render (template:'listaPropiedades', model:[nombres:nombres, tags:tags])
	}

	def obtenerPalabrasClave(String palabras) {
		println "Comiezo de phraser para separar palabras clave..."
		println "las palabras son: " + palabras
		def listaPalabras = []
		for(int i=0;i<palabras.size();i++)
		        {
		            if (palabras[i] == " ")
		            {
		            	println "posicion " + i
		            	listaPalabras.add(palabras.substring(0,i).trim())
		            	println "Palabra " + palabras.substring(0,i).trim()
		            	palabras = palabras.substring(palabras.substring(0,i).size()+1).trim()
	            		i= 0
		            }
		        }
		        listaPalabras.add(palabras.trim())
			println "nombre archivo " + palabras
			listaPalabras.each{nombre->
				println "lista nombres " + nombre
			}
	}

	def editarAtributos = {

		listaArchivos.each{ archivoIt->
			println rutaActual
			if(rutaActual != null){
				def archivo = dominio.Archivo.findByRuta(rutaActual + File.separatorChar.toString() + archivoIt)
				if(!archivo){
					archivo = new dominio.Archivo(ruta:rutaActual + File.separatorChar.toString() + archivoIt, nombre:archivoIt)
					archivo.save()
				}
				def listaPalabras = obtenerPalabrasClave(params.etiquetas)
				listaPalabras.each{palabra->
					def tag = dominio.PalabraClave.findByPalabraClave(palabra)
					if(tag==null){
						tag = new dominio.PalabraClave(palabraClave:palabra)
						tag.save()
					}
					archivo.addToPalabrasClave(tag)
					archivo.save()
				}
			}
		}
	}

	def index = { redirect(action:archivos) }
	static transactional = true

	def allowedMethods = []

	def list = {
		def fileResourceInstanceList = []
		def f = new File( grailsApplication.config.images.location.toString() )
		if( f.exists() ){
			f.eachFile(){ file->
				if( !file.isDirectory() )
					fileResourceInstanceList.add( file.name )
			}
		}
		[ fileResourceInstanceList: fileResourceInstanceList ]
	}
	
	
	def delete = {
		def filename = params.id.replace('###', '.')
		def file = new File( grailsApplication.config.images.location.toString() + File.separatorChar +   filename )
		file.delete()
		flash.message = "file ${filename} removed"
		redirect( action:list )
	}

	def upload = {
		def f = request.getFile('fileUpload')
		if(!f.empty) {
			
			new File( grailsApplication.config.images.location.toString() ).mkdirs()
			f.transferTo( new File( grailsApplication.config.images.location.toString() + File.separatorChar + f.getOriginalFilename() ) )
			flash.message = 'Your file has been uploaded'
			
		}
		else {
			flash.message = 'file cannot be empty'
		}
		redirect( action:list)
	}
}
