<%-- 
    Document   : header
    Created on : 27-11-2015, 10:23:04
    Author     : Cypher
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

  <link href="Views/assets/css/bootstrap.min.css" rel="stylesheet">
  <link href="Views/assets/css/signin.css" rel="stylesheet">
  <link href="Views/assets/css/footable.bootstrap.min.css" rel="stylesheet">
  <script src="Views/assets/js/jquery-2.1.3.min.js"></script>  
  <script src="Views/assets/js/bootstrap.min.js"></script>
  <script src="Views/assets/js/bootbox.min.js"></script>
  <script src="Views/assets/js/jquery.validate.min.js"></script>
  <script src="Views/assets/js/footable.js"></script>
  <script src="Views/assets/js/lodash.min.js"></script>
  <script type="text/javascript">
      var fnMensaje;
      $(function(){
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
      });
  </script>
  
  
   
