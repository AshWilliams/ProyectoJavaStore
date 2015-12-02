<%-- 
    Document   : CRUDUsuarios
    Created on : 02-12-2015, 11:48:56
    Author     : Cypher
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuarios</title>
        <%@include file="header.jsp" %>
    </head>
    <body>
        <div class="container">

      <!-- Static navbar -->
      <%@include file="navbar.jsp" %>

      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
          <div id="UsuariosTableContainer">
            <table class="table" data-paging="true" data-sorting="true" data-filtering="true" data-filter-placeholder="Buscar">
                <thead>
                        <tr>
                                <th>ID</th>
                                <th>Usuario</th>
                                <th data-breakpoints="xs" >Nombre</th>
                                <th data-breakpoints="xs" >Rut</th>
                                <th data-breakpoints="xs" style="width: 20%;">Dirección</th>
                                <th data-breakpoints="xs" style="width: 10%;">Email</th>
                                <th data-breakpoints="xs" >Perfil</th>
                                <th data-breakpoints="xs">Acciones</th>
                        </tr>
                </thead>
                <tbody>		
                </tbody>
            </table>  
          </div>
          
          
     <div id="formContainer">
      <form id="myForm" method="post" class="form-horizontal" style="display: none;">
          <div class="col-md-12">
            <div class="form-group">
               <div class="row">
                  <div class="col-md-4">
                      <p>Categoría</p>
                  </div>
                  <div class="col-md-8">
                      <select id="selPerfiles" name="selPerfiles" class="form-control" >
                          
                      </select>                                   
                  </div>
              </div>
            </div>
        </div>
          <div class="col-md-12">
            <div class="form-group">
               <div class="row">
                  <div class="col-md-4">
                      <p>Usuario</p>
                  </div>
                  <div class="col-md-8">
                      <input id="Usuario" name="Usuario" value=""  class="form-control form-control-search" type="text" />
                  </div>
              </div>
            </div>
         </div>
          <div class="col-md-12">
            <div class="form-group">
               <div class="row">
                  <div class="col-md-4">
                      <p>Password</p>
                  </div>
                  <div class="col-md-8">
                      <input id="Password" name="Password" value=""  class="form-control form-control-search" type="password" />
                  </div>
              </div>
            </div>
         </div>
          <div class="col-md-12">
            <div class="form-group">
               <div class="row">
                  <div class="col-md-4">
                      <p>Nombres</p>
                  </div>
                  <div class="col-md-8">
                      <input id="Nombres" name="Nombres" value=""  class="form-control form-control-search" type="text" />
                  </div>
              </div>
            </div>
         </div>
          <div class="col-md-12">
            <div class="form-group">
               <div class="row">
                  <div class="col-md-4">
                      <p>Apellidos</p>
                  </div>
                  <div class="col-md-8">
                      <input id="Apellidos" name="Apellidos" value=""  class="form-control form-control-search" type="text" />
                  </div>
              </div>
            </div>
         </div>
          <div class="col-md-12">
            <div class="form-group">
               <div class="row">
                  <div class="col-md-4">
                      <p>Rut</p>
                  </div>
                  <div class="col-md-8">
                      <input id="Rut" name="Rut" value=""  class="form-control form-control-search" type="text" />
                  </div>
              </div>
            </div>
         </div>
         <div class="col-md-12">
            <div class="form-group">
               <div class="row">
                  <div class="col-md-4">
                      <p>Dirección</p>
                  </div>
                  <div class="col-md-8">
                      <textarea id="Direccion" name="Direccion" class="form-control form-control-search"></textarea>                                   
                  </div>
              </div>
            </div>
        </div>
          <div class="col-md-12">
            <div class="form-group">
               <div class="row">
                  <div class="col-md-4">
                      <p>Email</p>
                  </div>
                  <div class="col-md-8">
                      <input id="Email" name="Email" value=""  class="form-control form-control-search" type="text" />
                  </div>
              </div>
            </div>
         </div>                
          
         <div class="form-group">
            <div class="col-md-12 text-right">
                <input type="submit" id="btnForm" value="" class="btn btn-success"/>
            </div>
         </div> 
            </form>
          </div>  
      </div>
    
      
    
    </div> <!-- /container -->
    
    <script type="text/javascript">
        var getUsuarios,getPerfiles,getSubmit,getEdit,getModal,validateForm,modo;
        var objUsuario,objUsuarios,setUsuario,updateUsuario,getDelete;
         $(function(){             
            fnActiva();
            getPerfiles = function(){
                $.ajax({
                    url:'Perfiles',
                    type:'POST',
                    data:{Metodo:'listall'}
                }).done(function(datos){
                    var html = '<option value="">Seleccione...</option>';
                    if(datos.length > 0){
                        $.each(datos,function(i,item){
                            html +='<option value="'+item.idPerfil+'">'+item.Nombre+'</option>';                                     
                        });
                    }                    
                    $('#selPerfiles').html(html);
                    
                });
            };
            getUsuarios = function(){
                $.ajax({
                    url:'Usuarios',
                    type:'POST',
                    data:{Metodo:'listall'}
                }).done(function(datos){
                    var html = '';
                    objUsuarios = datos;
                    if(datos.length > 0){
                        $.each(datos,function(i,item){
                            html += '<tr>'
                                   +'<td>'+item.idUsuario+'</td>'
                                   +'<td>'+item.Usuario+'</td>'
                                   +'<td>'+item.Completo+'</td>'
                                   +'<td>'+item.Rut+'</td>'
                                   +'<td>'+item.Direccion+'</td>'
                                   +'<td>'+item.Email+'</td>'
                                   +'<td>'+item.Perfil+'</td>'
                                   +'<td>'
                                   +'<span class="btn-group"><a class="xcrud-action btn btn-info btn-sm" title="Ver" href="javascript:;" data-primary="1" data-task="view"><i class="glyphicon glyphicon-search"></i></a><a data-usuario="'+item.idUsuario+'" class="xcrud-action btn btn-warning btn-sm btnEditar" title="Editar" href="javascript:;" data-primary="1" data-task="edit"><i class="glyphicon glyphicon-edit "></i></a><a data-usuario="'+item.idUsuario+'" class="xcrud-action btn btn-danger btn-sm btnEliminar" title="Eliminar" href="javascript:;" data-primary="1" data-task="remove" data-confirm="Do you really want remove this entry?"><i class="glyphicon glyphicon-remove"></i></a></span>'
                                   +'</td>'
                                   +'</tr>';
                        });
                    }
                    else{
                        html += '<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>';
                    }
                    
                    $('.table >tbody').html(html);
                    $('.table').footable({
                        "paging": {
                                "enabled": true
                        },
                        "filtering": {
                            "placeholder": "Buscar"
                        },
                        "columns": [{
                            "sortable": true
                        }]
                    });
                    $('.form-inline').prepend('<a href="javascript:;" data-task="create" class="btn btn-success btnIngresar"><i class="glyphicon glyphicon-plus-sign"></i> Ingresar</a>');
                    getSubmit();
                    getEdit();
                    getDelete(); 
                    getPerfiles();
                });
            };
            getUsuarios();
            
            getEdit = function(){
                $('.btnEditar').click(function(e){
                    e.preventDefault();
                    var idUser = $(this).data('usuario');
                    objUsuario = _.where(objUsuarios, { idUsuario: idUser.toString() })[0];
                    console.log(idUser,objUsuario);
                    getModal("M",objUsuario);
                });
            };
            
            getDelete = function(){
                $('.btnEliminar').click(function(e){
                    e.preventDefault();
                    var myForm = {};
                    myForm.Metodo = 'delete';
                    myForm.IdUsuario = $(this).data('usuario');
                    $.ajax({
                        url:'Usuarios',
                        type:'POST',
                        data:myForm
                     }).done(function(datos){
                        fnMensaje(datos.Mensaje);
                        getUsuarios();
                     }); 
                });
            };
            
            setUsuario = function(){
              var myForm = {};
              myForm.Metodo = 'insert';
              myForm.IdPerfil = $('#selPerfiles').val();
              myForm.Usuario = $('#Usuario').val();
              myForm.Password = $("#Password").val();
              myForm.Nombres = $('#Nombres').val();
              myForm.Apellidos = $('#Apellidos').val();
              myForm.Direccion = $('#Direccion').val();
              myForm.Rut = $('#Rut').val();
              myForm.Email = $('#Email').val();
              $.ajax({
                 url:'Usuarios',
                 type:'POST',
                 data:myForm
              }).done(function(datos){
                 fnMensaje(datos.Mensaje);
                 getUsuarios();
              });               
            };
            
            updateUsuario = function(IdUsuario){
              var myForm = {};
              myForm.Metodo = 'update';
              myForm.IdUsuario = IdUsuario;
              myForm.IdPerfil = $('#selPerfiles').val();
              myForm.Usuario = $('#Usuario').val();
              myForm.Password = $("#Password").val();
              myForm.Nombres = $('#Nombres').val();
              myForm.Apellidos = $('#Apellidos').val();
              myForm.Rut = $('#Rut').val();
              myForm.Direccion = $('#Direccion').val();
              myForm.Email = $('#Email').val();
              $.ajax({
                 url:'Usuarios',
                 type:'POST',
                 data:myForm
              }).done(function(datos){
                 fnMensaje(datos.Mensaje);
                 getUsuarios();
              });  
            }; 
            
            getSubmit = function(){
                $('.btnIngresar').click(function(e){
                    e.preventDefault();
                    getModal("I",{});
                });
            };
            validateForm = function(){
                $('#myForm').validate({
                  rules: {                   
                    selPerfiles:{
                        required: true
                    },
                    Usuario: {
                        minlength: 5,
                        maxlength: 255,
                        required: true
                    },
                    Password: {
                        minlength: 5,
                        maxlength: 255,
                        required: true
                    },
                    Nombres :{
                        minlength: 5,
                        maxlength: 255,
                        required: true
                    },
                    Apellidos: {
                        minlength: 5,
                        maxlength: 255,
                        required: true
                    },
                    Rut: {
                        minlength: 9,
                        maxlength: 255,
                        required: true
                    },
                    Direccion: {
                        required: true,
                        minlength: 5,
                        maxlength: 255
                    }                    ,
                    Email: {
                        minlength: 5,
                        maxlength: 255,
                        required: true,
                        email:true
                    }
                },
                messages: {
                    selPerfiles: {
                        required: "Campo vacío"                        
                    },
                    Usuario: {
                        required: "Campo vacío",
                        minlength: jQuery.validator.format("Ingrese al menos {0} caracteres")
                    },
                    Password: {
                        required: "Campo vacío",
                        minlength: jQuery.validator.format("Ingrese al menos {0} caracteres")
                    },
                    Nombres: {
                        required: "Campo vacío",
                        minlength: jQuery.validator.format("Ingrese al menos {0} caracteres")
                    },
                    Apellidos: {
                        required: "Campo vacío",
                        minlength: jQuery.validator.format("Ingrese al menos {0} caracteres")
                    },
                    Rut: {
                        required: "Campo vacío",
                        minlength: jQuery.validator.format("Ingrese al menos {0} caracteres")
                    },
                    Direccion: {
                        required: "Campo vacío",
                        minlength: jQuery.validator.format("Ingrese al menos {0} caracteres")
                    },
                    Email: {
                        required: "Campo vacío",
                        minlength: jQuery.validator.format("Ingrese al menos {0} caracteres"),
                        email:"Ingrese Email Válido"
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
                    modo==="I"?setUsuario():updateUsuario(objUsuario.idUsuario);
                    bootbox.hideAll();
                    return false;
                }
              });
            };
            getModal = function (Modo) {
                modo = Modo;
                var titulo = "Ingresar Usuario";
                var boton = "Guardar Usuario";
                if (modo === "M") {
                    titulo = "Modificar Usuario";
                    boton = "Actualizar Usuario";               
                }  
                validateForm();
                bootbox.dialog({
                    title: titulo,
                    message: $("#myForm")
                }).init(function () {
                    if(modo==="M"){
                        console.log(objUsuario);
                        $('#selPerfiles').val(objUsuario.idPerfil);
                        $('#Usuario').val(objUsuario.Usuario);
                        $('#Nombres').val(objUsuario.Nombres);
                        $('#Rut').val(objUsuario.Rut);
                        $('#Apellidos').val(objUsuario.Apellidos);
                        $('#Direccion').val(objUsuario.Direccion);
                        $('#Email').val(objUsuario.Email);
                    }
                    $("#btnForm").val(boton);
                    $("#myForm").show();
                  });
                $('.bootbox').on('shown.bs.modal', function () {
                    $('#selCategoria').focus();
                });
                $('.bootbox').on('hide.bs.modal', function () {
                    $("#myForm").validate().resetForm();
                    $("#myForm").find('.form-group').removeClass('has-error');
                    $('#myForm')[0].reset();
                    $('#myForm').hide();
                    $('#myForm').appendTo("#formContainer");
                });
            };
        });        
    </script>
    </body>
</html>


