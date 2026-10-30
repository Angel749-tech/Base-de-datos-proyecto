-- AMASAE V2 | CONSULTAS DE VERIFICACION Y DEMOSTRACION
-- No modifica los datos: solo SELECT.
USE amasae_bd_v2;

-- A. Las 13 tablas esperadas.
SHOW TABLES;

-- B. Conteo esperado: 7,8,4,4,6,16,10,20,9,20,9,1,9 (orden listado).
SELECT 'categoria' tabla, COUNT(*) registros FROM categoria
UNION ALL SELECT 'cliente', COUNT(*) FROM cliente
UNION ALL SELECT 'empleado', COUNT(*) FROM empleado
UNION ALL SELECT 'metodo_pago', COUNT(*) FROM metodo_pago
UNION ALL SELECT 'proveedor', COUNT(*) FROM proveedor
UNION ALL SELECT 'producto', COUNT(*) FROM producto
UNION ALL SELECT 'pedido', COUNT(*) FROM pedido
UNION ALL SELECT 'detalle_pedido', COUNT(*) FROM detalle_pedido
UNION ALL SELECT 'pago', COUNT(*) FROM pago
UNION ALL SELECT 'producto_proveedor', COUNT(*) FROM producto_proveedor
UNION ALL SELECT 'inventario', COUNT(*) FROM inventario
UNION ALL SELECT 'empresa_emisora', COUNT(*) FROM empresa_emisora
UNION ALL SELECT 'comprobante', COUNT(*) FROM comprobante;

-- C. Boletas y facturas: serie, numero, receptor, impuestos y total.
SELECT c.tipo, CONCAT(c.serie,'-',LPAD(c.numero,8,'0')) AS numero_comprobante,
       c.id_pedido,c.fecha_emision,c.receptor_nombre,
       c.receptor_numero_documento,c.base_gravada,c.igv,c.total,c.estado
FROM comprobante c ORDER BY c.tipo,c.numero;

-- D. Reconciliacion: deben ser cero filas (pagos diferentes de subtotales).
SELECT p.id_pedido, p.monto AS monto_pago,
       SUM(d.cantidad*d.precio_aplicado) AS suma_detalles
FROM pago p JOIN detalle_pedido d ON d.id_pedido=p.id_pedido
GROUP BY p.id_pedido,p.monto
HAVING ABS(p.monto-SUM(d.cantidad*d.precio_aplicado))>0.01;

-- E. Reconciliacion: deben ser cero filas (comprobantes y pagos distintos).
SELECT c.id_comprobante,c.id_pedido,c.total,p.monto
FROM comprobante c JOIN pago p ON p.id_pedido=c.id_pedido
WHERE ABS(c.total-p.monto)>0.01;

-- F. NO debe haber comprobantes para pedidos pendientes o anulados.
SELECT c.id_comprobante,p.id_pedido,p.estado
FROM comprobante c JOIN pedido p ON p.id_pedido=c.id_pedido
WHERE p.estado <> 'PAGADO';

-- G. Pedidos pagados sin comprobante: debe dar cero filas en los datos de prueba.
SELECT p.id_pedido FROM pedido p
LEFT JOIN comprobante c ON c.id_pedido=p.id_pedido
WHERE p.estado='PAGADO' AND c.id_comprobante IS NULL;

-- H. El pedido 1008 permanece pendiente: debe aparecer sin pago ni comprobante.
SELECT p.id_pedido,p.estado,pg.id_pago,c.id_comprobante
FROM pedido p LEFT JOIN pago pg ON pg.id_pedido=p.id_pedido
LEFT JOIN comprobante c ON c.id_pedido=p.id_pedido
WHERE p.id_pedido=1008;

-- I. Datos fiscales y contacto (todos SIMULADOS).
SELECT id_cliente,nombre,tipo_documento,numero_documento,razon_social,
       telefono,correo,direccion FROM cliente ORDER BY id_cliente;
SELECT id_proveedor,razon_social,ruc,contacto,telefono,correo,direccion
FROM proveedor ORDER BY id_proveedor;

-- J. Productos con proveedores e inventarios, cuando existan.
SELECT pr.id_producto,pr.nombre AS producto,ca.nombre AS categoria,
       pv.razon_social AS proveedor,i.stock_actual
FROM producto pr JOIN categoria ca ON ca.id_categoria=pr.id_categoria
LEFT JOIN producto_proveedor pp ON pp.id_producto=pr.id_producto
LEFT JOIN proveedor pv ON pv.id_proveedor=pp.id_proveedor
LEFT JOIN inventario i ON i.id_producto=pr.id_producto
ORDER BY pr.id_producto,pv.id_proveedor;
