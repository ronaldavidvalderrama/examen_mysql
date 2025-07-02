# Examen MySQL II

En este Examen se te proporcionará el script SQL correspondiente a la estructura y datos de una base de datos transaccional. Tu tarea consistirá en validar su integridad, cargar correctamente los datos y desarrollar soluciones funcionales a partir de la información contenida. Sigue cuidadosamente los pasos a continuación y asegúrate de documentar cada parte mediante commits bien estructurados y haciendo uso de `Conventional Commit` en tu repositorio.

## **Objetivos**

1. Restaurar la base de datos desde los archivos proporcionados.
2. Verificar la estructura e integridad referencial de las tablas a partir del diagrama ER.
3. Insertar y validar los datos de prueba suministrados.
4. Realizar las consultas SQL planteadas.
5. Diseñar y codificar 5 procedimientos almacenados, 5 funciones, 5 triggers (disparadores) y 5 eventos.
6. Asegurar el control de versiones con un commit específico por cada ejercicio resuelto.

### Entrega 

- Repositorio con commits organizados por tema haciendo uso de `Conventional Commit`.
- Script completo con todas las creaciones (Creación de la DB, Insercción de datos, Selects, Procedimientos, Funciones, Disparadores y Eventos).
- Evidencias de ejecución (capturas u outputs de consola).
- Archivo README explicando la estructura y pruebas realizadas.

## Consultas con JOIN

1. Mostrar los empleados junto al país donde laboran.


```sql
SELECT
    e.nombre AS Nombre_empleado,
    p.nombre AS pais_laburando

FROM empleados e
JOIN sucursal s ON e.sucursalid = s.id
JOIN municipio m ON s.municipioid = m.id
JOIN departamento d ON m.depid = d.id
JOIN pais p ON d.paisid = p.id;
```

## procedimientos

```sql
-- 1. Cree un procedimiento llamado `ps_registrar_cliente_unico`  que inserta un
-- nuevo cliente si su correo no está registrado .

DELIMITER $$
CREATE PROCEDURE `ps_registrar_cliente_unico`(
    IN email VARCHAR(50),
    IN nombre VARCHAR(80),
    IN telefono VARCHAR(15),
    IN direccion VARCHAR(50),
    IN fecha_registro DATE,
    IN municipioid INT
)
BEGIN
    IF NOT EXISTS (SELECT * FROM clientes WHERE email = email) THEN
        INSERT INTO clientes (email, nombre, telefono, direccion, fecha_registro, municipioid) 
        VALUES (email, nombre, telefono, direccion, fecha_registro, municipioid);
    END IF;
END$$
DELIMITER ;

CALL ps_registrar_cliente_unico('Adrian Ruiz',
                                'adrian.ruiz@gmail.com',
                                '3123456789',
                                'Calle 123 #45-67',
                                '2025-02-01', 5);
```

## implementacion extra

Se implemento un archivo sql ejemplo visual para mejor visualizacion de la base de datos.


```sql


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

```