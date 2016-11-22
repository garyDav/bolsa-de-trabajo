-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 22-11-2016 a las 06:13:24
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertCategoria` (IN `v_name` VARCHAR(50), IN `v_logo` VARCHAR(150))  BEGIN
IF NOT EXISTS(SELECT id FROM categoria WHERE name LIKE v_name) THEN
INSERT INTO categoria VALUES(null,v_name,v_logo);
SELECT @@identity AS id, 'success' error;
ELSE
SELECT 'Error: Nombre ya registrado.' error;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertDepartamento` (IN `v_name` VARCHAR(100))  BEGIN
INSERT INTO departamento VALUES(null, v_name);
SELECT @@identity AS id, 'success' error;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertEmpresa` (IN `v_id_categoria` INT, IN `v_name` VARCHAR(50), IN `v_email` VARCHAR(100), IN `v_address` VARCHAR(50), IN `v_phone` VARCHAR(30), IN `v_cell` INT, IN `v_photo` VARCHAR(150), IN `v_detail` TEXT)  BEGIN
IF NOT EXISTS(SELECT id FROM empresa WHERE name LIKE v_name) THEN
INSERT INTO empresa VALUES(null, v_id_categoria, v_name, v_email, v_address, v_phone, v_cell, v_photo, v_detail);
SELECT @@identity AS id, 'success' error;
ELSE
SELECT 'Error: Nombre de empresa ya registrado.' error;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertSucursal` (IN `v_id_empresa` INT, IN `v_id_departamento` INT, IN `v_name` VARCHAR(50), IN `v_address` VARCHAR(50), IN `v_phone` VARCHAR(30), IN `v_cell` INT)  BEGIN
INSERT INTO sucursal VALUES(null, v_id_empresa, v_id_departamento, v_name, v_address, v_phone, v_cell);
SELECT @@identity AS id, 'success' error;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertTrabajo` (IN `v_id_empresa` INT, IN `v_name` VARCHAR(50), IN `v_detail` TEXT, IN `v_salary` FLOAT, IN `v_fec_in` DATETIME, IN `v_fec_lim` DATETIME)  BEGIN
INSERT INTO trabajo VALUES(null, v_id_empresa, v_name, v_detail, v_salary, v_fec_in, v_fec_lim);
SELECT @@identity AS id, 'success' error;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertUser` (IN `v_name` VARCHAR(50), IN `v_las_name` VARCHAR(50), IN `v_email` VARCHAR(100), IN `v_password` VARCHAR(100), IN `v_cell` INT)  BEGIN
IF NOT EXISTS(SELECT id FROM user WHERE email LIKE v_email) THEN
INSERT INTO user VALUES(null,v_name,v_las_name,v_email,v_password,v_cell,CURRENT_TIMESTAMP);
SELECT @@identity AS id, 'success' error;
ELSE
SELECT 'Error: Correo ya registrado.' error;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pSession` (IN `v_email` VARCHAR(100), IN `v_pwd` VARCHAR(100))  BEGIN
DECLARE us int(11);
SET us = (SELECT id FROM user WHERE email LIKE v_email);
IF(us) THEN
IF EXISTS(SELECT id FROM user WHERE id = us AND password LIKE v_pwd) THEN
SELECT id,'success' error FROM user WHERE id = us;
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
  `name` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `logo` varchar(150) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `name`, `logo`) VALUES
(1, 'tecnicos', 'tecnicos.jpg'),
(2, 'hogar', 'hogar.jpg'),
(3, 'diseñador', 'diseñador.jpg'),
(4, 'licenciatura', 'licenciatura.jpg'),
(5, 'ingenieria', 'ingenieria.jpg'),
(6, 'salud', 'salud.jpg'),
(7, 'sociales', 'sociales.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

CREATE TABLE `departamento` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `id` int(11) NOT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `address` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `phone` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cell` int(11) DEFAULT NULL,
  `photo` varchar(150) COLLATE utf8_spanish_ci NOT NULL,
  `detail` text COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`id`, `id_categoria`, `name`, `email`, `address`, `phone`, `cell`, `photo`, `detail`) VALUES
(1, 1, 'Constructora muro duro', 'm_constructora@gmail.com', 'Cll: Descatamento 111 N° 563', '64-35845', 75784211, 'empresa1.jpg', 'Esta es una empresa dedicada a la construccion de viviendas.'),
(2, 1, 'Tecno Service', 'tecno_service@gmail.com', 'Ricardo Andrade N°10', '64-15476', 72784566, 'empresa2.jpg', 'Esta es una empresa dedicada a la reparacion y mantenimiento de computadoras.'),
(3, 2, 'Empresa señoritas del hogar', 'hogar_emp@gmail.com', 'Jaime Mendoza N°541', '64-95478', 72006544, 'empresa3.jpg', 'Esta es una empresa donde contrataras las mejores chicas para el cuidado de tu hogar y el tuyo.'),
(4, 4, 'Buffet los doctores', 'buffet_abogados@gmail.com', 'Aniceto Arce N°50', '64-65841', 73006588, 'empresa4.jpg', 'Esta es una empresa de gangster que te robaran si ganas un caso o no.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursal`
--

CREATE TABLE `sucursal` (
  `id` int(11) NOT NULL,
  `id_empresa` int(11) DEFAULT NULL,
  `id_departamento` int(11) DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `address` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `phone` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cell` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajo`
--

CREATE TABLE `trabajo` (
  `id` int(11) NOT NULL,
  `id_empresa` int(11) DEFAULT NULL,
  `name` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `detail` text COLLATE utf8_spanish_ci,
  `salary` float DEFAULT NULL,
  `fec` datetime DEFAULT NULL,
  `fec_in` datetime DEFAULT NULL,
  `fec_lim` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `las_name` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `password` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cell` int(11) DEFAULT NULL,
  `fec` datetime DEFAULT NULL
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
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_empresa` (`id_empresa`),
  ADD KEY `id_departamento` (`id_departamento`);

--
-- Indices de la tabla `trabajo`
--
ALTER TABLE `trabajo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_empresa` (`id_empresa`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `departamento`
--
ALTER TABLE `departamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `trabajo`
--
ALTER TABLE `trabajo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD CONSTRAINT `empresa_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`);

--
-- Filtros para la tabla `sucursal`
--
ALTER TABLE `sucursal`
  ADD CONSTRAINT `sucursal_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id`),
  ADD CONSTRAINT `sucursal_ibfk_2` FOREIGN KEY (`id_departamento`) REFERENCES `departamento` (`id`);

--
-- Filtros para la tabla `trabajo`
--
ALTER TABLE `trabajo`
  ADD CONSTRAINT `trabajo_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
