package manejadorArchivos

class UsuarioController {

    def index() { }
    
    def login = {}
    
    def authenticate = {
        def user = dominio.Usuario.findByNickAndContrasenia(params.nick, params.contrasenia)
        if(user){
            session.user = user
            flash.message = "Hello ${user.nombre}!"
            redirect(action:"login")
            
        }else{
        flash.message = "Sorry, ${params.nick}. Please try again."
        redirect(action:"login")
        }
    }
    
    def logout = {
        flash.message = "Goodbye ${session.user.nick}"
        session.Usuario = null
        redirect(action:"login")
    }
}

