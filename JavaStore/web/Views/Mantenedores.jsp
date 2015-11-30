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
            <table class="table" data-paging="true" data-filtering="true" data-filter-placeholder="Buscar">
                <thead>
                        <tr>
                                <th data-breakpoints="xs">ID</th>
                                <th>Nombre</th>
                                <th>Descripcion</th>
                                <th data-breakpoints="xs">Fecha de Creación</th>
                                <th >Accciones</th>
                        </tr>
                </thead>
                <tbody>		
                </tbody>
            </table>  
          </div>
      </div>

    </div> <!-- /container -->
    
    <script type="text/javascript">
        var getCategorias;
        $(function(){
            getCategorias = function(){
                $.ajax({
                    url:'ListaCategorias',
                    type:'GET'
                }).done(function(datos){
                    var html = '';
                    console.log(datos);
                    if(datos.length > 0){
                        $.each(datos,function(i,item){
                            html += '<tr>'
                                   +'<td>'+item.IdCategoria+'</td>'
                                   +'<td>'+item.Nombre+'</td>'
                                   +'<td>'+item.Descripcion+'</td>'
                                   +'<td>'+item.Fecha+'</td>'
                                   +'<td></td>'
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
                });
            };
            getCategorias();
            
        });        
    </script>
    </body>
</html>
