/*
    CONSULTAS DE VERIFICACION Y EVIDENCIA DEL PROYECTO.
*/
USE AMASAE_Cafeteria;
GO

-- 1. Listar todas las tablas creadas.
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;
GO

-- 2. Productos y categorias.
SELECT p.id_producto, p.nombre AS producto, c.nombre AS categoria,
       p.precio_actual, p.unidad_venta, p.activo
FROM dbo.producto p
INNER JOIN dbo.categoria c ON c.id_categoria = p.id_categoria
ORDER BY c.nombre, p.nombre;
GO

-- 3. Inventario y alerta de stock.
SELECT p.nombre, i.stock_actual, i.stock_minimo, i.stock_maximo,
       CASE WHEN i.stock_actual <= i.stock_minimo THEN 'REABASTECER'
            ELSE 'STOCK DISPONIBLE' END AS estado_stock
FROM dbo.inventario i
INNER JOIN dbo.producto p ON p.id_producto = i.id_producto
ORDER BY estado_stock DESC, p.nombre;
GO

-- 4. Pedidos con cliente y empleado.
SELECT pe.id_pedido, pe.fecha_hora, pe.estado, pe.modalidad_venta,
       COALESCE(cl.nombre, 'Consumidor final') AS cliente,
       em.nombre AS empleado
FROM dbo.pedido pe
LEFT JOIN dbo.cliente cl ON cl.id_cliente = pe.id_cliente
INNER JOIN dbo.empleado em ON em.id_empleado = pe.id_empleado
ORDER BY pe.id_pedido;
GO

-- 5. Detalle de ventas.
SELECT dp.id_pedido, pr.nombre AS producto, dp.cantidad,
       dp.precio_aplicado,
       CONVERT(DECIMAL(12,2), dp.cantidad * dp.precio_aplicado) AS importe
FROM dbo.detalle_pedido dp
INNER JOIN dbo.producto pr ON pr.id_producto = dp.id_producto
ORDER BY dp.id_pedido, pr.nombre;
GO

-- 6. Pagos y metodo utilizado.
SELECT pa.id_pago, pa.id_pedido, mp.nombre AS metodo_pago,
       pa.fecha_hora, pa.monto, pa.referencia_operacion
FROM dbo.pago pa
INNER JOIN dbo.metodo_pago mp ON mp.id_metodo = pa.id_metodo
ORDER BY pa.id_pago;
GO

-- 7. Boletas emitidas.
SELECT b.id_boleta, b.serie, b.numero, b.fecha_emision,
       b.receptor_nombre, b.subtotal, b.igv, b.descuento_aplicado, b.total
FROM dbo.boleta b
ORDER BY b.id_boleta;
GO

-- 8. Detalle de cada boleta.
SELECT b.serie, b.numero, db.descripcion, db.cantidad,
       db.precio_unitario, db.importe
FROM dbo.boleta b
INNER JOIN dbo.detalle_boleta db ON db.id_boleta = b.id_boleta
ORDER BY b.id_boleta, db.descripcion;
GO

-- 9. Promociones por categoria.
SELECT d.nombre AS promocion, d.tipo_descuento, d.porcentaje,
       c.nombre AS categoria, d.fecha_inicio, d.fecha_fin
FROM dbo.descuento d
INNER JOIN dbo.descuento_categoria dc ON dc.id_descuento = d.id_descuento
INNER JOIN dbo.categoria c ON c.id_categoria = dc.id_categoria
ORDER BY d.id_descuento, c.nombre;
GO

-- 10. Proveedores de cada producto.
SELECT p.nombre AS producto, pr.razon_social AS proveedor,
       pp.plazo_entrega_dias
FROM dbo.producto_proveedor pp
INNER JOIN dbo.producto p ON p.id_producto = pp.id_producto
INNER JOIN dbo.proveedor pr ON pr.id_proveedor = pp.id_proveedor
ORDER BY p.nombre;
GO

-- 11. Validar consistencia del importe de boletas.
-- Debe devolver cero filas: el total más el descuento debe coincidir
-- con la suma de los importes de los productos.
SELECT b.id_boleta, b.total, b.descuento_aplicado,
       SUM(db.importe) AS bruto_detalle
FROM dbo.boleta b
INNER JOIN dbo.detalle_boleta db ON db.id_boleta = b.id_boleta
GROUP BY b.id_boleta, b.total, b.descuento_aplicado
HAVING ABS((b.total + b.descuento_aplicado) - SUM(db.importe)) > 0.02;
GO

-- 12. Validar pagos contra total del pedido menos descuento.
-- Debe devolver cero filas.
SELECT pa.id_pago, pa.monto, pe.id_pedido,
       SUM(dp.cantidad * dp.precio_aplicado) - pe.descuento_aplicado AS total_esperado
FROM dbo.pago pa
INNER JOIN dbo.pedido pe ON pe.id_pedido = pa.id_pedido
INNER JOIN dbo.detalle_pedido dp ON dp.id_pedido = pe.id_pedido
GROUP BY pa.id_pago, pa.monto, pe.id_pedido, pe.descuento_aplicado
HAVING ABS(pa.monto - (SUM(dp.cantidad * dp.precio_aplicado) - pe.descuento_aplicado)) > 0.02;
GO

-- 13. Resumen de ventas por metodo de pago.
SELECT mp.nombre AS metodo_pago, COUNT(*) AS cantidad_pagos,
       SUM(pa.monto) AS total_recaudado
FROM dbo.pago pa
INNER JOIN dbo.metodo_pago mp ON mp.id_metodo = pa.id_metodo
GROUP BY mp.nombre
ORDER BY total_recaudado DESC;
GO

-- 14. Resumen de ventas por categoria.
SELECT c.nombre AS categoria,
       SUM(dp.cantidad) AS unidades_vendidas,
       SUM(dp.cantidad * dp.precio_aplicado) AS importe_bruto
FROM dbo.detalle_pedido dp
INNER JOIN dbo.producto p ON p.id_producto = dp.id_producto
INNER JOIN dbo.categoria c ON c.id_categoria = p.id_categoria
GROUP BY c.nombre
ORDER BY importe_bruto DESC;
GO

-- 15. Verificar archivos MDF, NDF y LDF de esta base.
SELECT name AS nombre_logico, type_desc, physical_name
FROM sys.database_files;
GO
