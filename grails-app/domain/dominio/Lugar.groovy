package dominio

class Lugar {
    String lugar
    static constraints = {lugar unique: true
    }
    static hasMany = [archivos:Archivo]
    
}
