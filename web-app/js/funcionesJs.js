$(document).ajaxStart(function()
        { $('#imgCarga').fadeIn(); }
        ).ajaxStop(function()
        { $('#imgCarga').fadeOut(); }
        );
        
        $(document).ready(function(){
        
        $( "#botonSubir" ).click(function() {
            $( "#divSubir" ).toggle( "slide" );
          });
          
          $( "#botonCarpeta" ).click(function() {
            $( "#directorioNuevo" ).toggle( "slide" );
          });
 
	//Checkbox
	$("input[name=checktodos]").change(function(){
		$('input[type=checkbox]').each( function() {			
			if($("input[name=checktodos]:checked").length == 1){
				this.checked = true;
			} else {
				this.checked = false;
			}
		});
                hacerClic();
	});
 
        });
        
        function hacerClic(){
        $("#botonSubmit").click();
        }
        function llamarAjax(){
        
            jQuery.ajax({type:'POST',data:jQuery(this).serialize(), url:'/ManejadorArchivos/archivos/listaPropiedades',success:function(data,textStatus){jQuery('#archivosSeleccionados').html(data);},error:function(XMLHttpRequest,textStatus,errorThrown){}});return false
        };
      
        