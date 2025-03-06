-- Base de datos: `justify`
CREATE DATABASE IF NOT EXISTS `justify` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `justify`;

-- Tabla para publicaciones
CREATE TABLE `publicaciones` (
  `id_publicacion` INT NOT NULL AUTO_INCREMENT,
  `usuario_id` INT NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `imagen` VARCHAR(50) DEFAULT NULL,
  `fecha` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_publicacion`),
  FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tabla para usuarios (adaptada de tu ejemplo)
CREATE TABLE `usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `correo` VARCHAR(50) NOT NULL UNIQUE,
  `clave` VARCHAR(200) NOT NULL,
  `fechareg` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `perfil` CHAR(1) NOT NULL DEFAULT 'U', -- 'U' para usuario, 'A' para admin
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;