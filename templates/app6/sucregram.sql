-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 01-11-2016 a las 03:15:18
-- Versión del servidor: 10.1.13-MariaDB
-- Versión de PHP: 7.0.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sucregram`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pInsertUsuario` (IN `v_name` VARCHAR(100), IN `v_user` VARCHAR(70), IN `v_email` VARCHAR(50), IN `v_password` VARCHAR(100))  BEGIN
IF NOT EXISTS(SELECT id FROM usuario WHERE user = v_user) THEN
INSERT INTO usuario(name,user,email,password,date) VALUES(v_name,v_user,v_email,v_password,CURRENT_TIMESTAMP);
SELECT @@identity AS id,'success' AS error;
ELSE
SELECT 'Error: Usuario ya registrado.' error;
END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `user` varchar(70) COLLATE utf8_spanish2_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `name`, `user`, `email`, `password`, `date`) VALUES
(1, 'Juan Perez', 'juan', 'juan@gmail.com', '1234', '2016-10-31 20:57:58'),
(2, 'Pedro Fernandez', 'pedro', 'pedro@gmail.com', '1234', '2016-10-31 20:58:53'),
(3, 'Rosaly Sanchez', 'rosaly', 'rosaly@gmail.com', '1234', '2016-10-31 21:08:05'),
(4, 'Carolina Romero', 'carolina', 'carolina@gmail.com', '1234', '2016-10-31 21:47:46'),
(5, 'David Guzman', 'david', 'david@gmail.com', '1234', '2016-10-31 21:52:05');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
