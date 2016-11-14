-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-10-2016 a las 23:07:24
-- Versión del servidor: 5.6.24
-- Versión de PHP: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `sucregram_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comment`
--

CREATE TABLE IF NOT EXISTS `comment` (
  `comment_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `picture_id` int(11) NOT NULL,
  `date_reg` datetime NOT NULL,
  `status` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `like`
--

CREATE TABLE IF NOT EXISTS `like` (
  `like_id` int(11) NOT NULL,
  `picture_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_reg` datetime NOT NULL,
  `status` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `picture`
--

CREATE TABLE IF NOT EXISTS `picture` (
  `picture_id` int(11) NOT NULL,
  `url` varchar(250) NOT NULL,
  `description` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_reg` datetime NOT NULL,
  `status` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(11) NOT NULL,
  `facebookid` varchar(250) NOT NULL,
  `username` varchar(250) NOT NULL,
  `name` varchar(100) NOT NULL,
  `url_perfil` varchar(250) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(25) NOT NULL,
  `date_reg` datetime NOT NULL,
  `status` bit(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`user_id`, `facebookid`, `username`, `name`, `url_perfil`, `email`, `password`, `date_reg`, `status`) VALUES
(1, '57ea125b43ffb7b6857c0c33', 'Stafford', 'Marcia Potter', '../img/excepteur.jpg', 'marciapotter@supportal.com', '057ea125b43ffb7b6857c0c33', '2016-09-27 00:00:00', b'1'),
(2, '57ea125b43ffb7b6857c0c33', 'Stafford', 'Marcia Potter', '../img/excepteur.jpg', 'marciapotter@supportal.com', '057ea125b43ffb7b6857c0c33', '2016-09-27 00:00:00', b'1'),
(3, '57ea1382777a0128aacf72cd', 'Mcfarland', 'Dorothea Knight', '../img/mollit.jpg', 'dorotheaknight@supportal.com', '057ea13825609b0336331f4a3', '2016-09-27 00:00:00', b'1'),
(4, '57ea13824d8a24970d4ec7ee', 'George', 'Fanny Dunn', '../img/non.jpg', 'fannydunn@supportal.com', '157ea1382bff6fad807363e02', '2016-09-27 00:00:00', b'1'),
(5, '57ea1382e56aa7d35791e8c2', 'Lynch', 'Monique Garner', '../img/veniam.jpg', 'moniquegarner@supportal.com', '257ea13824fb11a16e4109b04', '2016-09-27 00:00:00', b'1'),
(6, '57ea1382439d02fbbac18354', 'Molina', 'Ella Chambers', '../img/ut.jpg', 'ellachambers@supportal.com', '357ea138202cf5472fb715109', '2016-09-27 00:00:00', b'1'),
(7, '57ea1382e806e849bf606320', 'Moody', 'Martina Winters', '../img/dolor.jpg', 'martinawinters@supportal.com', '457ea13828a958f6a9e56680b', '2016-09-27 00:00:00', b'1'),
(8, '57ea1382e27a6ac3eb168c7f', 'Bradshaw', 'Colleen Montgomery', '../img/laborum.jpg', 'colleenmontgomery@supportal.com', '557ea1382b0915b51d65d2709', '2016-09-27 00:00:00', b'1'),
(9, '57ea1382a7d483bed0a09607', 'Blake', 'Gabriela Potts', '../img/culpa.jpg', 'gabrielapotts@supportal.com', '657ea13827697bed9aa79cca1', '2016-09-27 00:00:00', b'1'),
(10, '57ea1382e22698fb63b6004b', 'Edwards', 'Burks Miller', '../img/occaecat.jpg', 'burksmiller@supportal.com', '757ea138215f0999090611eb3', '2016-09-27 00:00:00', b'1'),
(11, '57ea13823c8d7af2e7e3d569', 'Alvarez', 'Solomon Cannon', '../img/voluptate.jpg', 'solomoncannon@supportal.com', '857ea138298e57e338bb292bf', '2016-09-27 00:00:00', b'1'),
(12, '57ea1382f9c2143d53392890', 'Russo', 'Blanche Clayton', '../img/labore.jpg', 'blancheclayton@supportal.com', '1057ea13821874347fbad3b3c', '2016-09-27 00:00:00', b'1'),
(13, '', 'Clarke3', 'Debora LoveR', '../img/capo2015.jpg', 'deboralove@supportal.com', 'capo2015', '2016-09-27 03:31:52', b'1'),
(14, '', 'Dorsey', 'Kitty Rush', '', 'kittyrush@supportal.com', '26c47b6217f542254d0b59d81', '2016-09-27 03:39:01', b'1');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`comment_id`);

--
-- Indices de la tabla `like`
--
ALTER TABLE `like`
  ADD PRIMARY KEY (`like_id`);

--
-- Indices de la tabla `picture`
--
ALTER TABLE `picture`
  ADD PRIMARY KEY (`picture_id`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `comment`
--
ALTER TABLE `comment`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `like`
--
ALTER TABLE `like`
  MODIFY `like_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `picture`
--
ALTER TABLE `picture`
  MODIFY `picture_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
