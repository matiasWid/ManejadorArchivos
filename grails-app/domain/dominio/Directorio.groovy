package dominio

class Directorio {
    String ruta
    
    static hasMany = [archivos:Archivo]
    
    static constraints = {
        ruta unique: true
    }
}
