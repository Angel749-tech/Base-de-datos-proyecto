-- AMASAE PASTRY & CO. - SEMANA 9
-- Datos simulados para la exposicion: ejecutar una sola vez DESPUES de 01.
USE amasae_bd;

INSERT INTO categoria VALUES
(1,'Cafes','Bebidas con cafe'),(2,'Tortas','Porciones de tortas'),
(3,'Batidos','Batidos de fruta'),(4,'Bubble teas','Te con perlas'),
(5,'Sanguches','Preparaciones saladas'),(6,'Pasteleria','Productos horneados'),
(7,'Postres','Postres por porcion');

-- Los IDs de cliente parecen DNI, pero son numeros inventados.
INSERT INTO cliente VALUES
(90010001,'Valeria Rojas',NULL,NULL),(90010002,'Jorge Salinas',NULL,NULL),
(90010003,'Camila Mendoza',NULL,NULL),(90010004,'Luis Herrera',NULL,NULL),
(90010005,'Andrea Paredes',NULL,NULL),(90010006,'Diego Flores',NULL,NULL);

INSERT INTO empleado VALUES
(1,'Elena Torres','Cajera',1),(2,'Diego Rios','Barista',1),
(3,'Patricia Leon','Atencion',1),(4,'Miguel Vera','Administrador',1);

INSERT INTO metodo_pago VALUES
(1,'Efectivo',1),(2,'Yape',1),(3,'Plin',1),(4,'Tarjeta',1);

-- Proveedores ficticios: nombres ilustrativos, no empresas verificadas.
INSERT INTO proveedor VALUES
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
