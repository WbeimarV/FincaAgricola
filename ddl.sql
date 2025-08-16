CREATE database Finca_Agricola_Wbeimar;
use Finca_Agricola_Wbeimar;

CREATE TABLE producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo_producto VARCHAR(50),
    unidad_medida VARCHAR(20),
    precio_unitario DECIMAL(10,2)
);

CREATE TABLE cultivo (
    id_cultivo INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    fecha_siembra DATE,
    fecha_cosecha_estimada DATE,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE produccion (
    id_produccion INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    cantidad_producida DECIMAL(10,2),
    fecha DATE,
    observaciones TEXT,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE inventario (
    id_inventario INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    cantidad_actual DECIMAL(10,2),
    fecha_ultima_actualizacion DATE,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20),
    correo VARCHAR(100),
    direccion VARCHAR(150)
);

CREATE TABLE empleado (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    cargo VARCHAR(50),
    fecha_contratacion DATE,
    salario DECIMAL(10,2),
    estado VARCHAR(20)
);

CREATE TABLE venta (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha_venta DATE,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE detalle_venta (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad DECIMAL(10,2),
    precio_unitario DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE proveedor (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20),
    correo VARCHAR(100),
    direccion VARCHAR(150),
    tipo_producto VARCHAR(50)
);

CREATE TABLE compra (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    id_empleado INT NOT NULL,
    fecha_compra DATE,
    total DECIMAL(10,2),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE detalle_compra (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_compra INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad DECIMAL(10,2),
    precio_unitario DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    FOREIGN KEY (id_compra) REFERENCES compra(id_compra),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE asistencia_empleado (
    id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT NOT NULL,
    fecha DATE,
    hora_entrada TIME,
    hora_salida TIME,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE maquinaria (
    id_maquinaria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo VARCHAR(50),
    fecha_adquisicion DATE,
    estado VARCHAR(50),
    id_empleado INT,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE mantenimiento_maquinaria (
    id_mantenimiento INT AUTO_INCREMENT PRIMARY KEY,
    id_maquinaria INT NOT NULL,
    id_empleado INT NOT NULL,
    fecha DATE,
    descripcion TEXT,
    costo DECIMAL(10,2),
    FOREIGN KEY (id_maquinaria) REFERENCES maquinaria(id_maquinaria),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE actividad_maquinaria (
    id_actividad_maquinaria INT AUTO_INCREMENT PRIMARY KEY,
    id_maquinaria INT NOT NULL,
    tipo_actividad VARCHAR(50),
    descripcion_actividad TEXT,
    fecha_inicio DATE,
    fecha_fin DATE,
    FOREIGN KEY (id_maquinaria) REFERENCES maquinaria(id_maquinaria)
);