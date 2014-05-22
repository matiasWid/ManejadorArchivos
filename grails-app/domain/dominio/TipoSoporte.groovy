package dominio

class TipoSoporte {
    String tipoSoporte
    
    
    static constraints = {
        tipoSoporte unique:true
    }
    static belongsTo = Archivo
    static hasMany = [archivos:Archivo]
}
