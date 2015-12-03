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
        #chartdiv,#chartdiv2 {
	width		: 100%;
	height		: 435px;
	font-size	: 11px;
        }
        	
        </style>
    <%@include file="header.jsp" %>
<link href="Views/assets/css/export.css" rel="stylesheet">
<script src="Views/assets/js/amcharts.js"></script>
<script src="Views/assets/js/serial.js"></script>
<script src="Views/assets/js/pie.js"></script>
<script src="Views/assets/js/light.js"></script>
<script src="Views/assets/js/plugins/export.js" type="text/javascript"></script>
    </head>
    <body>
    <div class="container">

      <!-- Static navbar -->
      <%@include file="navbar.jsp" %>

      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">  
        <div class="row">  
            
            <div class="col-lg-6"><div id="chartdiv"></div></div>
            <div class="col-lg-6"><div id="chartdiv2"></div></div>
        </div>
      </div>
     
     </div>
        <script type="text/javascript">
            var chart,chart2,getDatos,colores = ["#67b7dc", "#fdd400", "#FF0F00", "#cc4748", "#cd82ad", "#2f4074", "#448e4d", "#b7b83f", "#b9783f", "#b93e3d", "#913167","#666","#777"];
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
                           datos[i]["Nombre"] = datos[i]["Nombre"].replace(" ","<br>");
                        });
                        chart(datos);
                        chart2(datos);
                        $('a[href$="http://www.amcharts.com/javascript-charts/"]').hide();
                    });
                    
                };
                
                getDatos();
                chart2 = function(chartData){
                    AmCharts.makeChart( "chartdiv2", {
                        "type": "pie",
                        "theme": "light",
                        "dataProvider":chartData,
                        "valueField": "Stock",
                        "titleField": "Nombre",
                        "outlineAlpha": 0.4,
                        "depth3D": 15,
                        "balloonText": "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>",
                        "angle": 30,
                        "export": {
                          "enabled": true
                        }
                      } );
                    
                };
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
