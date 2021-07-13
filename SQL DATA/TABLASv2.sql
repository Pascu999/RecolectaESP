DROP TABLE tipos_vehiculos CASCADE CONSTRAINTS PURGE;

DROP TABLE desechos CASCADE CONSTRAINTS PURGE;

DROP TABLE municipios CASCADE CONSTRAINTS PURGE;

DROP TABLE rutas CASCADE CONSTRAINTS PURGE;

DROP TABLE contratistas CASCADE CONSTRAINTS PURGE;

DROP TABLE contratistas_tarifan_desechos CASCADE CONSTRAINTS PURGE;

DROP TABLE vehiculos CASCADE CONSTRAINTS PURGE;

DROP TABLE conductores CASCADE CONSTRAINTS PURGE;

DROP TABLE centros_disposicion CASCADE CONSTRAINTS PURGE;

DROP TABLE centros_disposicion_limitan_desechos CASCADE CONSTRAINTS PURGE;

DROP TABLE trabajadores CASCADE CONSTRAINTS PURGE;

DROP TABLE celdas CASCADE CONSTRAINTS PURGE;

DROP TABLE celdas_admiten_desechos CASCADE CONSTRAINTS PURGE;

DROP TABLE ingresos CASCADE CONSTRAINTS PURGE;

DROP TABLE facturas CASCADE CONSTRAINTS PURGE;

DROP SEQUENCE ingresos_secuencia;

DROP SEQUENCE facturas_secuencia;

DROP SEQUENCE vehiculos_secuencia;

CREATE SEQUENCE ingresos_secuencia START WITH 1;

CREATE SEQUENCE facturas_secuencia START WITH 1;

CREATE SEQUENCE vehiculos_secuencia START WITH 1;

CREATE TABLE "TIPOS_VEHICULOS" (
    "TIPO_ID"           NUMBER(19, 0)
        NOT NULL ENABLE,
    "TIPO_DESCRIPCION"  VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "TIPO_NOMBRE"       VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    PRIMARY KEY ( "TIPO_ID" )
);

CREATE TABLE "DESECHOS" (
    "DESECHO_ID"           NUMBER(19, 0)
        NOT NULL ENABLE,
    "DESECHO_DESCRIPCION"  VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "DESECHO_ESTADO"       NUMBER(1, 0) DEFAULT 1
        NOT NULL ENABLE,
    "DESECHO_NOMBRE"       VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    PRIMARY KEY ( "DESECHO_ID" )
);

CREATE TABLE "MUNICIPIOS" (
    "MUNICIPIO_ID"             NUMBER(19, 0)
        NOT NULL ENABLE,
    "MUNICIPIO_CODIGO_POSTAL"  VARCHAR2(20 BYTE)
        NOT NULL ENABLE,
    "MUNICIPIO_ESTADO"         NUMBER(1, 0) DEFAULT 1
        NOT NULL ENABLE,
    "MUNICIPIO_NOMBRE"         VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    PRIMARY KEY ( "MUNICIPIO_ID" )
);

CREATE TABLE "RUTAS" (
    "RUTA_ID"                  NUMBER(19, 0)
        NOT NULL ENABLE,
    "RUTA_DESCRIPCION"         VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "RUTA_ESTADO"              NUMBER(1, 0)
        NOT NULL ENABLE,
    "RUTA_FECHA_FINALIZACION"  DATE
        NOT NULL ENABLE,
    "RUTA_FECHA_INICIO"        DATE
        NOT NULL ENABLE,
    "RUTA_NOMBRE"              VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "MUNICIPIO_ID"             NUMBER(19, 0)
        NOT NULL ENABLE,
    PRIMARY KEY ( "RUTA_ID" ),
    CONSTRAINT "FK_RUTA_MUNICIPIO" FOREIGN KEY ( "MUNICIPIO_ID" )
        REFERENCES "MUNICIPIOS" ( "MUNICIPIO_ID" )
);

CREATE TABLE "CONTRATISTAS" (
    "CONTRATISTA_ID"                  NUMBER(19, 0)
        NOT NULL ENABLE,
    "CONTRATISTA_CELULAR"             VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "CONTRATISTA_CONTRASENA"          VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "CONTRATISTA_CORREO"              VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "CONTRATISTA_DIRECCION"           VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "CONTRATISTA_FECHA_CREACION"      DATE
        NOT NULL ENABLE,
    "CONTRATISTA_NIT"                 VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "CONTRATISTA_NOMBRE"              VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "CONTRATISTA_ULTIMA_FACTURACION"  DATE
        NOT NULL ENABLE,
    PRIMARY KEY ( "CONTRATISTA_ID" ),
    CONSTRAINT "U_CONTRATISTA_NIT" UNIQUE ( "CONTRATISTA_NIT" ),
    CONSTRAINT "U_CONTRATISTA_CORREO" UNIQUE ( "CONTRATISTA_CELULAR" )
);

CREATE TABLE "CONTRATISTAS_TARIFAN_DESECHOS" (
    "CONTRATISTAS_TARIFAN_DESECHOS_PRECIO_KILO"  FLOAT(126)
        NOT NULL ENABLE,
    "DESECHO_ID"                                 NUMBER(19, 0)
        NOT NULL ENABLE,
    "CONTRATISTA_ID"                             NUMBER(19, 0)
        NOT NULL ENABLE,
    PRIMARY KEY ( "CONTRATISTA_ID",
                  "DESECHO_ID" ),
    CONSTRAINT "FK_DESECHO_TARIFADO" FOREIGN KEY ( "DESECHO_ID" )
        REFERENCES "DESECHOS" ( "DESECHO_ID" ),
    CONSTRAINT "FK_CONTRATISTA_TARIFA_DESECHO" FOREIGN KEY ( "CONTRATISTA_ID" )
        REFERENCES "CONTRATISTAS" ( "CONTRATISTA_ID" )
);

CREATE TABLE "VEHICULOS" (
    "VEHICULO_ID"              NUMBER(19, 0)
        NOT NULL ENABLE,
    "VEHICULO_FECHA_CREACION"  DATE
        NOT NULL ENABLE,
    "VEHICULO_MARCA"           VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "VEHICULO_MODELO"          VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "VEHICULO_PESO"            FLOAT(126)
        NOT NULL ENABLE,
    "VEHICULO_PLACA"           VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "CONTRATISTA_ID"           NUMBER(19, 0)
        NOT NULL ENABLE,
    "RUTA_ID"                  NUMBER(19, 0)
        NOT NULL ENABLE,
    "TIPO_ID"                  NUMBER(19, 0)
        NOT NULL ENABLE,
    "VEHICULO_ESTADO"          NUMBER(1, 0)
        NOT NULL ENABLE,
    PRIMARY KEY ( "VEHICULO_ID" ),
    CONSTRAINT "U_VEHICULO_PLACA" UNIQUE ( "VEHICULO_PLACA" ),
    CONSTRAINT "FK_VEHICULO_CONTRATISTA" FOREIGN KEY ( "CONTRATISTA_ID" )
        REFERENCES "CONTRATISTAS" ( "CONTRATISTA_ID" ),
    CONSTRAINT "FK_VEHICULO_RUTA" FOREIGN KEY ( "RUTA_ID" )
        REFERENCES "RUTAS" ( "RUTA_ID" ),
    CONSTRAINT "FK_VEHICULO_TIPO" FOREIGN KEY ( "TIPO_ID" )
        REFERENCES "TIPOS_VEHICULOS" ( "TIPO_ID" )
);

CREATE TABLE "CONDUCTORES" (
    "CONDUCTOR_ID"                NUMBER(19, 0)
        NOT NULL ENABLE,
    "CONDUCTOR_APELLIDO"          VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "CONDUCTOR_CELULAR"           VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "CONDUCTOR_CORREO"            VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "CONDUCTOR_DOCUMENTO"         VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "CONDUCTOR_ESTADO"            NUMBER(1, 0)
        NOT NULL ENABLE,
    "CONDUCTOR_FECHA_NACIMIENTO"  DATE
        NOT NULL ENABLE,
    "CONDUCTOR_NOMBRE"            VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "CONTRATISTA_ID"              NUMBER(19, 0),
    PRIMARY KEY ( "CONDUCTOR_ID" ),
    CONSTRAINT "FK_CONDUCTOR_CONTRISTA" FOREIGN KEY ( "CONTRATISTA_ID" )
        REFERENCES "CONTRATISTAS" ( "CONTRATISTA_ID" )
);

CREATE TABLE "CENTROS_DISPOSICION" (
    "CENTRO_DISPOSICION_ID"         NUMBER(19, 0)
        NOT NULL ENABLE,
    "CENTRO_DISPOSICION_CELULAR"    VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "CENTRO_DISPOSICION_CORREO"     VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "CENTRO_DISPOSICION_DIRECCION"  VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "CENTRO_DISPOSICION_ESTADO"     NUMBER(1, 0) DEFAULT 1,
    "CENTRO_DISPOSICION_NOMBRE"     VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "MUNICIPIO_ID"                  NUMBER(19, 0),
    PRIMARY KEY ( "CENTRO_DISPOSICION_ID" ),
    CONSTRAINT "FK_CENTRO_DISPOSICION_MUNICIPIO" FOREIGN KEY ( "MUNICIPIO_ID" )
        REFERENCES "MUNICIPIOS" ( "MUNICIPIO_ID" )
);

CREATE TABLE "CENTROS_DISPOSICION_LIMITAN_DESECHOS" (
    "CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO"  NUMBER(10, 0)
        NOT NULL ENABLE,
    "CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO"   NUMBER(10, 0)
        NOT NULL ENABLE,
    "TIPO_ID"                                            NUMBER(19, 0)
        NOT NULL ENABLE,
    "CENTRO_DISPOSICION_ID"                              NUMBER(19, 0)
        NOT NULL ENABLE,
    "DESECHO_ID"                                         NUMBER(19, 0)
        NOT NULL ENABLE,
    CONSTRAINT "FK_VEHICULO_LIMITADO" FOREIGN KEY ( "TIPO_ID" )
        REFERENCES "TIPOS_VEHICULOS" ( "TIPO_ID" ),
    CONSTRAINT "FK_CENTRO_DISPOSICION_LIMITANDO" FOREIGN KEY ( "CENTRO_DISPOSICION_ID" )
        REFERENCES "CENTROS_DISPOSICION" ( "CENTRO_DISPOSICION_ID" ),
    CONSTRAINT "FK_DESECHO_LIMITADO" FOREIGN KEY ( "DESECHO_ID" )
        REFERENCES "DESECHOS" ( "DESECHO_ID" )
);

CREATE TABLE "TRABAJADORES" (
    "TRABAJADOR_ID"                NUMBER(19, 0)
        NOT NULL ENABLE,
    "TRABAJADOR_APELLIDO"          VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "TRABAJADOR_CELULAR"           VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "TRABAJADOR_CONTRASENA"        VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "TRABAJADOR_CORREO"            VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "TRABAJADOR_DIRECCION"         VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "TRABAJADOR_DOCUMENTO"         VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "TRABAJADOR_ESTADO"            NUMBER(1, 0)
        NOT NULL ENABLE,
    "TRABAJADOR_FECHA_INGRESO"     DATE
        NOT NULL ENABLE,
    "TRABAJADOR_FECHA_NACIMIENTO"  DATE
        NOT NULL ENABLE,
    "TRABAJADOR_NOMBRE"            VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "TRABAJADOR_TIPO"              NUMBER(1, 0)
        NOT NULL ENABLE,
    "CENTRO_DISPOSICION_ID"        NUMBER(19, 0)
        NOT NULL ENABLE,
    PRIMARY KEY ( "TRABAJADOR_ID" ),
    CONSTRAINT "U_TRABAJADOR_DOCUMENTO" UNIQUE ( "TRABAJADOR_DOCUMENTO" ),
    CONSTRAINT "U_TRABAJADOR_CELULAR" UNIQUE ( "TRABAJADOR_CELULAR" ),
    CONSTRAINT "U_TRABAJADOR_CORREO" UNIQUE ( "TRABAJADOR_CORREO" ),
    CONSTRAINT "FK_TRABAJADOR_CENTRO" FOREIGN KEY ( "CENTRO_DISPOSICION_ID" )
        REFERENCES "CENTROS_DISPOSICION" ( "CENTRO_DISPOSICION_ID" )
);

CREATE TABLE "CELDAS" (
    "CELDA_ID"               NUMBER(19, 0)
        NOT NULL ENABLE,
    "CELDA_CAPACIDAD_TOTAL"  NUMBER(10, 0)
        NOT NULL ENABLE,
    "CELDA_CAPACIDAD_USADA"  NUMBER(10, 0)
        NOT NULL ENABLE,
    "CELDA_ESTADO"           NUMBER(1, 0)
        NOT NULL ENABLE,
    "CELDA_NOMBRE"           VARCHAR2(255 BYTE)
        NOT NULL ENABLE,
    "CENTRO_DISPOSICION_ID"  NUMBER(19, 0)
        NOT NULL ENABLE,
    PRIMARY KEY ( "CELDA_ID" ),
    CONSTRAINT "FK_CELDA_CENTRO" FOREIGN KEY ( "CENTRO_DISPOSICION_ID" )
        REFERENCES "CENTROS_DISPOSICION" ( "CENTRO_DISPOSICION_ID" )
            ON DELETE SET NULL
);

CREATE TABLE "CELDAS_ADMITEN_DESECHOS" (
    "CELDA_ID"    NUMBER(19, 0)
        NOT NULL ENABLE,
    "DESECHO_ID"  NUMBER(19, 0)
        NOT NULL ENABLE,
    PRIMARY KEY ( "CELDA_ID",
                  "DESECHO_ID" ),
    CONSTRAINT "FK_CELDA_ADMITIENDO" FOREIGN KEY ( "CELDA_ID" )
        REFERENCES "CELDAS" ( "CELDA_ID" ),
    CONSTRAINT "FK_CELDA_ADMITE_DESECHO" FOREIGN KEY ( "DESECHO_ID" )
        REFERENCES "DESECHOS" ( "DESECHO_ID" )
);

CREATE TABLE "FACTURAS" (
    "FACTURA_ID"                NUMBER(19, 0)
        NOT NULL ENABLE,
    "FACTURA_COSTO_TRANSPORTE"  FLOAT(126)
        NOT NULL ENABLE,
    "FACTURA_DESCUENTO"         FLOAT(126)
        NOT NULL ENABLE,
    "FACTURA_FIN_PERIODO"       DATE
        NOT NULL ENABLE,
    "FACTURA_INICIO_PERIODO"    DATE
        NOT NULL ENABLE,
    "CENTRO_DISPOSICION_ID"     NUMBER(19, 0)
        NOT NULL ENABLE,
    "CONTRATISTA_ID"            NUMBER(19, 0)
        NOT NULL ENABLE,
    PRIMARY KEY ( "FACTURA_ID" ),
    CONSTRAINT "FK_FACTURA_CONTRATISTA" FOREIGN KEY ( "CONTRATISTA_ID" )
        REFERENCES "CONTRATISTAS" ( "CONTRATISTA_ID" ),
    CONSTRAINT "FK_FACTURA_CENTRO" FOREIGN KEY ( "CENTRO_DISPOSICION_ID" )
        REFERENCES "CENTROS_DISPOSICION" ( "CENTRO_DISPOSICION_ID" )
);

CREATE TABLE "INGRESOS" (
    "INGRESO_ID"                NUMBER(19, 0)
        NOT NULL ENABLE,
    "INGRESO_FECHA"             DATE,
    "INGRESO_PESO"              FLOAT(126)
        NOT NULL ENABLE,
    "INGRESO_PESO_SOBRECARGA"   FLOAT(126)
        NOT NULL ENABLE,
    "INGRESO_VALOR_SOBRECARGA"  NUMBER(10, 0)
        NOT NULL ENABLE,
    "INGRESO_VALOR_TRANSPORTE"  NUMBER(10, 0)
        NOT NULL ENABLE,
    "INGRESO_ESTADO"            NUMBER(1, 0) DEFAULT 0,
    "CELDA_ID"                  NUMBER(19, 0),
    "CONDUCTOR_ID"              NUMBER(19, 0)
        NOT NULL ENABLE,
    "DESECHO_ID"                NUMBER(19, 0)
        NOT NULL ENABLE,
    "FACTURA_ID"                NUMBER(19, 0),
    "TRABAJADOR_ID"             NUMBER(19, 0)
        NOT NULL ENABLE,
    "VEHICULO_ID"               NUMBER(19, 0)
        NOT NULL ENABLE,
    PRIMARY KEY ( "INGRESO_ID" ),
    CONSTRAINT "FK_INGRESO_CELDA" FOREIGN KEY ( "CELDA_ID" )
        REFERENCES "CELDAS" ( "CELDA_ID" ),
    CONSTRAINT "FK_INGRESO_CONDUCTOR" FOREIGN KEY ( "CONDUCTOR_ID" )
        REFERENCES "CONDUCTORES" ( "CONDUCTOR_ID" ),
    CONSTRAINT "FK_INGRESO_DESECHO" FOREIGN KEY ( "DESECHO_ID" )
        REFERENCES "DESECHOS" ( "DESECHO_ID" ),
    CONSTRAINT "FK_INGRESO_FACTURA" FOREIGN KEY ( "FACTURA_ID" )
        REFERENCES "FACTURAS" ( "FACTURA_ID" ),
    CONSTRAINT "FK_INGRESO_TRABAJADOR" FOREIGN KEY ( "TRABAJADOR_ID" )
        REFERENCES "TRABAJADORES" ( "TRABAJADOR_ID" ),
    CONSTRAINT "FK_INGRESO_VEHICULO" FOREIGN KEY ( "VEHICULO_ID" )
        REFERENCES "VEHICULOS" ( "VEHICULO_ID" )
);

CREATE INDEX "IDX_INGRESOS_FACTURA" ON
    "INGRESOS" (
        "FACTURA_ID"
    );

CREATE INDEX "IDX_INGRESOS_FECHA" ON
    "INGRESOS" (
        "INGRESO_FECHA"
    DESC );

CREATE INDEX "IDX_INGRESOS_VEHICULO" ON
    "INGRESOS" (
        "VEHICULO_ID"
    );

CREATE INDEX "IDX_FACTURAS_CENTRO_DISPOSICION" ON
    "FACTURAS" (
        "CENTRO_DISPOSICION_ID"
    );

CREATE INDEX "IDX_FACTURAS_CONTRATISTA" ON
    "FACTURAS" (
        "CONTRATISTA_ID"
    );

CREATE INDEX "IDX_FACTURAS_RANGO_FECHA" ON
    "FACTURAS" (
        "FACTURA_INICIO_PERIODO"
    DESC,
        "FACTURA_FIN_PERIODO"
    DESC );

CREATE OR REPLACE TRIGGER ingresos_id_generador BEFORE
    INSERT ON ingresos
    FOR EACH ROW
BEGIN

    
    SELECT
        ingresos_secuencia.NEXTVAL,
        sysdate
    INTO :new.ingreso_id,:new.ingreso_fecha
    FROM
        dual;

    IF :new.celda_id = NULL THEN
        :new.ingreso_estado := 3;
    ELSE
        :new.ingreso_estado := 1;
         Registrar_ingreso.actualizar_celda(:NEW.celda_id,:NEW.ingreso_peso);
    END IF;

END;
/

CREATE OR REPLACE TRIGGER facturas_id_generador BEFORE
    INSERT ON facturas
    FOR EACH ROW
BEGIN
    SELECT
        facturas_secuencia.NEXTVAL
    INTO :new.factura_id
    FROM
        dual;

END;
/

CREATE OR REPLACE TRIGGER vehiculos_id_generador BEFORE
    INSERT ON vehiculos
    FOR EACH ROW
BEGIN
    SELECT
        vehiculos_secuencia.NEXTVAL
    INTO :new.vehiculo_id
    FROM
        dual;

END;
/


CREATE OR REPLACE TRIGGER registrar_factura_ingresos AFTER
    INSERT ON facturas
    FOR EACH ROW
BEGIN
    UPDATE ingresos i
    SET
        factura_id = :new.factura_id,
        ingreso_estado = 3
    WHERE
        i.trabajador_id IN (
            SELECT
                trabajador_id
            FROM
                trabajadores
            WHERE
                centro_disposicion_id = :new.centro_disposicion_id
        )
        AND i.vehiculo_id IN (
            SELECT
                vehiculo_id
            FROM
                vehiculos
            WHERE
                contratista_id = :new.contratista_id
        );

END;

/

create or replace PACKAGE facturacion AS

    PROCEDURE facturacion_masiva;
    
    PROCEDURE generar_facturas_centro (
        centro          IN  NUMBER,
        inicio_periodo  IN  DATE,
        fin_periodo     IN  DATE
    );


END facturacion;

/

create or replace PACKAGE BODY facturacion AS

--PROCEDIMIENTO QUE GENERA LAS FACTURAS DE UN CENTRO DE DISPOSICION EN UN PERIODO DE TIEMPO

    PROCEDURE generar_facturas_centro (
        centro          IN  NUMBER,
        inicio_periodo  IN  DATE,
        fin_periodo     IN  DATE
    ) IS

        contratista               NUMBER;
        factura_costo_transporte  NUMBER;
        factura_descuento         NUMBER;
        cantidad_resultados       NUMBER;
        CURSOR ingresos_centro_facturar IS

--OBTENER LOS INGRESOS DE UN CENTRO DE DISPOSICION EN ESPECIFICO, QUE NO HAYAN SIDO FACTURADOS Y EN UN RANGO DE FECHA DEFINIDO, JUNTO CON LA INFORMACIÓN DE QUE EMPRESA CONTRATISTA REALIZO ESTE INGRESO 
        SELECT
            contratista_id,
            SUM(ingreso_valor_sobrecarga)     descuento,
            SUM(ingreso_valor_transporte)     transporte
        FROM
                 (
                SELECT
                    ingreso_id,
                    ingreso_valor_sobrecarga,
                    ingreso_valor_transporte,
                    contratista_id,
                    trabajador_id
                FROM
                         ingresos i
                    INNER JOIN (
                        SELECT
                            conductor_id,
                            conductor_nombre,
                            contratista_id
                        FROM
                            conductores
                    ) c ON i.conductor_id = c.conductor_id
                WHERE
                    ingreso_fecha BETWEEN inicio_periodo AND fin_periodo
                    AND ingreso_estado = 2
            ) s1
            INNER JOIN (
                SELECT
                    trabajador_id,
                    trabajador_nombre
                FROM
                    trabajadores
                WHERE
                    centro_disposicion_id = centro
            ) s2 ON s1.trabajador_id = s2.trabajador_id
        GROUP BY
            contratista_id;

    BEGIN
        OPEN ingresos_centro_facturar;
        LOOP
            FETCH ingresos_centro_facturar INTO
                contratista,
                factura_descuento,
                factura_costo_transporte;
            EXIT WHEN ingresos_centro_facturar%notfound;
            INSERT INTO facturas (
                factura_costo_transporte,
                factura_descuento,
                factura_fin_periodo,
                factura_inicio_periodo,
                centro_disposicion_id,
                contratista_id
            ) VALUES (
                factura_costo_transporte,
                factura_descuento,
                fin_periodo,
                inicio_periodo,
                centro,
                contratista
            );

            COMMIT;
        END LOOP;

        CLOSE ingresos_centro_facturar;
    END;

--PROCEDIMIENTO QUE GENERA LAS FACTURAS DE LOS CENTROS DE DISPOSICION ASOCIADOS A UN CONTRATISTA DETERMINADO
    PROCEDURE generar_facturas_contratista (
        contratista     IN   NUMBER,
        inicio_periodo  IN   DATE,
        fin_periodo     IN   DATE,
        resultado       OUT  NUMBER
    ) IS
        centro_disposicion NUMBER;
        factura_descuento NUMBER;
        factura_costo_transporte NUMBER;

        res NUMBER;
        CURSOR ingresos_contratista_facturar IS
        SELECT
            centro_disposicion_id,
            SUM(ingreso_valor_sobrecarga)     multa,
            SUM(ingreso_valor_transporte)     valor
        FROM
                 (
                SELECT
                    trabajador_id,
                    contratista_id,
                    ingreso_valor_sobrecarga,
                    ingreso_valor_transporte
                FROM
                         (
                        SELECT
                            vehiculo_id,
                            ingreso_valor_sobrecarga,
                            ingreso_valor_transporte,
                            trabajador_id
                        FROM
                            ingresos
                        WHERE
                            ingreso_fecha BETWEEN inicio_periodo AND fin_periodo
                            AND ingreso_estado = 2
                    ) q1
                    INNER JOIN (
                        SELECT
                            vehiculo_id,
                            contratista_id
                        FROM
                            vehiculos
                        WHERE
                            contratista_id = contratista
                    ) q2 ON q1.vehiculo_id = q2.vehiculo_id
            ) q3
            INNER JOIN (
                SELECT
                    centro_disposicion_id,
                    trabajador_id
                FROM
                    trabajadores
            ) q4 ON q3.trabajador_id = q4.trabajador_id
        GROUP BY
            centro_disposicion_id;

    BEGIN
        OPEN ingresos_contratista_facturar;
        LOOP
            FETCH ingresos_contratista_facturar INTO
                centro_disposicion,
                factura_descuento,
                factura_costo_transporte;
            EXIT WHEN ingresos_contratista_facturar%notfound;
            INSERT INTO facturas (
                factura_costo_transporte,
                factura_descuento,
                factura_fin_periodo,
                factura_inicio_periodo,
                centro_disposicion_id,
                contratista_id
            ) VALUES (
                factura_costo_transporte,
                factura_descuento,
                fin_periodo,
                inicio_periodo,
                centro_disposicion,
                contratista
            );

            COMMIT;
        END LOOP;

        CLOSE ingresos_contratista_facturar;
    END;

--PROCEDIMIENTO QUE MARCA CUALES SON LOS INGRESOS PERTENECIENTES A UN CENTRO QUE SE FACTURARAN EN EL SIGUIENTE PERIODO DE FACTURACION
    PROCEDURE definir_ingresos_centro (
        inicio_periodo  IN  DATE,
        fin_periodo     IN  DATE,
        centro          IN  NUMBER
    ) IS
    BEGIN
        dbms_output.put_line('DEFINIENDO INGRESOS CENTRO');
        dbms_output.put_line(inicio_periodo);
        dbms_output.put_line(fin_periodo);
        dbms_output.put_line(centro);
        dbms_output.put_line('********************************');
        UPDATE ingresos
        SET
            ingreso_estado = 2
        WHERE
                ingreso_estado = 1
            AND ingreso_fecha BETWEEN inicio_periodo AND fin_periodo
            AND trabajador_id IN (
                SELECT
                    trabajador_id
                FROM
                    trabajadores t
                WHERE
                    t.centro_disposicion_id = centro
            );

    END;


--PROCEDIMIENTO QUE MARCA CUALES SON LOS INGRESOS EN LOS QUE SE INVOLUCRA UN DETERMINADO CONTRATISTA Y QUE SE FACTURARAN EN EL SIGUIENTE PERIODO DE FACTURACION

    PROCEDURE definir_ingresos_contratista (
        inicio_periodo  IN  DATE,
        fin_periodo     IN  DATE,
        contratista     IN  NUMBER
    ) IS
    BEGIN
        dbms_output.put_line('DEFINIENDO INGRESOS CENTRO');
        UPDATE ingresos
        SET
            ingreso_estado = 2
        WHERE
                ingreso_estado = 1
            AND ingreso_fecha BETWEEN inicio_periodo AND fin_periodo
            AND vehiculo_id IN (
                SELECT
                    vehiculo_id
                FROM
                    vehiculos v
                WHERE
                    v.contratista_id = contratista
            );

        COMMIT;
    END;

    
--PROCEDIMIENTO QUE MARCA LOS INGRESOS A FACTURAR PARA LOS CENTROS, CALCULA Y GENERA SUS FACTURAS Y LAS REGISTRA
    PROCEDURE facturar_ingresos_contratista (
        centro          IN   NUMBER,
        inicio_periodo  IN   DATE,
        fin_periodo     IN   DATE,
        resultado       OUT  NUMBER
    ) IS
    BEGIN
        resultado := 0;
        definir_ingresos_centro(inicio_periodo, fin_periodo, centro);
        generar_facturas_centro(centro, inicio_periodo, fin_periodo);
        resultado := 1;
        COMMIT;
    END;
    
    --PROCEDIMIENTO QUE PARA CADA CENTRO DE DISPOSICION GENERA SU FACTURACION MENSUAL

    PROCEDURE facturacion_masiva IS
        centro          NUMBER;
        estado          NUMBER;
        inicio_periodo  DATE;
        fin_periodo     DATE;
        CURSOR centros_disposicion IS
        SELECT
            centro_disposicion_id
        FROM
            centros_disposicion;

    BEGIN
        SELECT
            sysdate,
            add_months(sysdate, - 1)
        INTO
            fin_periodo,
            inicio_periodo
        FROM
            dual;

        OPEN centros_disposicion;
        LOOP
            FETCH centros_disposicion INTO centro;
            EXIT WHEN centros_disposicion%notfound;
            definir_ingresos_centro(inicio_periodo, fin_periodo, centro);
            generar_facturas_centro(centro, inicio_periodo, fin_periodo);
            estado := estado;
            COMMIT;
        END LOOP;
        
        
        dbms_output.put_line('********************************');
        dbms_output.put_line(inicio_periodo);
        dbms_output.put_line(fin_periodo);
        dbms_output.put_line('********************************');

        IF estado = 1 THEN
            UPDATE contratistas
            SET
                contratista_ultima_facturacion = fin_periodo
            WHERE
                contratista_id > 0;

        END IF;

        CLOSE centros_disposicion;
END;

END facturacion;
/

create or replace PACKAGE registrar_ingreso AS
    PROCEDURE actualizar_celda(celda NUMBER,peso NUMBER);

    PROCEDURE guardar_ingreso (
        peso              NUMBER,
        peso_sobrecarga   NUMBER,
        valor_sobrecarga  NUMBER,
        valor_transporte  NUMBER,
        celda             NUMBER,
        conductor         NUMBER,
        desecho           NUMBER,
        trabajador        NUMBER,
        vehiculo          NUMBER
    );

    PROCEDURE crear_ingreso (
        peso         IN   NUMBER,
        conductor    IN   NUMBER,
        desecho      IN   NUMBER,
        trabajador   IN   NUMBER,
        contratista  IN   NUMBER,
        vehiculo     IN   NUMBER,
        centro       IN   NUMBER,
        celda        OUT  NUMBER,
        nombre       OUT  VARCHAR2
    );

END registrar_ingreso;

/
create or replace PACKAGE BODY registrar_ingreso AS

    PROCEDURE actualizar_celda (
        celda  NUMBER,
        peso   NUMBER
    ) IS
        capacidad_nueva  NUMBER;
        capacidad_total  NUMBER;
        capacidad_usada  NUMBER;
    BEGIN
        SELECT
            celda_capacidad_total,
            celda_capacidad_usada
        INTO
            capacidad_total,
            capacidad_usada
        FROM
            celdas
        WHERE
            celda_id = celda;

        capacidad_nueva := capacidad_usada + peso;
        IF capacidad_nueva = capacidad_total THEN
            UPDATE celdas
            SET
                celda_capacidad_usada = capacidad_total,
                celda_estado = 2
            WHERE
                celda_id = celda;

        ELSE
            UPDATE celdas
            SET
                celda_capacidad_usada = capacidad_nueva,
                celda_estado = 1
            WHERE
                celda_id = celda;

        END IF;

    END;

    PROCEDURE guardar_ingreso (
        peso              NUMBER,
        peso_sobrecarga   NUMBER,
        valor_sobrecarga  NUMBER,
        valor_transporte  NUMBER,
        celda             NUMBER,
        conductor         NUMBER,
        desecho           NUMBER,
        trabajador        NUMBER,
        vehiculo          NUMBER
    ) IS
    BEGIN
        INSERT INTO ingresos (
            ingreso_peso,
            ingreso_peso_sobrecarga,
            ingreso_valor_sobrecarga,
            ingreso_valor_transporte,
            celda_id,
            conductor_id,
            desecho_id,
            trabajador_id,
            vehiculo_id
        ) VALUES (
            peso,
            peso_sobrecarga,
            valor_sobrecarga,
            valor_transporte,
            celda,
            conductor,
            desecho,
            trabajador,
            vehiculo
        );
        

    END;

    PROCEDURE crear_ingreso (
        peso         IN   NUMBER,
        conductor    IN   NUMBER,
        desecho      IN   NUMBER,
        trabajador   IN   NUMBER,
        contratista  IN   NUMBER,
        vehiculo     IN   NUMBER,
        centro       IN   NUMBER,
        celda        OUT  NUMBER,
        nombre       OUT  VARCHAR2
    ) IS

        peso_sobrecarga       NUMBER;
        valor_sobrecarga      NUMBER;
        valor_transporte      NUMBER;
        valor_kilo_exceso     NUMBER;
        peso_maximo           NUMBER;
        tipo                  NUMBER;
    BEGIN
        SELECT
            tipo_id
        INTO tipo
        FROM
            vehiculos
        WHERE
            vehiculo_id = vehiculo;

        SELECT
            contratistas_tarifan_desechos_precio_kilo
        INTO valor_transporte
        FROM
            contratistas_tarifan_desechos
        WHERE
                contratistas_tarifan_desechos.desecho_id = desecho
            AND contratistas_tarifan_desechos.contratista_id = contratista;

        SELECT
            centros_disposicion_limitan_desechos_costo_exceso,
            centros_disposicion_limitan_desechos_peso_maximo
        INTO
            valor_kilo_exceso,
            peso_maximo
        FROM
            centros_disposicion_limitan_desechos
        WHERE
                tipo_id = tipo
            AND desecho_id = desecho
            AND centro_disposicion_id = centro;

        IF peso < peso_maximo THEN
            valor_transporte := valor_transporte * peso;
            peso_sobrecarga := 0;
            valor_sobrecarga := 0;
        ELSE
            peso_sobrecarga := peso - peso_maximo;
            valor_transporte := valor_transporte * peso_maximo;
            valor_sobrecarga := valor_kilo_exceso * peso_sobrecarga;
        END IF;

        SELECT
            celda_centro_id
        INTO celda
        FROM
            (
                SELECT
                    celda_centro_id,
                    celda_centro_capacidad_disponible
                FROM
                         (
                        SELECT
                            "A1"."CELDA_ID"                                    "CELDA_CENTRO_ID",
                            ( celda_capacidad_total - celda_capacidad_usada )  "CELDA_CENTRO_CAPACIDAD_DISPONIBLE"
                        FROM
                            "DEMO_TEAMB"."CELDAS" "A1"
                        WHERE
                                "A1".centro_disposicion_id = centro
                            AND "A1".celda_estado = 1
                            AND "A1".celda_capacidad_total - "A1".celda_capacidad_usada - peso >= 0
                    )
                    INNER JOIN (
                        SELECT
                            "A2"."CELDA_ID"      "CELDA_ADMITIENDO_ID",
                            "A2"."DESECHO_ID"    "DESECHO_ADMITIDO_ID"
                        FROM
                            celdas_admiten_desechos "A2"
                        WHERE
                            "A2"."DESECHO_ID" = desecho
                    ) ON celda_centro_id = celda_admitiendo_id
                GROUP BY
                    celda_centro_id,
                    celda_centro_capacidad_disponible
                ORDER BY
                    celda_centro_capacidad_disponible DESC
                FETCH FIRST 1 ROWS ONLY
            );

        SELECT
            celda_nombre
        INTO nombre
        FROM
            celdas
        WHERE
            celda_id = celda;



        guardar_ingreso(peso, peso_sobrecarga, valor_sobrecarga, valor_transporte,
                       celda,
                       conductor,
                       desecho,
                       trabajador,
                       vehiculo);
        COMMIT;
    END crear_ingreso;

END registrar_ingreso;
/


--////////////////////////////////////////////////Datos de Prueba/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--


insert into Tipos_Vehiculos (tipo_id, tipo_descripcion, tipo_nombre) values (1, 'Zandalee', 'nulla');
insert into Tipos_Vehiculos (tipo_id, tipo_descripcion, tipo_nombre) values (2, 'Shanghai Ghetto', 'pulvinar');
insert into Tipos_Vehiculos (tipo_id, tipo_descripcion, tipo_nombre) values (3, 'Below Sea Level', 'nullam');
insert into Tipos_Vehiculos (tipo_id, tipo_descripcion, tipo_nombre) values (4, 'Lost Horizon', 'arcu');
insert into Tipos_Vehiculos (tipo_id, tipo_descripcion, tipo_nombre) values (5, 'Lady Terminator (Pembalasan ratu pantai selatan)', 'diam');


insert into Desechos (desecho_id, desecho_nombre, desecho_descripcion, desecho_estado) values (1, 'Reclaim Radiance', 'SCROPHULOUS HP', 1);
insert into Desechos (desecho_id, desecho_nombre, desecho_descripcion, desecho_estado) values (2, 'Tacrolimus', 'Erythromycin-Benzoyl Peroxide', 1);

INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(1, 'Antioquia', 5, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(2, 'Atlantico', 8, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(3, 'D. C. Santa Fe de Bogotá', 11, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(4, 'Bolivar', 13, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(5, 'Boyaca', 15, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(6, 'Caldas', 17, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(7, 'Caqueta', 18, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(8, 'Cauca', 19, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(9, 'Cesar', 20, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(10, 'Cordova', 23, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(11, 'Cundinamarca', 25, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(12, 'Choco', 27, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(13, 'Huila', 41, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(14, 'La Guajira', 44, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(15, 'Magdalena', 47, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(16, 'Meta', 50, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(17, 'Nariño', 52, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(18, 'Norte de Santander', 54, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(19, 'Quindio', 63, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(20, 'Risaralda', 66, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(21, 'Santander', 68, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(22, 'Sucre', 70, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(23, 'Tolima', 73, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(24, 'Valle', 76, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(25, 'Arauca', 81, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(26, 'Casanare', 85, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(27, 'Putumayo', 86, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(28, 'San Andres', 88, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(29, 'Amazonas', 91, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(30, 'Guainia', 94, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(31, 'Guaviare', 95, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(32, 'Vaupes', 97, 1);
INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(33, 'Vichada', 99, 1);



insert into Rutas (ruta_id, municipio_id, ruta_nombre, ruta_descripcion, ruta_fecha_inicio, ruta_fecha_finalizacion, ruta_estado) values (1, 1, 'Divavu', 'lvyjbucayetqkuf', '13/05/2020', '18/05/2020', 1);
insert into Rutas (ruta_id, municipio_id, ruta_nombre, ruta_descripcion, ruta_fecha_inicio, ruta_fecha_finalizacion, ruta_estado) values (2, 2, 'Browsezoom', 'pdkgmvzhhscfkpn', '13/05/2020', '18/05/2020', 1);



insert into Contratistas (contratista_id, contratista_nit, contratista_nombre, contratista_celular, contratista_direccion, contratista_correo, contratista_contrasena, contratista_fecha_creacion, contratista_ultima_facturacion) values (1, '0295602422', 'Kwideo', '3299075944', '03 Forster Hill', 'msilverton0@yale.edu', '4GFm6iANqgP', '17/10/2013', '01/02/2020');
insert into Contratistas (contratista_id, contratista_nit, contratista_nombre, contratista_celular, contratista_direccion, contratista_correo, contratista_contrasena, contratista_fecha_creacion, contratista_ultima_facturacion) values (2, '6886245228', 'Dabjam', '7777360185', '4 Barby Alley', 'glutsch1@hexun.com', 'Wpv7Az', '20/06/2014', '01/02/2020');



insert into  contratistas_tarifan_desechos  (contratista_id,  desecho_id, contratistas_tarifan_desechos_precio_kilo) values (2, 1, 200);
insert into  contratistas_tarifan_desechos  (contratista_id,  desecho_id, contratistas_tarifan_desechos_precio_kilo) values (1, 2, 200);
insert into  contratistas_tarifan_desechos  (contratista_id,  desecho_id, contratistas_tarifan_desechos_precio_kilo) values (1, 1, 200);
insert into  contratistas_tarifan_desechos  (contratista_id,  desecho_id, contratistas_tarifan_desechos_precio_kilo) values (2, 2, 200);


insert into Vehiculos (vehiculo_id, contratista_id, ruta_id, tipo_id, vehiculo_marca, vehiculo_placa, vehiculo_modelo, vehiculo_peso, vehiculo_fecha_creacion, vehiculo_estado) values (1, 1, 2, 2, 'Mazda', '2T1BU4EE0DC075978', 2003, 100, '14/06/2014', 1);
insert into Vehiculos (vehiculo_id, contratista_id, ruta_id, tipo_id, vehiculo_marca, vehiculo_placa, vehiculo_modelo, vehiculo_peso, vehiculo_fecha_creacion, vehiculo_estado) values (2, 2, 2, 3, 'Kia', '1C4RDJAG3FC130519', 2008, 100, '15/06/2014', 1);
insert into Vehiculos (vehiculo_id, contratista_id, ruta_id, tipo_id, vehiculo_marca, vehiculo_placa, vehiculo_modelo, vehiculo_peso, vehiculo_fecha_creacion, vehiculo_estado) values (3, 2, 1, 5, 'Lexus', 'JN8AS5MTXFW790207', 2006, 100, '31/08/2013', 1);
insert into Vehiculos (vehiculo_id, contratista_id, ruta_id, tipo_id, vehiculo_marca, vehiculo_placa, vehiculo_modelo, vehiculo_peso, vehiculo_fecha_creacion, vehiculo_estado) values (4, 2, 1, 2, 'Toyota', 'JH4CW2H57CC341727', 2012, 100, '05/12/2013', 1);
insert into Vehiculos (vehiculo_id, contratista_id, ruta_id, tipo_id, vehiculo_marca, vehiculo_placa, vehiculo_modelo, vehiculo_peso, vehiculo_fecha_creacion, vehiculo_estado) values (5, 2, 2, 1, 'Honda', 'JH4CU4F42AC369136', 2006, 100, '27/10/2013', 1);
insert into Vehiculos (vehiculo_id, contratista_id, ruta_id, tipo_id, vehiculo_marca, vehiculo_placa, vehiculo_modelo, vehiculo_peso, vehiculo_fecha_creacion, vehiculo_estado) values (6, 2, 1, 1, 'Infiniti', 'WVGFF9BP1BD167076', 2004, 100, '05/08/2013', 1);


insert into Conductores (conductor_id, contratista_id, conductor_nombre, conductor_apellido, conductor_documento, conductor_fecha_nacimiento, conductor_celular, conductor_correo, conductor_estado) values (1, 2, 'Rae', 'Blakeley', '9374625822', '14/03/1993', '2609651856', 'rblakeley0@privacy.gov.au', 1);
insert into Conductores (conductor_id, contratista_id, conductor_nombre, conductor_apellido, conductor_documento, conductor_fecha_nacimiento, conductor_celular, conductor_correo, conductor_estado) values (2, 1, 'Lucias', 'Blatchford', '5493367645', '11/02/1996', '6665441359', 'lblatchford1@youtube.com', 1);



insert into centros_disposicion (centro_disposicion_id, centro_disposicion_celular, municipio_id, centro_disposicion_nombre, centro_disposicion_direccion, centro_disposicion_correo, centro_disposicion_estado) values (1, '6827150183', 28, 'Wolf, mexican', '8 Dryden Park', 'mbradburn0@about.me', 1);
insert into centros_disposicion (centro_disposicion_id, centro_disposicion_celular, municipio_id, centro_disposicion_nombre, centro_disposicion_direccion, centro_disposicion_correo, centro_disposicion_estado) values (2, '6300512439', 21, 'Sandpiper, spotted wood', '01 Jackson Terrace', 'mwhibley1@yolasite.com', 1);



insert into  Centros_disposicion_limitan_desechos (centro_disposicion_id, tipo_id, desecho_id, CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO) values (1, 2, 1, 50000, 200);
insert into  Centros_disposicion_limitan_desechos (centro_disposicion_id, tipo_id, desecho_id, CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO) values (2, 3, 2, 50000, 200);
insert into  Centros_disposicion_limitan_desechos (centro_disposicion_id, tipo_id, desecho_id, CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO) values (1, 4, 2, 50000, 200);
insert into  Centros_disposicion_limitan_desechos (centro_disposicion_id, tipo_id, desecho_id, CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO) values (2, 1, 1, 50000, 200);
insert into  Centros_disposicion_limitan_desechos (centro_disposicion_id, tipo_id, desecho_id, CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO) values (1, 3, 1, 50000, 200);
insert into  Centros_disposicion_limitan_desechos (centro_disposicion_id, tipo_id, desecho_id, CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO) values (1, 4, 2, 50000, 200);



insert into trabajadores (trabajador_id, centro_disposicion_id, trabajador_nombre, trabajador_apellido, trabajador_documento, trabajador_celular, trabajador_correo, trabajador_direccion, trabajador_tipo, trabajador_fecha_ingreso, trabajador_fecha_nacimiento, trabajador_contrasena, trabajador_estado) values (1, 2, 'Bartlett', 'Coate', '2658998082', '8445741366', 'bcoate0@histats.com', '17 Kensington Lane', 2, '29/03/2014', '10/09/1995', 'roDVb4SNi', 1);
insert into trabajadores (trabajador_id, centro_disposicion_id, trabajador_nombre, trabajador_apellido, trabajador_documento, trabajador_celular, trabajador_correo, trabajador_direccion, trabajador_tipo, trabajador_fecha_ingreso, trabajador_fecha_nacimiento, trabajador_contrasena, trabajador_estado) values (2, 2, 'My', 'Rosenwasser', '3145265695', '8401395078', 'mrosenwasser1@about.me', '94737 Gale Avenue', 2, '22/05/2014', '06/11/1995', 'DuyimSWRxAiT', 1);
insert into trabajadores (trabajador_id, centro_disposicion_id, trabajador_nombre, trabajador_apellido, trabajador_documento, trabajador_celular, trabajador_correo, trabajador_direccion, trabajador_tipo, trabajador_fecha_ingreso, trabajador_fecha_nacimiento, trabajador_contrasena, trabajador_estado) values (3, 2, 'Garrard', 'Wipper', '6586522285', '7078284274', 'gwipper2@fotki.com', '57897 Stang Pass', 1, '20/06/2014', '05/08/1990', 'Eb1DEfq6z', 1);
insert into trabajadores (trabajador_id, centro_disposicion_id, trabajador_nombre, trabajador_apellido, trabajador_documento, trabajador_celular, trabajador_correo, trabajador_direccion, trabajador_tipo, trabajador_fecha_ingreso, trabajador_fecha_nacimiento, trabajador_contrasena, trabajador_estado) values (4, 2, 'Roxy', 'Rugg', '8862140371', '9029631473', 'rrugg3@cocolog-nifty.com', '2459 Butternut Drive', 2, '30/03/2014', '30/03/1992', 'x6XGGSNmPvgc', 1);



insert into Celdas (celda_id, centro_disposicion_id, celda_nombre, celda_estado, celda_capacidad_total, celda_capacidad_usada) values (1, 2, 'Fluocinonide', 1, 500, 100);
insert into Celdas (celda_id, centro_disposicion_id, celda_nombre, celda_estado, celda_capacidad_total, celda_capacidad_usada) values (2, 1, 'Viscum Crataegus', 1, 500, 155);
insert into Celdas (celda_id, centro_disposicion_id, celda_nombre, celda_estado, celda_capacidad_total, celda_capacidad_usada) values (3, 2, 'Clonidine Hydrochloride', 1, 500, 151);
insert into Celdas (celda_id, centro_disposicion_id, celda_nombre, celda_estado, celda_capacidad_total, celda_capacidad_usada) values (4, 1, 'VITALUMIERE AQUA', 1, 500, 163);
insert into Celdas (celda_id, centro_disposicion_id, celda_nombre, celda_estado, celda_capacidad_total, celda_capacidad_usada) values (5, 2, 'Allopurinol', 1, 500, 112);
insert into Celdas (celda_id, centro_disposicion_id, celda_nombre, celda_estado, celda_capacidad_total, celda_capacidad_usada) values (6, 1, 'Promethazine Hydrochloride', 1, 500, 144);
insert into Celdas (celda_id, centro_disposicion_id, celda_nombre, celda_estado, celda_capacidad_total, celda_capacidad_usada) values (7, 2, 'Cytotec', 1, 500, 117);
insert into Celdas (celda_id, centro_disposicion_id, celda_nombre, celda_estado, celda_capacidad_total, celda_capacidad_usada) values (8, 1, 'Necon 10/11', 1, 500, 112);
insert into Celdas (celda_id, centro_disposicion_id, celda_nombre, celda_estado, celda_capacidad_total, celda_capacidad_usada) values (9, 2, 'cold and cough', 1, 500, 128);
insert into Celdas (celda_id, centro_disposicion_id, celda_nombre, celda_estado, celda_capacidad_total, celda_capacidad_usada) values (10, 1, 'Pollens - Trees, Birch Mix', 1, 500, 141);

insert into  celdas_admiten_desechos (desecho_id, celda_id) values (1, 1 );
insert into  celdas_admiten_desechos (desecho_id, celda_id) values (1, 2 );
insert into  celdas_admiten_desechos (desecho_id, celda_id) values (1, 4);
insert into  celdas_admiten_desechos (desecho_id, celda_id) values (1, 5);
insert into  celdas_admiten_desechos (desecho_id, celda_id) values (1, 6);
insert into  celdas_admiten_desechos (desecho_id, celda_id) values (1, 7);
insert into  celdas_admiten_desechos (desecho_id, celda_id) values (1, 8);
insert into  celdas_admiten_desechos (desecho_id, celda_id) values (1, 9);
insert into  celdas_admiten_desechos (desecho_id, celda_id) values (1, 10);
insert into  celdas_admiten_desechos (desecho_id, celda_id) values (2, 1 );
insert into  celdas_admiten_desechos (desecho_id, celda_id) values (2, 2 );
insert into  celdas_admiten_desechos (desecho_id, celda_id) values (2, 4);
insert into  celdas_admiten_desechos (desecho_id, celda_id) values (2, 5);
insert into  celdas_admiten_desechos (desecho_id, celda_id) values (2, 6);
insert into  celdas_admiten_desechos (desecho_id, celda_id) values (2, 7);
insert into  celdas_admiten_desechos (desecho_id, celda_id) values (2, 8);
insert into  celdas_admiten_desechos (desecho_id, celda_id) values (2, 9);
insert into  celdas_admiten_desechos (desecho_id, celda_id) values (2, 10);

COMMIT;

