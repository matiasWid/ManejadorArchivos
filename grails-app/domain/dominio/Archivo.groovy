package dominio
import dominio.NivelDescripcion
import dominio.EstadoConservacion
import dominio.TipoSoporte
class Archivo {
    int id
    String ruta
    String nombre
    String formato
    String extension
    Date fechaCreacion
    Date fechaModificacion
    String descripcion
    String idioma
    String signaturaTopografica
    

    static belongsTo = [usuario:Usuario,
        editorial: Editorial,
        descripcion: NivelDescripcion,
        lugar: Lugar,
        estadoconservacion: EstadoConservacion
    ]
    
    static hasMany = [palabrasClave:PalabraClave,
        archivosRelacionados:Archivo,
        tiposoporte: dominio.TipoSoporte]

    static constraints = {
        
    }
}
