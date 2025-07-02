-- Active: 1751455831511@@127.0.0.1@3307@examen

-- Mostrar los empleados junto al país donde laboran.

SELECT
    e.nombre AS Nombre_empleado,
    p.nombre AS pais_laburando

FROM empleados e
JOIN sucursal s ON e.sucursalid = s.id
JOIN municipio m ON s.municipioid = m.id
JOIN departamento d ON m.depid = d.id
JOIN pais p ON d.paisid = p.id;

-- 2. Listar el nombre de cada cliente con su municipio, departamento y país.
