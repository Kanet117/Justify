-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 29-11-2024 a las 16:14:05
-- Versión del servidor: 5.7.44-log
-- Versión de PHP: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `eclipsehome`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectosjar`
--

CREATE TABLE `proyectosjar` (
  `idproyectosjar` int(8) NOT NULL,
  `nombre` text COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8_spanish_ci NOT NULL,
  `tipo_proyecto` text COLLATE utf8_spanish_ci NOT NULL,
  `imagen` varchar(50) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `proyectosjar`
--

INSERT INTO `proyectosjar` (`idproyectosjar`, `nombre`, `descripcion`, `tipo_proyecto`, `imagen`) VALUES
(1, '', 'This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.', 'IEJ', 'E1.jpg'),
(2, '', 'This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.', 'IEJ', 'E2.jpg'),
(3, '', 'This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.', 'IEJ', 'E3.jpg'),
(4, '', 'This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.', 'IEJ', 'E4.jpg'),
(5, '', 'This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.', 'IEJ', 'E5.jpg'),
(6, '', 'This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.', 'IEJ', 'E6.jpg'),
(7, '', 'This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.', 'IEJ', 'E7.jpg'),
(8, '', 'This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.', 'IEJ', 'E8.jpg'),
(9, '', 'This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.', 'IEJ', 'E9.jpg'),
(10, 'Ya quedo', 'listo', 'IEJ', 'E5.jpg');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `proyectosjar`
--
ALTER TABLE `proyectosjar`
  ADD PRIMARY KEY (`idproyectosjar`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `proyectosjar`
--
ALTER TABLE `proyectosjar`
  MODIFY `idproyectosjar` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
