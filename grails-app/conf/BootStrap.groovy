import dominio.Usuario
class BootStrap {

    def init = { servletContext ->
        if (!Usuario.count()){
            new Usuario(nick:"matiasW", nombre:"Matias", apellido:"Widmaier", 
                contrasenia:"12345").save(failOnError:true)

    }
    }
    def destroy = {
    }
}
