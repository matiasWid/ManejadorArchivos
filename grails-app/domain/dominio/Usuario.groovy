package dominio

class Usuario {
    String nick
    String nombre
    String apellido
    String contraseña
    String confirmarContraseña
    static constraints = {
        nick                blank: false, size: 5..45, unique: true        
        contraseña          size: 5..45, blank: false, password: true
        confirmarContraseña size: 5..45, blank: false, password: true
    }
    static hasMany = [archivos:Archivo]
}
