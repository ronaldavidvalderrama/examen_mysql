
CREATE TABLE `clientes` (
  `cliente_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL UNIQUE,
  `telefono` varchar(15) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `municipioid` int DEFAULT NULL,
  PRIMARY KEY (`cliente_id`),
  FOREIGN KEY (`municipioid`) REFERENCES `municipio` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `departamento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `paisid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`paisid`) REFERENCES `pais` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `detalles_pedidos` (
  `detalle_id` int NOT NULL AUTO_INCREMENT,
  `pedido_id` int DEFAULT NULL,
  `producto_id` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  `sucid` int DEFAULT NULL,
  PRIMARY KEY (`detalle_id`),
  FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`pedido_id`),
  FOREIGN KEY (`producto_id`, `sucid`) REFERENCES `producto_suc` (`productoid`, `sucursalid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `empleados` (
  `empleado_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) DEFAULT NULL,
  `puesto` varchar(50) DEFAULT NULL,
  `fecha_contratacion` date DEFAULT NULL,
  `salario` decimal(10,2) DEFAULT NULL,
  `sucursalid` int DEFAULT NULL,
  PRIMARY KEY (`empleado_id`),
  FOREIGN KEY (`sucursalid`) REFERENCES `sucursal` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `empresa` (
  `id` varchar(20) NOT NULL,
  `nombre` varchar(80) NOT NULL UNIQUE,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `municipio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) DEFAULT NULL,
  `depid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`depid`) REFERENCES `departamento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL UNIQUE,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pedidos` (
  `pedido_id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int DEFAULT NULL,
  `empleado_id` int DEFAULT NULL,
  `fecha_pedido` date DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`pedido_id`),
  FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`cliente_id`),
  FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`empleado_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `productos` (
  `producto_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) DEFAULT NULL,
  `categoria` varchar(80) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `stock` int DEFAULT NULL,
  PRIMARY KEY (`producto_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `producto_suc` (
  `productoid` int NOT NULL,
  `sucursalid` int NOT NULL,
  PRIMARY KEY (`productoid`,`sucursalid`),
  FOREIGN KEY (`productoid`) REFERENCES `productos` (`producto_id`),
  FOREIGN KEY (`sucursalid`) REFERENCES `sucursal` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sucursal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `direccion` varchar(80) DEFAULT NULL,
  `empresaid` varchar(20) DEFAULT NULL,
  `municipioid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`empresaid`) REFERENCES `empresa` (`id`),
  FOREIGN KEY (`municipioid`) REFERENCES `municipio` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

