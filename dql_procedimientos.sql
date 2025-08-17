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
