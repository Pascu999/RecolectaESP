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
    "CELDA_CAPACIDAD_TOTAL"  NUMBER(38, 0)
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

COMMIT;

