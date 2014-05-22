package dominio

class Editorial {

    String descripcion
    static constraints = {descripcion unique:true
    }
    static hasMany = [archivos:Archivo]
}
