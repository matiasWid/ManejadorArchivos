package dominio

class PalabraClave {
    String palabraClave
    
    static constraints = {
        palabraClave unique:true
    }
    static belongsTo = Archivo
    static hasMany = [archivos:Archivo]
    static mapping = {
        archivos joinTable: [name: "archivo_palabras_clave", key: 'palabra_clave_id' ]
    }
}