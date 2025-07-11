-- Active: 1751455831511@@127.0.0.1@3307@examen

-- 1 Mostrar los empleados junto al país donde laboran.

SELECT
    e.nombre AS Nombre_empleado,
    p.nombre AS pais_laburando

FROM empleados e
JOIN sucursal s ON e.sucursalid = s.id
JOIN municipio m ON s.municipioid = m.id
JOIN departamento d ON m.depid = d.id
JOIN pais p ON d.paisid = p.id;

-- 2. Listar el nombre de cada cliente con su municipio, departamento y país.
SELECT 
  c.nombre AS nombre_cliente,
  m.nombre AS nombre_municipio,
  d.nombre AS nombre_departamento,
  p.nombre AS nombre_pais
FROM 
  clientes c
  LEFT JOIN municipio m ON c.municipioid = m.id
  LEFT JOIN departamento d ON m.depid = d.id
  LEFT JOIN pais p ON d.paisid = p.id;


-- 3 Obtener los nombres de los empleados cuyo puesto existe en más de una sucursal.

SELECT 
  e.nombre,
  e.puesto
FROM 
  empleados e
WHERE 
  e.puesto IN (
    SELECT 
      puesto
    FROM 
      empleados
    GROUP BY 
      puesto
  );

-- 4 Mostrar el total de empleados por municipio y el nombre del departamento al que pertenecen.

SELECT 
  m.nombre AS municipio,
  d.nombre AS departamento,
  COUNT(e.empleado_id) AS total_empleados
FROM 
  empleados e
  JOIN sucursal s ON e.sucursalid = s.id
  JOIN municipio m ON s.municipioid = m.id
  JOIN departamento d ON m.depid = d.id
GROUP BY 
  m.id, m.nombre, d.nombre
ORDER BY 
  d.nombre, m.nombre;

-- 5 Mostrar todos los municipios con sucursales activas (que tengan al menos un empleado).
SELECT DISTINCT m.nombre AS municipio_nombre
FROM municipio m
JOIN sucursal s ON m.id = s.municipioid
JOIN empleados e ON s.id = e.sucursalid
WHERE e.empleado_id IS NOT NULL;
