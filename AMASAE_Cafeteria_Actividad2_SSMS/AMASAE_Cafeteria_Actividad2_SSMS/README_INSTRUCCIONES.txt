AMASAE - SISTEMA DE GESTION DE CAFETERIA
Proyecto preparado para Microsoft SQL Server Management Studio (SSMS)

CONTENIDO DE LA CARPETA
00_CREAR_BASE_DATOS.sql
    Crea AMASAE_Cafeteria y sus archivos MDF, NDF y LDF.
01_CREAR_TABLAS.sql
    Crea las 16 tablas, claves primarias, foraneas, restricciones y valores DEFAULT.
02_INSERTAR_DATOS.sql
    Inserta datos de prueba adaptados del modelo MySQL proporcionado.
03_ACTUALIZAR_REGISTROS.sql
    Contiene ejemplos de UPDATE (punto h).
04_ELIMINAR_REGISTROS.sql
    Contiene un DELETE controlado y transaccional (punto i).
05_CONSULTAS_Y_VALIDACIONES.sql
    Consultas de evidencia y validaciones.

ORDEN DE EJECUCION
1. Abrir SQL Server Management Studio y conectarse a la instancia.
2. Abrir 00_CREAR_BASE_DATOS.sql y ejecutarlo conectado a master.
3. Abrir y ejecutar 01_CREAR_TABLAS.sql.
4. Abrir y ejecutar 02_INSERTAR_DATOS.sql.
5. Ejecutar 03_ACTUALIZAR_REGISTROS.sql.
6. Ejecutar 04_ELIMINAR_REGISTROS.sql.
7. Ejecutar 05_CONSULTAS_Y_VALIDACIONES.sql.

IMPORTANTE SOBRE LOS ARCHIVOS
- El primer script intenta detectar las rutas predeterminadas de SQL Server.
- Si falla por permisos o por rutas, verificar la ruta de datos y logs de la instancia.
- La carpeta destino debe existir y la cuenta del servicio SQL Server debe tener permisos.
- No ejecutar repetidamente los scripts de creacion e insercion sobre una base ya poblada,
  porque las tablas y los identificadores ya existiran.

DECISIONES DE MODELADO
- Se conserva el modelo de cafeteria AMASAE: categorias, productos, clientes,
  empleados, proveedores, inventario, pedidos, pagos y promociones.
- Se usan boleta y detalle_boleta como tablas de comprobante solicitadas.
- Los registros que en el origen estaban marcados como FACTURA (pagos 508 y 509)
  se conservan como pagos, pero no se convierten artificialmente en boletas.
  Si el alcance academico requiere facturas, se puede agregar una entidad factura.
- detalle_boleta guarda una copia de la descripcion y del precio historico vendido.
- El IGV y los importes de ejemplo respetan los valores del archivo fuente entregado.
- El DELETE de ejemplo elimina el pedido pendiente 1008 y sus detalles, siempre que
  no exista un pago asociado.

NOTA ACADEMICA
Este paquete cubre los puntos a-i indicados en la consigna. Antes de entregar,
ejecutar los scripts en la instancia del laboratorio y capturar evidencias de:
1) archivos MDF/NDF/LDF;
2) tablas y relaciones;
3) registros insertados;
4) UPDATE;
5) DELETE;
6) consultas de validacion.


ACTIVIDAD 2 - CONSULTAS SQL
07_COMPLETAR_MINIMO_5_REGISTROS.sql
    Completa las tablas que inicialmente tenian menos de cinco registros:
    empleado, metodo_pago y descuento_dia_semana. Se puede ejecutar de nuevo
    sin duplicar esos registros.
08_CONSULTAS_ACTIVIDAD_2.sql
    Desarrolla todos los puntos de la segunda guia:
    - conteo minimo por tabla;
    - SELECT * de todas las tablas;
    - alias por columna;
    - ORDER BY ascendente;
    - DISTINCT por tabla;
    - filtros WHERE con AND, OR y NOT;
    - COUNT, SUM, AVG, MAX y MIN;
    - GROUP BY y HAVING.

ORDEN PARA LA SEGUNDA ACTIVIDAD
1. Asegurarse de haber ejecutado previamente los scripts 00 a 02.
2. Ejecutar 07_COMPLETAR_MINIMO_5_REGISTROS.sql.
3. Ejecutar 08_CONSULTAS_ACTIVIDAD_2.sql.
4. Revisar los resultados por bloques y guardar capturas de evidencia.

OBSERVACION
La guia solicita minimo cinco registros por tabla. El script 07 agrega filas
a las tablas que no alcanzaban ese minimo. Los registros adicionales son datos
academicos de prueba, no operaciones comerciales reales.
