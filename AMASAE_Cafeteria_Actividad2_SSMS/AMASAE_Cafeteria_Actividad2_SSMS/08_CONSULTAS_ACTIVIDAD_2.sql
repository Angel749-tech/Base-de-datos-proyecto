/*
 ACTIVIDAD 2 - CONSULTAS DML / SELECT
 Ejecutar despues de 07_COMPLETAR_MINIMO_5_REGISTROS.sql.
 Incluye:
 1) Verificacion de minimo 5 registros por tabla.
 2) SELECT * de cada tabla.
 3) Alias para todas las columnas.
 4) Ordenamiento ascendente.
 5) DISTINCT de al menos una columna por tabla.
 6) WHERE con AND, OR y NOT.
 7) Funciones de agregado.
 8) GROUP BY.
 9) HAVING.
*/
USE AMASAE_Cafeteria;
GO

/* =========================================================
   1. VERIFICAR MINIMO CINCO REGISTROS POR TABLA
   ========================================================= */
SELECT 'categoria' AS tabla, COUNT(*) AS cantidad FROM dbo.categoria
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

/* =========================================================
   2. EXTRAER TODOS LOS DATOS DE CADA TABLA - SELECT *
   ========================================================= */
SELECT * FROM dbo.categoria;
SELECT * FROM dbo.cliente;
SELECT * FROM dbo.empleado;
SELECT * FROM dbo.metodo_pago;
SELECT * FROM dbo.proveedor;
SELECT * FROM dbo.producto;
SELECT * FROM dbo.descuento;
SELECT * FROM dbo.descuento_categoria;
SELECT * FROM dbo.descuento_dia_semana;
SELECT * FROM dbo.pedido;
SELECT * FROM dbo.detalle_pedido;
SELECT * FROM dbo.pago;
SELECT * FROM dbo.producto_proveedor;
SELECT * FROM dbo.inventario;
SELECT * FROM dbo.boleta;
SELECT * FROM dbo.detalle_boleta;
GO

/* =========================================================
   3. TODOS LOS DATOS CON ALIAS PARA CADA COLUMNA
   ========================================================= */
SELECT id_categoria AS CodigoCategoria, nombre AS NombreCategoria,
       descripcion AS DescripcionCategoria
FROM dbo.categoria;

SELECT id_cliente AS CodigoCliente, nombre AS NombreCliente,
       telefono AS TelefonoCliente, correo AS CorreoCliente,
       tipo_documento AS TipoDocumento, numero_documento AS NumeroDocumento,
       direccion AS DireccionCliente
FROM dbo.cliente;

SELECT id_empleado AS CodigoEmpleado, nombre AS NombreEmpleado,
       cargo AS Puesto, activo AS EstadoLaboral,
       telefono AS Telefono, correo AS Correo
FROM dbo.empleado;

SELECT id_metodo AS CodigoMetodo, nombre AS MetodoPago,
       activo AS EstadoMetodo
FROM dbo.metodo_pago;

SELECT id_proveedor AS CodigoProveedor, razon_social AS RazonSocial,
       contacto AS PersonaContacto, telefono AS TelefonoProveedor,
       activo AS EstadoProveedor, ruc AS NumeroRUC,
       correo AS CorreoProveedor, direccion AS DireccionProveedor
FROM dbo.proveedor;

SELECT id_producto AS CodigoProducto, id_categoria AS CodigoCategoria,
       nombre AS NombreProducto, descripcion AS DescripcionProducto,
       precio_actual AS PrecioVenta, activo AS EstadoProducto,
       unidad_venta AS UnidadDeVenta
FROM dbo.producto;

SELECT id_descuento AS CodigoDescuento, nombre AS NombrePromocion,
       motivo AS MotivoPromocion, tipo_descuento AS TipoPromocion,
       fecha_inicio AS FechaInicio, fecha_fin AS FechaFin,
       porcentaje AS PorcentajeDescuento, activo AS EstadoPromocion
FROM dbo.descuento;

SELECT id_descuento AS CodigoDescuento, id_categoria AS CodigoCategoria
FROM dbo.descuento_categoria;

SELECT id_descuento AS CodigoDescuento, dia_semana AS NumeroDia
FROM dbo.descuento_dia_semana;

SELECT id_pedido AS CodigoPedido, id_cliente AS CodigoCliente,
       id_empleado AS CodigoEmpleado, fecha_hora AS FechaPedido,
       estado AS EstadoPedido, modalidad_venta AS ModalidadVenta,
       id_descuento AS CodigoDescuento, descuento_aplicado AS ImporteDescuento,
       observaciones AS ObservacionesPedido
FROM dbo.pedido;

SELECT id_pedido AS CodigoPedido, id_producto AS CodigoProducto,
       cantidad AS CantidadSolicitada, precio_aplicado AS PrecioAplicado
FROM dbo.detalle_pedido;

SELECT id_pago AS CodigoPago, id_pedido AS CodigoPedido,
       id_metodo AS CodigoMetodoPago, fecha_hora AS FechaPago,
       monto AS ImportePagado, referencia_operacion AS ReferenciaOperacion
FROM dbo.pago;

SELECT id_producto AS CodigoProducto, id_proveedor AS CodigoProveedor,
       plazo_entrega_dias AS DiasEntrega
FROM dbo.producto_proveedor;

SELECT id_producto AS CodigoProducto, stock_actual AS ExistenciaActual,
       stock_minimo AS ExistenciaMinima, stock_maximo AS ExistenciaMaxima,
       fecha_actualizacion AS UltimaActualizacion
FROM dbo.inventario;

SELECT id_boleta AS CodigoBoleta, id_pago AS CodigoPago,
       serie AS SerieBoleta, numero AS NumeroBoleta,
       fecha_emision AS FechaEmision, receptor_documento AS DocumentoReceptor,
       receptor_nombre AS NombreReceptor, subtotal AS Subtotal,
       igv AS ImpuestoIGV, total AS TotalBoleta,
       descuento_aplicado AS DescuentoAplicado
FROM dbo.boleta;

SELECT id_boleta AS CodigoBoleta, id_producto AS CodigoProducto,
       descripcion AS DescripcionProducto, cantidad AS Cantidad,
       precio_unitario AS PrecioUnitario, importe AS ImporteLinea
FROM dbo.detalle_boleta;
GO

/* =========================================================
   4. TODOS LOS DATOS ORDENADOS ASCENDENTEMENTE
   ========================================================= */
SELECT * FROM dbo.categoria ORDER BY id_categoria ASC;
SELECT * FROM dbo.cliente ORDER BY id_cliente ASC;
SELECT * FROM dbo.empleado ORDER BY id_empleado ASC;
SELECT * FROM dbo.metodo_pago ORDER BY id_metodo ASC;
SELECT * FROM dbo.proveedor ORDER BY id_proveedor ASC;
SELECT * FROM dbo.producto ORDER BY id_producto ASC;
SELECT * FROM dbo.descuento ORDER BY id_descuento ASC;
SELECT * FROM dbo.descuento_categoria ORDER BY id_descuento ASC, id_categoria ASC;
SELECT * FROM dbo.descuento_dia_semana ORDER BY id_descuento ASC, dia_semana ASC;
SELECT * FROM dbo.pedido ORDER BY id_pedido ASC;
SELECT * FROM dbo.detalle_pedido ORDER BY id_pedido ASC, id_producto ASC;
SELECT * FROM dbo.pago ORDER BY id_pago ASC;
SELECT * FROM dbo.producto_proveedor ORDER BY id_producto ASC, id_proveedor ASC;
SELECT * FROM dbo.inventario ORDER BY id_producto ASC;
SELECT * FROM dbo.boleta ORDER BY id_boleta ASC;
SELECT * FROM dbo.detalle_boleta ORDER BY id_boleta ASC, id_producto ASC;
GO

/* =========================================================
   5. VALORES UNICOS CON DISTINCT - AL MENOS UNA COLUMNA POR TABLA
   ========================================================= */
SELECT DISTINCT nombre AS NombresCategoria FROM dbo.categoria;
SELECT DISTINCT tipo_documento AS TiposDocumento FROM dbo.cliente;
SELECT DISTINCT cargo AS Cargos FROM dbo.empleado;
SELECT DISTINCT nombre AS MetodosPago FROM dbo.metodo_pago;
SELECT DISTINCT razon_social AS Proveedores FROM dbo.proveedor;
SELECT DISTINCT unidad_venta AS UnidadesVenta FROM dbo.producto;
SELECT DISTINCT tipo_descuento AS TiposDescuento FROM dbo.descuento;
SELECT DISTINCT id_categoria AS CategoriasEnPromocion FROM dbo.descuento_categoria;
SELECT DISTINCT dia_semana AS DiasConPromocion FROM dbo.descuento_dia_semana;
SELECT DISTINCT estado AS EstadosPedido FROM dbo.pedido;
SELECT DISTINCT cantidad AS CantidadesVendidas FROM dbo.detalle_pedido;
SELECT DISTINCT id_metodo AS MetodosUtilizados FROM dbo.pago;
SELECT DISTINCT plazo_entrega_dias AS PlazosEntrega FROM dbo.producto_proveedor;
SELECT DISTINCT stock_actual AS StocksRegistrados FROM dbo.inventario;
SELECT DISTINCT receptor_nombre AS ReceptoresBoleta FROM dbo.boleta;
SELECT DISTINCT descripcion AS ProductosFacturadosEnBoleta FROM dbo.detalle_boleta;
GO

/* =========================================================
   6. FILTROS WHERE CON AND, OR Y NOT
   ========================================================= */
-- AND: categorias cuyo nombre no esta vacio y tienen descripcion.
SELECT * FROM dbo.categoria
WHERE nombre IS NOT NULL AND descripcion IS NOT NULL;

-- OR: clientes registrados con DNI o RUC.
SELECT * FROM dbo.cliente
WHERE tipo_documento = 'DNI' OR tipo_documento = 'RUC';

-- NOT: empleados que no estan inactivos.
SELECT * FROM dbo.empleado
WHERE NOT (activo = 0);

-- AND: metodos de pago activos cuyo nombre contiene una palabra.
SELECT * FROM dbo.metodo_pago
WHERE activo = 1 AND nombre IS NOT NULL;

-- OR: proveedores activos o proveedores sin correo registrado.
SELECT * FROM dbo.proveedor
WHERE activo = 1 OR correo IS NULL;

-- AND: productos activos con precio mayor o igual a S/ 10.
SELECT * FROM dbo.producto
WHERE activo = 1 AND precio_actual >= 10;

-- NOT: descuentos que no estan inactivos.
SELECT * FROM dbo.descuento
WHERE NOT (activo = 0);

-- OR: relaciones de descuento asociadas a las categorias 2 u 8.
SELECT * FROM dbo.descuento_categoria
WHERE id_categoria = 2 OR id_categoria = 8;

-- AND: dias de promocion entre lunes y viernes.
SELECT * FROM dbo.descuento_dia_semana
WHERE dia_semana >= 1 AND dia_semana <= 5;

-- AND / OR: pedidos pagados de venta local o pedidos pendientes.
SELECT * FROM dbo.pedido
WHERE (estado = 'PAGADO' AND modalidad_venta = 'LOCAL')
   OR estado = 'PENDIENTE';

-- AND: detalle de pedido con cantidad de dos o mas y precio mayor a S/ 10.
SELECT * FROM dbo.detalle_pedido
WHERE cantidad >= 2 AND precio_aplicado > 10;

-- NOT: pagos que no fueron realizados en efectivo (id_metodo = 1).
SELECT * FROM dbo.pago
WHERE NOT (id_metodo = 1);

-- OR: productos relacionados con proveedores de entrega de 1 o 2 dias.
SELECT * FROM dbo.producto_proveedor
WHERE plazo_entrega_dias = 1 OR plazo_entrega_dias = 2;

-- AND: inventario con stock actual por debajo del minimo y minimo mayor a cero.
SELECT * FROM dbo.inventario
WHERE stock_actual < stock_minimo AND stock_minimo > 0;

-- AND: boletas con total superior a S/ 30 y descuento mayor o igual a cero.
SELECT * FROM dbo.boleta
WHERE total > 30 AND descuento_aplicado >= 0;

-- NOT: lineas de boleta cuya cantidad no es uno.
SELECT * FROM dbo.detalle_boleta
WHERE NOT (cantidad = 1);
GO

/* =========================================================
   7. FUNCIONES DE AGREGADO: COUNT, SUM, AVG, MAX, MIN
   ========================================================= */
-- Conteo de registros por tabla.
SELECT 'categoria' AS Tabla, COUNT(*) AS TotalRegistros FROM dbo.categoria
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
ORDER BY Tabla;

-- Estadisticas de precios de productos.
SELECT COUNT(*) AS CantidadProductos,
       SUM(precio_actual) AS SumaPrecios,
       AVG(precio_actual) AS PrecioPromedio,
       MAX(precio_actual) AS PrecioMaximo,
       MIN(precio_actual) AS PrecioMinimo
FROM dbo.producto;

-- Estadisticas de pagos.
SELECT COUNT(*) AS CantidadPagos,
       SUM(monto) AS TotalRecaudado,
       AVG(monto) AS PagoPromedio,
       MAX(monto) AS PagoMayor,
       MIN(monto) AS PagoMenor
FROM dbo.pago;

-- Estadisticas de inventario.
SELECT SUM(stock_actual) AS StockTotal,
       AVG(CAST(stock_actual AS DECIMAL(10,2))) AS StockPromedio,
       MAX(stock_actual) AS StockMaximo,
       MIN(stock_actual) AS StockMinimo,
       COUNT(*) AS ProductosControlados
FROM dbo.inventario;

-- Estadisticas de descuentos.
SELECT COUNT(*) AS CantidadPromociones,
       AVG(porcentaje) AS DescuentoPromedio,
       MAX(porcentaje) AS DescuentoMaximo,
       MIN(porcentaje) AS DescuentoMinimo
FROM dbo.descuento;

-- Estadisticas de boletas.
SELECT COUNT(*) AS BoletasEmitidas,
       SUM(total) AS TotalFacturado,
       AVG(total) AS PromedioBoleta,
       MAX(total) AS BoletaMayor,
       MIN(total) AS BoletaMenor
FROM dbo.boleta;
GO

/* =========================================================
   8. GROUP BY: AGRUPAR Y RESUMIR
   ========================================================= */
-- Ventas agrupadas por cliente.
SELECT COALESCE(c.nombre, 'Consumidor final') AS Cliente,
       COUNT(p.id_pedido) AS CantidadPedidos
FROM dbo.pedido p
LEFT JOIN dbo.cliente c ON c.id_cliente = p.id_cliente
GROUP BY COALESCE(c.nombre, 'Consumidor final')
ORDER BY CantidadPedidos DESC;

-- Productos agrupados por categoria.
SELECT c.nombre AS Categoria,
       COUNT(p.id_producto) AS CantidadProductos,
       AVG(p.precio_actual) AS PrecioPromedio,
       MIN(p.precio_actual) AS PrecioMinimo,
       MAX(p.precio_actual) AS PrecioMaximo
FROM dbo.producto p
INNER JOIN dbo.categoria c ON c.id_categoria = p.id_categoria
GROUP BY c.nombre
ORDER BY c.nombre ASC;

-- Importe vendido por pedido.
SELECT id_pedido AS Pedido,
       SUM(cantidad) AS Unidades,
       SUM(cantidad * precio_aplicado) AS ImporteBruto
FROM dbo.detalle_pedido
GROUP BY id_pedido
ORDER BY id_pedido ASC;

-- Pagos agrupados por metodo.
SELECT mp.nombre AS MetodoPago,
       COUNT(pa.id_pago) AS NumeroPagos,
       SUM(pa.monto) AS TotalRecaudado,
       AVG(pa.monto) AS PromedioPago
FROM dbo.pago pa
INNER JOIN dbo.metodo_pago mp ON mp.id_metodo = pa.id_metodo
GROUP BY mp.nombre
ORDER BY TotalRecaudado DESC;

-- Stock agrupado por categoria.
SELECT c.nombre AS Categoria,
       SUM(i.stock_actual) AS StockAcumulado,
       AVG(CAST(i.stock_actual AS DECIMAL(10,2))) AS StockPromedio
FROM dbo.inventario i
INNER JOIN dbo.producto p ON p.id_producto = i.id_producto
INNER JOIN dbo.categoria c ON c.id_categoria = p.id_categoria
GROUP BY c.nombre
ORDER BY StockAcumulado DESC;

-- Boletas agrupadas por mes de emision.
SELECT YEAR(fecha_emision) AS Anio,
       MONTH(fecha_emision) AS Mes,
       COUNT(*) AS CantidadBoletas,
       SUM(total) AS TotalEmitido
FROM dbo.boleta
GROUP BY YEAR(fecha_emision), MONTH(fecha_emision)
ORDER BY Anio ASC, Mes ASC;

-- Proveedores agrupados por cantidad de productos suministrados.
SELECT pr.razon_social AS Proveedor,
       COUNT(pp.id_producto) AS ProductosSuministrados
FROM dbo.proveedor pr
INNER JOIN dbo.producto_proveedor pp ON pp.id_proveedor = pr.id_proveedor
GROUP BY pr.razon_social
ORDER BY ProductosSuministrados DESC;
GO

/* =========================================================
   9. HAVING: FILTRAR GRUPOS POR RESULTADOS AGREGADOS
   ========================================================= */
-- Clientes con dos o mas pedidos.
SELECT COALESCE(c.nombre, 'Consumidor final') AS Cliente,
       COUNT(p.id_pedido) AS CantidadPedidos
FROM dbo.pedido p
LEFT JOIN dbo.cliente c ON c.id_cliente = p.id_cliente
GROUP BY COALESCE(c.nombre, 'Consumidor final')
HAVING COUNT(p.id_pedido) >= 2
ORDER BY CantidadPedidos DESC;

-- Categorias cuyo precio promedio es mayor a S/ 10.
SELECT c.nombre AS Categoria,
       AVG(pr.precio_actual) AS PrecioPromedio
FROM dbo.producto pr
INNER JOIN dbo.categoria c ON c.id_categoria = pr.id_categoria
GROUP BY c.nombre
HAVING AVG(pr.precio_actual) > 10
ORDER BY PrecioPromedio DESC;

-- Pedidos cuyo importe bruto supera S/ 25.
SELECT id_pedido AS Pedido,
       SUM(cantidad * precio_aplicado) AS ImporteBruto
FROM dbo.detalle_pedido
GROUP BY id_pedido
HAVING SUM(cantidad * precio_aplicado) > 25
ORDER BY ImporteBruto DESC;

-- Metodos de pago utilizados en al menos dos operaciones.
SELECT mp.nombre AS MetodoPago,
       COUNT(pa.id_pago) AS CantidadOperaciones,
       SUM(pa.monto) AS TotalRecaudado
FROM dbo.metodo_pago mp
INNER JOIN dbo.pago pa ON pa.id_metodo = mp.id_metodo
GROUP BY mp.nombre
HAVING COUNT(pa.id_pago) >= 2
ORDER BY CantidadOperaciones DESC;

-- Categorias con stock acumulado superior a 15 unidades.
SELECT c.nombre AS Categoria,
       SUM(i.stock_actual) AS StockTotal
FROM dbo.inventario i
INNER JOIN dbo.producto p ON p.id_producto = i.id_producto
INNER JOIN dbo.categoria c ON c.id_categoria = p.id_categoria
GROUP BY c.nombre
HAVING SUM(i.stock_actual) > 15
ORDER BY StockTotal DESC;

-- Meses con dos o mas boletas emitidas.
SELECT YEAR(fecha_emision) AS Anio,
       MONTH(fecha_emision) AS Mes,
       COUNT(*) AS BoletasEmitidas
FROM dbo.boleta
GROUP BY YEAR(fecha_emision), MONTH(fecha_emision)
HAVING COUNT(*) >= 2
ORDER BY Anio, Mes;
GO

PRINT 'Actividad 2: consultas SELECT, alias, ORDER BY, DISTINCT, WHERE, agregados, GROUP BY y HAVING ejecutadas.';
GO
