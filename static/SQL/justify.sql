-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 06-03-2025 a las 00:00:00 (ejemplo, ajusta según tu fecha)
-- Versión del servidor: 8.0.41
-- Versión de PHP: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `justify`
--
CREATE DATABASE IF NOT EXISTS `justify` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `justify`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS usuario (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    correo VARCHAR(50) NOT NULL UNIQUE,
    clave VARCHAR(200) NOT NULL,
    fechareg DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    perfil CHAR(1) NOT NULL DEFAULT 'U', -- 'U' (estudiante), 'E' (empresa), 'A' (administrador)
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
--
-- Volcado de datos para la tabla `usuarios`
--

-- Usuarios
INSERT INTO usuario (nombre, correo, clave, perfil) VALUES
('Estudiante 1', 'estudiante1@justify.com', 'hashed_password_1', 'U'),
('Empresa 1', 'empresa1@justify.com', 'hashed_password_2', 'E'),
('Admin 1', 'admin1@justify.com', 'hashed_password_3', 'A');
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `publicaciones`
--

CREATE TABLE IF NOT EXISTS publicaciones (
    id_publicacion INT NOT NULL AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    imagen VARCHAR(50) DEFAULT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_publicacion),
    FOREIGN KEY (usuario_id) REFERENCES usuario (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
--
-- Volcado de datos para la tabla `publicaciones`
--

-- Publicaciones
INSERT INTO publicaciones (usuario_id, titulo, descripcion, imagen) VALUES
(1, 'Busco beca en diseño', 'Soy estudiante de diseño gráfico buscando experiencia.', NULL),
(2, 'Oferta de prácticas', 'Buscamos estudiantes para prácticas en marketing.', NULL),
(3, 'Anuncio oficial', 'Evento de JUSTIFY para todos los estudiantes.', NULL);
--
-- Índices para tablas volcadas
--

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` INT NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `publicaciones`
--
ALTER TABLE `publicaciones`
  MODIFY `id_publicacion` INT NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `publicaciones`
--
ALTER TABLE `publicaciones`
  ADD CONSTRAINT `fk_usuario_publicacion` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;