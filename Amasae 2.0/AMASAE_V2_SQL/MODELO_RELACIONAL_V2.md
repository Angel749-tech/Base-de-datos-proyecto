# Modelo relacional Amasae V2 (13 tablas)

**Origen:** 11 tablas de los scripts del ZIP de Amasae + las nuevas tablas
`empresa_emisora` y `comprobante`. Los clientes y proveedores tienen atributos
nuevos de documento, dirección y contacto.

```mermaid
erDiagram
  CATEGORIA ||--o{ PRODUCTO : clasifica
  CLIENTE o|--o{ PEDIDO : realiza
  EMPLEADO ||--o{ PEDIDO : registra
  PEDIDO ||--|{ DETALLE_PEDIDO : contiene
  PRODUCTO ||--o{ DETALLE_PEDIDO : solicitado
  PEDIDO ||--o| PAGO : pagado_con
  METODO_PAGO ||--o{ PAGO : usa
  PRODUCTO ||--o{ PRODUCTO_PROVEEDOR : ofrecido_por
  PROVEEDOR ||--o{ PRODUCTO_PROVEEDOR : suministra
  PRODUCTO ||--o| INVENTARIO : controla
  EMPRESA_EMISORA ||--o{ COMPROBANTE : emite
  PEDIDO ||--o| COMPROBANTE : documenta

  CATEGORIA {
    int id_categoria PK
    varchar nombre UK
    varchar descripcion
  }
  CLIENTE {
    int id_cliente PK
    varchar nombre
    varchar telefono
    varchar correo
    varchar tipo_documento
    varchar numero_documento UK
    varchar razon_social
    varchar direccion
  }
  EMPLEADO {
    int id_empleado PK
    varchar nombre
    varchar cargo
    tinyint activo
  }
  METODO_PAGO {
    int id_metodo PK
    varchar nombre UK
    tinyint activo
  }
  PROVEEDOR {
    int id_proveedor PK
    varchar razon_social
    varchar contacto
    varchar telefono
    varchar ruc UK
    varchar correo
    varchar direccion
    tinyint activo
  }
  PRODUCTO {
    int id_producto PK
    int id_categoria FK
    varchar nombre
    decimal precio_actual
    tinyint activo
  }
  PEDIDO {
    int id_pedido PK
    int id_cliente FK
    int id_empleado FK
    datetime fecha_hora
    varchar estado
  }
  DETALLE_PEDIDO {
    int id_pedido PK, FK
    int id_producto PK, FK
    int cantidad
    decimal precio_aplicado
  }
  PAGO {
    int id_pago PK
    int id_pedido FK, UK
    int id_metodo FK
    datetime fecha_hora
    decimal monto
  }
  PRODUCTO_PROVEEDOR {
    int id_producto PK, FK
    int id_proveedor PK, FK
  }
  INVENTARIO {
    int id_producto PK, FK
    int stock_actual
    int stock_minimo
    datetime fecha_actualizacion
  }
  EMPRESA_EMISORA {
    int id_emisor PK
    varchar ruc UK
    varchar razon_social
    varchar nombre_comercial
    varchar direccion_fiscal
    varchar telefono
    varchar correo
    tinyint activo
  }
  COMPROBANTE {
    int id_comprobante PK
    int id_pedido FK, UK
    int id_emisor FK
    varchar tipo
    varchar serie
    int numero
    datetime fecha_emision
    varchar receptor_tipo_documento
    varchar receptor_numero_documento
    varchar receptor_nombre
    varchar receptor_direccion
    decimal base_gravada
    decimal igv
    decimal total
    varchar estado
  }
```

**Observación:** El EER generado desde MySQL Workbench es la referencia para la
implementación física. El diagrama anterior es una guía textual editable; no es
un archivo `.mwb` y no sustituye la ingeniería inversa de Workbench.
