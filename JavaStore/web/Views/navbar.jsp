<%-- 
    Document   : navbar
    Created on : 29-11-2015, 17:40:54
    Author     : Overlord
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<nav class="navbar navbar-default">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Administración</a>
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li class="active"><a href="Categorias">Categorias</a></li>
              <li><a href="#">Productos</a></li>
              <li><a href="#">Usuarios</a></li>
              <li><a href="#">Perfiles</a></li>
              <li><a id="btnSalir" href="javascript:;">Salir</a></li>
            </ul>  
            <ul class="nav navbar-nav navbar-right">
              <li><a href="javascript:;">Bienvenido: ${sessionScope.Usuario}</a></li>              
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
</nav>
<script type="text/javascript">
    $(function(){
        $('#btnSalir').click(function(){
            window.location='LogOut';            
        });
    });
</script>
