use finca_agricola_wbeimar;

-- Retorna el subtotal de un detalle de compra (cantidad * precio_unitario).
CREATE FUNCTION calcular_total_detalle_compra(
    cantidad DECIMAL(10,2),
    precio_unitario DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN cantidad * precio_unitario;
END



-- calcular_total_detalle_venta

CREATE FUNCTION calcular_total_detalle_venta(
    cantidad DECIMAL(10,2),
    precio_unitario DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN cantidad * precio_unitario;
END 


-- Retorna el precio unitario de un producto, dado su id_producto

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
END


-- Devuelve el estado del empleado a partir de su ID:

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
END


-- Retorna el tipo de una maquinaria dado su ID

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
END 

-- Obtener nombre de producto
CREATE FUNCTION obtener_nombre_producto(id_producto INT)
RETURNS VARCHAR(100)
DETERMINISTIC
RETURN (SELECT nombre FROM producto WHERE producto.id_producto = id_producto);

-- Obtener nombre de cliente
CREATE FUNCTION obtener_nombre_cliente(id_cliente INT)
RETURNS VARCHAR(100)
DETERMINISTIC
RETURN (SELECT nombre FROM cliente WHERE cliente.id_cliente = id_cliente);

-- Obtener nombre de empleado
CREATE FUNCTION obtener_nombre_empleado(id_empleado INT)
RETURNS VARCHAR(100)
DETERMINISTIC
RETURN (SELECT nombre FROM empleado WHERE empleado.id_empleado = id_empleado);

-- Obtener teléfono del proveedor
CREATE FUNCTION obtener_telefono_proveedor(id_proveedor INT)
RETURNS VARCHAR(20)
DETERMINISTIC
RETURN (SELECT telefono FROM proveedor WHERE proveedor.id_proveedor = id_proveedor);

-- Obtener tipo de producto
CREATE FUNCTION obtener_tipo_producto(id_producto INT)
RETURNS VARCHAR(50)
DETERMINISTIC
RETURN (SELECT tipo_producto FROM producto WHERE producto.id_producto = id_producto);

-- Calcular total de una compra
CREATE FUNCTION calcular_total_compra(id_compra INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (SELECT SUM(subtotal) FROM detalle_compra WHERE detalle_compra.id_compra = id_compra);

-- Calcular total de una venta
CREATE FUNCTION calcular_total_venta(id_venta INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (SELECT SUM(subtotal) FROM detalle_venta WHERE detalle_venta.id_venta = id_venta);

-- Obtener cantidad en inventario de un producto
CREATE FUNCTION obtener_cantidad_inventario(id_producto INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (SELECT cantidad_actual FROM inventario WHERE inventario.id_producto = id_producto);

-- Calcular cantidad total producida de un producto
CREATE FUNCTION calcular_total_produccion(id_producto INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (SELECT SUM(cantidad_producida) FROM produccion WHERE produccion.id_producto = id_producto);

-- Obtener salario de un empleado
CREATE FUNCTION obtener_salario_empleado(id_empleado INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (SELECT salario FROM empleado WHERE empleado.id_empleado = id_empleado);

-- Calcular total de ventas a un cliente
CREATE FUNCTION calcular_ventas_cliente(id_cliente INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (SELECT SUM(total) FROM venta WHERE venta.id_cliente = id_cliente);

-- Calcular total de compras a un proveedor
CREATE FUNCTION calcular_compras_proveedor(id_proveedor INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (SELECT SUM(total) FROM compra WHERE compra.id_proveedor = id_proveedor);

-- Calcular total de mantenimiento de una maquinaria
CREATE FUNCTION calcular_mantenimientos_maquinaria(id_maquinaria INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (SELECT SUM(costo) FROM mantenimiento_maquinaria WHERE mantenimiento_maquinaria.id_maquinaria = id_maquinaria);

-- Calcular promedio de horas trabajadas por un empleado
CREATE FUNCTION calcular_promedio_asistencia(id_empleado INT)
RETURNS DECIMAL(5,2)
DETERMINISTIC
RETURN (
  SELECT AVG(TIMESTAMPDIFF(MINUTE, hora_entrada, hora_salida)/60) 
  FROM asistencia_empleado 
  WHERE asistencia_empleado.id_empleado = id_empleado
);

-- Contar productos sin producción
CREATE FUNCTION productos_sin_produccion()
RETURNS INT
DETERMINISTIC
RETURN (
  SELECT COUNT(*) 
  FROM producto p 
  WHERE NOT EXISTS (
    SELECT 1 FROM produccion pr WHERE pr.id_producto = p.id_producto
  )
);
