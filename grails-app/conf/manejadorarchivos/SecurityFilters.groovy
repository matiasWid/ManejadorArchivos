package manejadorarchivos

class SecurityFilters {

    def filters = {
        loginCheck(controller:'*', action:'*') {
            before = {
                if(!session.user && actionName !="login"){
                    redirect(controller:"usuario",action:"login")
                    return false
                }
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
