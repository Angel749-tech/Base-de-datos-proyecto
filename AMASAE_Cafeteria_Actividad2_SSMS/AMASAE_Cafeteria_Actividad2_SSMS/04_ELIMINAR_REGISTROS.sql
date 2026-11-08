/*
    PUNTO I: ELIMINAR REGISTROS CON DELETE.
    Se elimina un pedido de prueba que está PENDIENTE y no tiene pago ni boleta.
    Primero se elimina su detalle para respetar la FK detalle_pedido -> pedido.
*/
USE AMASAE_Cafeteria;
GO

SET XACT_ABORT ON;
BEGIN TRY
    BEGIN TRANSACTION;

    IF EXISTS
    (
        SELECT 1
        FROM dbo.pedido
        WHERE id_pedido = 1008
          AND estado = 'PENDIENTE'
    )
    AND NOT EXISTS (SELECT 1 FROM dbo.pago WHERE id_pedido = 1008)
    BEGIN
        DELETE FROM dbo.detalle_pedido
        WHERE id_pedido = 1008;

        DELETE FROM dbo.pedido
        WHERE id_pedido = 1008
          AND estado = 'PENDIENTE';

        COMMIT TRANSACTION;
        PRINT 'Pedido de prueba 1008 y su detalle eliminados correctamente.';
    END
    ELSE
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'No se eliminó el pedido: no existe, no está pendiente o tiene un pago asociado.';
    END;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    THROW;
END CATCH;
GO

-- Verificar que ya no exista el pedido 1008.
SELECT *
FROM dbo.pedido
WHERE id_pedido = 1008;
GO
