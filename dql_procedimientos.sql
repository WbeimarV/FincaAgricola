use finca_agricola_wbeimar;

-- Procedimiento para registrar un nuevo proveedor
DELIMITER $$
CREATE PROCEDURE registrar_proveedor (
    IN p_nombre VARCHAR(100),
    IN p_telefono VARCHAR(20),
    IN p_correo VARCHAR(100),
    IN p_direccion VARCHAR(150),
    IN p_tipo_producto VARCHAR(50)
)
BEGIN
    INSERT INTO proveedor (nombre, telefono, correo, direccion, tipo_producto)
    VALUES (p_nombre, p_telefono, p_correo, p_direccion, p_tipo_producto);
END $$
DELIMITER ;

-- Procedimiento para registrar un nuevo empleado
DELIMITER $$
CREATE PROCEDURE registrar_empleado (
    IN p_nombre VARCHAR(100),
    IN p_cargo VARCHAR(50),
    IN p_fecha_contratacion DATE,
    IN p_salario DECIMAL(10,2),
    IN p_estado VARCHAR(20)
)
BEGIN
    INSERT INTO empleado (nombre, cargo, fecha_contratacion, salario, estado)
    VALUES (p_nombre, p_cargo, p_fecha_contratacion, p_salario, p_estado);
END $$
DELIMITER ;

-- Procedimiento para registrar una compra (sin detalles)
DELIMITER $$
CREATE PROCEDURE registrar_compra (
    IN p_id_proveedor INT,
    IN p_id_empleado INT,
    IN p_fecha DATE,
    IN p_total DECIMAL(10,2)
)
BEGIN
    INSERT INTO compra (id_proveedor, id_empleado, fecha_compra, total)
    VALUES (p_id_proveedor, p_id_empleado, p_fecha, p_total);
END $$
DELIMITER ;

-- Procedimiento para registrar una venta (sin detalles)
DELIMITER $$
CREATE PROCEDURE registrar_venta (
    IN p_id_cliente INT,
    IN p_id_empleado INT,
    IN p_fecha DATE,
    IN p_total DECIMAL(10,2)
)
BEGIN
    INSERT INTO venta (id_cliente, id_empleado, fecha_venta, total)
    VALUES (p_id_cliente, p_id_empleado, p_fecha, p_total);
END $$
DELIMITER ;

-- Procedimiento para actualizar el estado de una maquinaria
DELIMITER $$
CREATE PROCEDURE actualizar_estado_maquinaria (
    IN p_id_maquinaria INT,
    IN p_nuevo_estado VARCHAR(50)
)
BEGIN
    UPDATE maquinaria
    SET estado = p_nuevo_estado
    WHERE id_maquinaria = p_id_maquinaria;
END $$
DELIMITER ;

-- Registrar un nuevo producto
DELIMITER $$
CREATE PROCEDURE registrar_producto(
    IN p_nombre VARCHAR(100),
    IN p_tipo_producto VARCHAR(50),
    IN p_unidad_medida VARCHAR(20),
    IN p_precio_unitario DECIMAL(10,2)
)
BEGIN
    INSERT INTO producto (nombre, tipo_producto, unidad_medida, precio_unitario)
    VALUES (p_nombre, p_tipo_producto, p_unidad_medida, p_precio_unitario);
END$$
DELIMITER ;

-- Registrar un nuevo cliente
DELIMITER $$
CREATE PROCEDURE registrar_cliente(
    IN p_nombre VARCHAR(100),
    IN p_telefono VARCHAR(20),
    IN p_correo VARCHAR(100),
    IN p_direccion VARCHAR(150)
)
BEGIN
    INSERT INTO cliente (nombre, telefono, correo, direccion)
    VALUES (p_nombre, p_telefono, p_correo, p_direccion);
END$$
DELIMITER ;

-- Registrar un nuevo proveedor
DELIMITER $$
CREATE PROCEDURE registrar_proveedor(
    IN p_nombre VARCHAR(100),
    IN p_telefono VARCHAR(20),
    IN p_correo VARCHAR(100),
    IN p_direccion VARCHAR(150),
    IN p_tipo_producto VARCHAR(50)
)
BEGIN
    INSERT INTO proveedor (nombre, telefono, correo, direccion, tipo_producto)
    VALUES (p_nombre, p_telefono, p_correo, p_direccion, p_tipo_producto);
END$$
DELIMITER ;

-- Cambiar el estado de un empleado
DELIMITER $$
CREATE PROCEDURE actualizar_estado_empleado(
    IN p_id_empleado INT,
    IN p_nuevo_estado VARCHAR(20)
)
BEGIN
    UPDATE empleado
    SET estado = p_nuevo_estado
    WHERE id_empleado = p_id_empleado;
END$$
DELIMITER ;

-- Registrar asistencia
DELIMITER $$
CREATE PROCEDURE registrar_asistencia(
    IN p_id_empleado INT,
    IN p_fecha DATE,
    IN p_hora_entrada TIME,
    IN p_hora_salida TIME
)
BEGIN
    INSERT INTO asistencia_empleado (id_empleado, fecha, hora_entrada, hora_salida)
    VALUES (p_id_empleado, p_fecha, p_hora_entrada, p_hora_salida);
END$$
DELIMITER ;

-- Registrar cultivo
DELIMITER $$
CREATE PROCEDURE registrar_cultivo(
    IN p_id_producto INT,
    IN p_fecha_siembra DATE,
    IN p_fecha_cosecha_estimada DATE
)
BEGIN
    INSERT INTO cultivo (id_producto, fecha_siembra, fecha_cosecha_estimada)
    VALUES (p_id_producto, p_fecha_siembra, p_fecha_cosecha_estimada);
END$$
DELIMITER ;

-- Registrar producción
DELIMITER $$
CREATE PROCEDURE registrar_produccion(
    IN p_id_producto INT,
    IN p_cantidad DECIMAL(10,2),
    IN p_fecha DATE,
    IN p_observaciones TEXT
)
BEGIN
    INSERT INTO produccion (id_producto, cantidad_producida, fecha, observaciones)
    VALUES (p_id_producto, p_cantidad, p_fecha, p_observaciones);
END$$
DELIMITER ;

-- Registrar maquinaria
DELIMITER $$
CREATE PROCEDURE registrar_maquinaria(
    IN p_nombre VARCHAR(100),
    IN p_tipo VARCHAR(50),
    IN p_fecha_adquisicion DATE,
    IN p_estado VARCHAR(50),
    IN p_id_empleado INT,
    IN p_id_compra INT
)
BEGIN
    INSERT INTO maquinaria (nombre, tipo, fecha_adquisicion, estado, id_empleado, id_compra)
    VALUES (p_nombre, p_tipo, p_fecha_adquisicion, p_estado, p_id_empleado, p_id_compra);
END$$
DELIMITER ;

-- Registrar mantenimiento
DELIMITER $$
CREATE PROCEDURE registrar_mantenimiento(
    IN p_id_maquinaria INT,
    IN p_id_empleado INT,
    IN p_fecha DATE,
    IN p_descripcion TEXT,
    IN p_costo DECIMAL(10,2)
)
BEGIN
    INSERT INTO mantenimiento_maquinaria (id_maquinaria, id_empleado, fecha, descripcion, costo)
    VALUES (p_id_maquinaria, p_id_empleado, p_fecha, p_descripcion, p_costo);
END$$
DELIMITER ;

-- Registrar actividad de maquinaria
DELIMITER $$
CREATE PROCEDURE registrar_actividad_maquinaria(
    IN p_id_maquinaria INT,
    IN p_tipo_actividad VARCHAR(50),
    IN p_descripcion TEXT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    INSERT INTO actividad_maquinaria (id_maquinaria, tipo_actividad, descripcion_actividad, fecha_inicio, fecha_fin)
    VALUES (p_id_maquinaria, p_tipo_actividad, p_descripcion, p_fecha_inicio, p_fecha_fin);
END$$
DELIMITER ;

-- Eliminar una venta y sus detalles
DELIMITER $$
CREATE PROCEDURE eliminar_venta(
    IN p_id_venta INT
)
BEGIN
    DELETE FROM detalle_venta WHERE id_venta = p_id_venta;
    DELETE FROM venta WHERE id_venta = p_id_venta;
END$$
DELIMITER ;

-- Eliminar una compra y sus detalles
DELIMITER $$
CREATE PROCEDURE eliminar_compra(
    IN p_id_compra INT
)
BEGIN
    DELETE FROM detalle_compra WHERE id_compra = p_id_compra;
    DELETE FROM compra WHERE id_compra = p_id_compra;
END$$
DELIMITER ;

-- Actualizar inventario tras una producción
DELIMITER $$
CREATE PROCEDURE actualizar_inventario_produccion(
    IN p_id_producto INT,
    IN p_cantidad DECIMAL(10,2),
    IN p_fecha DATE
)
BEGIN
    UPDATE inventario
    SET cantidad_actual = cantidad_actual + p_cantidad,
        fecha_ultima_actualizacion = p_fecha
    WHERE id_producto = p_id_producto;
END$$
DELIMITER ;

-- Actualizar inventario tras una venta
DELIMITER $$
CREATE PROCEDURE actualizar_inventario_venta(
    IN p_id_producto INT,
    IN p_cantidad DECIMAL(10,2),
    IN p_fecha DATE
)
BEGIN
    UPDATE inventario
    SET cantidad_actual = cantidad_actual - p_cantidad,
        fecha_ultima_actualizacion = p_fecha
    WHERE id_producto = p_id_producto;
END$$
DELIMITER ;

-- Reasignar maquinaria a otro empleado
DELIMITER $$
CREATE PROCEDURE reasignar_maquinaria(
    IN p_id_maquinaria INT,
    IN p_nuevo_empleado INT
)
BEGIN
    UPDATE maquinaria
    SET id_empleado = p_nuevo_empleado
    WHERE id_maquinaria = p_id_maquinaria;
END$$

DELIMITER ;
