package dominio

class PalabraClave {
    String palabraClave
    
    static constraints = {
        palabraClave unique:true
    }
    static belongsTo = Archivo
    static hasMany = [archivos:Archivo]
}