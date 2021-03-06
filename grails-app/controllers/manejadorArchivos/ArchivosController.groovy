package manejadorArchivos

import grails.converters.JSON
import groovy.io.FileType;

class ArchivosController {
	String rutaActual
	def archivos= {
		def listaDirectorios = []
		def listaArchivos = []
		
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
				println "lista nombres " + nombre
			}

			println "FIN..."
		 render (template:'archivos', model:[nombres:nombres])
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
