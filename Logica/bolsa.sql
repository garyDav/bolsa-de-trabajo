-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 04-12-2016 a las 06:21:46
-- Versión del servidor: 10.1.13-MariaDB
-- Versión de PHP: 7.0.5

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
DECLARE nameCate varchar(50);
IF NOT EXISTS(SELECT id FROM empresa WHERE name LIKE v_name) THEN
INSERT INTO empresa VALUES(null, v_id_categoria, v_name, v_email, v_address, v_phone, v_cell, v_photo, v_detail);
SET nameCate = (SELECT name FROM categoria WHERE id = v_id_categoria);
SELECT @@identity AS id, 'success' error,nameCate;
ELSE
SELECT 'Error: Nombre de empresa ya registrado.' error;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertSucursal` (IN `v_id_empresa` INT, IN `v_id_departamento` INT, IN `v_name` VARCHAR(50), IN `v_address` VARCHAR(50), IN `v_phone` VARCHAR(30), IN `v_cell` INT)  BEGIN
INSERT INTO sucursal VALUES(null, v_id_empresa, v_id_departamento, v_name, v_address, v_phone, v_cell);
SELECT @@identity AS id, 'success' error;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertTrabajo` (IN `v_id_empresa` INT, IN `v_name` VARCHAR(50), IN `v_detail` TEXT, IN `v_salary` FLOAT, IN `v_fec_in` DATETIME, IN `v_fec_lim` DATETIME)  BEGIN
DECLARE photo_e varchar(150);
DECLARE name_empresa varchar(150);
SET photo_e = (SELECT photo FROM empresa WHERE id = v_id_empresa);
SET name_empresa = (SELECT name FROM empresa WHERE id = v_id_empresa);
INSERT INTO trabajo VALUES(null, v_id_empresa, v_name, v_detail, v_salary, CURRENT_TIMESTAMP, v_fec_in, v_fec_lim);
SELECT @@identity AS id,CURRENT_TIMESTAMP AS fec,photo_e AS photo,name_empresa, 'success' error;
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
(8, 'Medicos', '1480629450.png'),
(9, 'Albañiles', '1480629847.jpeg'),
(10, 'Arquitectos', '1480630141.jpeg'),
(11, 'Pintores', '1480630343.jpeg'),
(12, 'Abogados', '1480630500.png'),
(13, 'Diseñador', '1480630695.jpeg'),
(14, 'Docentes', '1480630831.jpeg'),
(15, 'Choferes', '1480631145.jpeg'),
(16, 'Lavanderas', '1480631243.jpeg'),
(17, 'Tecnicos', '1480631377.jpeg'),
(18, 'Veterinarios', '1480645964.jpeg');

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
(10, 8, 'San Carlos', 'medicos@gmail.com', 'Av. Olimpo', '64-62318', 73400123, '1480631688.png', 'La clinica San Carlos se dedica a la al diagnostico de los pacientes'),
(11, 10, 's&n', 'arquitectos@gmail.com', 'Antofagasta # 85', '64-58974', 68945782, '1480633228.jpeg', 'Se dedica al diseño de su vivienda, y entre otros.'),
(12, 11, 'Pintura Bonita', 'pintores@gmail.com', 'Antofagasta # 23', '64-58958', 68945745, '1480633405.jpg', 'Realizan todo tipo de pintura tradicional, simantica.'),
(13, 12, 'Bufeg de Abogados', 'abogados@gmail.com', 'Manuel Molina #12', '64-58364', 68945285, '1480634112.jpg', 'Se dedica a casos de penalistas y otros.'),
(14, 14, 'ITSEC', 'docentes@gmail.com', 'Manuel Molina #89', '64-52568', 68946985, '1480634455.jpeg', 'La institucion se dedica a contratar docentes de exelencia en sus diferentes carreras.'),
(15, 15, 'Dorado', 'dorado@gmail.com', 'Ostria Gutierrez', '64-65894', 75698246, '1480634892.jpg', 'Se necesita un chofer categria c  buen sueldo'),
(16, 9, 'Constructora', 'constructora@gmail.com', 'Destacamento # 25', '64-25686', 73542135, '1480636678.jpeg', 'Busca maestro albañil y ayudantes'),
(17, 18, 'Procam', 'veterinarios@gmail.com', 'Paraguay', '64-67659', 73465321, '1480646137.jpeg', 'La empresa procam se dedica a la atencion de mascotas.');

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
  `fec_in` date DEFAULT NULL,
  `fec_lim` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `trabajo`
--

INSERT INTO `trabajo` (`id`, `id_empresa`, `name`, `detail`, `salary`, `fec`, `fec_in`, `fec_lim`) VALUES
(9, 10, 'nicolas', 'Busco Traumatologo para la clinica San Carlos', 8000, '2016-12-01 22:48:09', '2016-12-02', '2016-12-10'),
(10, 10, 'Medico General', 'See necesita un Medico General eficiente', 7500, '2016-12-01 22:55:06', '2016-12-04', '2016-12-09'),
(11, 15, 'Adrian Castellanos', 'Necesita chofer categoria c para viajes interdepartamentales', 8000, '2016-12-01 23:32:06', '2016-12-01', '2016-12-08'),
(12, 12, 'Pintor', 'Se busca pintor profecional y un ayudante', 2000, '2016-12-01 23:36:50', '2016-12-01', '2016-12-12'),
(13, 13, 'Penalista', 'Se busca abagado penalista buen sueldo', 10000, '2016-12-01 23:41:26', '2016-12-01', '2016-12-15'),
(14, 11, 'Arquitectos', 'Se necesita un arquitecto con experiencia o sin experiencia', 5000, '2016-12-01 23:50:14', '2016-12-01', '2016-12-16'),
(15, 16, 'Maestro albañil', 'busca maestro albañil', 3500, '2016-12-02 00:03:43', '2016-12-01', '2016-12-16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `last_name` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `password` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cell` int(11) DEFAULT NULL,
  `fec` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `name`, `last_name`, `email`, `password`, `cell`, `fec`) VALUES
(3, 'Nicolas', 'Quispe', 'nick_8391@hotmail.com', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', 68638233, '2016-11-24 00:36:32'),
(5, 'Juan', 'Perez', 'juan@gmail.com', 'b686682c584d3bb40e819d7eb67212b9e44ad99b', 75792276, '2016-12-04 00:26:05');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT de la tabla `departamento`
--
ALTER TABLE `departamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT de la tabla `sucursal`
--
ALTER TABLE `sucursal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `trabajo`
--
ALTER TABLE `trabajo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
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
