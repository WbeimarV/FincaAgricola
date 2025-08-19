# Sistema de Gestión de Producción Agrícola

## Descripción del Proyecto
Este proyecto consiste en el diseño y desarrollo de una base de datos relacional para gestionar de forma eficiente todas las operaciones de una finca de producción agrícola que maneja múltiples productos.

El sistema permite la administración integral de los recursos y procesos de la finca, incluyendo:

- Gestión de empleados.
- Control de maquinaria y equipos.
- Administración de inventarios y producción.
- Registro de ventas y compras.
- Seguimiento de proveedores y clientes.

La base de datos ha sido modelada y normalizada hasta la Tercera Forma Normal (3FN), asegurando integridad, consistencia y escalabilidad.

## Objetivos
- Diseñar un modelo de datos robusto que represente todos los componentes clave de una finca agrícola.
- Normalizar la base de datos hasta 3FN para evitar redundancias y asegurar consistencia.
- Cargar la base de datos con datos simulados realistas (mínimo 50 registros por tabla).
- Facilitar consultas rápidas y precisas para la toma de decisiones.

## Estructura del Modelo de Datos
El modelo incluye, entre otras, las siguientes entidades:

1. Productos: Información de cada tipo de producto agrícola o pecuario.
2. Producción: Registros de las cantidades producidas por periodo.
3. Inventario: Control de existencias y movimientos.
4. Ventas: Registro de transacciones con clientes.
5. Compras: Control de adquisiciones de insumos y servicios.
6. Empleados: Datos personales, cargos y asignaciones.
7. Maquinaria: Información sobre los equipos y su mantenimiento.
8. Proveedores: Datos de las empresas o personas que suministran insumos.
9. Clientes: Datos de compradores y distribuidores.

## Funcionalidades Clave
- Consultar producción.
- Control de stock.
- Reporte de ventas.
- Seguimiento de compras.
- Registro y control de mantenimiento de maquinaria.
- Administración de recursos humanos (empleados, roles, asignaciones).

## Instrucciones de Uso

### Requisitos del Sistema

Para ejecutar correctamente este proyecto, asegúrate de contar con:

- **Sistema Operativo**: Windows, Linux o macOS
- **MySQL Server**: Versión **8.0 o superior**
- **Cliente de base de datos**:
  - [MySQL Workbench](https://dev.mysql.com/downloads/workbench/) (recomendado)
  - [DBeaver](https://dbeaver.io/)
  - Terminal `mysql`
- **Espacio en disco**: al menos 100 MB disponibles
- **Editor de texto opcional**: Visual Studio Code o similar para editar archivos `.sql`

### ⚙️ Instalación y Configuración

#### 1. Clona o descarga el proyecto

### 2. Inicia el servidor MySQL

Asegúrate de que el servidor de MySQL esté en ejecución antes de continuar.

### 3. Ejecuta el archivo ddl.sql

Este archivo contiene la definición de toda la estructura de la base de datos (tablas y relaciones).

Opción A: Desde MySQL Workbench

Abre el archivo ddl.sql

Ejecuta el script completo

Verifica que todas las tablas se hayan creado

### 4. Ejecuta el archivo dml.sql

Este script inserta todos los datos necesarios para comenzar a probar el sistema (productos, empleados, clientes, ventas, etc.).

## Consultas SQL

Las consultas SQL son instrucciones utilizadas para recuperar, filtrar y analizar la información almacenada en la base de datos. A través de ellas, es posible:

- Obtener listados de productos, clientes, empleados, etc.
- Consultar ventas o compras en un rango de fechas
- Verificar el estado del inventario
- Generar reportes personalizados con filtros y condiciones
- Realizar análisis agregados como totales, promedios y agrupaciones

A continuación se presentan algunos ejemplos prácticos que puedes ejecutar directamente. Solo debes ejecutar el bloque de código.
```
-- Mostrar todos los productos disponibles con su tipo, unidad y precio unitario

SELECT nombre, tipo_producto, unidad_medida, precio_unitario
FROM producto;
```
```
-- Consultar los detalles de una venta especifica

SELECT dv.id_detalle, p.nombre AS producto, dv.cantidad, dv.precio_unitario, dv.subtotal
FROM detalle_venta dv
JOIN producto p ON dv.id_producto = p.id_producto
WHERE dv.id_venta = 6;
```
```
-- Consultar los clientes que han realizado más de 2 compras

SELECT c.id_cliente, c.nombre, COUNT(v.id_venta) AS cantidad_ventas
FROM venta v
JOIN cliente c ON v.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nombre
HAVING cantidad_ventas > 2;
```

[Para más consultas puedes revisar este documento](dql_select.sql)

## Procedimientos Almacenados

A continuación se presentan ejemplos de cómo se pueden utilizar y probar los procedimientos incluidos en este sistema.

### Ejemplo 1: ajustar_salario_empleado
```
-- Este procedimiento permite aumentar o reducir el salario de un empleado en un porcentaje dado.

DELIMITER // 
CREATE PROCEDURE ajustar_salario_empleado (
    IN emp_id INT,
    IN porcentaje DECIMAL(5,2)
)
BEGIN
    UPDATE empleado
    SET salario = salario + (salario * porcentaje / 100)
    WHERE id_empleado = emp_id;
END//
DELIMITER ;
```

Para ver su funcionamiento se recomienda seguir estos pasos:
1. Ver salario actual del empleado (ID 5)
```
SELECT id_empleado, nombre, salario
FROM empleado
WHERE id_empleado = 5;
```

2. Llamar el procedimiento aumentando el salario 10%
```
CALL ajustar_salario_empleado(5, 10);
```

3. Verificar nuevo salario
```
SELECT id_empleado, nombre, salario
FROM empleado
WHERE id_empleado = 5;
```

### Ejemplo 2: actualizar_estado_maquinaria
```
-- Este procedimiento cambia el estado de una maquinaria dada

DELIMITER //
CREATE PROCEDURE actualizar_estado_maquinaria (
    IN maq_id INT,
    IN nuevo_estado VARCHAR(50)
)
BEGIN
    UPDATE maquinaria
    SET estado = nuevo_estado
    WHERE id_maquinaria = maq_id;
END//
DELIMITER ;
```

Para ver su funcionamiento se recomienda seguir estos pasos: 
1. Ver estado actual de la maquinaria (ID 8):
```
SELECT id_maquinaria, nombre, estado
FROM maquinaria
WHERE id_maquinaria = 8;
```

2. Cambiar estado a "En reparación":
```
CALL actualizar_estado_maquinaria(8, 'En reparación');
```

3. Verificar nuevo estado:
```
SELECT id_maquinaria, nombre, estado
FROM maquinaria
WHERE id_maquinaria = 7;
```

### Ejemplo 3: registrar_detalle_compra
```
-- Este procedimiento registra una nueva fila en detalle_compra, calculando el subtotal automáticamente.
DELIMITER //
CREATE PROCEDURE registrar_detalle_compra (
    IN compra_id INT,
    IN producto_id INT,
    IN cantidad DECIMAL(10,2),
    IN precio_unitario DECIMAL(10,2)
)
BEGIN
    INSERT INTO detalle_compra (id_compra, id_producto, cantidad, precio_unitario, subtotal)
    VALUES (compra_id, producto_id, cantidad, precio_unitario, cantidad * precio_unitario);
END//
DELIMITER ;
```
Para verificar su funcionamiento siga estos pasos

1. Ver detalles actuales de la compra (ID 3):
```
SELECT id_detalle, id_producto, cantidad, precio_unitario, subtotal
FROM detalle_compra
WHERE id_compra = 3;
```

2. Registrar nuevo detalle:
```
CALL registrar_detalle_compra(3, 10, 5, 3000);
```

3. Verificar nuevo detalle agregado:
```
SELECT id_detalle, id_producto, cantidad, precio_unitario, subtotal
FROM detalle_compra
WHERE id_compra = 3;
```
[Para más procedimientos puedes revisar el documento](dql_procedimientos.sql)

## Funciones
A continuación se muestran tres ejemplos completos de funciones SQL implementadas en el sistema de gestión de la finca agrícola, incluyendo cómo crearlas y cómo probar su funcionamiento en distintos contextos.

### Ejemplo 1: calcular_total_detalle_venta 

```
-- Calcula el subtotal de un detalle de venta (cantidad × precio unitario).

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

```
1. Se prueba la función 
```
SELECT calcular_total_detalle_venta(12, 1800);
```
### Ejemplo 2: obtener_nombre_producto
```
-- Retorna el nombre de un producto dado su ID.

DELIMITER $$

CREATE FUNCTION obtener_nombre_producto(id_producto INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE nombre_resultado VARCHAR(100);
    SELECT nombre INTO nombre_resultado
    FROM producto
    WHERE producto.id_producto = id_producto;
    RETURN nombre_resultado;
END$$

DELIMITER ;
```
1. Verifica que exista un producto con ID 5
```
SELECT * FROM producto WHERE id_producto = 5;
```

2. Llama la función
```
SELECT obtener_nombre_producto(5);
```

### Ejemplo 3: calcular_total_compra
```
-- Calcula el total de una compra sumando los subtotales de sus detalles.

DELIMITER $$

CREATE FUNCTION calcular_total_compra(id_compra INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_resultado DECIMAL(10,2);
    SELECT SUM(subtotal) INTO total_resultado
    FROM detalle_compra
    WHERE detalle_compra.id_compra = id_compra;
    RETURN total_resultado;
END$$

DELIMITER ;
```

1. Verifica detalles de compra con ID 4
```
SELECT * FROM detalle_compra WHERE id_compra = 4;
```

2. Llama la función
```
SELECT calcular_total_compra(4);
``` 

[Para más funciones puedes revisar el documento](dql_funciones.sql.sql)

## Triggers 

A continuación se dan detalles para el uso correcto de los triggers. Estos se pueden encontrar [en este documento.](dql_triggers.sql). Ejecute previamente el trigger encontrado en el documento, para su  verificación siga los pasos que encuentra a continuación.

### Trigger 1: actualizar_total_venta
Actualiza automáticamente el campo total en la tabla venta cuando se inserta un nuevo detalle_venta.
```
-- 1. verifique el total una venta con un id válido
SELECT * FROM venta WHERE id_venta = 1;

-- 2. Insertar un detalle de venta (esto dispara el trigger) teniendo en cuenta el mismo id
INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
VALUES (1, 1, 2, 1500, 3000);

-- 3. Verificar que el total se actualizó automáticamente
SELECT * FROM venta WHERE id_venta = 1;
```

### Trigger 2: trg_disminuir_inventario_venta
Disminuye la cantidad de producto en inventario tras registrar un detalle de venta.
```
-- 1. Verificar stock actual del producto (ej: id_producto = 1)
SELECT * FROM inventario WHERE id_producto = 1;

-- 2. Insertar un nuevo detalle de venta (esto disminuirá el inventario)
INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
VALUES (1, 1, 3, 1500, 4500);

-- 3. Consultar nuevamente el inventario para ver la reducción
SELECT * FROM inventario WHERE id_producto = 1;
```

### Trigger 3: actualizar_inventario_despues_produccion

Actualiza o crea una entrada en el inventario cuando se registra producción.
```
-- 1. Verificar si el producto ya está en inventario
SELECT * FROM inventario WHERE id_producto = 2;

-- 2. Insertar producción de ese producto (esto actualiza o crea inventario)
INSERT INTO produccion (id_producto, cantidad_producida, fecha)
VALUES (2, 100, CURDATE());

-- 3. Verificar que el inventario se haya actualizado o creado
SELECT * FROM inventario WHERE id_producto = 2;
```

### Trigger 4: actualizar_total_compra

Actualiza el total de una compra automáticamente al insertar un detalle de compra.
```
-- 1. Verificar una compra válida 
SELECT * FROM compra WHERE id_compra = 1;

-- 2. Verificamos los subtotales de esta compra
select * from detalle_compra where id_compra=1;

-- 3. Insertamos un detalle de compra
INSERT INTO detalle_compra (id_compra, id_producto, cantidad, precio_unitario, subtotal)
VALUES (1, 1, 10, 100000.33, 10*100000.33);

-- 4. Verificamos que el total se actualizó automáticamente
SELECT * FROM compra WHERE id_compra = 1;
```

## Eventos
A continuación se dan detalles para el uso correcto de los eventos. Estos se pueden encontrar [en este documento.](dql_eventos.sql). Ejecute previamente el trigger encontrado en el documento, para su  verificación siga los pasos que encuentra a continuación.

### Evento 1: registrar_asistencia_faltante
Inserta registros de asistencia con NULL en horas para empleados que no marcaron ese día.
```
-- 1. Verificar asistencia antes
SELECT * FROM asistencia_empleado WHERE fecha = CURDATE();

-- 2. Simular el dia actual marcado para un empleado
INSERT INTO asistencia_empleado (id_empleado, fecha, hora_entrada, hora_salida) VALUES
(1, curdate(), '07:10:00', '16:00:00');

-- 3. Ejecutar el primer evento del documento "dql_eventos.sql"

-- 4. Verificar que se registró la asistencia con NULL
SELECT * FROM asistencia_empleado WHERE fecha = CURDATE();
```

### Evento 2: limpiar_asistencias_incompletas

Elimina registros de asistencia con horas incompletas que tengan más de 7 días.
```
-- Insertar una asistencia incompleta hace más de 7 días
INSERT INTO asistencia_empleado (id_empleado, fecha, hora_entrada, hora_salida)
VALUES (1, CURDATE() - INTERVAL 10 DAY, '08:00:00', NULL);

-- Verificar antes
SELECT * FROM asistencia_empleado
WHERE fecha < CURDATE() - INTERVAL 7 DAY;

-- Ejecutar el segundo evento del documento "dql_eventos.sql"

-- Verificar después
SELECT * FROM asistencia_empleado
WHERE fecha < CURDATE() - INTERVAL 7 DAY;
```

### Evento 3: actualizar_estado_maquinaria_inactiva

Descripción: Marca como 'Inactiva' las maquinarias sin actividad en los últimos 30 días.
```
-- Verificar estado actual
SELECT id_maquinaria, estado FROM maquinaria;

-- Asegurarse de que una máquina no tenga actividad reciente
-- (por ejemplo, eliminar actividades de la maquinaria 3)
DELETE FROM actividad_maquinaria
WHERE id_maquinaria = 3 AND fecha_fin >= CURDATE() - INTERVAL 30 DAY;

-- Ejecutar el tercer evento del documento "dql_eventos.sql"UPDATE maquinaria

-- Verificar el cambio
SELECT id_maquinaria, estado FROM maquinaria WHERE id_maquinaria = 3;
```

## Conclusión

Este proyecto implementa un sistema de gestión para una finca agrícola, incluyendo:

Consultas SQL  para análisis y gestión de datos.

Procedimientos y funciones almacenadas que automatizan operaciones comunes.

Triggers que garantizan la consistencia e integridad automática de los datos.

Eventos que programan tareas repetitivas para mantener el sistema actualizado.

La estructura modular y funcional permite escalar o adaptar fácilmente el sistema según las necesidades de cualquier entorno agrícola digitalizado.