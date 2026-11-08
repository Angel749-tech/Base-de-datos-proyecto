# Modelo relacional - AMASAE Cafetería

```mermaid
erDiagram
    CATEGORIA ||--o{ PRODUCTO : clasifica
    PRODUCTO ||--o| INVENTARIO : controla
    PRODUCTO ||--o{ DETALLE_PEDIDO : aparece
    PEDIDO ||--|{ DETALLE_PEDIDO : contiene
    CLIENTE o|--o{ PEDIDO : realiza
    EMPLEADO ||--o{ PEDIDO : registra
    DESCUENTO o|--o{ PEDIDO : aplica
    DESCUENTO ||--o{ DESCUENTO_CATEGORIA : incluye
    CATEGORIA ||--o{ DESCUENTO_CATEGORIA : participa
    DESCUENTO ||--o{ DESCUENTO_DIA_SEMANA : programa
    PEDIDO ||--o| PAGO : genera
    METODO_PAGO ||--o{ PAGO : utiliza
    PAGO ||--o| BOLETA : sustenta
    BOLETA ||--|{ DETALLE_BOLETA : contiene
    PRODUCTO ||--o{ DETALLE_BOLETA : detalla
    PRODUCTO ||--o{ PRODUCTO_PROVEEDOR : abastece
    PROVEEDOR ||--o{ PRODUCTO_PROVEEDOR : suministra
```

## Entidades principales
- categoria: clasificacion del menu.
- producto: bebidas, postres, tortas, sanguches y otros productos.
- cliente: datos de clientes y consumidores identificados.
- empleado: personal que registra las ventas.
- pedido y detalle_pedido: cabecera y lineas de una venta.
- pago y metodo_pago: cobro y medio utilizado.
- boleta y detalle_boleta: comprobante y productos incluidos.
- inventario: existencias y niveles de reposicion.
- proveedor y producto_proveedor: abastecimiento.
- descuento, descuento_categoria y descuento_dia_semana: promociones.
