-- Active: 1743685642141@@127.0.0.1@3306@sakilacampus
--1
SELECT id_cliente, COUNT(*) AS cantidad_alquileres
FROM alquiler
WHERE fecha_alquiler >= CURDATE() - INTERVAL 6 MONTH
GROUP BY id_cliente
ORDER BY cantidad_alquileres DESC
LIMIT 1;

SELECT p.id_pelicula, p.titulo, COUNT(*) AS cantidad_alquileres
FROM alquiler a
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula p ON i.id_pelicula = p.id_pelicula
WHERE a.fecha_alquiler >= CURDATE() - INTERVAL 1 YEAR
GROUP BY p.id_pelicula
ORDER BY cantidad_alquileres DESC
LIMIT 5;

SELECT c.nombre AS categoria, SUM(pago.total) AS ingresos_totales, COUNT(*) AS cantidad_alquileres
FROM alquiler a
JOIN pago ON a.id_alquiler = pago.id_alquiler
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula_categoria pc ON i.id_pelicula = pc.id_pelicula
JOIN categoria c ON pc.id_categoria = c.id_categoria
GROUP BY c.id_categoria;

SELECT i.nombre AS idioma, COUNT(DISTINCT a.id_cliente) AS total_clientes
FROM alquiler a
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula p ON i.id_pelicula = p.id_pelicula
JOIN idioma i ON p.id_idioma = i.id_idioma
WHERE MONTH(a.fecha_alquiler) = 4 AND YEAR(a.fecha_alquiler) = 2025 
GROUP BY i.id_idioma;

SELECT a.id_cliente
FROM alquiler a
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula p ON i.id_pelicula = p.id_pelicula
JOIN pelicula_categoria pc ON p.id_pelicula = pc.id_pelicula
GROUP BY a.id_cliente, pc.id_categoria
HAVING COUNT(DISTINCT p.id_pelicula) = (SELECT COUNT(*) FROM pelicula_categoria WHERE id_categoria = pc.id_categoria);

SELECT ci.nombre AS ciudad, COUNT(*) AS clientes_activos
FROM cliente c
JOIN direccion d ON c.id_direccion = d.id_direccion
JOIN ciudad ci ON d.id_ciudad = ci.id_ciudad
WHERE c.activo = 1 AND c.fecha_creacion >= CURDATE() - INTERVAL 3 MONTH
GROUP BY ci.id_ciudad
ORDER BY clientes_activos DESC
LIMIT 3;

SELECT c.nombre AS categoria, COUNT(*) AS cantidad_alquileres
FROM alquiler a
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula_categoria pc ON i.id_pelicula = pc.id_pelicula
JOIN categoria c ON pc.id_categoria = c.id_categoria
WHERE a.fecha_alquiler >= CURDATE() - INTERVAL 1 YEAR
GROUP BY c.id_categoria
ORDER BY cantidad_alquileres ASC
LIMIT 5;

SELECT a.id_cliente, AVG(DATEDIFF(a.fecha_devolucion, a.fecha_alquiler)) AS promedio_dias
FROM alquiler a
GROUP BY a.id_cliente;

SELECT e.id_empleado, COUNT(*) AS cantidad_alquileres
FROM alquiler a
JOIN empleado e ON a.id_empleado = e.id_empleado
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula_categoria pc ON i.id_pelicula = pc.id_pelicula
JOIN categoria c ON pc.id_categoria = c.id_categoria
WHERE c.nombre = 'Acción'
GROUP BY e.id_empleado
ORDER BY cantidad_alquileres DESC
LIMIT 5;

SELECT id_cliente, COUNT(*) AS cantidad_alquileres
FROM alquiler
GROUP BY id_cliente
ORDER BY cantidad_alquileres DESC;

SELECT i.nombre AS idioma, AVG(pago.total) AS costo_promedio
FROM alquiler a
JOIN pago ON a.id_alquiler = pago.id_alquiler
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula p ON i.id_pelicula = p.id_pelicula
JOIN idioma i ON p.id_idioma = i.id_idioma
GROUP BY i.id_idioma;


--14
SELECT p.id_pelicula, p.titulo, p.duracion, COUNT(*) AS cantidad_alquileres
FROM alquiler a
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula p ON i.id_pelicula = p.id_pelicula
WHERE a.fecha_alquiler >= CURDATE() - INTERVAL 1 YEAR
GROUP BY p.id_pelicula
ORDER BY p.duracion DESC
LIMIT 5;

--15
SELECT c.id_cliente, COUNT(*) AS cantidad_alquileres
FROM alquiler a
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula p ON i.id_pelicula = p.id_pelicula
JOIN pelicula_categoria pc ON p.id_pelicula = pc.id_pelicula
JOIN categoria c ON pc.id_categoria = c.id_categoria
WHERE c.nombre = 'Comedia'
GROUP BY c.id_cliente
ORDER BY cantidad_alquileres DESC;


--16
SELECT a.id_cliente, SUM(DATEDIFF(a.fecha_devolucion, a.fecha_alquiler)) AS total_dias
FROM alquiler a
WHERE a.fecha_alquiler >= CURDATE() - INTERVAL 1 MONTH
GROUP BY a.id_cliente;

--17
SELECT a.id_almacen, COUNT(*) AS alquileres_diarios
FROM alquiler a
WHERE a.fecha_alquiler >= CURDATE() - INTERVAL 3 MONTH
GROUP BY a.id_almacen, DATE(a.fecha_alquiler)
ORDER BY alquileres_diarios DESC;

--18
SELECT a.id_almacen, SUM(pago.total) AS ingresos_totales
FROM alquiler al
JOIN pago p ON al.id_alquiler = p.id_alquiler
WHERE al.fecha_alquiler >= CURDATE() - INTERVAL 6 MONTH
GROUP BY a.id_almacen;

--17
SELECT id_cliente, MAX(pago.total) AS alquiler_mas_caro
FROM pago
WHERE fecha_pago >= CURDATE() - INTERVAL 1 YEAR
GROUP BY id_cliente
ORDER BY alquiler_mas_caro DESC
LIMIT 1;

--18
SELECT c.nombre AS categoria, SUM(pago.total) AS ingresos_totales
FROM alquiler a
JOIN pago ON a.id_alquiler = pago.id_alquiler
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula_categoria pc ON i.id_pelicula = pc.id_pelicula
JOIN categoria c ON pc.id_categoria = c.id_categoria
WHERE a.fecha_alquiler >= CURDATE() - INTERVAL 3 MONTH
GROUP BY c.id_categoria
ORDER BY ingresos_totales DESC
LIMIT 5;

--19
SELECT i.nombre AS idioma, COUNT(*) AS cantidad_peliculas_alquiladas
FROM alquiler a
JOIN inventario i ON a.id_inventario = i.id_inventario
JOIN pelicula p ON i.id_pelicula = p.id_pelicula
WHERE a.fecha_alquiler >= CURDATE() - INTERVAL 1 MONTH
GROUP BY i.id_idioma;

--20
SELECT c.id_cliente, c.nombre, c.apellido
FROM cliente c
LEFT JOIN alquiler a ON c.id_cliente = a.id_cliente AND a.fecha_alquiler >= CURDATE() - INTERVAL 1 YEAR
WHERE a.id_cliente IS NULL;
