package dominio

class NivelDescripcion
{
    String descripcion
    static constraints = { descripcion Unique:true
    }
    static hasMany = [archivos:Archivo]
}
    
    
