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