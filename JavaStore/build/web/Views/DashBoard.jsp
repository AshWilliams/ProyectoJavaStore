<%-- 
    Document   : DashBoard
    Created on : 02-12-2015, 16:38:08
    Author     : Cypher
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DashBoard</title>
        <style>
        #chartdiv {
	width		: 100%;
	height		: 435px;
	font-size	: 11px;
}		
        </style>
    <%@include file="header.jsp" %>
<script src="http://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="http://www.amcharts.com/lib/3/serial.js"></script>
<script src="http://www.amcharts.com/lib/3/themes/light.js"></script>
    </head>
    <body>
    <div class="container">

      <!-- Static navbar -->
      <%@include file="navbar.jsp" %>

      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">    
        <div id="chartdiv"></div>
      </div>
     
     </div>
        <script type="text/javascript">
            var chart,getDatos,colores = ["#67b7dc", "#fdd400", "#FF0F00", "#cc4748", "#cd82ad", "#2f4074", "#448e4d", "#b7b83f", "#b9783f", "#b93e3d", "#913167","#666","#777"];
            $(function(){
                fnActiva();
                
                getDatos = function(){
                    $.ajax({
                        url:'DashBoard',
                        type:'POST',
                        data:{Metodo:'getStock'}
                    }).done(function(datos){
                        $.each(datos,function(i,item){
                           datos[i]["color"] = colores[i]; 
                        });
                        chart(datos);
                    });
                    
                };
                
                getDatos();

                chart = function(chartData){
                 AmCharts.makeChart("chartdiv", {
                    "theme": "light",
                    "type": "serial",
                    "startDuration": 2,
                    "dataProvider": chartData,
                    "valueAxes": [{
                        "position": "left",
                        "title": "Stock Productos"
                    }],
                    "graphs": [{
                        "balloonText": "[[category]]: <b>Stock [[value]]</b>",
                        "fillColorsField": "color",
                        "fillAlphas": 1,
                        "lineAlpha": 0.1,
                        "type": "column",
                        "valueField": "Stock"
                    }],
                    "depth3D": 20,
                        "angle": 30,
                    "chartCursor": {
                        "categoryBalloonEnabled": false,
                        "cursorAlpha": 0,
                        "zoomable": false
                    },    
                    "categoryField": "Nombre",
                    "categoryAxis": {
                        "gridPosition": "start",
                        "labelRotation": 0
                    },
                    "export": {
                        "enabled": true
                     }

                });

                };
    });
        </script>    
    </body>
</html>
