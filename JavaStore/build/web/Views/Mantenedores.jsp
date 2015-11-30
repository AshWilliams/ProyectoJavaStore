<%-- 
    Document   : Mantenedores
    Created on : 29-11-2015, 17:20:07
    Author     : Overlord
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Categorias</title>
        <%@include file="header.jsp" %>
    </head>
    <body>
        <div class="container">

      <!-- Static navbar -->
      <%@include file="navbar.jsp" %>

      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
          <div id="CategoriasTableContainer">
            <table class="table" data-sorting="true" data-paging="true" data-filtering="true" data-filter-placeholder="Buscar">
                <thead>
                        <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th  data-breakpoints="xs" style="width: 50%;">Descripcion</th>
                                <th>Fecha de Creación</th>
                                <th  data-breakpoints="xs">Acciones</th>
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
                      <p>Nombre</p>
                  </div>
                  <div class="col-md-8">
                      <input id="Nombre" name="Nombre" value=""  class="form-control form-control-search" type="text" />
                  </div>
              </div>
            </div>
         </div>
                <div class="col-md-12">
            <div class="form-group">
               <div class="row">
                  <div class="col-md-4">
                      <p>Descripción</p>
                  </div>
                  <div class="col-md-8">
                      <textarea id="Descripcion" name="Descripcion" class="form-control form-control-search"></textarea>                                   
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
        var getCategorias,getSubmit,getEdit,getModal,validateForm,modo;
        var objCategorias,objCategoria,setCategoria,updateCategoria,getDelete;
         $(function(){
            fnActiva();
            getCategorias = function(){
                $.ajax({
                    url:'ListaCategorias',
                    type:'GET'
                }).done(function(datos){
                    var html = '';
                    objCategorias = datos;
                    if(datos.length > 0){
                        $.each(datos,function(i,item){
                            html += '<tr>'
                                   +'<td>'+item.IdCategoria+'</td>'
                                   +'<td>'+item.Nombre+'</td>'
                                   +'<td>'+item.Descripcion+'</td>'
                                   +'<td>'+item.Fecha+'</td>'
                                   +'<td>'
                                   +'<span class="btn-group"><a class="xcrud-action btn btn-info btn-sm" title="Ver" href="javascript:;" data-primary="1" data-task="view"><i class="glyphicon glyphicon-search"></i></a><a data-categoria="'+item.IdCategoria+'" class="xcrud-action btn btn-warning btn-sm btnEditar" title="Editar" href="javascript:;" data-primary="1" data-task="edit"><i class="glyphicon glyphicon-edit "></i></a><a data-categoria="'+item.IdCategoria+'" class="xcrud-action btn btn-danger btn-sm btnEliminar" title="Eliminar" href="javascript:;" data-primary="1" data-task="remove" data-confirm="Do you really want remove this entry?"><i class="glyphicon glyphicon-remove"></i></a></span>'
                                   +'</td>'
                                   +'</tr>';
                        });
                    }
                    else{
                        html += '<tr><td></td><td></td><td></td><td></td><td></td></tr>';
                    }
                    
                    $('.table >tbody').html(html);
                    $('.table').footable({
                        "paging": {
                                "enabled": true
                        },
                        "filtering": {
                            "placeholder": "Buscar"
                        }
                    });
                    $('.form-inline').prepend('<a href="javascript:;" data-task="create" class="btn btn-success btnIngresar"><i class="glyphicon glyphicon-plus-sign"></i> Ingresar</a>');
                    getSubmit();
                    getEdit();
                    getDelete();
                });
            };
            getCategorias();
            
            getEdit = function(){
                $('.btnEditar').click(function(e){
                    e.preventDefault();
                    var idCat = $(this).data('categoria');
                    objCategoria = _.where(objCategorias, { IdCategoria: parseInt(idCat) })[0];
                    getModal("M",objCategoria);
                });
            };
            
            getDelete = function(){
                $('.btnEliminar').click(function(e){
                    e.preventDefault();
                    var myForm = {};
                    myForm.Metodo = 'delete';
                    myForm.IdCategoria = $(this).data('categoria');
                    $.ajax({
                        url:'Categorias',
                        type:'POST',
                        data:myForm
                     }).done(function(datos){
                        fnMensaje(datos.Mensaje);
                        getCategorias();
                     }); 
                });
            };
            
            setCategoria = function(){
              var myForm = {};
              myForm.Metodo = 'insert';
              myForm.Nombre = $('#Nombre').val();
              myForm.Descripcion = $("#Descripcion").val();
              $.ajax({
                 url:'Categorias',
                 type:'POST',
                 data:myForm
              }).done(function(datos){
                 fnMensaje(datos.Mensaje);
                 getCategorias();
              });               
            };
            
            updateCategoria = function(IdCategoria){
              var myForm = {};
              myForm.Metodo = 'update';
              myForm.IdCategoria = IdCategoria;
              myForm.Nombre = $('#Nombre').val();
              myForm.Descripcion = $("#Descripcion").val();
              $.ajax({
                 url:'Categorias',
                 type:'POST',
                 data:myForm
              }).done(function(datos){
                 fnMensaje(datos.Mensaje);
                 getCategorias();
              });  
            } 
            
            getSubmit = function(){
                $('.btnIngresar').click(function(e){
                    e.preventDefault();
                    getModal("I",{});
                });
            };
            validateForm = function(){
                $('#myForm').validate({
                  rules: {
                    Nombre: {
                        minlength: 5,
                        maxlength: 255,
                        required: true
                    },
                    Descripcion: {
                        minlength: 5,
                        maxlength: 255,
                        required: true
                    }                    
                },
                messages: {
                    Nombre: {
                        required: "Campo vacío",
                        minlength: jQuery.validator.format("Ingrese al menos {0} caracteres")
                    },
                    Descripcion: {
                        required: "Campo vacío",
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
                    modo==="I"?setCategoria():updateCategoria(objCategoria.IdCategoria);
                    bootbox.hideAll();
                    return false;
                }
                });
            };
            getModal = function (Modo) {
                modo = Modo;
                var titulo = "Ingresar Categoria: ";
                var boton = "Guardar Categoria:";
                if (modo === "M") {
                    titulo = "Modificar Categoria: ";
                    boton = "Actualizar Categoria:";               
                }  
                validateForm();
                bootbox.dialog({
                    title: titulo,
                    message: $("#myForm")
                }).init(function () {
                    if(modo==="M"){
                        $("#Nombre").val(objCategoria.Nombre);
                        $("#Descripcion").val(objCategoria.Descripcion);
                    }
                    $("#btnForm").val(boton);
                    $("#myForm").show();
                  });
                $('.bootbox').on('shown.bs.modal', function () {
                    $('#Nombre').focus();
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
