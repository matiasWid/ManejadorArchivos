package manejadorArchivos

class ArchivosController {
	 def archivos= {
		 def lista = []
		 new File (grailsApplication.config.images.location.toString()).eachDir {
			   dir -> lista.add(dir.getPath().substring(dir.getPath().lastIndexOf('\\')+1))}
		
		return [ lista: lista]
	 }	
	 
	def index = { redirect(action:list,params:params) }
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
