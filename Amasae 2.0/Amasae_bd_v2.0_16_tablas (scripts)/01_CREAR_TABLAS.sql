CREATE DATABASE `Amasae_bd_v2.0`
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `Amasae_bd_v2.0`;

CREATE TABLE categoria (
  id_categoria INT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL UNIQUE,
  descripcion VARCHAR(150)
);

CREATE TABLE cliente (
  id_cliente INT PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL,
  telefono VARCHAR(15),
  correo VARCHAR(100),
  tipo_documento VARCHAR(3),
  numero_documento VARCHAR(11),
  direccion VARCHAR(160),
  UNIQUE (tipo_documento, numero_documento),
  CHECK ((tipo_documento IS NULL AND numero_documento IS NULL)
      OR (tipo_documento = 'DNI' AND CHAR_LENGTH(numero_documento) = 8)
      OR (tipo_documento = 'RUC' AND CHAR_LENGTH(numero_documento) = 11))
);

CREATE TABLE empleado (
  id_empleado INT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  cargo VARCHAR(50) NOT NULL,
  activo TINYINT NOT NULL DEFAULT 1 CHECK (activo IN (0,1)),
  telefono VARCHAR(15),
  correo VARCHAR(100)
);

CREATE TABLE metodo_pago (
  id_metodo INT PRIMARY KEY,
  nombre VARCHAR(40) NOT NULL UNIQUE,
  activo TINYINT NOT NULL DEFAULT 1 CHECK (activo IN (0,1))
);

CREATE TABLE proveedor (
  id_proveedor INT PRIMARY KEY,
  razon_social VARCHAR(120) NOT NULL,
  contacto VARCHAR(100),
  telefono VARCHAR(15),
  activo TINYINT NOT NULL DEFAULT 1 CHECK (activo IN (0,1)),
  ruc VARCHAR(11) UNIQUE,
  correo VARCHAR(100),
  direccion VARCHAR(160),
  CHECK (ruc IS NULL OR CHAR_LENGTH(ruc) = 11)
);

CREATE TABLE producto (
  id_producto INT PRIMARY KEY,
  id_categoria INT NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  descripcion VARCHAR(200),
  precio_actual DECIMAL(10,2) NOT NULL CHECK (precio_actual > 0),
  activo TINYINT NOT NULL DEFAULT 1 CHECK (activo IN (0,1)),
  unidad_venta VARCHAR(15) NOT NULL DEFAULT 'UNIDAD',
  FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
  CHECK (unidad_venta IN ('UNIDAD','TAZA','VASO','PORCION'))
);

CREATE TABLE descuento (
  id_descuento INT PRIMARY KEY,
  nombre VARCHAR(90) NOT NULL,
  motivo VARCHAR(120) NOT NULL,
  tipo_descuento VARCHAR(20) NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  porcentaje DECIMAL(5,2) NOT NULL,
  activo TINYINT NOT NULL DEFAULT 1,
  CHECK (tipo_descuento IN ('FECHA_ESPECIAL','SEMANAL')),
  CHECK (fecha_fin >= fecha_inicio),
  CHECK (porcentaje > 0 AND porcentaje < 100),
  CHECK (activo IN (0,1))
);

CREATE TABLE descuento_categoria (
  id_descuento INT NOT NULL,
  id_categoria INT NOT NULL,
  PRIMARY KEY (id_descuento, id_categoria),
  FOREIGN KEY (id_descuento) REFERENCES descuento(id_descuento),
  FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE descuento_dia_semana (
  id_descuento INT NOT NULL,
  dia_semana TINYINT NOT NULL,
  PRIMARY KEY (id_descuento, dia_semana),
  FOREIGN KEY (id_descuento) REFERENCES descuento(id_descuento),
  CHECK (dia_semana BETWEEN 1 AND 7)
);

CREATE TABLE pedido (
  id_pedido INT PRIMARY KEY,
  id_cliente INT NULL,
  id_empleado INT NOT NULL,
  fecha_hora DATETIME NOT NULL,
  estado VARCHAR(15) NOT NULL,
  modalidad_venta VARCHAR(20) NOT NULL DEFAULT 'LOCAL',
  id_descuento INT NULL,
  descuento_aplicado DECIMAL(10,2) NOT NULL DEFAULT 0,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
  FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
  FOREIGN KEY (id_descuento) REFERENCES descuento(id_descuento),
  CHECK (estado IN ('PENDIENTE','PAGADO','ANULADO')),
  CHECK (modalidad_venta IN ('LOCAL','PARA_LLEVAR')),
  CHECK (descuento_aplicado >= 0),
  CHECK (id_descuento IS NOT NULL OR descuento_aplicado = 0)
);

CREATE TABLE detalle_pedido (
  id_pedido INT NOT NULL,
  id_producto INT NOT NULL,
  cantidad INT NOT NULL CHECK (cantidad > 0),
  precio_aplicado DECIMAL(10,2) NOT NULL CHECK (precio_aplicado > 0),
  PRIMARY KEY (id_pedido, id_producto),
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE pago (
  id_pago INT PRIMARY KEY,
  id_pedido INT NOT NULL UNIQUE,
  id_metodo INT NOT NULL,
  fecha_hora DATETIME NOT NULL,
  monto DECIMAL(10,2) NOT NULL CHECK (monto > 0),
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
  FOREIGN KEY (id_metodo) REFERENCES metodo_pago(id_metodo)
);

CREATE TABLE producto_proveedor (
  id_producto INT NOT NULL,
  id_proveedor INT NOT NULL,
  plazo_entrega_dias INT NULL,
  PRIMARY KEY (id_producto, id_proveedor),
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
  FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
  CHECK (plazo_entrega_dias IS NULL OR plazo_entrega_dias > 0)
);

CREATE TABLE inventario (
  id_producto INT PRIMARY KEY,
  stock_actual INT NOT NULL CHECK (stock_actual >= 0),
  stock_minimo INT NOT NULL CHECK (stock_minimo >= 0),
  stock_maximo INT NULL,
  fecha_actualizacion DATETIME NOT NULL,
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
  CHECK (stock_maximo IS NULL OR stock_maximo >= stock_minimo)
);

CREATE TABLE comprobante (
  id_comprobante INT PRIMARY KEY,
  id_pago INT NOT NULL UNIQUE,
  tipo VARCHAR(7) NOT NULL,
  serie VARCHAR(4) NOT NULL,
  numero VARCHAR(8) NOT NULL,
  fecha_emision DATETIME NOT NULL,
  receptor_documento VARCHAR(11),
  receptor_nombre VARCHAR(120) NOT NULL,
  subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0),
  igv DECIMAL(10,2) NOT NULL CHECK (igv >= 0),
  total DECIMAL(10,2) NOT NULL CHECK (total > 0),
  descuento_aplicado DECIMAL(10,2) NOT NULL DEFAULT 0,
  FOREIGN KEY (id_pago) REFERENCES pago(id_pago),
  UNIQUE (serie, numero),
  CHECK (tipo IN ('BOLETA','FACTURA')),
  CHECK (ROUND(total - subtotal - igv, 2) = 0),
  CHECK (descuento_aplicado >= 0),
  CHECK (tipo <> 'FACTURA' OR (receptor_documento IS NOT NULL AND CHAR_LENGTH(receptor_documento) = 11)),
  CHECK ((tipo = 'BOLETA' AND LEFT(serie,1) = 'B')
      OR (tipo = 'FACTURA' AND LEFT(serie,1) = 'F'))
);

CREATE TABLE detalle_comprobante (
  id_comprobante INT NOT NULL,
  id_producto INT NOT NULL,
  nombre_producto VARCHAR(100) NOT NULL,
  cantidad INT NOT NULL CHECK (cantidad > 0),
  precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario > 0),
  PRIMARY KEY (id_comprobante, id_producto),
  FOREIGN KEY (id_comprobante) REFERENCES comprobante(id_comprobante),
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- Campos complementarios.
ALTER TABLE pedido ADD COLUMN observaciones VARCHAR(200) NULL;
ALTER TABLE pago ADD COLUMN referencia_operacion VARCHAR(40) NULL;
