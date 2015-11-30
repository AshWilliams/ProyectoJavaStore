<%-- 
    Document   : login
    Created on : 27-11-2015, 10:04:18
    Author     : Cypher
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

    <div class="container">

      <form id="myForm" class="form-signin">
        <h2 class="form-signin-heading">Ingreso de Usuarios:</h2>
        <hr class="colorgraph"><br>
        <label for="inputEmail" class="sr-only">Usuario</label>
        <input type="text" name="inputUsuario" id="inputUsuario" class="form-control" placeholder="Ingrese Usuario" autofocus>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" name="inputPassword" id="inputPassword" class="form-control" placeholder="Ingrese Password">
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> Recordarme
          </label>
        </div>
        <button id="btnIngresar" class="btn btn-lg btn-primary btn-block" type="submit">Ingresar</button>
      </form>
        
        <script type="text/javascript">
        var submitAction,fnMensaje;
        $(function(){
            $('#myForm').validate({
                rules: {
                    inputUsuario: {
                        minlength: 5,
                        maxlength: 255,
                        required: true
                    },
                    inputPassword: {
                        minlength: 5,
                        maxlength: 255,
                        required: true
                    }
                },
                messages: {
                    inputUsuario: {
                        required: "Ingrese Usuario",
                        minlength: jQuery.validator.format("Ingrese al menos {0} caracteres")
                    },
                    inputPassword: {
                        required: "Ingrese Password",
                        minlength: jQuery.validator.format("Ingrese al menos {0} caracteres")
                    }
                },
                highlight: function (element) {
                    $(element).closest('.form-group').addClass('has-error');
                    $("span").remove("#response");
                },
                unhighlight: function (element) {
                    $(element).closest('.form-group').removeClass('has-error');
                },
                errorElement: 'span',
                errorClass: 'help-block',
                errorPlacement: function (error, element) {            
                    if (element.parent('.input-group').length) {
                        error.insertAfter(element.parent());
                    } else {
                        error.insertAfter(element);
                    }
                },
                submitHandler: function (form) {
                    submitAction(form);
                    return false;
                }
            });
                
            fnMensaje = function(mensaje){
                bootbox.dialog({
                        message: mensaje,
                        title: "Estado",
                        buttons: {
                          success: {
                            label: "OK",
                            className: "btn-success"
                          }
                         }                        
                });                
            };    
            submitAction = function(){
               var datos = {};
               datos.inputUsuario = $('#inputUsuario').val();
               datos.inputPassword = $('#inputPassword').val();
               $.ajax({
                   url:'Login',
                   type:'POST',
                   data:datos                   
               }).done(function(respuesta){
                   if(respuesta.Codigo === 200 && respuesta.Estado === 1){                       
                       fnMensaje(respuesta.Mensaje);
                       setTimeout(function(){window.location="Categorias"}, 2000);
                   }
                   else{
                       fnMensaje(respuesta.Mensaje);                       
                   }
               });
            };                
        });
        </script>

    </div> <!-- /container -->



