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

-- verificar stock para vender
DELIMITER $$
CREATE TRIGGER verificar_stock_antes_venta
BEFORE INSERT ON detalle_venta
FOR EACH ROW
BEGIN
    DECLARE existe INT DEFAULT 0;
    DECLARE stock_actual DECIMAL(10,2) DEFAULT 0;

    -- Verificar si el producto existe en inventario
    SELECT COUNT(*) INTO existe
    FROM inventario
    WHERE id_producto = NEW.id_producto;

    IF existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El producto no existe en el inventario.';
    ELSE
        -- Obtener la cantidad actual del inventario
        SELECT cantidad_actual INTO stock_actual
        FROM inventario
        WHERE id_producto = NEW.id_producto;

        -- Verificar si hay suficiente stock
        IF stock_actual < NEW.cantidad THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Inventario insuficiente para realizar la venta.';
        END IF;
    END IF;
END$$
DELIMITER ;

-- actualizar estado maquina cuando entra a mantenimiento
DELIMITER $$
CREATE TRIGGER actualizar_estado_maquinaria_por_mantenimiento
AFTER INSERT ON mantenimiento_maquinaria
FOR EACH ROW
BEGIN
  update maquinaria
  set estado = "En matenimiento"
  where id_maquinaria = new.id_maquinaria;
END$$
DELIMITER ;

-- actualizar estado maquina segun fecha fucionamiento
DELIMITER $$
CREATE TRIGGER actualizar_estado_maquinaria_funcionamiento
AFTER INSERT ON actividad_maquinaria
FOR EACH ROW
BEGIN
  DECLARE hoy DATE;
  SET hoy = CURDATE();

  IF hoy >= NEW.fecha_inicio AND hoy <= NEW.fecha_fin THEN
    UPDATE maquinaria
    SET estado = 'En funcionamiento'
    WHERE id_maquinaria = NEW.id_maquinaria;
  END IF;
END$$
DELIMITER ;


-- impedir ventas de empleado inactivo
DELIMITER $$
CREATE TRIGGER bloquear_venta_empleado_inactivo
BEFORE INSERT ON venta
FOR EACH ROW
BEGIN
  DECLARE estado_empleado VARCHAR(20);

  SELECT estado INTO estado_empleado
  FROM empleado
  WHERE id_empleado = NEW.id_empleado;

  IF estado_empleado <> 'Activo' THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'El empleado no se encuentra activo y no puede registrar ventas';
  END IF;
END$$
DELIMITER ;
