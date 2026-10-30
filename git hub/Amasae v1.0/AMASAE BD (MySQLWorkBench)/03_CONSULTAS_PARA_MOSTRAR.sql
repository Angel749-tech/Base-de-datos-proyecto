-- Consultas sencillas
USE amasae_bd;
SHOW TABLES;
SELECT * FROM categoria;
SELECT * FROM producto;
SELECT * FROM cliente;
SELECT * FROM pedido;
SELECT * FROM detalle_pedido;
SELECT * FROM pago;
SELECT * FROM inventario;

-- Cuantos registros tiene cada tabla: 11 filas de resultado.
SELECT 'categoria' AS tabla, COUNT(*) AS registros FROM categoria
UNION ALL SELECT 'cliente', COUNT(*) FROM cliente
UNION ALL SELECT 'empleado', COUNT(*) FROM empleado
UNION ALL SELECT 'metodo_pago', COUNT(*) FROM metodo_pago
UNION ALL SELECT 'proveedor', COUNT(*) FROM proveedor
UNION ALL SELECT 'producto', COUNT(*) FROM producto
UNION ALL SELECT 'pedido', COUNT(*) FROM pedido
UNION ALL SELECT 'detalle_pedido', COUNT(*) FROM detalle_pedido
UNION ALL SELECT 'pago', COUNT(*) FROM pago
UNION ALL SELECT 'producto_proveedor', COUNT(*) FROM producto_proveedor
UNION ALL SELECT 'inventario', COUNT(*) FROM inventario;

-- pedido y producto relacionados
SELECT d.id_pedido, p.nombre, d.cantidad,
       d.precio_aplicado, d.cantidad*d.precio_aplicado AS subtotal
FROM detalle_pedido d
JOIN producto p ON p.id_producto=d.id_producto
ORDER BY d.id_pedido;
