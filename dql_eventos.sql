-- Inserta una marca con NULL en horas para los que no tienen asistencia ese día
CREATE EVENT registrar_asistencia_faltante
ON SCHEDULE EVERY 1 DAY
DO
INSERT INTO asistencia_empleado (id_empleado, fecha, hora_entrada, hora_salida)
SELECT id_empleado, CURDATE(), NULL, NULL
FROM empleado
WHERE id_empleado NOT IN (
    SELECT id_empleado FROM asistencia_empleado WHERE fecha = CURDATE()
);

-- eliminar asistencias con horas incompletas mayores a 7 días
CREATE EVENT limpiar_asistencias_incompletas
ON SCHEDULE EVERY 1 WEEK
DO
DELETE FROM asistencia_empleado
WHERE (hora_entrada IS NULL OR hora_salida IS NULL)
AND fecha < CURDATE() - INTERVAL 7 DAY;

-- marcar maquinaria sin actividad reciente como 'Inactiva'
CREATE EVENT actualizar_estado_maquinaria_inactiva
ON SCHEDULE EVERY 1 MONTH
DO
UPDATE maquinaria
SET estado = 'Inactiva'
WHERE id_maquinaria NOT IN (
    SELECT id_maquinaria
    FROM actividad_maquinaria
    WHERE fecha_fin >= CURDATE() - INTERVAL 30 DAY
);

-- verificar maquinaria en mantenimiento por más de 15 días 
CREATE EVENT verificar_mantenimientos_largos
ON SCHEDULE EVERY 1 DAY
DO
UPDATE maquinaria
SET estado = 'Revisión prolongada'
WHERE id_maquinaria IN (
    SELECT id_maquinaria
    FROM mantenimiento_maquinaria
    WHERE fecha <= CURDATE() - INTERVAL 15 DAY
);

-- Eliminar ventas sin detalles pasadas más de 2 días
CREATE EVENT limpiar_ventas_incompletas
ON SCHEDULE EVERY 1 DAY
DO
  DELETE FROM venta
  WHERE id_venta NOT IN (SELECT id_venta FROM detalle_venta)
    AND fecha_venta < CURDATE() - INTERVAL 2 DAY;