-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 14-11-2016 a las 23:42:46
-- Versión del servidor: 10.1.9-MariaDB
-- Versión de PHP: 7.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bolsa`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertCategoria` (IN `v_nombre` VARCHAR(50), IN `v_logo` VARCHAR(30))  BEGIN
IF NOT EXISTS(SELECT id FROM categoria WHERE nombre LIKE v_nombre) THEN
INSERT INTO categoria VALUES(null,v_nombre,v_logo);
SELECT @@identity AS id, '' error;
ELSE
SELECT 'Error: Nombre ya registrado.' error;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertDepartamento` (IN `v_nombre` VARCHAR(50))  BEGIN
IF NOT EXISTS(SELECT id FROM departamento WHERE nombre LIKE v_nombre) THEN
INSERT INTO departamento VALUES(null,v_nombre);
SELECT @@identity AS id, '' error;
ELSE
SELECT 'Error: Nombre ya registrado.' error;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertEmpleado` (IN `v_ci` VARCHAR(15), IN `v_foto` VARCHAR(30), IN `v_nombre` VARCHAR(50), IN `v_apellido` VARCHAR(50), IN `v_telefono` VARCHAR(15), IN `v_celular` INT, IN `v_direccion` VARCHAR(50))  BEGIN
IF NOT EXISTS(SELECT id FROM categoria WHERE ci LIKE v_ci) THEN
INSERT INTO categoria VALUES(null,v_ci,v_foto,v_nombre,v_apellido,v_telefono,v_celular,v_direccion);
SELECT @@identity AS id, '' error;
ELSE
SELECT 'Error: CI ya registrado.' error;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertEmpleador` (IN `v_foto` VARCHAR(30), IN `v_nombre` VARCHAR(50), IN `v_apellido` VARCHAR(50), IN `v_empresa` VARCHAR(60), IN `v_correo` VARCHAR(100), IN `v_contra` VARCHAR(100), IN `v_telefono` VARCHAR(15), IN `v_celular` INT)  BEGIN
IF NOT EXISTS(SELECT id FROM empleador WHERE correo LIKE v_correo) THEN
INSERT INTO empleador VALUES(null,v_foto,v_nombre,v_apellido,v_empresa,v_correo,v_contra,v_telefono,v_celular);
SELECT @@identity AS id, 'Usuario creado exitosamente :)' error;
ELSE
SELECT 'Error: Correo ya registrado.' error;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertMensaje` (IN `v_id_empleador` INT, IN `v_correo` VARCHAR(30), IN `v_mensaje` TEXT)  BEGIN
INSERT INTO categoria VALUES(null,v_id_empleador,v_correo,v_mensaje,CURRENT_TIMESTAMP);
SELECT @@identity AS id, '' error;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertNotificaciones` (IN `v_id_categoria` INT, IN `v_id_empleado` INT)  BEGIN
INSERT INTO notificaciones VALUES(null,v_id_categoria,v_id_empleado,CURRENT_TIMESTAMP);
SELECT @@identity AS id, '' error;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertOferta` (IN `v_id_categoria` INT, IN `v_id_empleado` INT, IN `v_id_empleador` INT, IN `v_id_departamento` INT, IN `v_detalle` TEXT, IN `v_direccion` VARCHAR(50), IN `v_latitud` VARCHAR(150), IN `v_longitud` VARCHAR(150))  BEGIN
INSERT INTO departamento VALUES(null,v_id_categoria,v_id_empleado,v_id_empleador,v_id_departamento,v_detalle,v_direccion,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,v_latitud,v_longitud);
SELECT @@identity AS id, '' error;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pSession` (IN `v_correo` VARCHAR(100), IN `v_pwd` VARCHAR(100))  BEGIN
DECLARE us int(11);
SET us = (SELECT id FROM empleador WHERE correo LIKE v_correo);
IF(us) THEN
IF EXISTS(SELECT id FROM empleador WHERE id = us AND contra LIKE v_pwd) THEN
SELECT id,'success' error FROM empleador WHERE id = us;
ELSE
SELECT 'Error: Contraseña incorrecta.' error;
END IF;
ELSE
SELECT 'Error: Correo no registrado.' error;
END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `logo` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `nombre`, `logo`) VALUES
(1, 'Mano de obra', 'mano_de_obra.jpg'),
(2, 'Tecnicos', 'tecnicos.jpg'),
(3, 'Medicos', 'medicos.jpg'),
(4, 'Odontologos', 'odontologos.jpg'),
(5, 'Abogados', 'abogados.jpg'),
(6, 'Limpieza', 'limpieza.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

CREATE TABLE `departamento` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `id` int(11) NOT NULL,
  `ci` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `foto` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `apellido` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `telefono` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `celular` int(11) DEFAULT NULL,
  `direccion` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleador`
--

CREATE TABLE `empleador` (
  `id` int(11) NOT NULL,
  `foto` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `apellido` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `empresa` varchar(60) COLLATE utf8_spanish_ci DEFAULT NULL,
  `correo` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `contra` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `telefono` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `celular` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `empleador`
--

INSERT INTO `empleador` (`id`, `foto`, `nombre`, `apellido`, `empresa`, `correo`, `contra`, `telefono`, `celular`) VALUES
(5, '', 'Juan', 'Perez', 'Diseñadores', 'juan@gmail.com', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', '', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensaje`
--

CREATE TABLE `mensaje` (
  `id` int(11) NOT NULL,
  `id_empleador` int(11) DEFAULT NULL,
  `correo` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `mensaje` text COLLATE utf8_spanish_ci,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id` int(11) NOT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oferta`
--

CREATE TABLE `oferta` (
  `id` int(11) NOT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `id_empleador` int(11) DEFAULT NULL,
  `id_departamento` int(11) DEFAULT NULL,
  `detalle` text COLLATE utf8_spanish_ci,
  `direccion` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha_in` datetime DEFAULT NULL,
  `fecha_lim` datetime DEFAULT NULL,
  `latitud` varchar(150) COLLATE utf8_spanish_ci DEFAULT NULL,
  `longitud` varchar(150) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `empleador`
--
ALTER TABLE `empleador`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `mensaje`
--
ALTER TABLE `mensaje`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_empleador` (`id_empleador`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_empleado` (`id_empleado`);

--
-- Indices de la tabla `oferta`
--
ALTER TABLE `oferta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_empleado` (`id_empleado`),
  ADD KEY `id_empleador` (`id_empleador`),
  ADD KEY `id_departamento` (`id_departamento`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `departamento`
--
ALTER TABLE `departamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `empleador`
--
ALTER TABLE `empleador`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `mensaje`
--
ALTER TABLE `mensaje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `oferta`
--
ALTER TABLE `oferta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `mensaje`
--
ALTER TABLE `mensaje`
  ADD CONSTRAINT `mensaje_ibfk_1` FOREIGN KEY (`id_empleador`) REFERENCES `empleador` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `notificaciones_ibfk_2` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `oferta`
--
ALTER TABLE `oferta`
  ADD CONSTRAINT `oferta_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `oferta_ibfk_2` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `oferta_ibfk_3` FOREIGN KEY (`id_empleador`) REFERENCES `empleador` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `oferta_ibfk_4` FOREIGN KEY (`id_departamento`) REFERENCES `departamento` (`id`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
