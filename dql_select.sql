use finca_agricola_wbeimar;

-- 1. Mostrar todos los productos disponibles con su tipo, unidad y precio unitario
SELECT nombre, tipo_producto, unidad_medida, precio_unitario
FROM producto;

-- 2. Obtener los datos de contacto (nombre, teléfono, correo, dirección) de todos los proveedores registrados
SELECT nombre, telefono, correo, direccion
FROM proveedor;

-- 3. Listar todos los empleados que están en estado 'Activo'
SELECT id_empleado, nombre, cargo, fecha_contratacion, salario
FROM empleado
WHERE estado = 'Activo';

-- 4. Mostrar todas las ventas realizadas incluyendo el nombre del cliente, total y fecha
SELECT v.id_venta, c.nombre AS cliente, v.total, v.fecha_venta
FROM venta v
JOIN cliente c ON v.id_cliente = c.id_cliente;

-- 5. Consultar el inventario actual de todos los productos registrados
SELECT p.nombre, i.cantidad_actual, i.fecha_ultima_actualizacion
FROM inventario i
JOIN producto p ON i.id_producto = p.id_producto;

-- 6. Mostrar todas las compras realizadas, con el nombre del proveedor, el total y la fecha
SELECT c.id_compra, p.nombre AS proveedor, c.total, c.fecha_compra
FROM compra c
JOIN proveedor p ON c.id_proveedor = p.id_proveedor;

-- 7. Ver las máquinas asignadas a un empleado específico (ejemplo: empleado con id 26)
SELECT m.id_maquinaria, m.nombre, m.tipo, m.estado
FROM maquinaria m
WHERE m.id_empleado = 26;

-- 8. Listar todas las actividades de maquinaria realizadas en un periodo de tiempo
SELECT a.id_actividad_maquinaria, m.nombre AS maquinaria, a.tipo_actividad, a.fecha_inicio, a.fecha_fin
FROM actividad_maquinaria a
JOIN maquinaria m ON a.id_maquinaria = m.id_maquinaria
WHERE a.fecha_inicio >= "2024-1-1" and a.fecha_fin <="2024-6-1" ;

-- 9. Consultar los mantenimientos realizados por un empleado específico (ejemplo: empleado con id 14)
SELECT mm.id_mantenimiento, m.nombre AS maquinaria, mm.fecha, mm.descripcion, mm.costo
FROM mantenimiento_maquinaria mm
JOIN maquinaria m ON mm.id_maquinaria = m.id_maquinaria
WHERE mm.id_empleado = 14;

-- 10. Ver la producción total acumulada por producto (nombre del producto y suma de la cantidad producida)
SELECT p.nombre, SUM(pr.cantidad_producida) AS total_producido
FROM produccion pr
JOIN producto p ON pr.id_producto = p.id_producto
GROUP BY p.nombre;

-- 10. Ver la producción total acumulada por producto (nombre del producto y suma de la cantidad producida)
SELECT p.nombre, SUM(pr.cantidad_producida) AS total_producido
FROM produccion pr
JOIN producto p ON pr.id_producto = p.id_producto
GROUP BY p.nombre;

-- 11. Obtener todas las ventas realizadas por un empleado
SELECT v.id_venta, c.nombre AS cliente, v.total, v.fecha_venta
FROM venta v
JOIN cliente c ON v.id_cliente = c.id_cliente
WHERE v.id_empleado = 21;

-- 12. Mostrar las compras gestionadas por un empleado
SELECT c.id_compra, p.nombre AS proveedor, c.total, c.fecha_compra
FROM compra c
JOIN proveedor p ON c.id_proveedor = p.id_proveedor
WHERE c.id_empleado = 8;

-- 13. Consultar los detalles de una venta especifica
SELECT dv.id_detalle, p.nombre AS producto, dv.cantidad, dv.precio_unitario, dv.subtotal
FROM detalle_venta dv
JOIN producto p ON dv.id_producto = p.id_producto
WHERE dv.id_venta = 6;

-- 14. Ver los detalles de una compra especifica
SELECT dc.id_detalle, p.nombre AS producto, dc.cantidad, dc.precio_unitario, dc.subtotal
FROM detalle_compra dc
JOIN producto p ON dc.id_producto = p.id_producto
WHERE dc.id_compra = 3;

-- 15. Mostrar los empleados que han realizado al menos un mantenimiento
SELECT DISTINCT e.id_empleado, e.nombre, e.cargo
FROM mantenimiento_maquinaria mm
JOIN empleado e ON mm.id_empleado = e.id_empleado;

-- 16. Listar las máquinas que han recibido mantenimiento en 2024
SELECT m.id_maquinaria, m.nombre, mm.fecha, mm.descripcion, mm.costo
FROM mantenimiento_maquinaria mm
JOIN maquinaria m ON mm.id_maquinaria = m.id_maquinaria
WHERE YEAR(mm.fecha) = 2024;

-- 17. Mostrar todas las actividades de una maquinaria especifica
SELECT tipo_actividad, descripcion_actividad, fecha_inicio, fecha_fin
FROM actividad_maquinaria
WHERE id_maquinaria = 13;

-- 18. Consultar la producción registrada en el mes de julio 2024
SELECT p.nombre AS producto, pr.cantidad_producida, pr.fecha
FROM produccion pr
JOIN producto p ON pr.id_producto = p.id_producto
WHERE pr.fecha BETWEEN '2024-07-01' AND '2024-07-31';

-- 19. Mostrar los cultivos activos cuya cosecha estimada es después del 1 de septiembre de 2024
SELECT cu.id_cultivo, p.nombre AS producto, cu.fecha_siembra, cu.fecha_cosecha_estimada
FROM cultivo cu
JOIN producto p ON cu.id_producto = p.id_producto
WHERE cu.fecha_cosecha_estimada > '2024-09-01';

-- 20. Ver el horario de un empleado especifico
SELECT fecha, hora_entrada, hora_salida
FROM asistencia_empleado
WHERE id_empleado = 13

-- 21. Obtener el total vendido por cada empleado
SELECT e.nombre AS empleado, SUM(v.total) AS total_vendido
FROM venta v
JOIN empleado e ON v.id_empleado = e.id_empleado
GROUP BY e.id_empleado, e.nombre;

-- 22. Obtener el total comprado por cada empleado
SELECT e.nombre AS empleado, SUM(c.total) AS total_comprado
FROM compra c
JOIN empleado e ON c.id_empleado = e.id_empleado
GROUP BY e.id_empleado, e.nombre;

-- 23. Listar los 5 productos con mayor cantidad actual en inventario
SELECT p.nombre, i.cantidad_actual
FROM inventario i
JOIN producto p ON i.id_producto = p.id_producto
ORDER BY i.cantidad_actual DESC
LIMIT 5;

-- 24. Ver los productos con producción total mayor a 1000 unidades
SELECT p.nombre, SUM(pr.cantidad_producida) AS total_producida
FROM produccion pr
JOIN producto p ON pr.id_producto = p.id_producto
GROUP BY p.nombre
HAVING total_producida > 1000;

-- 25. Consultar los clientes que han realizado más de 2 compras
SELECT c.id_cliente, c.nombre, COUNT(v.id_venta) AS cantidad_ventas
FROM venta v
JOIN cliente c ON v.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombre
HAVING cantidad_ventas > 2;

-- 26. Ver todas las compras realizadas entre abril y junio de 2024
SELECT c.id_compra, p.nombre AS proveedor, c.total, c.fecha_compra
FROM compra c
JOIN proveedor p ON c.id_proveedor = p.id_proveedor
WHERE c.fecha_compra BETWEEN '2024-04-01' AND '2024-06-30';

-- 27. Mostrar el promedio de productos distintos vendidos por venta
SELECT AVG(productos_distintos) AS promedio_productos_por_venta
FROM (
    SELECT COUNT(DISTINCT id_producto) AS productos_distintos
    FROM detalle_venta
    GROUP BY id_venta
) AS sub;

-- 28. Ver el producto más vendido por cantidad total
SELECT p.nombre, SUM(dv.cantidad) AS cantidad_total
FROM detalle_venta dv
JOIN producto p ON dv.id_producto = p.id_producto
GROUP BY p.id_producto, p.nombre
ORDER BY cantidad_total DESC
LIMIT 1;

-- 29. Mostrar la última fecha de mantenimiento realizada para cada maquinaria
SELECT m.id_maquinaria, m.nombre, MAX(mm.fecha) AS ultima_fecha_mantenimiento
FROM mantenimiento_maquinaria mm
JOIN maquinaria m ON mm.id_maquinaria = m.id_maquinaria
GROUP BY m.id_maquinaria, m.nombre;

-- 30. Listar los productos que nunca se han vendido
SELECT p.nombre
FROM producto p
WHERE p.id_producto NOT IN (
    SELECT DISTINCT id_producto FROM detalle_venta
);

-- 31. Mostrar las maquinarias actualmente asignadas a algún empleado
SELECT m.id_maquinaria, m.nombre, e.nombre AS empleado
FROM maquinaria m
JOIN empleado e ON m.id_empleado = e.id_empleado
WHERE m.id_empleado IS NOT NULL;

-- 32. Listar todos los mantenimientos realizados en julio de 2024
SELECT mm.id_mantenimiento, m.nombre AS maquinaria, e.nombre AS empleado, mm.fecha, mm.descripcion, mm.costo
FROM mantenimiento_maquinaria mm
JOIN maquinaria m ON mm.id_maquinaria = m.id_maquinaria
JOIN empleado e ON mm.id_empleado = e.id_empleado
WHERE mm.fecha BETWEEN '2024-07-01' AND '2024-07-31';

-- 33. Ver los empleados que han asistido más de 3 días diferentes
SELECT e.id_empleado, e.nombre, COUNT(DISTINCT a.fecha) AS dias_asistidos
FROM asistencia_empleado a
JOIN empleado e ON a.id_empleado = e.id_empleado
GROUP BY e.id_empleado, e.nombre
HAVING dias_asistidos > 3;

-- 34. Mostrar los productos que tienen más de 1000 unidades producidas en total
SELECT p.nombre, SUM(pr.cantidad_producida) AS total_produccion
FROM produccion pr
JOIN producto p ON pr.id_producto = p.id_producto
GROUP BY p.id_producto, p.nombre
HAVING total_produccion > 1000;

-- 35. Consultar las 5 últimas ventas realizadas
SELECT v.id_venta, c.nombre AS cliente, e.nombre AS empleado, v.fecha_venta, v.total
FROM venta v
JOIN cliente c ON v.id_cliente = c.id_cliente
JOIN empleado e ON v.id_empleado = e.id_empleado
ORDER BY v.fecha_venta DESC
LIMIT 5;

-- 36. Listar las maquinarias en estado "En reparación"
SELECT id_maquinaria, nombre, tipo, estado
FROM maquinaria
WHERE estado = 'En reparación';

-- 37. Ver los productos que más se han comprado (por cantidad total)
SELECT p.nombre, SUM(dc.cantidad) AS total_comprado
FROM detalle_compra dc
JOIN producto p ON dc.id_producto = p.id_producto
GROUP BY p.id_producto, p.nombre
ORDER BY total_comprado DESC
LIMIT 5;

-- 38. Obtener el número de ventas por mes en 2024
SELECT MONTH(fecha_venta) AS mes, COUNT(*) AS cantidad_ventas
FROM venta
WHERE YEAR(fecha_venta) = 2024
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- 39. Ver los productos que han sido cultivados al menos una vez
SELECT DISTINCT p.nombre
FROM cultivo c
JOIN producto p ON c.id_producto = p.id_producto;

-- 40. Mostrar empleados que tengan salario mayor al promedio general
SELECT id_empleado, nombre, salario
FROM empleado
WHERE salario > (SELECT AVG(salario) FROM empleado);

-- 41. Mostrar los empleados que han realizado al menos 2 mantenimientos de maquinaria diferentes
SELECT e.id_empleado, e.nombre, COUNT(DISTINCT mm.id_maquinaria) AS mantenimientos_realizados
FROM mantenimiento_maquinaria mm
JOIN empleado e ON mm.id_empleado = e.id_empleado
GROUP BY e.id_empleado, e.nombre
HAVING mantenimientos_realizados >= 2;

-- 42. Listar los productos con más diferencias entre lo producido y lo que hay en inventario
SELECT 
    p.nombre,
    COALESCE(SUM(pr.cantidad_producida), 0) AS total_producido,
    COALESCE(i.cantidad_actual, 0) AS en_inventario,
    ABS(COALESCE(SUM(pr.cantidad_producida), 0) - COALESCE(i.cantidad_actual, 0)) AS diferencia
FROM producto p
LEFT JOIN produccion pr ON p.id_producto = pr.id_producto
LEFT JOIN inventario i ON p.id_producto = i.id_producto
GROUP BY p.id_producto, p.nombre, i.cantidad_actual
ORDER BY diferencia DESC
LIMIT 5;

-- 43. Obtener el porcentaje de productos vendidos respecto al total producido
SELECT 
    p.nombre,
    COALESCE(SUM(dv.cantidad), 0) AS vendidos,
    COALESCE(SUM(pr.cantidad_producida), 0) AS producidos,
    ROUND(
        (COALESCE(SUM(dv.cantidad), 0) / NULLIF(SUM(pr.cantidad_producida), 0)) * 100,
        2
    ) AS porcentaje_vendido
FROM producto p
LEFT JOIN detalle_venta dv ON p.id_producto = dv.id_producto
LEFT JOIN produccion pr ON p.id_producto = pr.id_producto
GROUP BY p.id_producto, p.nombre
HAVING producidos > 0;

-- 44. Mostrar los 3 empleados con más ventas realizadas (por número de facturas)
SELECT e.id_empleado, e.nombre, COUNT(v.id_venta) AS ventas_realizadas
FROM venta v
JOIN empleado e ON v.id_empleado = e.id_empleado
GROUP BY e.id_empleado, e.nombre
ORDER BY ventas_realizadas DESC
LIMIT 3;

-- 45. Listar los productos más rentables (precio_unitario * cantidad vendida)
SELECT 
    p.nombre,
    SUM(dv.cantidad * dv.precio_unitario) AS ingresos_totales
FROM detalle_venta dv
JOIN producto p ON dv.id_producto = p.id_producto
GROUP BY p.id_producto, p.nombre
ORDER BY ingresos_totales DESC
LIMIT 5;

-- 46. Ver ventas donde el total no coincide con la suma de los subtotales en detalle_venta
SELECT v.id_venta, v.total, SUM(dv.subtotal) AS suma_detalle
FROM venta v
JOIN detalle_venta dv ON v.id_venta = dv.id_venta
GROUP BY v.id_venta, v.total
HAVING ROUND(v.total, 2) <> ROUND(SUM(dv.subtotal), 2);

-- 47. Calcular el tiempo promedio de actividad por tipo de maquinaria
SELECT 
    m.tipo,
    ROUND(AVG(DATEDIFF(am.fecha_fin, am.fecha_inicio)), 2) AS promedio_dias_actividad
FROM actividad_maquinaria am
JOIN maquinaria m ON am.id_maquinaria = m.id_maquinaria
GROUP BY m.tipo;

-- 48. Mostrar el inventario promedio por tipo de producto
SELECT 
    p.tipo_producto,
    ROUND(AVG(i.cantidad_actual), 2) AS inventario_promedio
FROM inventario i
JOIN producto p ON i.id_producto = p.id_producto
GROUP BY p.tipo_producto;

-- 49. Obtener las fechas donde hubo más de 5 ventas
SELECT fecha_venta, COUNT(*) AS total_ventas
FROM venta
GROUP BY fecha_venta
HAVING total_ventas > 5;

-- 50. Ver los empleados que han trabajado en más de un rol (basado en sus actividades y mantenimientos)
SELECT e.id_empleado, e.nombre, COUNT(DISTINCT actividad) AS roles_distintos
FROM (
    SELECT id_empleado, 'vendedor' AS actividad FROM venta
    UNION ALL
    SELECT id_empleado, 'comprador' AS actividad FROM compra
    UNION ALL
    SELECT id_empleado, 'mantenimiento' AS actividad FROM mantenimiento_maquinaria
    UNION ALL
    SELECT id_empleado, 'operario' AS actividad FROM maquinaria WHERE id_empleado IS NOT NULL
) AS actividades
JOIN empleado e ON actividades.id_empleado = e.id_empleado
GROUP BY e.id_empleado, e.nombre
HAVING roles_distintos > 1;