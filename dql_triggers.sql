use finca_agricola_wbeimar;

-- actualizar venta al registrar un detalle de venta
DELIMITER $$
CREATE TRIGGER actualizar_total_venta
AFTER INSERT ON detalle_venta
FOR EACH ROW
BEGIN
    UPDATE venta
    SET total = (
        SELECT SUM(subtotal)
        FROM detalle_venta
        WHERE id_venta = NEW.id_venta
    )
    WHERE id_venta = NEW.id_venta;
END$$
DELIMITER ;

-- Actualizar inventario al registrar un detalle de venta
DELIMITER $$
CREATE TRIGGER trg_disminuir_inventario_venta
AFTER INSERT ON detalle_venta
FOR EACH ROW
BEGIN
    UPDATE inventario
    SET cantidad_actual = cantidad_actual - NEW.cantidad,
        fecha_ultima_actualizacion = CURDATE()
    WHERE id_producto = NEW.id_producto;
END $$
DELIMITER ;

-- actualiza o inserta en inventario cuando hay producción
DELIMITER $$
CREATE TRIGGER actualizar_inventario_despues_produccion
AFTER INSERT ON produccion
FOR EACH ROW
BEGIN
    DECLARE existe INT DEFAULT 0;

    -- Verificar si ya existe el producto en inventario
    SELECT COUNT(*) INTO existe
    FROM inventario
    WHERE id_producto = NEW.id_producto;

    IF existe > 0 THEN
        -- Actualizar cantidad si ya existe
        UPDATE inventario
        SET cantidad_actual = cantidad_actual + NEW.cantidad_producida,
            fecha_ultima_actualizacion = CURDATE()
        WHERE id_producto = NEW.id_producto;
    ELSE
        -- Insertar nuevo registro si no existe
        INSERT INTO inventario (id_producto, cantidad_actual, fecha_ultima_actualizacion)
        VALUES (NEW.id_producto, NEW.cantidad_producida, CURDATE());
    END IF;
END;$$
DELIMITER ;

-- actualizar una compra al registrar un detalle de compra
DELIMITER $$
CREATE TRIGGER actualizar_total_compra
AFTER INSERT ON detalle_compra
FOR EACH ROW
BEGIN
    UPDATE compra
    SET total = (
        SELECT SUM(subtotal)
        FROM detalle_compra
        WHERE id_compra = NEW.id_compra
    )
    WHERE id_compra = NEW.id_compra;
END$$
DELIMITER ;

-- actualizar o insertar en inventario despues de registrar un detalle de compra
DELIMITER $$
CREATE TRIGGER actualizar_inventario_despues_compra
AFTER INSERT ON detalle_compra
FOR EACH ROW
BEGIN
    DECLARE existe INT DEFAULT 0;

    -- Verificar si ya existe el producto en inventario
    SELECT COUNT(*) INTO existe
    FROM inventario
    WHERE id_producto = NEW.id_producto;

    IF existe > 0 THEN
        -- Actualizar cantidad si ya existe
        UPDATE inventario
        SET cantidad_actual = cantidad_actual + NEW.cantidad,
            fecha_ultima_actualizacion = CURDATE()
        WHERE id_producto = NEW.id_producto;
    ELSE
        -- Insertar nuevo registro si no existe
        INSERT INTO inventario (id_producto, cantidad_actual, fecha_ultima_actualizacion)
        VALUES (NEW.id_producto, NEW.cantidad, CURDATE());
    END IF;
END;$$
DELIMITER ;