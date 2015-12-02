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
        <title>Productos</title>
        <%@include file="header.jsp" %>
    </head>
    <body>
        <div class="container">

      <!-- Static navbar -->
      <%@include file="navbar.jsp" %>

      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
          <div id="ProductosTableContainer">
            <table class="table" data-paging="true" data-sorting="true" data-filtering="true" data-filter-placeholder="Buscar">
                <thead>
                        <tr>
                                <th>ID</th>
                                <th>Categoria</th>
                                <th>Nombre</th>
                                <th data-breakpoints="xs" style="width: 50%;">Especificaciones</th>
                                <th>Precio</th>
                                <th>Stock</th>
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
                      <select id="selCategoria" name="selCategoria" class="form-control" >
                          
                      </select>                                   
                  </div>
              </div>
            </div>
        </div>
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
                      <p>Especificaciones</p>
                  </div>
                  <div class="col-md-8">
                      <textarea id="Specs" name="Specs" class="form-control form-control-search"></textarea>                                   
                  </div>
              </div>
            </div>
        </div>
          <div class="col-md-12">
            <div class="form-group">
               <div class="row">
                  <div class="col-md-4">
                      <p>Precio</p>
                  </div>
                  <div class="col-md-8">
                      <input id="Precio" name="Precio" value=""  class="form-control form-control-search" type="text" />
                  </div>
              </div>
            </div>
         </div>
          
         <div class="col-md-12">
            <div class="form-group">
               <div class="row">
                  <div class="col-md-4">
                      <p>Stock</p>
                  </div>
                  <div class="col-md-8">
                      <input id="Stock" name="Stock" value=""  class="form-control form-control-search" type="text" />
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
        var getProductos,getSubmit,getEdit,getModal,validateForm,modo;
        var objProducto,objProductos,setProducto,updateProducto,getDelete;
         $(function(){             
            fnActiva();
            getCategorias = function(){
                $.ajax({
                    url:'ListaCategorias',
                    type:'GET'
                }).done(function(datos){
                    var html = '<option value="">Seleccione...</option>';
                    if(datos.length > 0){
                        $.each(datos,function(i,item){
                            html +='<option value="'+item.IdCategoria+'">'+item.Nombre+'</option>';                                     
                        });
                    }                    
                    $('#selCategoria').html(html);
                    
                });
            };
            getProductos = function(){
                $.ajax({
                    url:'Products',
                    type:'POST',
                    data:{Metodo:'listall'}
                }).done(function(datos){
                    var html = '';
                    objProductos = datos;
                    if(datos.length > 0){
                        $.each(datos,function(i,item){
                            html += '<tr>'
                                   +'<td>'+item.IdProducto+'</td>'
                                   +'<td>'+item.Categoria+'</td>'
                                   +'<td>'+item.Nombre+'</td>'
                                   +'<td>'+item.Especificaciones+'</td>'
                                   +'<td>'+item.Precio+'</td>'
                                   +'<td>'+item.Stock+'</td>'
                                   +'<td>'
                                   +'<span class="btn-group"><a class="xcrud-action btn btn-info btn-sm" title="Ver" href="javascript:;" data-primary="1" data-task="view"><i class="glyphicon glyphicon-search"></i></a><a data-producto="'+item.IdProducto+'" class="xcrud-action btn btn-warning btn-sm btnEditar" title="Editar" href="javascript:;" data-primary="1" data-task="edit"><i class="glyphicon glyphicon-edit "></i></a><a data-producto="'+item.IdProducto+'" class="xcrud-action btn btn-danger btn-sm btnEliminar" title="Eliminar" href="javascript:;" data-primary="1" data-task="remove" data-confirm="Do you really want remove this entry?"><i class="glyphicon glyphicon-remove"></i></a></span>'
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
                    getCategorias(); //Select de categorías
                });
            };
            getProductos();
            
            getEdit = function(){
                $('.btnEditar').click(function(e){
                    e.preventDefault();
                    var idProd = $(this).data('producto');
                    objProducto = _.where(objProductos, { IdProducto: parseInt(idProd) })[0];
                    getModal("M",objProducto);
                });
            };
            
            getDelete = function(){
                $('.btnEliminar').click(function(e){
                    e.preventDefault();
                    var myForm = {};
                    myForm.Metodo = 'delete';
                    myForm.IdProducto = $(this).data('producto');
                    $.ajax({
                        url:'Products',
                        type:'POST',
                        data:myForm
                     }).done(function(datos){
                        fnMensaje(datos.Mensaje);
                        getProductos();
                     }); 
                });
            };
            
            setProducto = function(){
              var myForm = {};
              myForm.Metodo = 'insert';
              myForm.Nombre = $('#Nombre').val();
              myForm.Especificacion = $("#Specs").val();
              myForm.Categoria = $('#selCategoria').val();
              myForm.Precio = $('#Precio').val();
              myForm.Stock = $('#Stock').val();
              $.ajax({
                 url:'Products',
                 type:'POST',
                 data:myForm
              }).done(function(datos){
                 fnMensaje(datos.Mensaje);
                 getProductos();
              });               
            };
            
            updateProducto = function(IdProducto){
              var myForm = {};
              myForm.Metodo = 'update';
              myForm.IdProducto = IdProducto;
              myForm.Nombre = $('#Nombre').val();
              myForm.Especificacion = $("#Specs").val();
              myForm.Categoria = $('#selCategoria').val();
              myForm.Precio = $('#Precio').val();
              myForm.Stock = $('#Stock').val();
              $.ajax({
                 url:'Products',
                 type:'POST',
                 data:myForm
              }).done(function(datos){
                 fnMensaje(datos.Mensaje);
                 getProductos();
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
                    selCategoria:{
                        required: true
                    },
                    Nombre: {
                        minlength: 5,
                        maxlength: 255,
                        required: true
                    },
                    Specs: {
                        minlength: 5,
                        maxlength: 255,
                        required: true
                    },
                    Precio: {
                        required: true,
                        number: true
                    },
                    Stock: {
                        required: true,
                        number: true
                    }
                },
                messages: {
                    selCategoria: {
                        required: "Campo vacío"                        
                    },
                    Nombre: {
                        required: "Campo vacío",
                        minlength: jQuery.validator.format("Ingrese al menos {0} caracteres")
                    },
                    Specs: {
                        required: "Campo vacío",
                        minlength: jQuery.validator.format("Ingrese al menos {0} caracteres")
                    },
                    Precio: {
                        required: "Campo vacío",
                        number:"Sólo Números"
                    },
                    Stock: {
                        required: "Campo vacío",
                        number:"Sólo Números"
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
                    modo==="I"?setProducto():updateProducto(objProducto.IdProducto);
                    bootbox.hideAll();
                    return false;
                }
              });
            };
            getModal = function (Modo) {
                modo = Modo;
                var titulo = "Ingresar Producto:";
                var boton = "Guardar Producto";
                if (modo === "M") {
                    titulo = "Modificar Producto:";
                    boton = "Actualizar Producto";               
                }  
                validateForm();
                bootbox.dialog({
                    title: titulo,
                    message: $("#myForm")
                }).init(function () {
                    if(modo==="M"){
                        $('#selCategoria').val(objProducto.IdCategoria);
                        $("#Nombre").val(objProducto.Nombre);
                        $("#Specs").val(objProducto.Especificaciones);
                        $('#Precio').val(objProducto.Precio);
                        $('#Stock').val(objProducto.Stock);
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

