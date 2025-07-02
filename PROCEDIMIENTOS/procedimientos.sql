-- Active: 1751455831511@@127.0.0.1@3307@examen

-- Procedimientos de alamacenado
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


-- 2. Cree un procedimiento por nombre `ps_obtener_clientes_por_municipio` donde liste todos los clientes de un municipio .

DELIMITER $$
CREATE PROCEDURE `ps_obtener_clientes_por_municipio`(
    IN municipio_nombre VARCHAR(80)
)
BEGIN
    SELECT * FROM clientes WHERE municipioid = (SELECT id FROM municipio WHERE nombre = municipio_nombre);
END$$
DELIMITER ;

CALL ps_obtener_clientes_por_municipio('Cali');

-- 3. Cree un procedimiento por nombre  `ps_listar_empleados_por_sucursal` donde muestre todos los empleados de una sucursal .

DELIMITER $$
CREATE PROCEDURE `ps_listar_empleados_por_sucursal`(
    IN sucursal_nombre VARCHAR(80)
)
BEGIN
    SELECT * FROM empleados WHERE sucursalid = (SELECT id FROM sucursal WHERE nombre = sucursal_nombre);
END$$
DELIMITER ;

CALL ps_listar_empleados_por_sucursal('Sucursal Zona 3');
