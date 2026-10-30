-- AMASAE PASTRY & CO. - SEMANA 9
-- Creacion de la base de datos y sus 11 tablas (MySQL 8)
CREATE DATABASE IF NOT EXISTS amasae_bd_v2;
USE amasae_bd_v2;

-- 1. Categorias del menu
CREATE TABLE categoria (
 id_categoria INT PRIMARY KEY,
 nombre VARCHAR(50) NOT NULL UNIQUE,
 descripcion VARCHAR(150)
);

-- 2. Clientes: DNI
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

USE amasae_bd_v2;

-- 1. Complementar datos de identificacion y contacto del cliente.
-- id_cliente se conserva por compatibilidad: es la PK interna de la tabla.
ALTER TABLE cliente
 ADD COLUMN tipo_documento VARCHAR(3) NOT NULL DEFAULT 'DNI',
 ADD COLUMN numero_documento VARCHAR(11) NULL,
 ADD COLUMN razon_social VARCHAR(160) NULL,
 ADD COLUMN direccion VARCHAR(200) NULL,
 ADD CONSTRAINT ck_cliente_tipo_documento CHECK (tipo_documento IN ('DNI','RUC')),
 ADD CONSTRAINT ck_cliente_longitud_documento CHECK (
  numero_documento IS NULL OR
  (tipo_documento = 'DNI' AND CHAR_LENGTH(numero_documento) = 8) OR
  (tipo_documento = 'RUC' AND CHAR_LENGTH(numero_documento) = 11)
 ),
 ADD UNIQUE KEY uq_cliente_documento (tipo_documento, numero_documento);

-- 2. Complementar datos del proveedor.
ALTER TABLE proveedor
 ADD COLUMN ruc VARCHAR(11) NULL,
 ADD COLUMN correo VARCHAR(100) NULL,
 ADD COLUMN direccion VARCHAR(200) NULL,
 ADD CONSTRAINT ck_proveedor_ruc CHECK (ruc IS NULL OR CHAR_LENGTH(ruc) = 11),
 ADD UNIQUE KEY uq_proveedor_ruc (ruc);

-- 3. Datos del negocio que emite la boleta o factura (ficticios).
CREATE TABLE empresa_emisora (
 id_emisor INT PRIMARY KEY,
 ruc VARCHAR(11) NOT NULL UNIQUE,
 razon_social VARCHAR(160) NOT NULL,
 nombre_comercial VARCHAR(120) NOT NULL,
 direccion_fiscal VARCHAR(200) NOT NULL,
 telefono VARCHAR(20),
 correo VARCHAR(100),
 activo TINYINT NOT NULL DEFAULT 1,
 CONSTRAINT ck_emisor_ruc CHECK (CHAR_LENGTH(ruc) = 11)
);

-- 4. UNA tabla para boleta y factura: evita duplicar columnas comunes.
-- Un pedido puede tener como maximo un comprobante en esta version academica.
-- Los importes se obtienen con base en el pago; no representan emision SUNAT.
CREATE TABLE comprobante (
 id_comprobante INT PRIMARY KEY,
 id_pedido INT NOT NULL UNIQUE,
 id_emisor INT NOT NULL,
 tipo VARCHAR(7) NOT NULL,
 serie VARCHAR(4) NOT NULL,
 numero INT NOT NULL,
 fecha_emision DATETIME NOT NULL,
 receptor_tipo_documento VARCHAR(3) NULL,
 receptor_numero_documento VARCHAR(11) NULL,
 receptor_nombre VARCHAR(160) NULL,
 receptor_direccion VARCHAR(200) NULL,
 base_gravada DECIMAL(10,2) NOT NULL,
 igv DECIMAL(10,2) NOT NULL,
 total DECIMAL(10,2) NOT NULL,
 estado VARCHAR(10) NOT NULL DEFAULT 'EMITIDO',
 UNIQUE KEY uq_comprobante_serie_numero (serie, numero),
 CONSTRAINT fk_comp_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
 CONSTRAINT fk_comp_emisor FOREIGN KEY (id_emisor) REFERENCES empresa_emisora(id_emisor),
 CONSTRAINT ck_comp_tipo CHECK (tipo IN ('BOLETA','FACTURA')),
 CONSTRAINT ck_comp_estado CHECK (estado IN ('EMITIDO','ANULADO')),
 CONSTRAINT ck_comp_numero CHECK (numero > 0),
 CONSTRAINT ck_comp_serie CHECK (
  (tipo = 'BOLETA' AND LEFT(serie,1) = 'B') OR
  (tipo = 'FACTURA' AND LEFT(serie,1) = 'F')
 ),
 CONSTRAINT ck_comp_importes CHECK (
  base_gravada >= 0 AND igv >= 0 AND total > 0 AND
  base_gravada + igv = total
 ),
 CONSTRAINT ck_comp_factura_receptor CHECK (
  tipo <> 'FACTURA' OR
  (receptor_tipo_documento = 'RUC' AND
   receptor_numero_documento IS NOT NULL AND
   CHAR_LENGTH(receptor_numero_documento) = 11 AND
   receptor_nombre IS NOT NULL AND
   receptor_direccion IS NOT NULL)
 ),
 CONSTRAINT ck_comp_boleta_identificacion CHECK (
  tipo <> 'BOLETA' OR total <= 700 OR
  (receptor_numero_documento IS NOT NULL AND receptor_nombre IS NOT NULL)
 )
);

SHOW TABLES;
