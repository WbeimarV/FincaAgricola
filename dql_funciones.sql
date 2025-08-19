use finca_agricola_wbeimar;

-- Retorna el subtotal de un detalle de compra (cantidad * precio_unitario)
DELIMITER $$
CREATE FUNCTION calcular_total_detalle_compra(
    cantidad DECIMAL(10,2),
    precio_unitario DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN cantidad * precio_unitario;
END$$
DELIMITER ;

-- Calcula el subtotal de un detalle de venta
DELIMITER $$
CREATE FUNCTION calcular_total_detalle_venta(
    cantidad DECIMAL(10,2),
    precio_unitario DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN cantidad * precio_unitario;
END$$
DELIMITER ;

-- Retorna el precio unitario de un producto dado su ID
DELIMITER $$
CREATE FUNCTION obtener_precio_producto(id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE precio DECIMAL(10,2);
    SELECT precio_unitario INTO precio
    FROM producto
    WHERE id_producto = id;
    RETURN precio;
END$$
DELIMITER ;

-- Devuelve el estado del empleado a partir de su ID
DELIMITER $$
CREATE FUNCTION obtener_estado_empleado(id INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE estado_resultado VARCHAR(20);
    SELECT estado INTO estado_resultado
    FROM empleado
    WHERE id_empleado = id;
    RETURN estado_resultado;
END$$
DELIMITER ;

-- Retorna el tipo de una maquinaria dado su ID
DELIMITER $$
CREATE FUNCTION obtener_tipo_maquinaria(id INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE tipo_resultado VARCHAR(50);
    SELECT tipo INTO tipo_resultado
    FROM maquinaria
    WHERE id_maquinaria = id;
    RETURN tipo_resultado;
END$$
DELIMITER ;

-- Obtener nombre de producto
DELIMITER $$
CREATE FUNCTION obtener_nombre_producto(id_producto INT)
RETURNS VARCHAR(100)
DETERMINISTIC
RETURN (SELECT nombre FROM producto WHERE producto.id_producto = id_producto);$$
DELIMITER ;

-- Obtener nombre de cliente
DELIMITER $$
CREATE FUNCTION obtener_nombre_cliente(id_cliente INT)
RETURNS VARCHAR(100)
DETERMINISTIC
RETURN (SELECT nombre FROM cliente WHERE cliente.id_cliente = id_cliente);$$
DELIMITER ;

-- Obtener nombre de empleado
DELIMITER $$
CREATE FUNCTION obtener_nombre_empleado(id_empleado INT)
RETURNS VARCHAR(100)
DETERMINISTIC
RETURN (SELECT nombre FROM empleado WHERE empleado.id_empleado = id_empleado);$$
DELIMITER ;

-- Obtener teléfono del proveedor
DELIMITER $$
CREATE FUNCTION obtener_telefono_proveedor(id_proveedor INT)
RETURNS VARCHAR(20)
DETERMINISTIC
RETURN (SELECT telefono FROM proveedor WHERE proveedor.id_proveedor = id_proveedor);$$
DELIMITER ;

-- Obtener tipo de producto
DELIMITER $$
CREATE FUNCTION obtener_tipo_producto(id_producto INT)
RETURNS VARCHAR(50)
DETERMINISTIC
RETURN (SELECT tipo_producto FROM producto WHERE producto.id_producto = id_producto);$$
DELIMITER ;

-- Calcular total de una compra
DELIMITER $$
CREATE FUNCTION calcular_total_compra(id_compra INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (SELECT SUM(subtotal) FROM detalle_compra WHERE detalle_compra.id_compra = id_compra);$$
DELIMITER ;

-- Calcular total de una venta
DELIMITER $$
CREATE FUNCTION calcular_total_venta(id_venta INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (SELECT SUM(subtotal) FROM detalle_venta WHERE detalle_venta.id_venta = id_venta);$$
DELIMITER ;

-- Obtener cantidad en inventario de un producto
DELIMITER $$
CREATE FUNCTION obtener_cantidad_inventario(id_producto INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (SELECT cantidad_actual FROM inventario WHERE inventario.id_producto = id_producto);$$
DELIMITER ;

-- Calcular cantidad total producida de un producto
DELIMITER $$
CREATE FUNCTION calcular_total_produccion(id_producto INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (SELECT SUM(cantidad_producida) FROM produccion WHERE produccion.id_producto = id_producto);$$
DELIMITER ;

-- Obtener salario de un empleado
DELIMITER $$
CREATE FUNCTION obtener_salario_empleado(id_empleado INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (SELECT salario FROM empleado WHERE empleado.id_empleado = id_empleado);$$
DELIMITER ;

-- Calcular total de ventas a un cliente
DELIMITER $$
CREATE FUNCTION calcular_ventas_cliente(id_cliente INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (SELECT SUM(total) FROM venta WHERE venta.id_cliente = id_cliente);$$
DELIMITER ;

-- Calcular total de compras a un proveedor
DELIMITER $$
CREATE FUNCTION calcular_compras_proveedor(id_proveedor INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (SELECT SUM(total) FROM compra WHERE compra.id_proveedor = id_proveedor);$$
DELIMITER ;

-- Calcular total de mantenimiento de una maquinaria
DELIMITER $$
CREATE FUNCTION calcular_mantenimientos_maquinaria(id_maquinaria INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (SELECT SUM(costo) FROM mantenimiento_maquinaria WHERE mantenimiento_maquinaria.id_maquinaria = id_maquinaria);$$
DELIMITER ;

-- Calcular promedio de horas trabajadas por un empleado
DELIMITER $$
CREATE FUNCTION calcular_promedio_asistencia(id_empleado INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
RETURN (
  SELECT AVG(TIMESTAMPDIFF(MINUTE, hora_entrada, hora_salida)/60) 
  FROM asistencia_empleado 
  WHERE asistencia_empleado.id_empleado = id_empleado
);$$
DELIMITER ;

-- Contar productos sin producción
DELIMITER $$
CREATE FUNCTION productos_sin_produccion()
RETURNS INT
DETERMINISTIC
RETURN (
  SELECT COUNT(*) 
  FROM producto p 
  WHERE NOT EXISTS (
    SELECT 1 FROM produccion pr WHERE pr.id_producto = p.id_producto
  )
);$$
DELIMITER ;
