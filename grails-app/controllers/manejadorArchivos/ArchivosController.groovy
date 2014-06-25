package manejadorArchivos
import java.nio.file.*
import java.io.IOException
import grails.converters.JSON
import groovy.io.FileType
import java.util.zip.ZipEntry
import java.util.zip.ZipOutputStream

class ArchivosController {
    def allowedMethods = []
    String rutaActual
    def listaArchivos=[]
    def listaArchivosMarcados=[]
    def nombreArchivos =[]
    static transactional = true
    def nombres = []
    def tags = []
    
    
    def index = { redirect(action:archivos) }
	
    def archivos= {
            def listaDirectorios = []
            listaArchivos = []
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
                             + params.ruta.replace('|',File.separatorChar.toString()))
                    f.eachDir { 
                            dir ->listaDirectorios.add(params.ruta.replace('|',File.separatorChar.toString()) + File.separatorChar + dir.getPath().toString().substring(dir.getPath().toString().lastIndexOf(File.separatorChar.toString())+1))
                            }
                    rutaActual = f.getPath()
            }
            //obtengo la lista de archivos
            
            if(!params.ruta){
                    new File (grailsApplication.config.images.location.toString()).eachFile(FileType.FILES) {
                            dir ->
                            Date d = new Date(dir.lastModified())
                            listaArchivos.add(nombre: dir.getPath().toString().substring(dir.getPath().toString().lastIndexOf(File.separatorChar.toString())+1),fecha: d)
                            
                            println "Fecha de modificacion " + d
                    }
            }else{
                    String ruta = params.ruta
                    def f = new File(grailsApplication.config.images.location.toString() + File.separatorChar
                             + params.ruta.replace('|',File.separatorChar.toString()))
                    f.eachFile(FileType.FILES){
                            dir ->
                            Date d = new Date(dir.lastModified())
                            listaArchivos.add(nombre: params.ruta.replace('|',File.separatorChar.toString()) + File.separatorChar + dir.getPath().toString().substring(dir.getPath().toString().lastIndexOf(File.separatorChar.toString())+1),fecha: d)
                            
                            println "Fecha de modificacion " + d
                            }

            }
            println listaArchivos

            println rutaActual

        def listaDirRecorridos = obtenerDirectoriosRecorridos(rutaActual)
        return [ listaDirectorios: listaDirectorios, listaArchivos:listaArchivos, listaDirRecorridos:listaDirRecorridos ]
}

    def listaPropiedades= {
        nombreArchivos=[]
        params.check.each
        {
            nombre->
            if(nombre.value){
                
                println "Agregando a la lista de nombres: " + nombre.value
                nombreArchivos.add(nombre.value)
            }
        }
        
            if (nombreArchivos){
            //nombreArchivos = params.lista
            tags = []
            //phraser para obtener una lista con los nombres de archivos
            //separados por una coma para manjearlos mas comodo en la view
            println nombreArchivos
           
            if(rutaActual != null){
                nombreArchivos.each{nombre->
                        def tagArchivo =[]
                        def archivo = dominio.Archivo.findByRuta(rutaActual + File.separatorChar + nombre)
                        if(archivo!=null){

                                tagArchivo= archivo.palabrasClave
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
                listaArchivosMarcados= nombreArchivos
                tags.sort { it.id }
                render (template:'listaPropiedades', model:[nombres:nombreArchivos, tags:tags])
                }
            }
             render (template:'listaPropiedades', model:[nombres:null, tags:null])
    }
    
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

    def upload = {
        List fileList = request.getFiles('filesUpload') // 'files' is the name of the input
        fileList.each { file ->
            println 'Nombre de archivo: ' + file.getOriginalFilename() 
            if(!file.empty) {

                new File( rutaActual ).mkdirs()
                file.transferTo( new File( rutaActual + File.separatorChar + file.getOriginalFilename() ) )
                flash.message = 'Los archivos se subieron correctamente'
                def archivo = new dominio.Archivo(ruta:rutaActual + File.separatorChar.toString() + file.getOriginalFilename() , nombre:file.getOriginalFilename() )
                archivo.save()
                println "Etiquetas!!!!!:  " + params.tags

                if(params.etiquetas != ""){
                    def listaPalabras = obtenerPalabrasClave(params.etiquetas)
                    println "Lista obtenida" + listaPalabras
                    listaPalabras.each{palabra->
                        palabra=palabra.toLowerCase()
                        def tag = dominio.PalabraClave.findByPalabraClave(palabra)
                        if(tag==null){

                            tag = new dominio.PalabraClave(palabraClave:palabra)
                            tag.save()
                        }   
                        println "Intentando meter la palabra: " + tag
                        try { 
                            tag.addToArchivos(archivo)
                            tag.save(flush: true)

                            archivo.addToPalabrasClave(tag)
                            archivo.save(flush: true)
                            }
                            catch (Exception e) {
                                    println "ocurrio la exepcion"
                            }
                    }
                }
            }
        }
                
        def par
        if(rutaActual.length()>=grailsApplication.config.images.location.toString().length()){
            par=rutaActual.substring(grailsApplication.config.images.location.toString().length())
        }
        if (par!=null){
            redirect(controler: "archivos", action: "archivos", params: [ruta: par.replace(File.separatorChar.toString(),"|")])
        }
        else{
            redirect(controler: "archivos", action: "archivos")
        }
    }
    
    def multipleFileDownload={
        response.setContentType('APPLICATION/OCTET-STREAM')
        response.setHeader('Content-Disposition', 'Attachment;Filename="Archivos.zip"')
        ZipOutputStream zip = new ZipOutputStream(response.outputStream)
        
        listaArchivosMarcados.each{nombre->
            def file = new File(rutaActual + File.separatorChar + nombre)

            if (file.exists()) {
                def fileEntry = new ZipEntry(nombre)
                zip.putNextEntry(fileEntry)
                zip.write(file.bytes)
            }
        }
        zip.close()
        return
    }

    def removerTag= {
        
	    listaArchivosMarcados.each{ archivoIt->
	        println rutaActual
	        if(rutaActual != null){
	            def archivo = dominio.Archivo.findByRuta(rutaActual + File.separatorChar.toString() + archivoIt)
	            if(archivo){
	                println "Id tag: " + params.id
	                def tag = dominio.PalabraClave.get(params.id)
                        println "Tag: " + tag.id
	                if(tag!=null){
	                    tag.removeFromArchivos(archivo)
	                    archivo.removeFromPalabrasClave(tag)
                            println "Indice en lista: " + tags.findIndexOf{it.id == tag.id}
                            if(tags.findIndexOf{it.id == tag.id}>-1){
                                tags.remove(tags.findIndexOf{it.id == tag.id})
                            }
                            println "Ahora las tags son: " + tags
                    }
                }
            }
        }
        /*def tagsAux = []
        println "acaaaaaa"
        println tags
        tags.each{tag->
            
            if(tag.id != params.id)
            tagsAux(tag)
        }
        tags=tagsAux*/
        render (template:'listaPropiedades', model:[nombres:listaArchivosMarcados, tags:tags])
    }
      
    def delete = {
            def filename = params.id.replace('###', '.')
            def file = new File( grailsApplication.config.images.location.toString() + File.separatorChar +   filename )
            file.delete()
            flash.message = "file ${filename} removed"
            redirect( action:list )
    }
    
    def nuevaCarpeta ={
        if(params.dirName != null && rutaActual != null){
            def d1= new File(rutaActual + File.separatorChar + params.dirName)
            d1.mkdir()
            
        }
         def par
        if(rutaActual.length()>=grailsApplication.config.images.location.toString().length()){
            par=rutaActual.substring(grailsApplication.config.images.location.toString().length())
        }
        if (par!=null){
            redirect(controler: "archivos", action: "archivos", params: [ruta: par.replace(File.separatorChar.toString(),"|")])
        }
        else
        {
            redirect(controler: "archivos", action: "archivos")
        }
        
    }
    
    def editarNombre = {
        flash.message = ''
        listaArchivosMarcados.each{ archivoIt->
            println rutaActual
            println "El archivo se llama: " + archivoIt
            
            if(rutaActual != null){
                def archivo = dominio.Archivo.findByRuta(rutaActual + File.separatorChar.toString() + archivoIt)
                if(!archivo){
                    archivo = new dominio.Archivo(ruta:rutaActual + File.separatorChar.toString() + archivoIt, nombre:archivoIt)
                    archivo.save()
                }

                if(listaArchivosMarcados.size() == 1 && params.nombreArchivo != archivoIt.substring(0,archivoIt.lastIndexOf('.'))){
                    try {
                        //   Renombrado de archivos
                        def nombreActual = rutaActual + File.separatorChar.toString() + archivoIt
                        def soloNombreCambiado = params.nombreArchivo + archivoIt.substring(archivoIt.lastIndexOf('.'))
                        def nombreCambiado = rutaActual + File.separatorChar.toString() + soloNombreCambiado
                       
                        def file1 = new File(nombreActual)
                        def file2 = new File(nombreCambiado)
                        println "Probando si el archivo existe en el disco"
                        if(!file1.exists()){
                            println "El archivo no existe en el disco"
                            archivo.delete()
                        }else{
                            if(!file2.exists()){
                                file1.renameTo(file2)
                                archivoIt = params.nombreArchivo + archivoIt.substring(archivoIt.lastIndexOf('.'))


                                if(archivo!=null){
                                    println "Cambiando el nombre en la base"
                                    archivo.ruta = nombreCambiado
                                    archivo.nombre = soloNombreCambiado
                                    archivo.save()
                                }

                            }else{
                                flash.message = 'No se pudo cambiar el nombre, ya existe un archivo con ese nombre'
                            }
                        }
                    } catch (Exception e) {
                        println(e)
                    }
                }
                println "Ahora el archivo se llama: " + archivoIt  
            }

        }
          def par
        if(rutaActual.length()>=grailsApplication.config.images.location.toString().length()){
            par=rutaActual.substring(grailsApplication.config.images.location.toString().length())
        }
        if (par!=null){
            redirect(controler: "archivos", action: "archivos", params: [ruta: par.replace(File.separatorChar.toString(),"|")])
        }
        else
        {
            redirect(controler: "archivos", action: "archivos")
        }
    }
    
    def editarTags = {
    
                println "Etiquetas parametro: " + params.etiquetas
                  if(params.etiquetas != ""){
                    def listaPalabras = obtenerPalabrasClave(params.etiquetas)
                    println "Lista obtenida" + listaPalabras
                    listaPalabras.each{palabra->
                        palabra=palabra.toLowerCase()
                        def tag = dominio.PalabraClave.findByPalabraClave(palabra)
                        if(tag==null){
                            
                            tag = new dominio.PalabraClave(palabraClave:palabra)
                            tag.save()
                        }   
                        println "Intentando meter la palabra: " + tag
                       try { 
                            tag.addToArchivos(archivo)
        					tag.save(flush: true)
                     
                            archivo.addToPalabrasClave(tag)
                    		archivo.save(flush: true)
                        }
                        catch (Exception e) {
                                println "ocurrio la exepcion"
                        }
                        if((tags.findIndexOf{it.id == tag.id}) == -1){
                            tags.add(tag)
                        }
                    }
                }
                println "Ahora los tags son: " + tags
            
        
       // flash.message = 'Los cambios se han aplicado correctamente'
        render (template:'listaPropiedades', model:[nombres:listaArchivosMarcados, tags:tags])
        
    }

    def obtenerDirectoriosRecorridos(String rutaAct) {
        println "Comiezo de phraser para separar rutas..."
        println "las rutas son: " + rutaAct
        def listaRutas = []
        if(rutaAct.length()>=grailsApplication.config.images.location.toString().length()){
            rutaAct=rutaAct.substring(grailsApplication.config.images.location.toString().length())
            for(int i=0;i<rutaAct.size();i++){
                    if (rutaAct[i] == File.separatorChar.toString()){
                       println "posicion " + i
                       listaRutas.add(rutaAct.substring(0,i).trim())
                       println "Ruta " + rutaAct.substring(0,i).trim()
                       rutaAct = rutaAct.substring(rutaAct.substring(0,i).size()+1).trim()
                       i= 0
                    }
                 }
                 listaRutas.add(rutaAct.trim())
                 println "nombre archivo " + rutaAct
                 listaRutas.each{nombre->
                    println "lista nombres " + nombre
                 }
        }
        }
    
    def obtenerPalabrasClave(String palabras) {
        println "Comiezo de phraser para separar palabras clave..."
        println "las palabras son: " + palabras
        def listaPalabras = []
        for(int i=0;i<palabras.size();i++){
                if (palabras[i] == " "){
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
}
