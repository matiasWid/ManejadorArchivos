package manejadorArchivos

class UsuarioController {

    def index() { }
    
    def login = {
        if (request.get) {
            render(view: "login")
        }
        def user = dominio.Usuario.findByNickAndContrasenia(params.nick, params.contrasenia)
        
        if(user){
            session.user = user
           
            //flash.message = "Hello ${user.nombre}!"
            redirect(controller:"archivos", action:"archivos")
            
        }else{
            flash.message = "Usuario o constraseña incorrecta"
            render(view: "login", model: [message: "User not found"])
        }
    }

    def logout = {
        flash.message = "Goodbye ${session.user.nick}"
        session.user = null
        redirect(action:"login")
    }
}

