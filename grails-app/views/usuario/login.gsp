<%@ page import="dominio.Usuario" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="ProjectTracker Login" />
        <title><g:message code="ProjectTracker Login" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#create-usuario" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="logout"><g:message code="Logout" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="create-Usuario" class="content scaffold-create" role="main">
            <h1><g:message code="ProjectTracker Login" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${usuarioInstance}">
            <ul class="errors" role="alert">
                <g:eachError bean="${usuarioInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form action="authenticate" >
                <fieldset class="form">
                    <div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'nick', 'error')} ">
                        <label for="nick">
                            <g:message code="usuario.nick.label" default="Nombre de usuario" />
                            
                        </label>
                        <g:textField name="nick" value="${usuarioInstance?.nick}"/>
                    </div>
                    
                    <div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'contraseña', 'error')} ">
                        <label for="contraseña">
                            <g:message code="usuario.contrasenia.label" default="Contraseña" />
                            
                        </label>
                        <g:field type="password" name="contrasenia" value="${usuarioInstance?.contrasenia}"/>
                    </div>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton name="login" class="save" value="Login" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>


   </html>