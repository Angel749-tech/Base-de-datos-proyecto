/*
    DATOS DE PRUEBA PARA AMASAE - CAFETERIA
    Adaptados del modelo y de los registros entregados en MySQL.
    Las dos ventas que originalmente tenían FACTURA se conservan como pagos,
    pero no se convierten en boletas porque este modelo implementa boletas.
*/
USE AMASAE_Cafeteria;
GO

INSERT INTO dbo.categoria (id_categoria, nombre, descripcion) VALUES
(1, 'Cafes', 'Bebidas con cafe'),
(2, 'Tortas', 'Porciones de tortas'),
(3, 'Batidos', 'Batidos de fruta'),
(4, 'Bubble teas', 'Te con perlas de tapioca'),
(5, 'Sanguches', 'Preparaciones saladas'),
(6, 'Pasteleria', 'Productos horneados'),
(7, 'Postres', 'Postres por porcion'),
(8, 'Mochis', 'Dulces japoneses a base de arroz');
GO

INSERT INTO dbo.cliente
(id_cliente, nombre, telefono, correo, tipo_documento, numero_documento, direccion) VALUES
(90010001, 'Valeria Rojas Paredes', '986274153', 'valeria.rojas@example.com', 'DNI', '74816329', 'Av. Universitaria 438, Los Olivos, Lima'),
(90010002, 'Jorge Salinas Cruz', '973185426', 'jorge.salinas@example.com', 'DNI', '70642815', 'Jr. Los Cedros 191, Comas, Lima'),
(90010003, 'Camila Mendoza Vega', '982361745', 'camila.mendoza@example.com', 'DNI', '46281739', 'Av. Tomas Valle 531, San Martin de Porres, Lima'),
(90010004, 'Luis Herrera Chavez', '969214853', 'luis.herrera@example.com', 'DNI', '73590624', 'Jr. Los Pinos 285, Independencia, Lima'),
(90010005, 'Andrea Paredes Rios', '958472631', 'andrea.paredes@example.com', 'DNI', '48261375', 'Av. Tupac Amaru 765, Comas, Lima'),
(90010006, 'Diego Flores Quispe', '947285163', 'diego.flores@example.com', 'DNI', '76325091', 'Av. Los Alisos 344, Los Olivos, Lima'),
(90010007, 'Andes Gestion Administrativa S.A.C.', '975628413', 'compras@andesgestion.example.com', 'RUC', '20603851626', 'Av. Arequipa 1045, Lince, Lima'),
(90010008, 'Servicios Norte Corporativo S.A.C.', '961735284', 'administracion@serviciosnorte.example.com', 'RUC', '20605614737', 'Av. Alfredo Mendiola 1450, Independencia, Lima');
GO

INSERT INTO dbo.empleado (id_empleado, nombre, cargo, activo, telefono, correo) VALUES
(1, 'Elena Torres', 'Cajera', 1, '918274653', 'elena.torres@example.com'),
(2, 'Diego Rios', 'Barista', 1, '956318274', 'diego.rios@example.com'),
(3, 'Patricia Leon', 'Atencion', 1, '973582146', 'patricia.leon@example.com'),
(4, 'Miguel Vera', 'Administrador', 1, '984271635', 'miguel.vera@example.com');
GO

INSERT INTO dbo.metodo_pago (id_metodo, nombre, activo) VALUES
(1, 'Efectivo', 1),
(2, 'Yape', 1),
(3, 'Plin', 1),
(4, 'Tarjeta', 1);
GO

INSERT INTO dbo.proveedor
(id_proveedor, razon_social, contacto, telefono, activo, ruc, correo, direccion) VALUES
(1, 'Distribuidora Altura S.A.C.', 'Cesar Romero', '965284731', 1, '20608173545', 'ventas@altura.example.com', 'Av. Argentina 1320, Callao'),
(2, 'Frutales y Lacteos del Norte S.A.C.', 'Mariela Huaman', '942615837', 1, '20607319481', 'pedidos@frutalesnorte.example.com', 'Av. Proceres 670, Los Olivos, Lima'),
(3, 'Insumos Panaderos Lima S.A.C.', 'Carlos Molina', '986153247', 1, '20604286191', 'contacto@insumospanaderos.example.com', 'Jr. Huascar 540, Lima'),
(4, 'Tapiocas y Tes del Pacifico S.A.C.', 'Rosa Gutierrez', '953728164', 1, '20609357283', 'comercial@tapiocas.example.com', 'Av. Canada 132, La Victoria, Lima'),
(5, 'Dulces Nikkei Distribucion S.A.C.', 'Alicia Navarro', '961842573', 1, '20606481935', 'pedidos@dulcesnikkei.example.com', 'Av. Colonial 1950, Cercado de Lima');
GO

INSERT INTO dbo.producto
(id_producto, id_categoria, nombre, descripcion, precio_actual, activo, unidad_venta) VALUES
(101, 1, 'Cafe americano', 'Cafe filtrado caliente', 8.00, 1, 'TAZA'),
(102, 1, 'Capuchino', 'Cafe con leche espumada', 12.00, 1, 'TAZA'),
(201, 2, 'Torta de chocolate', 'Porcion de torta de chocolate', 15.00, 1, 'PORCION'),
(202, 2, 'Torta tres leches', 'Porcion de torta tres leches', 16.00, 1, 'PORCION'),
(301, 3, 'Batido de fresa', 'Batido de fruta en vaso mediano', 14.00, 1, 'VASO'),
(302, 3, 'Batido de lucuma', 'Batido de lucuma en vaso mediano', 16.00, 1, 'VASO'),
(401, 4, 'Bubble tea de taro', 'Te de taro con tapioca', 17.00, 1, 'VASO'),
(402, 4, 'Bubble tea de mango', 'Te de mango con tapioca', 17.00, 1, 'VASO'),
(501, 5, 'Sanguche de pollo', 'Pan con pollo deshilachado', 15.00, 1, 'UNIDAD'),
(502, 5, 'Sanguche mixto', 'Pan con jamon y queso', 12.00, 1, 'UNIDAD'),
(601, 6, 'Croissant', 'Masa hojaldrada horneada', 9.00, 1, 'UNIDAD'),
(701, 7, 'Cheesecake', 'Porcion de cheesecake', 16.00, 1, 'PORCION'),
(801, 8, 'Mochi de fresa', 'Mochi relleno de fresa', 10.00, 1, 'UNIDAD'),
(802, 8, 'Mochi de matcha', 'Mochi de te verde matcha', 12.00, 1, 'UNIDAD'),
(803, 8, 'Mochi de mango', 'Mochi relleno de mango', 11.00, 1, 'UNIDAD');
GO

INSERT INTO dbo.descuento
(id_descuento, nombre, motivo, tipo_descuento, fecha_inicio, fecha_fin, porcentaje, activo) VALUES
(2, 'San Valentin en Amasae', 'Dia de San Valentin', 'FECHA_ESPECIAL', '2026-02-13', '2026-02-15', 15.00, 1),
(5, 'Dulce Dia de Mama', 'Dia de la Madre', 'FECHA_ESPECIAL', '2026-05-09', '2026-05-10', 15.00, 1),
(7, 'Fiestas Patrias', 'Fiestas Patrias del Peru', 'FECHA_ESPECIAL', '2026-07-27', '2026-07-29', 20.00, 1),
(10, 'Sabor Criollo', 'Dia de la Cancion Criolla', 'FECHA_ESPECIAL', '2026-10-30', '2026-10-31', 15.00, 1),
(12, 'Navidad Dulce', 'Navidad', 'FECHA_ESPECIAL', '2026-12-24', '2026-12-25', 20.00, 1),
(20, 'Lunes para Empezar', 'Desayunos para iniciar la semana', 'SEMANAL', '2026-01-01', '2026-12-31', 10.00, 1),
(21, 'Jueves de Bubble Tea', 'Jueves de bebidas especiales', 'SEMANAL', '2026-01-01', '2026-12-31', 15.00, 1),
(22, 'Sabados de Mochis', 'Sabados de postres japoneses', 'SEMANAL', '2026-01-01', '2026-12-31', 20.00, 1);
GO

INSERT INTO dbo.descuento_categoria (id_descuento, id_categoria) VALUES
(2, 2), (2, 7), (5, 2), (7, 1), (7, 6),
(10, 1), (10, 2), (12, 2), (12, 7),
(20, 1), (20, 5), (21, 4), (22, 8);
GO

INSERT INTO dbo.descuento_dia_semana (id_descuento, dia_semana) VALUES
(20, 1), (21, 4), (22, 6);
GO

INSERT INTO dbo.pedido
(id_pedido, id_cliente, id_empleado, fecha_hora, estado, modalidad_venta, id_descuento, descuento_aplicado, observaciones) VALUES
(1001, 90010001, 1, '2026-10-14T09:20:00', 'PAGADO', 'LOCAL', NULL, 0.00, NULL),
(1002, 90010002, 3, '2026-10-14T10:05:00', 'PAGADO', 'PARA_LLEVAR', NULL, 0.00, NULL),
(1003, NULL, 1, '2026-10-14T11:30:00', 'PAGADO', 'LOCAL', NULL, 0.00, NULL),
(1004, 90010003, 3, '2026-10-14T13:00:00', 'PAGADO', 'LOCAL', NULL, 0.00, NULL),
(1005, 90010004, 1, '2026-10-15T09:45:00', 'PAGADO', 'LOCAL', NULL, 0.00, NULL),
(1006, NULL, 3, '2026-10-15T15:20:00', 'PAGADO', 'PARA_LLEVAR', NULL, 0.00, 'Sin azucar en la bebida'),
(1007, 90010005, 1, '2026-10-15T17:10:00', 'PAGADO', 'LOCAL', NULL, 0.00, NULL),
(1008, 90010006, 3, '2026-10-16T10:00:00', 'PENDIENTE', 'LOCAL', NULL, 0.00, NULL),
(1009, 90010007, 1, '2026-10-17T09:30:00', 'PAGADO', 'LOCAL', NULL, 0.00, NULL),
(1010, 90010008, 3, '2026-10-17T11:40:00', 'PAGADO', 'PARA_LLEVAR', NULL, 0.00, NULL),
(1011, 90010003, 1, '2026-10-31T12:30:00', 'PAGADO', 'LOCAL', 10, 4.05, NULL),
(1012, 90010001, 1, '2026-10-26T08:45:00', 'PAGADO', 'LOCAL', 20, 2.30, NULL),
(1013, 90010002, 3, '2026-10-29T16:10:00', 'PAGADO', 'PARA_LLEVAR', 21, 2.55, NULL),
(1014, 90010005, 1, '2026-10-31T17:15:00', 'PAGADO', 'LOCAL', 22, 4.00, NULL);
GO

INSERT INTO dbo.detalle_pedido (id_pedido, id_producto, cantidad, precio_aplicado) VALUES
(1001, 101, 1, 8.00), (1001, 601, 1, 9.00),
(1002, 401, 1, 17.00), (1002, 201, 1, 15.00),
(1003, 301, 2, 14.00),
(1004, 501, 1, 15.00), (1004, 102, 1, 12.00),
(1005, 202, 2, 16.00), (1005, 701, 1, 16.00),
(1006, 402, 1, 17.00), (1006, 502, 1, 12.00),
(1007, 302, 1, 16.00), (1007, 601, 2, 9.00),
(1008, 101, 1, 8.00), (1008, 201, 1, 15.00),
(1009, 102, 3, 12.00), (1009, 201, 2, 15.00),
(1010, 101, 5, 8.00), (1010, 601, 3, 9.00),
(1011, 102, 1, 12.00), (1011, 201, 1, 15.00),
(1012, 101, 1, 8.00), (1012, 501, 1, 15.00), (1012, 201, 1, 15.00),
(1013, 401, 1, 17.00), (1013, 601, 1, 9.00),
(1014, 801, 2, 10.00), (1014, 201, 1, 15.00);
GO

INSERT INTO dbo.pago (id_pago, id_pedido, id_metodo, fecha_hora, monto, referencia_operacion) VALUES
(501, 1001, 1, '2026-10-14T09:25:00', 17.00, NULL),
(502, 1002, 2, '2026-10-14T10:10:00', 32.00, 'OP-000502'),
(503, 1003, 3, '2026-10-14T11:35:00', 28.00, 'OP-000503'),
(504, 1004, 4, '2026-10-14T13:05:00', 27.00, 'OP-000504'),
(505, 1005, 2, '2026-10-15T09:50:00', 48.00, 'OP-000505'),
(506, 1006, 1, '2026-10-15T15:25:00', 29.00, NULL),
(507, 1007, 3, '2026-10-15T17:15:00', 34.00, 'OP-000507'),
(508, 1009, 4, '2026-10-17T09:35:00', 66.00, 'OP-000508'),
(509, 1010, 4, '2026-10-17T11:45:00', 67.00, 'OP-000509'),
(510, 1011, 2, '2026-10-31T12:35:00', 22.95, 'OP-000510'),
(511, 1012, 1, '2026-10-26T08:50:00', 35.70, NULL),
(512, 1013, 2, '2026-10-29T16:15:00', 23.45, 'OP-000512'),
(513, 1014, 3, '2026-10-31T17:20:00', 31.00, 'OP-000513');
GO

INSERT INTO dbo.producto_proveedor (id_producto, id_proveedor, plazo_entrega_dias) VALUES
(101, 1, 2), (102, 1, 2),
(201, 2, 1), (202, 2, 1), (301, 2, 1), (302, 2, 1), (701, 2, 1),
(401, 4, 4), (402, 4, 4),
(501, 3, 3), (502, 3, 3), (601, 3, 3),
(801, 5, 3), (802, 5, 3), (803, 5, 3);
GO

INSERT INTO dbo.inventario
(id_producto, stock_actual, stock_minimo, stock_maximo, fecha_actualizacion) VALUES
(101, 30, 5, 45, '2026-10-30T18:00:00'),
(102, 28, 5, 45, '2026-10-30T18:00:00'),
(201, 8, 3, 25, '2026-10-30T18:00:00'),
(202, 6, 3, 20, '2026-10-30T18:00:00'),
(301, 24, 5, 40, '2026-10-30T18:00:00'),
(302, 22, 5, 40, '2026-10-30T18:00:00'),
(401, 18, 5, 40, '2026-10-30T18:00:00'),
(402, 20, 5, 40, '2026-10-30T18:00:00'),
(501, 10, 4, 30, '2026-10-30T18:00:00'),
(502, 12, 4, 30, '2026-10-30T18:00:00'),
(601, 15, 5, 40, '2026-10-30T18:00:00'),
(701, 7, 3, 20, '2026-10-30T18:00:00'),
(801, 22, 6, 45, '2026-10-30T18:00:00'),
(802, 18, 6, 45, '2026-10-30T18:00:00'),
(803, 20, 6, 45, '2026-10-30T18:00:00');
GO

/* Boletas de las ventas que originalmente estaban registradas como BOLETA. */
INSERT INTO dbo.boleta
(id_boleta, id_pago, serie, numero, fecha_emision, receptor_documento, receptor_nombre,
 subtotal, igv, total, descuento_aplicado) VALUES
(1, 501, 'B001', '00000001', '2026-10-14T09:26:00', '74816329', 'Valeria Rojas Paredes', 14.41, 2.59, 17.00, 0.00),
(2, 502, 'B001', '00000002', '2026-10-14T10:11:00', '70642815', 'Jorge Salinas Cruz', 27.12, 4.88, 32.00, 0.00),
(3, 503, 'B001', '00000003', '2026-10-14T11:36:00', NULL, 'Consumidor final', 23.73, 4.27, 28.00, 0.00),
(4, 504, 'B001', '00000004', '2026-10-14T13:06:00', '46281739', 'Camila Mendoza Vega', 22.88, 4.12, 27.00, 0.00),
(5, 505, 'B001', '00000005', '2026-10-15T09:51:00', '73590624', 'Luis Herrera Chavez', 40.68, 7.32, 48.00, 0.00),
(6, 506, 'B001', '00000006', '2026-10-15T15:26:00', NULL, 'Consumidor final', 24.58, 4.42, 29.00, 0.00),
(7, 507, 'B001', '00000007', '2026-10-15T17:16:00', '48261375', 'Andrea Paredes Rios', 28.81, 5.19, 34.00, 0.00),
(10, 510, 'B001', '00000008', '2026-10-31T12:36:00', '46281739', 'Camila Mendoza Vega', 19.45, 3.50, 22.95, 4.05),
(11, 511, 'B001', '00000009', '2026-10-26T08:51:00', '74816329', 'Valeria Rojas Paredes', 30.25, 5.45, 35.70, 2.30),
(12, 512, 'B001', '00000010', '2026-10-29T16:16:00', '70642815', 'Jorge Salinas Cruz', 19.87, 3.58, 23.45, 2.55),
(13, 513, 'B001', '00000011', '2026-10-31T17:21:00', '48261375', 'Andrea Paredes Rios', 26.27, 4.73, 31.00, 4.00);
GO

/* Detalle de boleta: copia la descripcion y el precio aplicado del pedido.
   Se conserva el precio historico aunque el precio actual del producto cambie. */
INSERT INTO dbo.detalle_boleta
(id_boleta, id_producto, descripcion, cantidad, precio_unitario)
SELECT b.id_boleta, dp.id_producto, pr.nombre, dp.cantidad, dp.precio_aplicado
FROM dbo.boleta AS b
INNER JOIN dbo.pago AS pa ON pa.id_pago = b.id_pago
INNER JOIN dbo.detalle_pedido AS dp ON dp.id_pedido = pa.id_pedido
INNER JOIN dbo.producto AS pr ON pr.id_producto = dp.id_producto;
GO

PRINT 'Datos de prueba insertados correctamente.';
GO
