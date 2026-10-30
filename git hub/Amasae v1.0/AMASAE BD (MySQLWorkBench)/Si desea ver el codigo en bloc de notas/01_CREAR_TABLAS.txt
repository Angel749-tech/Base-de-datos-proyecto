-- AMASAE PASTRY & CO. - SEMANA 9
-- Creacion de la base de datos y sus 11 tablas (MySQL 8)
CREATE DATABASE IF NOT EXISTS amasae_bd;
USE amasae_bd;

-- 1. Categorias del menu
CREATE TABLE categoria (
 id_categoria INT PRIMARY KEY,
 nombre VARCHAR(50) NOT NULL UNIQUE,
 descripcion VARCHAR(150)
);

-- 2. Clientes: DNI ficticio de ocho digitos usado como ID para esta practica
CREATE TABLE cliente (
 id_cliente INT PRIMARY KEY,
 nombre VARCHAR(100) NOT NULL,
 telefono VARCHAR(20),
 correo VARCHAR(100)
);

-- 3. Empleados
CREATE TABLE empleado (
 id_empleado INT PRIMARY KEY,
 nombre VARCHAR(100) NOT NULL,
 cargo VARCHAR(50) NOT NULL,
 activo TINYINT NOT NULL DEFAULT 1
);

-- 4. Metodos de pago
CREATE TABLE metodo_pago (
 id_metodo INT PRIMARY KEY,
 nombre VARCHAR(40) NOT NULL UNIQUE,
 activo TINYINT NOT NULL DEFAULT 1
);

-- 5. Proveedores
CREATE TABLE proveedor (
 id_proveedor INT PRIMARY KEY,
 razon_social VARCHAR(120) NOT NULL,
 contacto VARCHAR(100),
 telefono VARCHAR(20),
 activo TINYINT NOT NULL DEFAULT 1
);

-- 6. Productos: cada uno pertenece a una categoria
CREATE TABLE producto (
 id_producto INT PRIMARY KEY,
 id_categoria INT NOT NULL,
 nombre VARCHAR(80) NOT NULL,
 descripcion VARCHAR(200),
 precio_actual DECIMAL(10,2) NOT NULL CHECK (precio_actual > 0),
 activo TINYINT NOT NULL DEFAULT 1,
 FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

-- 7. Pedidos: pueden ser de clientes no identificados
CREATE TABLE pedido (
 id_pedido INT PRIMARY KEY,
 id_cliente INT,
 id_empleado INT NOT NULL,
 fecha_hora DATETIME NOT NULL,
 estado VARCHAR(15) NOT NULL CHECK (estado IN ('PENDIENTE','PAGADO','ANULADO')),
 FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
 FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

-- 8. Detalles: la PK compuesta evita repetir un producto en un mismo pedido
CREATE TABLE detalle_pedido (
 id_pedido INT NOT NULL,
 id_producto INT NOT NULL,
 cantidad INT NOT NULL CHECK (cantidad > 0),
 precio_aplicado DECIMAL(10,2) NOT NULL CHECK (precio_aplicado > 0),
 PRIMARY KEY (id_pedido, id_producto),
 FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
 FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- 9. Pagos: a lo sumo un pago por pedido
CREATE TABLE pago (
 id_pago INT PRIMARY KEY,
 id_pedido INT NOT NULL UNIQUE,
 id_metodo INT NOT NULL,
 fecha_hora DATETIME NOT NULL,
 monto DECIMAL(10,2) NOT NULL CHECK (monto > 0),
 FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
 FOREIGN KEY (id_metodo) REFERENCES metodo_pago(id_metodo)
);

-- 10. Tabla puente: productos y proveedores
CREATE TABLE producto_proveedor (
 id_producto INT NOT NULL,
 id_proveedor INT NOT NULL,
 PRIMARY KEY (id_producto, id_proveedor),
 FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
 FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
);

-- 11. Inventario de productos terminados, cuando aplique
CREATE TABLE inventario (
 id_producto INT PRIMARY KEY,
 stock_actual INT NOT NULL CHECK (stock_actual >= 0),
 stock_minimo INT NOT NULL CHECK (stock_minimo >= 0),
 fecha_actualizacion DATETIME NOT NULL,
 FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

SHOW TABLES;
