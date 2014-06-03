package manejadorArchivos

import groovy.io.FileType;

class ArchivosController {
	
	def archivos= {
		def listaDirectorios = []
		def listaArchivos = []
		
		if(!params.ruta){
			new File (grailsApplication.config.images.location.toString()).eachDir {
				dir ->listaDirectorios.add(dir.getPath().toString().substring(dir.getPath().toString().lastIndexOf(File.separatorChar.toString())+1))
			}
		}else{
			String ruta = params.ruta
			def f = new File(grailsApplication.config.images.location.toString() + File.separatorChar
				 + params.ruta.replace('#',File.separatorChar.toString()))
			f.eachDir { 
				dir ->listaDirectorios.add(params.ruta.replace('#',File.separatorChar.toString()) + File.separatorChar + dir.getPath().toString().substring(dir.getPath().toString().lastIndexOf(File.separatorChar.toString())+1))
				}
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
		return [ listaDirectorios: listaDirectorios, listaArchivos:listaArchivos]
	}

	def listaPropiedades= {
		String nombre = params.nombre
		String marcado = params.marcado
		        render params.marcado + params.nombre
		
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
