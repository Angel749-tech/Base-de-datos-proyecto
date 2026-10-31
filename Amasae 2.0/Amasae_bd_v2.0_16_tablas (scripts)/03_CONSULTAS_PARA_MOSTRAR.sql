USE `Amasae_bd_v2.0`;

SHOW TABLES;

SELECT * FROM categoria;
SELECT * FROM cliente;
SELECT * FROM empleado;
SELECT * FROM metodo_pago;
SELECT * FROM proveedor;
SELECT * FROM producto;
SELECT * FROM descuento;
SELECT * FROM descuento_categoria;
SELECT * FROM descuento_dia_semana;
SELECT * FROM pedido;
SELECT * FROM detalle_pedido;
SELECT * FROM pago;
SELECT * FROM producto_proveedor;
SELECT * FROM inventario;
SELECT * FROM comprobante;
SELECT * FROM detalle_comprobante;

-- Promociones por categoria.
SELECT d.nombre AS promocion, d.tipo_descuento, d.porcentaje,
       c.nombre AS categoria, d.fecha_inicio, d.fecha_fin
FROM descuento d
JOIN descuento_categoria dc ON dc.id_descuento = d.id_descuento
JOIN categoria c ON c.id_categoria = dc.id_categoria
ORDER BY d.id_descuento, c.nombre;

-- Dias semanales: 1 = lunes, 4 = jueves, 6 = sabado.
SELECT d.nombre AS promocion, ds.dia_semana, d.porcentaje,
       c.nombre AS categoria
FROM descuento d
JOIN descuento_dia_semana ds ON ds.id_descuento = d.id_descuento
JOIN descuento_categoria dc ON dc.id_descuento = d.id_descuento
JOIN categoria c ON c.id_categoria = dc.id_categoria
ORDER BY ds.dia_semana, c.nombre;

-- Descuentos sobre productos de categorias participantes.
SELECT pe.id_pedido, d.nombre AS promocion, d.porcentaje,
       ROUND(SUM(dp.cantidad * dp.precio_aplicado),2) AS total_bruto,
       ROUND(SUM(CASE WHEN dc.id_categoria IS NOT NULL
                      THEN dp.cantidad * dp.precio_aplicado ELSE 0 END),2) AS base_descuento,
       pe.descuento_aplicado,
       ROUND(SUM(dp.cantidad * dp.precio_aplicado) - pe.descuento_aplicado,2) AS total_final
FROM pedido pe
JOIN descuento d ON d.id_descuento = pe.id_descuento
JOIN detalle_pedido dp ON dp.id_pedido = pe.id_pedido
JOIN producto pr ON pr.id_producto = dp.id_producto
LEFT JOIN descuento_categoria dc
  ON dc.id_descuento = d.id_descuento AND dc.id_categoria = pr.id_categoria
GROUP BY pe.id_pedido, d.nombre, d.porcentaje, pe.descuento_aplicado
ORDER BY pe.id_pedido;

-- Ventas, pagos y comprobantes.
SELECT pe.id_pedido, pe.fecha_hora, pe.estado, pa.monto AS monto_pagado,
       co.tipo, co.serie, co.numero, co.total AS total_comprobante
FROM pedido pe
LEFT JOIN pago pa ON pa.id_pedido = pe.id_pedido
LEFT JOIN comprobante co ON co.id_pago = pa.id_pago
ORDER BY pe.id_pedido;

SELECT pr.nombre, ca.nombre AS categoria, i.stock_actual, i.stock_minimo, i.stock_maximo
FROM producto pr
JOIN categoria ca ON ca.id_categoria = pr.id_categoria
LEFT JOIN inventario i ON i.id_producto = pr.id_producto
ORDER BY ca.nombre, pr.nombre;

-- Validaciones: estas consultas deben devolver cero filas.
SELECT pa.id_pago, pa.monto,
       ROUND(SUM(dp.cantidad * dp.precio_aplicado) - pe.descuento_aplicado,2) AS esperado
FROM pago pa
JOIN pedido pe ON pe.id_pedido = pa.id_pedido
JOIN detalle_pedido dp ON dp.id_pedido = pe.id_pedido
GROUP BY pa.id_pago, pa.monto, pe.descuento_aplicado
HAVING ABS(pa.monto - esperado) > 0.001;

SELECT co.id_comprobante, co.total, co.descuento_aplicado,
       ROUND(SUM(dc.cantidad * dc.precio_unitario),2) AS bruto_detalle
FROM comprobante co
JOIN detalle_comprobante dc ON dc.id_comprobante = co.id_comprobante
GROUP BY co.id_comprobante, co.total, co.descuento_aplicado
HAVING ABS((co.total + co.descuento_aplicado) - bruto_detalle) > 0.001;

SELECT pe.id_pedido, pe.descuento_aplicado,
       ROUND(SUM(CASE WHEN dc.id_categoria IS NOT NULL
                      THEN dp.cantidad * dp.precio_aplicado ELSE 0 END)
             * d.porcentaje / 100.0,2) AS esperado
FROM pedido pe
JOIN descuento d ON d.id_descuento = pe.id_descuento
JOIN detalle_pedido dp ON dp.id_pedido = pe.id_pedido
JOIN producto pr ON pr.id_producto = dp.id_producto
LEFT JOIN descuento_categoria dc
  ON dc.id_descuento = d.id_descuento AND dc.id_categoria = pr.id_categoria
GROUP BY pe.id_pedido, pe.descuento_aplicado, d.porcentaje
HAVING ABS(pe.descuento_aplicado - esperado) > 0.001;

SELECT pe.id_pedido, d.nombre, pe.fecha_hora
FROM pedido pe
JOIN descuento d ON d.id_descuento = pe.id_descuento
WHERE DATE(pe.fecha_hora) NOT BETWEEN d.fecha_inicio AND d.fecha_fin
   OR (d.tipo_descuento = 'SEMANAL'
       AND NOT EXISTS (
         SELECT 1 FROM descuento_dia_semana ds
         WHERE ds.id_descuento = d.id_descuento
           AND ds.dia_semana = WEEKDAY(pe.fecha_hora) + 1
       ));

SELECT pr.id_producto, pr.nombre
FROM producto pr
LEFT JOIN inventario i ON i.id_producto = pr.id_producto
WHERE i.id_producto IS NULL;
