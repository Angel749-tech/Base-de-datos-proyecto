/*
    PROYECTO: AMASAE - SISTEMA DE GESTION DE CAFETERIA
    EJECUTAR DESPUES DE 00_CREAR_BASE_DATOS.sql
*/
USE AMASAE_Cafeteria;
GO

/* 1. CATEGORIAS */
CREATE TABLE dbo.categoria
(
    id_categoria INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(150) NULL,
    CONSTRAINT PK_categoria PRIMARY KEY (id_categoria),
    CONSTRAINT UQ_categoria_nombre UNIQUE (nombre)
);
GO

/* 2. CLIENTES */
CREATE TABLE dbo.cliente
(
    id_cliente INT NOT NULL,
    nombre VARCHAR(120) NOT NULL,
    telefono VARCHAR(15) NULL,
    correo VARCHAR(100) NULL,
    tipo_documento VARCHAR(3) NULL,
    numero_documento VARCHAR(11) NULL,
    direccion VARCHAR(160) NULL,
    CONSTRAINT PK_cliente PRIMARY KEY (id_cliente),
    CONSTRAINT UQ_cliente_documento UNIQUE (tipo_documento, numero_documento),
    CONSTRAINT CK_cliente_documento CHECK
    (
        (tipo_documento IS NULL AND numero_documento IS NULL)
        OR (tipo_documento = 'DNI' AND LEN(numero_documento) = 8)
        OR (tipo_documento = 'RUC' AND LEN(numero_documento) = 11)
    )
);
GO

/* 3. EMPLEADOS */
CREATE TABLE dbo.empleado
(
    id_empleado INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    activo BIT NOT NULL CONSTRAINT DF_empleado_activo DEFAULT (1),
    telefono VARCHAR(15) NULL,
    correo VARCHAR(100) NULL,
    CONSTRAINT PK_empleado PRIMARY KEY (id_empleado)
);
GO

/* 4. METODOS DE PAGO */
CREATE TABLE dbo.metodo_pago
(
    id_metodo INT NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    activo BIT NOT NULL CONSTRAINT DF_metodo_pago_activo DEFAULT (1),
    CONSTRAINT PK_metodo_pago PRIMARY KEY (id_metodo),
    CONSTRAINT UQ_metodo_pago_nombre UNIQUE (nombre)
);
GO

/* 5. PROVEEDORES */
CREATE TABLE dbo.proveedor
(
    id_proveedor INT NOT NULL,
    razon_social VARCHAR(120) NOT NULL,
    contacto VARCHAR(100) NULL,
    telefono VARCHAR(20) NULL,
    activo BIT NOT NULL CONSTRAINT DF_proveedor_activo DEFAULT (1),
    ruc VARCHAR(11) NULL,
    correo VARCHAR(100) NULL,
    direccion VARCHAR(160) NULL,
    CONSTRAINT PK_proveedor PRIMARY KEY (id_proveedor),
    CONSTRAINT UQ_proveedor_ruc UNIQUE (ruc),
    CONSTRAINT CK_proveedor_ruc CHECK (ruc IS NULL OR LEN(ruc) = 11)
);
GO

/* 6. PRODUCTOS */
CREATE TABLE dbo.producto
(
    id_producto INT NOT NULL,
    id_categoria INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200) NULL,
    precio_actual DECIMAL(10,2) NOT NULL,
    activo BIT NOT NULL CONSTRAINT DF_producto_activo DEFAULT (1),
    unidad_venta VARCHAR(15) NOT NULL CONSTRAINT DF_producto_unidad DEFAULT ('UNIDAD'),
    CONSTRAINT PK_producto PRIMARY KEY (id_producto),
    CONSTRAINT FK_producto_categoria FOREIGN KEY (id_categoria)
        REFERENCES dbo.categoria(id_categoria),
    CONSTRAINT CK_producto_precio CHECK (precio_actual > 0),
    CONSTRAINT CK_producto_unidad CHECK (unidad_venta IN ('UNIDAD','TAZA','VASO','PORCION'))
);
GO

/* 7. DESCUENTOS */
CREATE TABLE dbo.descuento
(
    id_descuento INT NOT NULL,
    nombre VARCHAR(90) NOT NULL,
    motivo VARCHAR(120) NOT NULL,
    tipo_descuento VARCHAR(20) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    porcentaje DECIMAL(5,2) NOT NULL,
    activo BIT NOT NULL CONSTRAINT DF_descuento_activo DEFAULT (1),
    CONSTRAINT PK_descuento PRIMARY KEY (id_descuento),
    CONSTRAINT CK_descuento_tipo CHECK (tipo_descuento IN ('FECHA_ESPECIAL','SEMANAL')),
    CONSTRAINT CK_descuento_fechas CHECK (fecha_fin >= fecha_inicio),
    CONSTRAINT CK_descuento_porcentaje CHECK (porcentaje > 0 AND porcentaje < 100)
);
GO

/* 8. DESCUENTO POR CATEGORIA */
CREATE TABLE dbo.descuento_categoria
(
    id_descuento INT NOT NULL,
    id_categoria INT NOT NULL,
    CONSTRAINT PK_descuento_categoria PRIMARY KEY (id_descuento, id_categoria),
    CONSTRAINT FK_descuento_categoria_descuento FOREIGN KEY (id_descuento)
        REFERENCES dbo.descuento(id_descuento),
    CONSTRAINT FK_descuento_categoria_categoria FOREIGN KEY (id_categoria)
        REFERENCES dbo.categoria(id_categoria)
);
GO

/* 9. DESCUENTO POR DIA DE SEMANA: 1 lunes ... 7 domingo */
CREATE TABLE dbo.descuento_dia_semana
(
    id_descuento INT NOT NULL,
    dia_semana TINYINT NOT NULL,
    CONSTRAINT PK_descuento_dia_semana PRIMARY KEY (id_descuento, dia_semana),
    CONSTRAINT FK_descuento_dia_semana_descuento FOREIGN KEY (id_descuento)
        REFERENCES dbo.descuento(id_descuento),
    CONSTRAINT CK_descuento_dia CHECK (dia_semana BETWEEN 1 AND 7)
);
GO

/* 10. PEDIDOS */
CREATE TABLE dbo.pedido
(
    id_pedido INT NOT NULL,
    id_cliente INT NULL,
    id_empleado INT NOT NULL,
    fecha_hora DATETIME2(0) NOT NULL,
    estado VARCHAR(15) NOT NULL,
    modalidad_venta VARCHAR(20) NOT NULL CONSTRAINT DF_pedido_modalidad DEFAULT ('LOCAL'),
    id_descuento INT NULL,
    descuento_aplicado DECIMAL(10,2) NOT NULL CONSTRAINT DF_pedido_descuento DEFAULT (0),
    observaciones VARCHAR(200) NULL,
    CONSTRAINT PK_pedido PRIMARY KEY (id_pedido),
    CONSTRAINT FK_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES dbo.cliente(id_cliente),
    CONSTRAINT FK_pedido_empleado FOREIGN KEY (id_empleado) REFERENCES dbo.empleado(id_empleado),
    CONSTRAINT FK_pedido_descuento FOREIGN KEY (id_descuento) REFERENCES dbo.descuento(id_descuento),
    CONSTRAINT CK_pedido_estado CHECK (estado IN ('PENDIENTE','PAGADO','ANULADO')),
    CONSTRAINT CK_pedido_modalidad CHECK (modalidad_venta IN ('LOCAL','PARA_LLEVAR')),
    CONSTRAINT CK_pedido_descuento CHECK (descuento_aplicado >= 0),
    CONSTRAINT CK_pedido_descuento_relacion CHECK (id_descuento IS NOT NULL OR descuento_aplicado = 0)
);
GO

/* 11. DETALLE DE PEDIDO */
CREATE TABLE dbo.detalle_pedido
(
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_aplicado DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_detalle_pedido PRIMARY KEY (id_pedido, id_producto),
    CONSTRAINT FK_detalle_pedido_pedido FOREIGN KEY (id_pedido) REFERENCES dbo.pedido(id_pedido),
    CONSTRAINT FK_detalle_pedido_producto FOREIGN KEY (id_producto) REFERENCES dbo.producto(id_producto),
    CONSTRAINT CK_detalle_pedido_cantidad CHECK (cantidad > 0),
    CONSTRAINT CK_detalle_pedido_precio CHECK (precio_aplicado > 0)
);
GO

/* 12. PAGOS */
CREATE TABLE dbo.pago
(
    id_pago INT NOT NULL,
    id_pedido INT NOT NULL,
    id_metodo INT NOT NULL,
    fecha_hora DATETIME2(0) NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    referencia_operacion VARCHAR(40) NULL,
    CONSTRAINT PK_pago PRIMARY KEY (id_pago),
    CONSTRAINT UQ_pago_pedido UNIQUE (id_pedido),
    CONSTRAINT FK_pago_pedido FOREIGN KEY (id_pedido) REFERENCES dbo.pedido(id_pedido),
    CONSTRAINT FK_pago_metodo FOREIGN KEY (id_metodo) REFERENCES dbo.metodo_pago(id_metodo),
    CONSTRAINT CK_pago_monto CHECK (monto > 0)
);
GO

/* 13. RELACION PRODUCTO - PROVEEDOR */
CREATE TABLE dbo.producto_proveedor
(
    id_producto INT NOT NULL,
    id_proveedor INT NOT NULL,
    plazo_entrega_dias INT NULL,
    CONSTRAINT PK_producto_proveedor PRIMARY KEY (id_producto, id_proveedor),
    CONSTRAINT FK_producto_proveedor_producto FOREIGN KEY (id_producto) REFERENCES dbo.producto(id_producto),
    CONSTRAINT FK_producto_proveedor_proveedor FOREIGN KEY (id_proveedor) REFERENCES dbo.proveedor(id_proveedor),
    CONSTRAINT CK_producto_proveedor_plazo CHECK (plazo_entrega_dias IS NULL OR plazo_entrega_dias > 0)
);
GO

/* 14. INVENTARIO */
CREATE TABLE dbo.inventario
(
    id_producto INT NOT NULL,
    stock_actual INT NOT NULL,
    stock_minimo INT NOT NULL,
    stock_maximo INT NULL,
    fecha_actualizacion DATETIME2(0) NOT NULL,
    CONSTRAINT PK_inventario PRIMARY KEY (id_producto),
    CONSTRAINT FK_inventario_producto FOREIGN KEY (id_producto) REFERENCES dbo.producto(id_producto),
    CONSTRAINT CK_inventario_stock_actual CHECK (stock_actual >= 0),
    CONSTRAINT CK_inventario_stock_minimo CHECK (stock_minimo >= 0),
    CONSTRAINT CK_inventario_stock_maximo CHECK (stock_maximo IS NULL OR stock_maximo >= stock_minimo)
);
GO

/* 15. BOLETAS */
CREATE TABLE dbo.boleta
(
    id_boleta INT NOT NULL,
    id_pago INT NOT NULL,
    serie VARCHAR(4) NOT NULL,
    numero VARCHAR(8) NOT NULL,
    fecha_emision DATETIME2(0) NOT NULL,
    receptor_documento VARCHAR(11) NULL,
    receptor_nombre VARCHAR(120) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    igv DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    descuento_aplicado DECIMAL(10,2) NOT NULL CONSTRAINT DF_boleta_descuento DEFAULT (0),
    CONSTRAINT PK_boleta PRIMARY KEY (id_boleta),
    CONSTRAINT UQ_boleta_pago UNIQUE (id_pago),
    CONSTRAINT UQ_boleta_serie_numero UNIQUE (serie, numero),
    CONSTRAINT FK_boleta_pago FOREIGN KEY (id_pago) REFERENCES dbo.pago(id_pago),
    CONSTRAINT CK_boleta_serie CHECK (LEFT(serie,1) = 'B'),
    CONSTRAINT CK_boleta_subtotal CHECK (subtotal >= 0),
    CONSTRAINT CK_boleta_igv CHECK (igv >= 0),
    CONSTRAINT CK_boleta_total CHECK (total > 0 AND ROUND(total - subtotal - igv, 2) = 0),
    CONSTRAINT CK_boleta_descuento CHECK (descuento_aplicado >= 0),
    CONSTRAINT CK_boleta_documento CHECK
        (receptor_documento IS NULL OR LEN(receptor_documento) IN (8,11))
);
GO

/* 16. DETALLE DE BOLETA */
CREATE TABLE dbo.detalle_boleta
(
    id_boleta INT NOT NULL,
    id_producto INT NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    importe AS CONVERT(DECIMAL(12,2), cantidad * precio_unitario) PERSISTED,
    CONSTRAINT PK_detalle_boleta PRIMARY KEY (id_boleta, id_producto),
    CONSTRAINT FK_detalle_boleta_boleta FOREIGN KEY (id_boleta) REFERENCES dbo.boleta(id_boleta),
    CONSTRAINT FK_detalle_boleta_producto FOREIGN KEY (id_producto) REFERENCES dbo.producto(id_producto),
    CONSTRAINT CK_detalle_boleta_cantidad CHECK (cantidad > 0),
    CONSTRAINT CK_detalle_boleta_precio CHECK (precio_unitario > 0)
);
GO

PRINT 'Las 16 tablas de AMASAE_Cafeteria fueron creadas correctamente.';
GO
