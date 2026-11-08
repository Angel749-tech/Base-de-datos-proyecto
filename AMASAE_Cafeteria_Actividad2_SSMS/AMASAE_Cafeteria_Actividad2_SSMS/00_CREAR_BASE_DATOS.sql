/*
    PROYECTO: AMASAE - SISTEMA DE GESTION DE CAFETERIA
    MOTOR: Microsoft SQL Server
    OBJETIVO: Crear la base de datos con archivos MDF, NDF y LDF.

    NOTA:
    - El script intenta obtener las rutas predeterminadas de la instancia.
    - La cuenta del servicio de SQL Server debe tener permisos de escritura.
    - Ejecutar conectado a la base master.
*/
USE master;
GO

IF DB_ID(N'AMASAE_Cafeteria') IS NOT NULL
BEGIN
    PRINT N'La base de datos AMASAE_Cafeteria ya existe. No se modificó.';
END
ELSE
BEGIN
    DECLARE @DataPath NVARCHAR(4000) =
        CONVERT(NVARCHAR(4000), SERVERPROPERTY('InstanceDefaultDataPath'));
    DECLARE @LogPath NVARCHAR(4000) =
        CONVERT(NVARCHAR(4000), SERVERPROPERTY('InstanceDefaultLogPath'));

    -- Compatibilidad: si la instancia no informa las rutas predeterminadas,
    -- se obtienen a partir de la ubicación de los archivos de master.
    IF @DataPath IS NULL OR LEN(@DataPath) = 0
    BEGIN
        SELECT @DataPath =
            LEFT(physical_name, LEN(physical_name) - CHARINDEX('\', REVERSE(physical_name)) + 1)
        FROM sys.master_files
        WHERE database_id = DB_ID(N'master') AND file_id = 1;
    END;

    IF @LogPath IS NULL OR LEN(@LogPath) = 0
    BEGIN
        SELECT @LogPath =
            LEFT(physical_name, LEN(physical_name) - CHARINDEX('\', REVERSE(physical_name)) + 1)
        FROM sys.master_files
        WHERE database_id = DB_ID(N'master') AND file_id = 2;
    END;

    IF @DataPath IS NULL OR @LogPath IS NULL
    BEGIN
        THROW 50001, 'No se pudieron determinar las rutas de datos y log. Configure las rutas manualmente en este script.', 1;
    END;

    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL = N'
    CREATE DATABASE [AMASAE_Cafeteria]
    ON PRIMARY
    (
        NAME = N''AMASAE_Cafeteria_Primary'',
        FILENAME = N''' + REPLACE(@DataPath + N'AMASAE_Cafeteria.mdf', N'''', N'''''') + N''',
        SIZE = 20MB,
        MAXSIZE = 500MB,
        FILEGROWTH = 10MB
    ),
    (
        NAME = N''AMASAE_Cafeteria_Secondary'',
        FILENAME = N''' + REPLACE(@DataPath + N'AMASAE_Cafeteria_02.ndf', N'''', N'''''') + N''',
        SIZE = 10MB,
        MAXSIZE = 250MB,
        FILEGROWTH = 10MB
    )
    LOG ON
    (
        NAME = N''AMASAE_Cafeteria_Log'',
        FILENAME = N''' + REPLACE(@LogPath + N'AMASAE_Cafeteria_log.ldf', N'''', N'''''') + N''',
        SIZE = 10MB,
        MAXSIZE = 250MB,
        FILEGROWTH = 10MB
    );';

    EXEC sys.sp_executesql @SQL;
    PRINT N'Base de datos creada correctamente con MDF, NDF y LDF.';
END;
GO

SELECT
    name AS NombreArchivoLogico,
    type_desc AS TipoArchivo,
    physical_name AS RutaFisica,
    size * 8 / 1024 AS TamanoAproximadoMB
FROM sys.master_files
WHERE database_id = DB_ID(N'AMASAE_Cafeteria');
GO
