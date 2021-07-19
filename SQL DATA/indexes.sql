--Indexar la tabla ingresos por la columna facturas
CREATE INDEX "IDX_INGRESOS_FACTURA" ON
    "INGRESOS" (
        "FACTURA_ID"
    );

--Indexar la tabla ingresos por la columna fecha y en orden descendente para acceder mas rapido a los registros mas nuevos(Que son los que se deben facturar)
CREATE INDEX "IDX_INGRESOS_FECHA" ON
    "INGRESOS" (
        "INGRESO_FECHA"
    DESC );

--Indexar la tabla ingresos por la columna vehiculo_id(Facilita el encontrar los ingresos asociados a un vehiculo perteneciente a un contratista)
CREATE INDEX "IDX_INGRESOS_VEHICULO" ON
    "INGRESOS" (
        "VEHICULO_ID"
    );

--Indexar la tabla ingresos por la columna trabajador_id(Facilita el encontrar los ingresos asociados a un trabajador perteneciente a un centro)
CREATE INDEX "IDX_INGRESOS_TRABAJADOR" ON
    "INGRESOS" (
        "TRABAJADOR_ID"
    );

--Indexar la tabla facturas respecto a la columna centro_disposicion_id(Facilita obtener de forma mas eficiente las facturas asociadas a un centro)
CREATE INDEX "IDX_FACTURAS_CENTRO_DISPOSICION" ON
    "FACTURAS" (
        "CENTRO_DISPOSICION_ID"
    );

--Indexar la tabla facturas respecto a la columna contratista_id(Facilita obtener de forma mas eficiente las facturas asociadas a un contratista)
CREATE INDEX "IDX_FACTURAS_CONTRATISTA" ON
    "FACTURAS" (
        "CONTRATISTA_ID"
    );



