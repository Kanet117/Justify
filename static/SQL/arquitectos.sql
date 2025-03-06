-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 13-02-2025 a las 19:10:43
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
-- Base de datos: `eclipsehome`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asesorias`
--

CREATE TABLE `asesorias` (
  `idasesorias` int NOT NULL,
  `proyecto_id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `fecha` datetime NOT NULL,
  `comentarios` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectos`
--

CREATE TABLE `proyectos` (
  `idproyectos` int NOT NULL,
  `nombre` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `tipo_proyecto` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `imagen` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Volcado de datos para la tabla `proyectos`
--

INSERT INTO `proyectos` (`idproyectos`, `nombre`, `descripcion`, `tipo_proyecto`, `imagen`) VALUES
(1, 'wabi sabi', 'Decoración japonesa que se concentra en la belleza de la imperfección.', 'I', 'wabi sabi.jpg'),
(2, 'industrial', 'Inspirada en un almacén o en un loft urbano. ', 'IE', 'industrial.jpg'),
(3, 'kinfolk', 'Vuelve a lo basico', 'IJ', 'kinfolk.jpg'),
(4, 'contemporaneo', 'Define por la simplicidad, la sofisticación sutil, el uso deliberado de la textura y las lÃ­neas limpias.', 'I', 'contemporaneo.jpg'),
(5, 'minimalista', 'El mantra principal del estilo del hogar minimalista es la simplicidad.', 'IJ', 'minimalista.jpg'),
(6, 'nordico', 'En estos países crearon la necesidad de interiores elegantes y espaciosos que aprovecharan al máximo la luz solar disponible.', 'IEJ', 'nordico.jpg'),
(7, 'oriental', 'Evocan instantáneamente una imagen de serenidad y tranquilidad.', 'IEJ', 'oriental.jpg'),
(8, 'Clasico', 'Estilo refinado, rico en detalles que se encuentran tanto en la estructura de los muebles, la iluminaciÃ³n, etc.', 'IEJ', 'Clasico.jpg'),
(9, 'art deco', 'Símbolo de glamur y sofisticación.', 'IEJ', 'art deco.png'),
(10, 'rustico', 'Lleva la naturaleza al interior de tu hogar.', 'IEJ', 'rustico.jpg'),
(11, '', 'En estos países crearon la necesidad de interiores elegantes y espaciosos que aprovecharan al máximo la luz solar disponible.', 'IEJ', '3.jpg'),
(12, '', 'Evocan instantáneamente una imagen de serenidad y tranquilidad.', 'IEJ', '4.jpg'),
(13, '', 'La clave del estilo escandinavo en el hogar es la combinación de funcionalidad y calidez.', 'IEJ', '5.jpg'),
(14, '', 'La esencia del estilo minimalista en el hogar radica en la simplicidad.', 'IEJ', '6.jpg'),
(15, '', 'El mantra principal del estilo del hogar minimalista es la simplicidad.', 'IEJ', '7.jpg'),
(16, '', 'El Art-Deco es simbolo de glamur y sofisticación.', 'IEJ', '8.jpg'),
(17, '', 'Define por la simplicidad, la sofisticación sutil, el uso deliberado de la textura y las líneas limpias.', 'IEJ', '10.jpg'),
(20, 'Ya casi', 'hola', 'IE', 'Clasico.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectosext`
--

CREATE TABLE `proyectosext` (
  `idproyectosext` int NOT NULL,
  `nombre` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `tipo_proyecto` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `imagen` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Volcado de datos para la tabla `proyectosext`
--

INSERT INTO `proyectosext` (`idproyectosext`, `nombre`, `descripcion`, `tipo_proyecto`, `imagen`) VALUES
(1, 'Fachada Ligera', '  La fachada ligera es un revestimiento que se adhiere a la estructura del edificio, sin formar parte de ella. Se fabrica con materiales como vidrio o metal y puede ser de dos tipos: muro cortina, que cubre los forjados, y fachada panel, que se interrumpe en cada forjado. Ofrece ventajas como facilidad de instalación y mayor luminosidad, pero presenta un menor aislamiento térmico y acústico y mayores costes de mantenimiento a largo plazo. Se utiliza principalmente en edificios de oficinas de mediana y gran altura.  ', 'E', 'Fachada Ligera.webp'),
(2, 'Muro Cortina', '  Las fachadas de muro cortina son sistemas de revestimiento no estructurales, comunes en edificios altos. Son autoportantes, sin soportar cargas externas, lo que permite usar materiales ligeros. El vidrio es el material más usado por su bajo coste y estética, permitiendo gran entrada de luz natural, aunque incrementa el calor solar. Otros materiales empleados incluyen piedra y paneles metálicos.  ', 'E', 'Muro Cortina.jpg'),
(3, 'Fachada Panel', '  La fachada panel es otro tipo de fachada ligera, compuesta por paneles prefabricados de materiales como aluminio, acero, composite o cerámica. Se interrumpe en cada forjado, con la estructura auxiliar apoyada en cada uno. Está formada por montantes, travesaños y los paneles.', 'E', 'Fachada Panel.jpg'),
(4, 'Fachada Pesada', 'Las fachadas pesadas tienen un peso superior a 100 kg por metro cuadrado. Pueden ser portantes o autoportantes, y algunas incluyen cámara de aire, dependiendo de las necesidades de aislamiento térmico. ', 'E', 'E4.jpg'),
(5, 'Prefabricada', 'La fachada prefabricada se compone de módulos ensamblados en obra, fabricados industrialmente con materiales como hormigón y madera. Ofrece ventajas como rapidez, facilidad de instalación y menor coste, pero presenta limitaciones en el diseño y requiere un volumen mínimo de obra. Es común en naves industriales y grandes superficies comerciales, aunque su uso en viviendas es menos frecuente. ', 'E', 'Prefabricada.jpg'),
(6, 'Tradicional', 'Las fachadas clásicas utilizan materiales tradicionales como ladrillo, piedra, madera y cerámica. Sus beneficios incluyen rapidez de instalación y bajo coste. Sin embargo, al no tener cámara de aire ni aislamiento, ofrecen menor rendimiento térmico y acústico, lo que reduce el ahorro energético. ', 'E', 'Tradicional.jpg'),
(7, 'Sistema SATE', 'La fachada SATE (Sistema de Aislamiento Térmico por el Exterior) se ha vuelto popular, especialmente en rehabilitaciones. Consiste en colocar placas aislantes sobre la envolvente del edificio, que se protegen con mortero y se fijan al muro. Luego, se aplica un revestimiento estético. Los materiales comunes para el aislamiento incluyen poliestireno expandido (EPS), poliestireno extruido (XPS), EPS grafito (EPS-G) y lana mineral. Este sistema mejora la eficiencia energética al reducir puentes térmicos y condensaciones, y es una opción económica ya que no requiere un sistema de perfilería. ', 'E', 'Sistema SATE.png'),
(8, 'Fachada Ventilada', 'El sistema de fachada ventilada o transventilada consta de un muro de soporte, una capa aislante y un revestimiento fijado mediante una estructura portante. Su principal diferencia con el sistema SATE es la cámara de aire entre el muro y el revestimiento. Aunque es más costoso y complejo de instalar, su rentabilidad es alta debido a las ventajas que ofrece la cámara de aire, como mejor ventilación y eficiencia térmica. ', 'E', 'Fachada Ventilada.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectosjar`
--

CREATE TABLE `proyectosjar` (
  `idproyectosjar` int NOT NULL,
  `nombre` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `tipo_proyecto` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `imagen` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Volcado de datos para la tabla `proyectosjar`
--

INSERT INTO `proyectosjar` (`idproyectosjar`, `nombre`, `descripcion`, `tipo_proyecto`, `imagen`) VALUES
(1, 'Jardín Clásico', 'Se caracteriza por una simetría estricta y formas geométricas, así como por el uso de césped y el recorte de los árboles. Las macetas con flores te alegran la vista por su gran cantidad de colores. El jardín clásico se decora con fuentes, esculturas, columnas, bolas de piedra, arcos de hierro forjado colocados en puntos cuidadosamente seleccionados. Este estilo de jardín crea una atmósfera de solidez y lujo.', 'J', 'Jardin Clásico.png'),
(2, 'Jardín Inglés', 'En el diseño del jardín inglés, las formas irregulares, la asimetría, la ausencia de esquinas afiladas y las curvas suaves pasan a primer plano.  El estilo inglés es un balance entre la naturaleza y los elementos artificiales, lo que genera la belleza del paisaje. Para crear relieves y pasillos pintorescos, se utilizan la jardinería vertical y plantas de varias alturas. El jardín inglés también se distingue por la abundancia de flores. El sitio se decora con elementos de agua como estanques, lagos, pequeños riachuelos, bancos hechos de materiales naturales y objetos antiguos.', 'J', 'Jardin Ingles.jpg'),
(3, 'Jardín de Cactus y Suculentas', 'La estética de los jardines de cactus puede ser muy diversa por el contraste de formas, texturas y colores. Según el feng shui, las suculentas y, sobre todo, los cactus, transmiten energías positivas y defienden el hogar con sus espinas. En el caso de los cactus y suculentas, se puede aplicar cualquier tipo de piedra, piedrín o canto rodado. Es recomendable colocar piedras blancas alrededor para crear un contraste con el color verde de las plantas.', 'J', 'Jardin de Cactus y Suculentas.jpg'),
(4, 'Jardín Mediterráneo', 'Es una composición de piedras, terracota y plantas que rodean una piscina. Las macetas y los jarrones de barro a menudo se usan para cultivar flores, arbustos e incluso árboles pequeños. El jardín mediterráneo suele estar ubicado en un relieve complejo de colinas, con terrazas y muros de contención. Los protagonistas de estos jardines son los bancos pintados de blanco, las áreas decoradas con mosaicos, las terrazas de piedra y las escaleras anchas, siendo el patio el centro de este espacio.', 'IEJ', 'Jardín Mediterráneo.jpg'),
(5, 'Jardín Japonés', 'Los jardines orientales tradicionales estaban destinados para la meditación y la contemplación. Un jardín japonés se ve natural y armonioso, porque no cuenta con elementos artificiales y tampoco se centra en la simetría.  En el jardín japonés a menudo se recortan los árboles en forma de una sombrilla. Con frecuencia estos se colocan detrás de paredes o rocas grandes y pueden estar asociados con un refugio.', 'J', 'Jardín Japonés.jpg'),
(6, 'Jardín Moderno', 'El estilo moderno es famoso por su sofisticación, elegancia y lujo. Las plantas se agrupan, entonces, un arbusto exótico, un árbol de hojas de colores, bayas brillantes o un tronco delicado, se vuelve el punto central de la composición. Este estilo se caracteriza por el uso de materiales modernos, la colocación de macetas asimétricas con flores y la abundancia de colores y texturas de contraste.', 'J', 'Jardín Moderno.webp'),
(7, 'Jardín Ecológico', 'La idea de un jardín ecológico es preservar la naturalidad del paisaje sin alterarlo mucho. La flora característica de la zona sirve como base en este caso. Los atributos del estilo ecológico son muebles simples hechos de madera, enredaderas, fogatas y cabañas. La decoración del jardín es discreta: linternas suspendidas en árboles, pajareras y artesanías de enredaderas.', 'J', 'Jardín Ecológico.jpg'),
(8, 'Jardín Árabe', 'El jardín árabe clásico suele ser un pequeño patio cerrado a miradas del exterior. Cada detalle del jardín impresiona con su brillo y variedad. En el centro hay una piscina o una fuente bordeada de mosaicos coloridos; es un huerto lleno de aromas dulces y un rincón sombreado, donde puedes refugiarte del calor del mediodía.', 'J', 'Jardín Árabe.jpg'),
(9, 'Jardín Comestible', 'Combina varios tipos de plantas que se pueden comer. Casi todas las verduras o frutas pueden convertirse en un punto focal del diseño, junto con las plantas del jardín. Por ejemplo, un repollo morado destaca entre los narcisos de colores brillantes, mientras que diferentes tipos de lechugas crean diversas composiciones gracias a sus texturas y tonalidades. El tema central de este estilo es la belleza de las plantas comestibles durante el florecimiento y en la etapa de maduración.', 'J', 'Jardín Comestible.jpg'),
(10, 'Jardín Sobre el Techo', 'Los “techos verdes” son azoteas que se cubren de tierra en lugar de materiales tradicionales, como hormigón o tejas, con el fin de cultivar plantas. En las ciudades grandes, que sufren de grave contaminación del aire, es una medida con un impacto positivo en el desarrollo sostenible. Es difícil organizar técnicamente este tipo de jardines: se debe minimizar el peso hasta donde sea posible. Se usan contenedores de plástico o fibra de vidrio en lugar de contenedores de tierra, y en vez de usar tierra de jardín es preferible utilizar tierra liviana para macetas.', 'J', 'Jardín Sobre el Techo.jpg'),
(11, 'Jardín Francés', 'Estos jardines se basan en la geometría. Cada elemento se encuentra situado en armonía con el resto para dar sensación de amplitud. Al igual que el jardín Inglés, el agua y los setos son elementos fundamentales y, además, cuentan con una zona elevada que permite observar el paisaje con detalle.', 'J', 'Jardín Francés.avif'),
(12, 'Jardín Feng Shui o Zen', 'Este tipo de jardines, también conocidos como jardines zen, buscan un equilibrio entre los edificios y el paisaje. Es por ello que todos los elementos del jardín deben estar colocados en la dirección y espacio correctos. Además, se busca que cada elemento se encuentre en armonía con el resto para conseguir un espacio de reflexión y meditación.', 'J', 'Jardín Feng Shui o Zen.avif'),
(13, 'Jardín Vertical', 'Con el fin de proporcionar un espacio verde en las ciudades, los jardines verticales se suelen utilizar en la arquitectura sostenible. Si bien necesitan de los mismos cuidados que los jardines convencionales, son mucho más versátiles a la hora de ser colocados. Para este tipo de jardín se recomiendan las plantas crasas y las aromáticas.', 'J', 'Jardín Vertical.avif'),
(14, 'Jardín de Secano o Xerófilo', 'Están compuestos en su totalidad por plantas capaces de adaptarse a condiciones de bajo riego que solo necesitan el aporte del agua proveniente de la lluvia. Al igual que el jardín mediterráneo, es común encontrar en ellos plantas desérticas y árboles con copas grandes o globosas. Por ejemplo, las suculentas.', 'J', 'Jardín de Secano o Xerófilo.avif'),
(15, 'Jardín Tropical', 'Se recomienda diseñar estos jardines en zonas preferentemente húmedas y de temperaturas estables. Asimismo, se diferencian de otros jardines por proporcionar zonas densas de vegetación, con plantas coloridas y de hojas grandes que se encuentran de forma desordenada, generando una sensación de naturaleza salvaje.', 'J', 'Jardín Tropical.avif'),
(16, ' Jardín Acuático', 'Estos jardines se crean en torno a un estanque, lo cual no significa que solo podamos utilizar plantas acuáticas. Por lo general, se busca crear un pequeño ecosistema acuático, en el cual también se pueden incluir animales como peces, pequeños reptiles y anfibios. ', 'J', 'Jardín Acuático.avif');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int NOT NULL,
  `nombre` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `correo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `clave` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `fechareg` datetime NOT NULL,
  `perfil` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL DEFAULT 'U'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `correo`, `clave`, `fechareg`, `perfil`) VALUES
(1, 'Rembrandt Admin', 'rembrandtmauricio18@gmail.com', 'scrypt:32768:8:1$bvFXt1vzhM4WMYG2$6f0e789dc2c05eacf2ac9d48638ed1463163948bee844a9aeab517915de118140c162250c1ec5a48eb94c6099eeb87b797b0dcc3d6b160da89e1c15499581d03', '2025-02-13 11:54:19', 'A'),
(2, 'Rembrandt', 'rembrandt.mauricio1762@alumnos.udg.mx', 'scrypt:32768:8:1$JmSJy23n34WvTazb$53bb52a8e0d334257e7429a621ed544e606b859636c0a699a984b8bf70fd3a1563f2c653de687380ad2949cd16e18571b1e5fae87f4dab20fda0f7837d8e6588', '2025-02-13 13:09:18', 'U');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `idventas` int NOT NULL,
  `proyecto_id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `fecha` datetime NOT NULL,
  `precio` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asesorias`
--
ALTER TABLE `asesorias`
  ADD PRIMARY KEY (`idasesorias`),
  ADD KEY `proyecto_id` (`proyecto_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  ADD PRIMARY KEY (`idproyectos`);

--
-- Indices de la tabla `proyectosext`
--
ALTER TABLE `proyectosext`
  ADD PRIMARY KEY (`idproyectosext`);

--
-- Indices de la tabla `proyectosjar`
--
ALTER TABLE `proyectosjar`
  ADD PRIMARY KEY (`idproyectosjar`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`idventas`),
  ADD KEY `proyecto_id` (`proyecto_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asesorias`
--
ALTER TABLE `asesorias`
  MODIFY `idasesorias` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  MODIFY `idproyectos` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `proyectosext`
--
ALTER TABLE `proyectosext`
  MODIFY `idproyectosext` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `proyectosjar`
--
ALTER TABLE `proyectosjar`
  MODIFY `idproyectosjar` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `idventas` int NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asesorias`
--
ALTER TABLE `asesorias`
  ADD CONSTRAINT `asesorias_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `asesorias_ibfk_2` FOREIGN KEY (`proyecto_id`) REFERENCES `proyectos` (`idproyectos`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`proyecto_id`) REFERENCES `proyectos` (`idproyectos`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
