use finca_agricola_wbeimar;

DELIMITER $$

-- Retorna el subtotal de un detalle de compra (cantidad * precio_unitario).
CREATE FUNCTION calcular_total_detalle_compra(
    cantidad DECIMAL(10,2),
    precio_unitario DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN cantidad * precio_unitario;
END $$

DELIMITER ;


-- calcular_total_detalle_venta
DELIMITER $$

CREATE FUNCTION calcular_total_detalle_venta(
    cantidad DECIMAL(10,2),
    precio_unitario DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN cantidad * precio_unitario;
END $$

DELIMITER ;

-- Retorna el precio unitario de un producto, dado su id_producto
DELIMITER $$

CREATE FUNCTION obtener_precio_producto(
    id INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE precio DECIMAL(10,2);
    
    SELECT precio_unitario INTO precio
    FROM producto
    WHERE id_producto = id;
    
    RETURN precio;
END $$

DELIMITER ;

-- Devuelve el estado del empleado a partir de su ID:
DELIMITER $$

CREATE FUNCTION obtener_estado_empleado(
    id INT
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE estado_resultado VARCHAR(20);

    SELECT estado INTO estado_resultado
    FROM empleado
    WHERE id_empleado = id;

    RETURN estado_resultado;
END $$

DELIMITER ;

-- Retorna el tipo de una maquinaria dado su ID
DELIMITER $$

CREATE FUNCTION obtener_tipo_maquinaria(
    id INT
)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE tipo_resultado VARCHAR(50);

    SELECT tipo INTO tipo_resultado
    FROM maquinaria
    WHERE id_maquinaria = id;

    RETURN tipo_resultado;
END $$

DELIMITER ;

