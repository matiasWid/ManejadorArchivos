package manejadoArchivos

class UsuarioController {

    def index() { }
    
    def login = {}
    
    def authenticate = {
        def user = Usuario.findByNickAndContraseña(params.nick, params.contraseña)
        if(user){
            session.user = user
            flash.message = "Hello ${user.Nombre}!"
            redirect(action:"login")
            
        }else{
        flash.message = "Sorry, ${params.nick}. Please try again."
        redirect(action:"login")
        }
    }
    
    def logout = {
        flash.message = "Goodbye ${session.Usuario.nick}"
        session.Usuario = null
        redirect(action:"login")
    }
}

