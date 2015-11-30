-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.6.17 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura de base de datos para javastore
CREATE DATABASE IF NOT EXISTS `javastore` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `javastore`;


-- Volcando estructura para tabla javastore.categorias
CREATE TABLE IF NOT EXISTS `categorias` (
  `idCategoria` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `Descripcion` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `FechaCreacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla javastore.categorias: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` (`idCategoria`, `Nombre`, `Descripcion`, `FechaCreacion`) VALUES
	(1, 'Notebooks', 'Es un ordenador personal móvil o transportable, que pesa normalmente entre 1 y 3 kilos', '2015-11-29 19:56:21'),
	(2, 'Ultralivianos', 'Ordenador ultraliaviano de uso personal', '2015-11-29 19:56:21'),
	(3, 'Tablets', 'Es una computadora portátil de mayor tamaño que un teléfono inteligente o un PDA', '2015-11-29 19:56:21'),
	(4, 'Smartphone', 'Tipo de teléfono móvil construido sobre una plataforma informática móvil.', '2015-11-30 12:11:11');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;


-- Volcando estructura para tabla javastore.productos
CREATE TABLE IF NOT EXISTS `productos` (
  `IdProducto` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(150) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `Especificaciones` varchar(350) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `Precio` int(11) NOT NULL DEFAULT '0',
  `Stock` int(11) NOT NULL DEFAULT '0',
  `IdCategoria` int(11) NOT NULL DEFAULT '0',
  `FechaCreacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IdProducto`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla javastore.productos: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` (`IdProducto`, `Nombre`, `Especificaciones`, `Precio`, `Stock`, `IdCategoria`, `FechaCreacion`) VALUES
	(1, 'Dell Inspiron 1450', 'Con dimensión inicial de 2,54 cm (1"), la Inspiron 14 es elegante y portátil. Y el diseño moderno la hace tan elegante como móvil.', 400000, 30, 1, '2015-11-30 15:50:40'),
	(2, 'Asus 4085', 'La ultrabook QHD más fina del mundo con tan solo 13 pulgadas. Más delgada. Más rápida. Más atractiva', 800000, 20, 2, '2015-11-30 15:51:03');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;


-- Volcando estructura para tabla javastore.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `idPerfil` int(11) NOT NULL,
  `Usuario` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Pass` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `Nombres` varchar(200) COLLATE utf8_unicode_ci DEFAULT '0',
  `Apellidos` varchar(200) COLLATE utf8_unicode_ci DEFAULT '0',
  `Rut` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `Email` varchar(200) COLLATE utf8_unicode_ci DEFAULT '0',
  `Direccion` varchar(200) COLLATE utf8_unicode_ci DEFAULT '0',
  `FechaCreacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Volcando datos para la tabla javastore.usuarios: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`idUsuario`, `idPerfil`, `Usuario`, `Pass`, `Nombres`, `Apellidos`, `Rut`, `Email`, `Direccion`, `FechaCreacion`) VALUES
	(1, 1, 'admin', 'f865b53623b121fd34ee5426c792e5c33af8c227', 'Robert', 'Rozas Navarro', '14542091-1', 'robert.rozas.n@gmail.com', 'Sin Especificar', '2015-11-29 18:12:34');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
