-- AMASAE PASTRY & CO. - SEMANA 9
-- Datos simulados para la exposicion: ejecutar una sola vez DESPUES de 01.
USE amasae_bd_v2;

INSERT INTO categoria VALUES
(1,'Cafes','Bebidas con cafe'),(2,'Tortas','Porciones de tortas'),
(3,'Batidos','Batidos de fruta'),(4,'Bubble teas','Te con perlas'),
(5,'Sanguches','Preparaciones saladas'),(6,'Pasteleria','Productos horneados'),
(7,'Postres','Postres por porcion');

-- Los IDs de cliente parecen DNI, pero son numeros inventados.
INSERT INTO cliente (id_cliente,nombre,telefono,correo) VALUES
(90010001,'Valeria Rojas',NULL,NULL),(90010002,'Jorge Salinas',NULL,NULL),
(90010003,'Camila Mendoza',NULL,NULL),(90010004,'Luis Herrera',NULL,NULL),
(90010005,'Andrea Paredes',NULL,NULL),(90010006,'Diego Flores',NULL,NULL);

INSERT INTO empleado VALUES
(1,'Elena Torres','Cajera',1),(2,'Diego Rios','Barista',1),
(3,'Patricia Leon','Atencion',1),(4,'Miguel Vera','Administrador',1);

INSERT INTO metodo_pago VALUES
(1,'Efectivo',1),(2,'Yape',1),(3,'Plin',1),(4,'Tarjeta',1);

-- Proveedores ficticios: nombres ilustrativos, no empresas verificadas.
INSERT INTO proveedor (id_proveedor,razon_social,contacto,telefono,activo) VALUES
(1,'Insumos Cafeteros Demo',NULL,NULL,1),
(2,'Lacteos y Frutas Demo',NULL,NULL,1),
(3,'Panaderia Mayorista Demo',NULL,NULL,1),
(4,'Insumos para Te Demo',NULL,NULL,1);

INSERT INTO producto VALUES
(101,1,'Cafe americano','Taza caliente',8.00,1),
(102,1,'Capuchino','Cafe con leche',12.00,1),
(201,2,'Torta de chocolate','Porcion',15.00,1),
(202,2,'Torta tres leches','Porcion',16.00,1),
(301,3,'Batido de fresa','Vaso mediano',14.00,1),
(302,3,'Batido de lucuma','Vaso mediano',16.00,1),
(401,4,'Bubble tea de taro','Vaso mediano',17.00,1),
(402,4,'Bubble tea de mango','Vaso mediano',17.00,1),
(501,5,'Sanguche de pollo','Pan con pollo',15.00,1),
(502,5,'Sanguche mixto','Jamon y queso',12.00,1),
(601,6,'Croissant','Pieza horneada',9.00,1),
(701,7,'Cheesecake','Porcion',16.00,1);

INSERT INTO pedido VALUES
(1001,90010001,1,'2026-10-14 09:20:00','PAGADO'),
(1002,90010002,3,'2026-10-14 10:05:00','PAGADO'),
(1003,NULL,1,'2026-10-14 11:30:00','PAGADO'),
(1004,90010003,3,'2026-10-14 13:00:00','PAGADO'),
(1005,90010004,1,'2026-10-15 09:45:00','PAGADO'),
(1006,NULL,3,'2026-10-15 15:20:00','PAGADO'),
(1007,90010005,1,'2026-10-15 17:10:00','PAGADO'),
(1008,90010006,3,'2026-10-16 10:00:00','PENDIENTE');

INSERT INTO detalle_pedido VALUES
(1001,101,1,8.00),(1001,601,1,9.00),
(1002,401,1,17.00),(1002,201,1,15.00),
(1003,301,2,14.00),
(1004,501,1,15.00),(1004,102,1,12.00),
(1005,202,2,16.00),(1005,701,1,16.00),
(1006,402,1,17.00),(1006,502,1,12.00),
(1007,302,1,16.00),(1007,601,2,9.00),
(1008,101,1,8.00),(1008,201,1,15.00);

-- Los montos corresponden a la suma de los productos de cada pedido.
-- El pedido 1008 esta pendiente y no registra pago.
INSERT INTO pago VALUES
(501,1001,1,'2026-10-14 09:25:00',17.00),
(502,1002,2,'2026-10-14 10:10:00',32.00),
(503,1003,3,'2026-10-14 11:35:00',28.00),
(504,1004,4,'2026-10-14 13:05:00',27.00),
(505,1005,2,'2026-10-15 09:50:00',48.00),
(506,1006,1,'2026-10-15 15:25:00',29.00),
(507,1007,3,'2026-10-15 17:15:00',34.00);

INSERT INTO producto_proveedor VALUES
(101,1),(102,1),(201,2),(202,2),(301,2),(302,2),
(401,4),(402,4),(501,3),(502,3),(601,3),(701,2);

-- El stock se usa solo en productos terminados; bebidas a pedido no lo requieren.
INSERT INTO inventario VALUES
(201,8,3,'2026-10-16 18:00:00'),(202,6,3,'2026-10-16 18:00:00'),
(501,10,4,'2026-10-16 18:00:00'),(502,12,4,'2026-10-16 18:00:00'),
(601,15,5,'2026-10-16 18:00:00'),(701,7,3,'2026-10-16 18:00:00');

SELECT 'Inserciones finalizadas. Revisa las tablas con el archivo 03.' AS resultado;

-- COMPLETAR Y DEMOSTRAR BOLETAS/FACTURAS
-- AMASAE V2 | DATOS COMPLEMENTARIOS (SIMULADOS) | Ejecutar UNA vez.
-- ANTES se debe ejecutar 01_MIGRAR_BASE_EXISTENTE.sql
-- Los correos example.test, RUC y DNI son ficticios. No usar en SUNAT.
USE amasae_bd_v2;
START TRANSACTION;

-- Completar los 6 clientes originales sin cambiar sus PK ni sus pedidos.
UPDATE cliente SET
 tipo_documento = 'DNI',
 numero_documento = CAST(id_cliente AS CHAR),
 telefono = CASE id_cliente
  WHEN 90010001 THEN '900000001' WHEN 90010002 THEN '900000002'
  WHEN 90010003 THEN '900000003' WHEN 90010004 THEN '900000004'
  WHEN 90010005 THEN '900000005' WHEN 90010006 THEN '900000006'
 END,
 correo = CASE id_cliente
  WHEN 90010001 THEN 'valeria.rojas@example.test'
  WHEN 90010002 THEN 'jorge.salinas@example.test'
  WHEN 90010003 THEN 'camila.mendoza@example.test'
  WHEN 90010004 THEN 'luis.herrera@example.test'
  WHEN 90010005 THEN 'andrea.paredes@example.test'
  WHEN 90010006 THEN 'diego.flores@example.test'
 END,
 direccion = CONCAT('Direccion ficticia, Lima - cliente ', id_cliente)
WHERE id_cliente BETWEEN 90010001 AND 90010006;

-- Clientes corporativos para demostrar la emision de FACTURAS.
INSERT INTO cliente
 (id_cliente,nombre,telefono,correo,tipo_documento,numero_documento,razon_social,direccion)
VALUES
 (90010007,'Compras Institucionales Demo SAC','900000007',
  'compras.institucionales@example.test','RUC','20699999001',
  'Compras Institucionales Demo S.A.C.','Av. Ejemplo 101, Lima (ficticia)'),
 (90010008,'Eventos Corporativos Demo SAC','900000008',
  'eventos.corporativos@example.test','RUC','20699999002',
  'Eventos Corporativos Demo S.A.C.','Jr. Modelo 202, Lima (ficticia)');

-- Completar los 4 proveedores existentes.
UPDATE proveedor SET
 ruc = CASE id_proveedor
  WHEN 1 THEN '20999999101' WHEN 2 THEN '20999999102'
  WHEN 3 THEN '20999999103' WHEN 4 THEN '20999999104' END,
 contacto = CASE id_proveedor
  WHEN 1 THEN 'Ana Demo' WHEN 2 THEN 'Marco Demo'
  WHEN 3 THEN 'Luz Demo' WHEN 4 THEN 'Pedro Demo' END,
 telefono = CASE id_proveedor
  WHEN 1 THEN '900000021' WHEN 2 THEN '900000022'
  WHEN 3 THEN '900000023' WHEN 4 THEN '900000024' END,
 correo = CONCAT('proveedor',id_proveedor,'@example.test'),
 direccion = CONCAT('Almacen ficticio ', id_proveedor, ', Lima')
WHERE id_proveedor BETWEEN 1 AND 4;

-- Dos proveedores nuevos: para empaques y reposteria.
INSERT INTO proveedor
 (id_proveedor,razon_social,contacto,telefono,activo,ruc,correo,direccion)
VALUES
 (5,'Reposteria y Frutos Secos Demo','Sofia Demo','900000025',1,
  '20999999105','reposteria@example.test','Av. Simulada 505, Lima'),
 (6,'Empaques Ecologicos Demo','Oscar Demo','900000026',1,
  '20999999106','empaques@example.test','Av. Simulada 606, Lima');

-- Datos ficticios del negocio emisor; NO corresponde a un RUC registrado.
INSERT INTO empresa_emisora
 (id_emisor,ruc,razon_social,nombre_comercial,direccion_fiscal,telefono,correo,activo)
VALUES
 (1,'20999999999','Amasae Pasteleria Demo S.A.C.','Amasae Pastry & Co.',
  'Direccion de demostracion, Lima, Peru','900000030','ventas@amasae.example.test',1);

-- Cuatro productos nuevos, con sus categorias existentes.
INSERT INTO producto
 (id_producto,id_categoria,nombre,descripcion,precio_actual,activo)
VALUES
 (103,1,'Mocha','Cafe con chocolate',14.00,1),
 (203,2,'Torta de zanahoria','Porcion',14.00,1),
 (602,6,'Pan de chocolate','Pieza horneada',11.00,1),
 (702,7,'Brownie','Porcion',10.00,1);

-- Nuevas relaciones con los proveedores (incluidas relaciones N:M adicionales).
INSERT INTO producto_proveedor (id_producto,id_proveedor) VALUES
 (103,1),(203,2),(602,3),(702,3),
 (702,5),(201,5),(501,6),(601,6);

-- Solo inventario de productos terminados (no bebidas preparadas al pedido).
INSERT INTO inventario
 (id_producto,stock_actual,stock_minimo,fecha_actualizacion) VALUES
 (203,6,2,'2026-10-16 18:00:00'),
 (602,8,3,'2026-10-16 18:00:00'),
 (702,10,3,'2026-10-16 18:00:00');

-- Dos ventas nuevas a clientes que requieren FACTURA.
INSERT INTO pedido
 (id_pedido,id_cliente,id_empleado,fecha_hora,estado) VALUES
 (1009,90010007,1,'2026-10-17 09:10:00','PAGADO'),
 (1010,90010008,3,'2026-10-17 12:30:00','PAGADO');

-- Pedido 1009: 3 x 14 + 2 x 12 = S/ 66.00.
-- Pedido 1010: 2 x 15 + 4 x 10 + 1 x 9 = S/ 79.00.
INSERT INTO detalle_pedido
 (id_pedido,id_producto,cantidad,precio_aplicado) VALUES
 (1009,203,3,14.00),(1009,102,2,12.00),
 (1010,201,2,15.00),(1010,702,4,10.00),(1010,601,1,9.00);

INSERT INTO pago
 (id_pago,id_pedido,id_metodo,fecha_hora,monto) VALUES
 (508,1009,4,'2026-10-17 09:15:00',66.00),
 (509,1010,2,'2026-10-17 12:35:00',79.00);

-- Boletas de los siete pedidos pagados existentes.
-- Precios y pagos iniciales se asumen INCLUIDOS el 18% del tributo aplicable
-- a operaciones gravadas para este ejercicio académico.
INSERT INTO comprobante
 (id_comprobante,id_pedido,id_emisor,tipo,serie,numero,fecha_emision,
  receptor_tipo_documento,receptor_numero_documento,receptor_nombre,receptor_direccion,
  base_gravada,igv,total,estado)
SELECT 3000 + (p.id_pedido - 1000), p.id_pedido, 1, 'BOLETA','B001',
       p.id_pedido - 1000, DATE_ADD(pg.fecha_hora, INTERVAL 1 MINUTE),
       c.tipo_documento,c.numero_documento,c.nombre,c.direccion,
       ROUND(pg.monto / 1.18, 2),
       pg.monto - ROUND(pg.monto / 1.18, 2),pg.monto,'EMITIDO'
FROM pedido p
JOIN pago pg ON pg.id_pedido = p.id_pedido
LEFT JOIN cliente c ON c.id_cliente = p.id_cliente
WHERE p.id_pedido BETWEEN 1001 AND 1007 AND p.estado = 'PAGADO';

-- Facturas F001-1 y F001-2 a los dos clientes corporativos.
INSERT INTO comprobante
 (id_comprobante,id_pedido,id_emisor,tipo,serie,numero,fecha_emision,
  receptor_tipo_documento,receptor_numero_documento,receptor_nombre,receptor_direccion,
  base_gravada,igv,total,estado)
SELECT 3000 + (p.id_pedido - 1000), p.id_pedido, 1, 'FACTURA','F001',
       p.id_pedido - 1008, DATE_ADD(pg.fecha_hora, INTERVAL 1 MINUTE),
       c.tipo_documento,c.numero_documento,c.razon_social,c.direccion,
       ROUND(pg.monto / 1.18, 2),
       pg.monto - ROUND(pg.monto / 1.18, 2),pg.monto,'EMITIDO'
FROM pedido p
JOIN pago pg ON pg.id_pedido = p.id_pedido
JOIN cliente c ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IN (1009,1010)
  AND p.estado = 'PAGADO' AND c.tipo_documento = 'RUC';

COMMIT;
SELECT 'Carga V2 finalizada: verificar con 03_VALIDAR_CONSULTAR_V2.sql' AS resultado;
