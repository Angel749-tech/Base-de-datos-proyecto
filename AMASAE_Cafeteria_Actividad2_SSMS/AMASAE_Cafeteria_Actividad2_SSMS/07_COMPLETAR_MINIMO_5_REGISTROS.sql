/*
 ACTIVIDAD 2 - COMPLETAR MINIMO 5 REGISTROS POR TABLA
 Ejecutar una sola vez, despues de 02_INSERTAR_DATOS.sql.
 Inserta registros solo en las tablas que tenian menos de cinco filas.
*/
USE AMASAE_Cafeteria;
GO

-- EMPLEADO: el modelo inicial tenia 4 registros; se agregan 2.
IF NOT EXISTS (SELECT 1 FROM dbo.empleado WHERE id_empleado = 5)
    INSERT INTO dbo.empleado (id_empleado, nombre, cargo, activo, telefono, correo)
    VALUES (5, 'Rosa Campos', 'Barista', 1, '987654321', 'rosa.campos@example.com');
IF NOT EXISTS (SELECT 1 FROM dbo.empleado WHERE id_empleado = 6)
    INSERT INTO dbo.empleado (id_empleado, nombre, cargo, activo, telefono, correo)
    VALUES (6, 'Carlos Medina', 'Cajero', 1, '987654322', 'carlos.medina@example.com');
GO

-- METODO_PAGO: el modelo inicial tenia 4 registros; se agregan 2.
IF NOT EXISTS (SELECT 1 FROM dbo.metodo_pago WHERE id_metodo = 5)
    INSERT INTO dbo.metodo_pago (id_metodo, nombre, activo)
    VALUES (5, 'Transferencia bancaria', 1);
IF NOT EXISTS (SELECT 1 FROM dbo.metodo_pago WHERE id_metodo = 6)
    INSERT INTO dbo.metodo_pago (id_metodo, nombre, activo)
    VALUES (6, 'Pago QR', 1);
GO

-- DESCUENTO_DIA_SEMANA: el modelo inicial tenia 3 registros; se agregan 4.
-- 1 = lunes, 2 = martes, 3 = miercoles, 4 = jueves, 5 = viernes,
-- 6 = sabado, 7 = domingo.
IF NOT EXISTS (SELECT 1 FROM dbo.descuento_dia_semana WHERE id_descuento = 20 AND dia_semana = 2)
    INSERT INTO dbo.descuento_dia_semana (id_descuento, dia_semana) VALUES (20, 2);
IF NOT EXISTS (SELECT 1 FROM dbo.descuento_dia_semana WHERE id_descuento = 20 AND dia_semana = 3)
    INSERT INTO dbo.descuento_dia_semana (id_descuento, dia_semana) VALUES (20, 3);
IF NOT EXISTS (SELECT 1 FROM dbo.descuento_dia_semana WHERE id_descuento = 21 AND dia_semana = 5)
    INSERT INTO dbo.descuento_dia_semana (id_descuento, dia_semana) VALUES (21, 5);
IF NOT EXISTS (SELECT 1 FROM dbo.descuento_dia_semana WHERE id_descuento = 22 AND dia_semana = 7)
    INSERT INTO dbo.descuento_dia_semana (id_descuento, dia_semana) VALUES (22, 7);
GO

-- VERIFICACION: cada tabla debe mostrar un total igual o superior a 5.
SELECT 'categoria' AS tabla, COUNT(*) AS total_registros FROM dbo.categoria
UNION ALL SELECT 'cliente', COUNT(*) FROM dbo.cliente
UNION ALL SELECT 'empleado', COUNT(*) FROM dbo.empleado
UNION ALL SELECT 'metodo_pago', COUNT(*) FROM dbo.metodo_pago
UNION ALL SELECT 'proveedor', COUNT(*) FROM dbo.proveedor
UNION ALL SELECT 'producto', COUNT(*) FROM dbo.producto
UNION ALL SELECT 'descuento', COUNT(*) FROM dbo.descuento
UNION ALL SELECT 'descuento_categoria', COUNT(*) FROM dbo.descuento_categoria
UNION ALL SELECT 'descuento_dia_semana', COUNT(*) FROM dbo.descuento_dia_semana
UNION ALL SELECT 'pedido', COUNT(*) FROM dbo.pedido
UNION ALL SELECT 'detalle_pedido', COUNT(*) FROM dbo.detalle_pedido
UNION ALL SELECT 'pago', COUNT(*) FROM dbo.pago
UNION ALL SELECT 'producto_proveedor', COUNT(*) FROM dbo.producto_proveedor
UNION ALL SELECT 'inventario', COUNT(*) FROM dbo.inventario
UNION ALL SELECT 'boleta', COUNT(*) FROM dbo.boleta
UNION ALL SELECT 'detalle_boleta', COUNT(*) FROM dbo.detalle_boleta
ORDER BY tabla;
GO
