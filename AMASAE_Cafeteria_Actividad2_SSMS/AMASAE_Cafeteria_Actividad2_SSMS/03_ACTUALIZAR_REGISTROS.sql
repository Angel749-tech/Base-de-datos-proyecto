/*
    PUNTO H: ACTUALIZAR INFORMACION CON UPDATE.
    Los ejemplos son reversibles o están claramente identificados.
*/
USE AMASAE_Cafeteria;
GO

-- Ejemplo 1: actualizar el precio de un producto.
UPDATE dbo.producto
SET precio_actual = 8.50
WHERE id_producto = 101;
GO

-- Ejemplo 2: actualizar datos de contacto de un cliente.
UPDATE dbo.cliente
SET telefono = '986274154'
WHERE id_cliente = 90010001;
GO

-- Ejemplo 3: actualizar observaciones de un pedido.
UPDATE dbo.pedido
SET observaciones = 'Pedido para llevar - entregar con servilletas'
WHERE id_pedido = 1006;
GO

-- Verificar los cambios.
SELECT id_producto, nombre, precio_actual
FROM dbo.producto
WHERE id_producto = 101;

SELECT id_cliente, nombre, telefono
FROM dbo.cliente
WHERE id_cliente = 90010001;

SELECT id_pedido, modalidad_venta, observaciones
FROM dbo.pedido
WHERE id_pedido = 1006;
GO
