package dominio

class Usuario {
    String nick
    String nombre
    String apellido
    String contrasenia
    static constraints = {
        nick                blank: false, size: 5..45, unique: true        
        contrasenia          size: 5..45, blank: false, password: true
      
    }
    static hasMany = [archivos:Archivo]
}
