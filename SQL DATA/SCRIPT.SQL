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

DROP TABLE insercion CASCADE CONSTRAINTS PURGE;

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
create table INSERCION (
	ingreso_peso INT,
	conductor_id INT,
	desecho_id INT,
	trabajador_id INT,
	contratista_id INT,
	vehiculo_id INT,
	centro_disposicion_id INT
);
/
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

/
--TRIGGERS


--trigger que crea el nuevo id de un ingreso, le da un estado de 3 en caso de que haya sucedido un error y 1 en caso que haya sido exitoso
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
--Después de realizar el ingreso se actualiza la celda.
         Registrar_ingreso.actualizar_celda(:NEW.celda_id,:NEW.ingreso_peso);
    END IF;

END;
/
--Genera el id de la tabla facturas
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
--Genera el id de la tabla vehículos
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

--Trigger que le asigna a los ingresos su respectiva factura cuando se realice el procesamiento masivo
create or replace TRIGGER registrar_factura_ingresos AFTER
    INSERT ON facturas
    FOR EACH ROW
BEGIN
--Se asocia el ingreso a una factura y se actualiza su estado a facturado(estado = 3)
-- teniendo en cuenta que no haya sido facturado ya
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
        )
        AND factura_id IS NULL;

END;

/
--Cuando se agrega una nueva ruta se le asigna la fecha actual como fecha de inicio y se le asigna la duración de 7 dias respectiva
create or replace TRIGGER RUTAS_FINALIZACION_GENERADOR BEFORE
    INSERT ON RUTAS
    FOR EACH ROW
BEGIN
    SELECT SYSDATE, SYSDATE+7 INTO :NEW.RUTA_FECHA_INICIO,:NEW.RUTA_FECHA_FINALIZACION FROM DUAL;


END;
/
--Paquete que nos permite realizar la facturación masiva. También contiene dos procedimientos dentro del cuerpo y los cuales utilizamos para conseguir el proceso masivo
create or replace PACKAGE facturacion AS

    PROCEDURE facturacion_masiva;


END facturacion;

/
CREATE OR REPLACE PACKAGE BODY facturacion AS
    
--Procedimiento que marca los ingresos a facturar (cambia su estado a 2) dentro de un periodo de tiempo.

    PROCEDURE definir_ingresos (
        inicio_periodo  IN  DATE,
        fin_periodo     IN  DATE
    ) IS
    BEGIN
        UPDATE ingresos
        SET
            ingreso_estado = 2
        WHERE /*+ INDEX(INGRESOS IDX_INGRESOS_FECHA) */
                ingreso_estado = 1
            AND ingreso_fecha BETWEEN inicio_periodo AND fin_periodo;

    END;


    --Procedimiento que genera una factura por cada tupla (contratista,centro).Estas tuplas se forman en un periodo de facturación y son únicas

    PROCEDURE generar_facturas (
        inicio_periodo  IN  DATE,
        fin_periodo     IN  DATE
    ) IS

        respuesta         NUMBER;
        contratista       NUMBER;
        centro            NUMBER;
        costo_transporte  NUMBER;
        descuento         NUMBER;
        CURSOR ingresos_centro_facturar IS

        --Obtenemos las tuplas únicas en base al registro de vehículo y trabajador que se almacena por cada ingreso
        SELECT DISTINCT
            contratista_id,
            centro_disposicion_id
        FROM
                 (
                SELECT DISTINCT
                    contratista_id,
                    trabajador_id
                FROM
                         (
                        SELECT
                            trabajador_id,
                            vehiculo_id
                        FROM
                            ingresos i
                        WHERE
                            ingreso_fecha BETWEEN inicio_periodo AND fin_periodo
                            AND ingreso_estado = 2
                    ) i
                    INNER JOIN (
                        SELECT
                            contratista_id,
                            vehiculo_id
                        FROM
                            vehiculos
                    ) v ON i.vehiculo_id = v.vehiculo_id
            ) q1
            INNER JOIN (
                SELECT
                    centro_disposicion_id,
                    trabajador_id
                FROM
                    trabajadores
            ) q2 ON q1.trabajador_id = q1.trabajador_id;

    BEGIN
        respuesta := 0;
        OPEN ingresos_centro_facturar;
        LOOP
            FETCH ingresos_centro_facturar INTO
                contratista,
                centro;
            EXIT WHEN ingresos_centro_facturar%notfound;

            --Por cada tupla(que convertimos en una factura), calculamos el valor total de los ingresos relacionados
            --tanto al centro como al contratista que se factura, dichos ingresos deben ser seleccionados como ingresos a facturar(estado = 2)
            --y deben estar en el periodo de facturación

            SELECT /*+ INDEX(ingresos  IDX_INGRESOS_VEHICULO IDX_INGRESOS_TRABAJADOR) */
                SUM(ingreso_valor_transporte),
                SUM(ingreso_valor_sobrecarga)
            INTO
                costo_transporte,
                descuento
            FROM
                ingresos
            WHERE
                ingreso_fecha BETWEEN inicio_periodo AND fin_periodo
                AND trabajador_id IN (
                    SELECT
                        trabajador_id
                    FROM
                        trabajadores
                    WHERE
                        centro_disposicion_id = centro
                )
                AND vehiculo_id IN (
                    SELECT
                        vehiculo_id
                    FROM
                        vehiculos
                    WHERE
                            contratista_id = contratista
                        AND ingreso_estado = 2
                );

            INSERT INTO facturas (
                factura_costo_transporte,
                factura_descuento,
                factura_fin_periodo,
                factura_inicio_periodo,
                centro_disposicion_id,
                contratista_id
            ) VALUES (
                costo_transporte,
                descuento,
                fin_periodo,
                inicio_periodo,
                centro,
                contratista
            );

            UPDATE contratistas
            SET
                contratista_ultima_facturacion = fin_periodo
            WHERE
                contratista_id = contratista;

        END LOOP;

        respuesta := 1;
        CLOSE ingresos_centro_facturar;
        IF respuesta < 1 THEN
            ROLLBACK;
        ELSE
            COMMIT;
        END IF;
    END;



--Procedimiento que controla el proceso masivo

    PROCEDURE facturacion_masiva IS
        estado          NUMBER;
        inicio_periodo  DATE;
        fin_periodo     DATE;
    BEGIN
    
  
        --Periodo de facturación
        SELECT
            sysdate,
            add_months(sysdate, - 1)
        INTO
            fin_periodo,
            inicio_periodo
        FROM
            dual;

        --Se definen los ingresos a facturar
        definir_ingresos(inicio_periodo, fin_periodo);
        --Se crean las facturas que contendrán dichos ingresos y se calcula su costo
        generar_facturas(inicio_periodo, fin_periodo);
    END;

END facturacion;

/

--Paquete que contiene los procedimientos que nos permiten manejar la lógica de los ingresos
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
    
    PROCEDURE Insertar_ingresos;

END registrar_ingreso;

/

create or replace PACKAGE BODY registrar_ingreso AS
    
--Una vez que se realiza un ingreso de forma exitosa, se procede a actualizar la información de la celda que contiene este ingreso
    PROCEDURE actualizar_celda (
        celda  NUMBER,
        peso   NUMBER
    ) IS
        capacidad_nueva  NUMBER;
        capacidad_total  NUMBER;
        capacidad_usada  NUMBER;
    BEGIN
        --Información de la celda antes de que se realizara el ingreso
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

        --Nueva capacidad de la celda
        capacidad_nueva := capacidad_usada + peso;

        --Si despues del ultimo ingreso la celda llega a su maxima capacidad, se simboliza esto cambiando su estado a 2
        IF capacidad_nueva = capacidad_total THEN
            UPDATE celdas
            SET
                celda_capacidad_usada = capacidad_total,
                celda_estado = 2
            WHERE
                celda_id = celda;

        ELSE
        --Si no sucede esto solo se actualiza su nueva capacidad disponible
            UPDATE celdas
            SET
                celda_capacidad_usada = capacidad_nueva,
                celda_estado = 1
            WHERE
                celda_id = celda;

        END IF;

    END;

--Procedimiento que guarda el ingreso en la base de datos
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
    
        COMMIT;
    END;

--Procedimiento que maneja la lógica de crear un nuevo ingreso
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
        peso_sobrecarga    NUMBER;
        valor_sobrecarga   NUMBER;
        valor_transporte   NUMBER;
        valor_kilo_exceso  NUMBER;
        peso_maximo        NUMBER;
        tipo               NUMBER;
    BEGIN
    --Tipo del vehículo que va a ingresar

        SELECT
            tipo_id
        INTO tipo
        FROM
            vehiculos
        WHERE
            vehiculo_id = vehiculo;

    --Costo de transportar un kilo del residuo a ingresar, dado por el contratista que transporta
        SELECT
            contratistas_tarifan_desechos_precio_kilo
        INTO valor_transporte
        FROM
            contratistas_tarifan_desechos
        WHERE
                contratistas_tarifan_desechos.desecho_id = desecho
            AND contratistas_tarifan_desechos.contratista_id = contratista;

    --Limites del transporte del desecho y el costo por excederlos, dados por el centro de disposición donde se realizará el ingreso
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

    --Calculo del valor de la sobrecarga si existe
        IF peso < peso_maximo THEN
            valor_transporte := valor_transporte * peso;
            peso_sobrecarga := 0;
            valor_sobrecarga := 0;
        ELSE
            peso_sobrecarga := peso - peso_maximo;
            valor_transporte := valor_transporte * peso_maximo;
            valor_sobrecarga := valor_kilo_exceso * peso_sobrecarga;
        END IF;
    
    --Se obtiene la celda en la que se debe hacer el ingreso que
        SELECT
            celda_centro_id
        INTO celda
        FROM
            (
    --Se obtienen las celdas que cumplan las condiciones de capacidad,estado,pertenezcan al centro  y admitan el desecho que se ingresa
                SELECT
                    celda_centro_id,
                    celda_centro_capacidad_disponible
                FROM
                         (
    --Se obtienen las celdas que le pertenezcan al centro de disposicion, se encuentren disponibles y que tengan capacidad para la carga que se ingresa                          
                        SELECT              
                            "A1"."CELDA_ID"                                    "CELDA_CENTRO_ID",
                            ( celda_capacidad_total - celda_capacidad_usada )  "CELDA_CENTRO_CAPACIDAD_DISPONIBLE"
                        FROM
                            celdas "A1"
                        WHERE
                                "A1".centro_disposicion_id = centro
                            AND "A1".celda_estado = 1
                            AND "A1".celda_capacidad_total - "A1".celda_capacidad_usada - peso >= 0
                    )
                    INNER JOIN (
    --Se obtienen las celdas que admitan el tipo de desecho que esta ingresando
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
    --Ordenamos las celdas en orden descendente y escogemos la primera(La que mayor capacidad disponible tiene)
                ORDER BY
                    celda_centro_capacidad_disponible DESC
                FETCH FIRST 1 ROWS ONLY
            );
    --Obtenemos el nombre de la celda en la cual haremos el ingreso
        SELECT
            celda_nombre
        INTO nombre
        FROM
            celdas
        WHERE
            celda_id = celda;
    --Se guarda la información del ingreso
        guardar_ingreso(peso, peso_sobrecarga, valor_sobrecarga, valor_transporte, celda,
                       conductor,
                       desecho,
                       trabajador,
                       vehiculo);

    END crear_ingreso;

    --Procedimiento para insertar de forma masiva ingresos(No hace parte de la logica de la aplicación)
    PROCEDURE Insertar_ingresos  IS

        peso         NUMBER;
        conductor    NUMBER;
        desecho      NUMBER;
        trabajador   NUMBER;
        contratista  NUMBER;
        vehiculo     NUMBER;
        centro       NUMBER;
        celda        Number;
        nombre       VARCHAR2(255);
        
        CURSOR micursor IS
        SELECT
            ingreso_peso,
            conductor_id,
            desecho_id,
            trabajador_id,
            contratista_id,
            vehiculo_id,
            centro_disposicion_id
        FROM
            insercion;

    BEGIN
        OPEN micursor;
        
        LOOP
            FETCH micursor INTO
                peso,
                conductor,
                desecho,
                trabajador,
                contratista,
                vehiculo,
                centro;
            EXIT WHEN micursor%notfound;
            
            registrar_ingreso.crear_ingreso(peso, conductor, desecho, trabajador, contratista,
                                           vehiculo,
                                           centro,
                                           celda,
                                           nombre);

            
        END LOOP;
        CLOSE micursor;
        COMMIT;
    END;

END registrar_ingreso;
/

--Jobs

--Trabajo que desactiva una ruta cuando detecta que su periodo de vigencia finalizó(se ejecuta a la media noche)
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => '"RECOLECTA"."RUTAESTADO"',
            job_type => 'PLSQL_BLOCK',
            job_action => 'UPDATE RUTAS SET RUTA ESTADO = 0 WHERE RUTA_FECHA_FINALIZACION < (SELECT SYSDATE FROM DUAL)',
            number_of_arguments => 0,
            start_date => TO_TIMESTAMP_TZ('2021-01-01 00:00:00.000000000 AMERICA/BOGOTA','YYYY-MM-DD HH24:MI:SS.FF TZR'),
            repeat_interval => 'FREQ=WEEKLY',
            end_date => NULL,
            enabled => FALSE,
            auto_drop => FALSE,
            comments => 'Desactiva las rutas si su periodo de vigencia acabó');

         
     
 
    DBMS_SCHEDULER.SET_ATTRIBUTE( 
             name => '"RECOLECTA"."RUTAESTADO"', 
             attribute => 'store_output', value => TRUE);
    DBMS_SCHEDULER.SET_ATTRIBUTE( 
             name => '"RECOLECTA"."RUTAESTADO"', 
             attribute => 'logging_level', value => DBMS_SCHEDULER.LOGGING_OFF);
      
   
  
    
    DBMS_SCHEDULER.enable(
             name => '"RECOLECTA"."RUTAESTADO"');
END;

/

--Trabajo que ejecuta el procesamiento masivo de forma mensual a la media noche
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
            job_name => '"RECOLECTA"."PROCESAMIENTOMASIVO"',
            job_type => 'STORED_PROCEDURE',
            job_action => 'RECOLECTA.FACTURACION.FACTURACION_MASIVA',
            number_of_arguments => 0,
            start_date => TO_TIMESTAMP_TZ('2021-07-18 00:00:13.000000000 AMERICA/BOGOTA','YYYY-MM-DD HH24:MI:SS.FF TZR'),
            repeat_interval => 'FREQ=MONTHLY',
            end_date => NULL,
            enabled => FALSE,
            auto_drop => FALSE,
            comments => 'Ejectua el procesamiento masivo');

         
     
 
    DBMS_SCHEDULER.SET_ATTRIBUTE( 
             name => '"RECOLECTA"."PROCESAMIENTOMASIVO"', 
             attribute => 'store_output', value => TRUE);
    DBMS_SCHEDULER.SET_ATTRIBUTE( 
             name => '"RECOLECTA"."PROCESAMIENTOMASIVO"', 
             attribute => 'logging_level', value => DBMS_SCHEDULER.LOGGING_OFF);
      
   
  
    
    DBMS_SCHEDULER.enable(
             name => '"RECOLECTA"."PROCESAMIENTOMASIVO"');
END;
/

--DATOS DE PRUEBA. 

insert into Tipos_Vehiculos (tipo_id, tipo_descripcion, tipo_nombre) values (1, 'Zandalee', 'Pesado');
insert into Tipos_Vehiculos (tipo_id, tipo_descripcion, tipo_nombre) values (2, 'Shanghai Ghetto', 'Liviano');

insert into Desechos (desecho_id, desecho_nombre, desecho_descripcion, desecho_estado) values (1, 'Residuo comercial', 'SCROPHULOUS HP', 1);
insert into Desechos (desecho_id, desecho_nombre, desecho_descripcion, desecho_estado) values (2, 'Residuo domiciliario', 'Erythromycin-Benzoyl Peroxide', 1);
insert into Desechos (desecho_id, desecho_nombre, desecho_descripcion, desecho_estado) values (3, 'Residuo agricola', 'SCROPHULOUS HP', 1);

INSERT INTO Municipios (municipio_id, municipio_nombre , municipio_codigo_postal,municipio_estado) VALUES(1, 'Antioquia', 5, 1);

insert into Rutas (ruta_id, municipio_id, ruta_nombre, ruta_descripcion, ruta_fecha_inicio, ruta_fecha_finalizacion, ruta_estado) values (1, 1, 'Mybuzz', 'pcjkybfnuafwxvp', '18/05/2020', '18/05/2020', 1);
insert into Rutas (ruta_id, municipio_id, ruta_nombre, ruta_descripcion, ruta_fecha_inicio, ruta_fecha_finalizacion, ruta_estado) values (2, 1, 'Tavu', 'elmiwzisfshfgxt', '18/05/2020', '18/05/2020', 1);

insert into Contratistas (contratista_id, contratista_nit, contratista_nombre, contratista_celular, contratista_direccion, contratista_correo, contratista_contrasena, contratista_fecha_creacion, contratista_ultima_facturacion) values (1, 'contratista1', 'Jabbersphere', '1447973557', '035 Sachs Hill', 'obeaty0@wufoo.com', 'contratista1', '28/09/2013', '01/02/2020');
insert into Contratistas (contratista_id, contratista_nit, contratista_nombre, contratista_celular, contratista_direccion, contratista_correo, contratista_contrasena, contratista_fecha_creacion, contratista_ultima_facturacion) values (2, 'contratista2', 'Pixonyx', '8146532106', '7 Lindbergh Court', 'ahinemoor1@goo.gl', 'contratista2', '28/12/2013', '01/02/2020');

INSERT INTO CONTRATISTAS_TARIFAN_DESECHOS(CONTRATISTA_ID, DESECHO_ID, CONTRATISTAS_TARIFAN_DESECHOS_PRECIO_KILO) VALUES
(1, 1, 5549);
INSERT INTO CONTRATISTAS_TARIFAN_DESECHOS(CONTRATISTA_ID, DESECHO_ID, CONTRATISTAS_TARIFAN_DESECHOS_PRECIO_KILO) VALUES
(1, 2, 5165);
INSERT INTO CONTRATISTAS_TARIFAN_DESECHOS(CONTRATISTA_ID, DESECHO_ID, CONTRATISTAS_TARIFAN_DESECHOS_PRECIO_KILO) VALUES
(1, 3, 6494);
INSERT INTO CONTRATISTAS_TARIFAN_DESECHOS(CONTRATISTA_ID, DESECHO_ID, CONTRATISTAS_TARIFAN_DESECHOS_PRECIO_KILO) VALUES
(2, 1, 6221);
INSERT INTO CONTRATISTAS_TARIFAN_DESECHOS(CONTRATISTA_ID, DESECHO_ID, CONTRATISTAS_TARIFAN_DESECHOS_PRECIO_KILO) VALUES
(2, 2, 7765);
INSERT INTO CONTRATISTAS_TARIFAN_DESECHOS(CONTRATISTA_ID, DESECHO_ID, CONTRATISTAS_TARIFAN_DESECHOS_PRECIO_KILO) VALUES
(2, 3, 5658);

insert into Vehiculos (vehiculo_id, contratista_id, ruta_id, tipo_id, vehiculo_marca, vehiculo_placa, vehiculo_modelo, vehiculo_peso, vehiculo_fecha_creacion, vehiculo_estado) values (1, 1, 1, 1, 'Nissan', 'AAA-123', 2007, 100, '15/03/2014', 1);
insert into Vehiculos (vehiculo_id, contratista_id, ruta_id, tipo_id, vehiculo_marca, vehiculo_placa, vehiculo_modelo, vehiculo_peso, vehiculo_fecha_creacion, vehiculo_estado) values (2, 1, 2, 2, 'Nissan', 'BBB-123', 2010, 100, '22/04/2014', 1);
insert into Vehiculos (vehiculo_id, contratista_id, ruta_id, tipo_id, vehiculo_marca, vehiculo_placa, vehiculo_modelo, vehiculo_peso, vehiculo_fecha_creacion, vehiculo_estado) values (3, 2, 1, 1, 'Acura', 'CCC-123', 2005, 100, '26/03/2014', 1);
insert into Vehiculos (vehiculo_id, contratista_id, ruta_id, tipo_id, vehiculo_marca, vehiculo_placa, vehiculo_modelo, vehiculo_peso, vehiculo_fecha_creacion, vehiculo_estado) values (4, 2, 2, 2, 'Chevrolet', 'DDD-123', 1993, 100, '09/06/2014', 1);

insert into Conductores (conductor_id, contratista_id, conductor_nombre, conductor_apellido, conductor_documento, conductor_fecha_nacimiento, conductor_celular, conductor_correo, conductor_estado) values (1, 1, 'Delano', 'Sargent', '1111111111', '29/08/1992', '3988264492', 'dsargent0@mail.ru', 1);
insert into Conductores (conductor_id, contratista_id, conductor_nombre, conductor_apellido, conductor_documento, conductor_fecha_nacimiento, conductor_celular, conductor_correo, conductor_estado) values (2, 2, 'Reginauld', 'O''Flannery', '2222222222', '23/01/1994', '3111369831', 'roflannery1@sciencedaily.com', 1);

insert into Centros_disposicion (centro_disposicion_id, municipio_id, centro_disposicion_nombre, centro_disposicion_direccion, centro_disposicion_celular, centro_disposicion_correo, centro_disposicion_estado) values (1, 1, 'Benetta', '3 Mifflin Center', '4023977601', 'bnoseworthy0@usnews.com', 1);
insert into Centros_disposicion (centro_disposicion_id, municipio_id, centro_disposicion_nombre, centro_disposicion_direccion, centro_disposicion_celular, centro_disposicion_correo, centro_disposicion_estado) values (2, 1, 'Lacey', '5 Buell Road', '3066333741', 'lduran1@clickbank.net', 1);

INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(3671, 847, 1, 1, 1);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(2037, 638, 1, 1, 2);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(1729, 904, 1, 1, 3);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(2984, 584, 1, 2, 1);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(3430, 652, 1, 2, 2);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(2706, 775, 1, 2, 3);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(3576, 638, 2, 1, 1);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(3634, 505, 2, 1, 2);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(4030, 910, 2, 1, 3);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(2774, 614, 2, 2, 1);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(2506, 674, 2, 2, 2);
INSERT INTO CENTROS_DISPOSICION_LIMITAN_DESECHOS(CENTROS_DISPOSICION_LIMITAN_DESECHOS_COSTO_EXCESO, CENTROS_DISPOSICION_LIMITAN_DESECHOS_PESO_MAXIMO, TIPO_ID, CENTRO_DISPOSICION_ID, DESECHO_ID) VALUES
(4604, 737, 2, 2, 3);

insert into trabajadores (trabajador_id, centro_disposicion_id, trabajador_nombre, trabajador_apellido, trabajador_documento, trabajador_celular, trabajador_correo, trabajador_direccion, trabajador_tipo, trabajador_fecha_ingreso, trabajador_fecha_nacimiento, trabajador_contrasena, trabajador_estado) values (1, 1, 'trabakado', 'Cotmore', 'trabajador', '31314688553', 'pcotmore0@storify.com', '5 Di Loreto Avenue', 2, '02/03/2014', '29/05/1997', 'trabajador', 1);
insert into trabajadores (trabajador_id, centro_disposicion_id, trabajador_nombre, trabajador_apellido, trabajador_documento, trabajador_celular, trabajador_correo, trabajador_direccion, trabajador_tipo, trabajador_fecha_ingreso, trabajador_fecha_nacimiento, trabajador_contrasena, trabajador_estado) values (2, 1, 'Jesus', 'Tumilty', 'admin', '31314688554', 'itumilty1@goo.gl', '11 Manufacturers Alley', 1, '04/03/2014', '01/08/1994', 'admin', 1);

insert into Celdas (celda_id, centro_disposicion_id, celda_nombre, celda_estado, celda_capacidad_total, celda_capacidad_usada) values (1, 1, 'Topiramate', 1, 999999999999999, 0);
insert into Celdas (celda_id, centro_disposicion_id, celda_nombre, celda_estado, celda_capacidad_total, celda_capacidad_usada) values (2, 1, 'Muscle Ice', 1, 999999999999999, 0);
insert into Celdas (celda_id, centro_disposicion_id, celda_nombre, celda_estado, celda_capacidad_total, celda_capacidad_usada) values (3, 2, 'Hydrocortisone and Acetic Acid', 1, 999999999999999, 0);
insert into Celdas (celda_id, centro_disposicion_id, celda_nombre, celda_estado, celda_capacidad_total, celda_capacidad_usada) values (4, 2, 'Targretin', 1, 999999999999999, 0);

insert into Celdas_admiten_desechos (celda_id, desecho_id) values (1, 1);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (1, 2);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (1, 3);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (2, 1);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (2, 2);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (2, 3);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (3, 1);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (3, 2);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (3, 3);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (4, 1);
insert into Celdas_admiten_desechos (celda_id, desecho_id) values (4, 2);

--Datos para probar el funcionamiento de la app.

--Centro de Disposicion 1 y contratista 1

insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (477, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (462, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (357, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (496, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (250, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (428, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (401, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (336, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (226, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (445, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (263, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (409, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (467, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (254, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (323, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (477, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (487, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (348, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (410, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (337, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (443, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (360, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (303, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (321, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (437, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (414, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (305, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (286, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (276, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (376, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (340, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (230, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (450, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (280, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (290, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (279, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (475, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (371, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (492, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (410, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (484, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (313, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (475, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (241, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (375, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (453, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (320, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (355, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (215, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (467, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (207, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (319, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (388, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (444, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (477, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (342, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (394, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (299, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (286, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (240, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (445, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (496, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (367, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (403, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (292, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (454, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (363, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (474, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (303, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (487, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (222, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (432, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (238, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (213, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (332, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (310, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (384, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (486, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (401, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (353, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (348, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (478, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (344, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (328, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (457, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (485, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (262, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (203, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (264, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (430, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (261, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (384, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (207, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (254, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (452, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (425, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (224, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (257, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (273, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (263, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (293, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (431, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (441, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (403, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (225, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (332, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (203, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (395, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (450, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (365, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (328, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (485, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (338, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (306, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (255, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (397, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (407, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (499, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (488, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (239, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (320, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (251, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (316, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (432, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (203, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (206, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (433, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (404, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (374, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (240, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (314, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (225, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (400, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (342, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (213, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (491, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (309, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (215, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (241, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (383, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (361, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (238, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (474, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (300, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (380, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (384, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (210, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (464, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (455, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (212, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (221, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (488, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (379, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (263, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (469, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (377, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (207, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (430, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (327, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (441, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (280, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (468, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (306, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (325, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (454, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (412, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (210, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (495, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (457, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (258, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (255, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (201, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (327, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (430, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (407, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (225, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (404, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (256, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (344, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (452, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (278, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (243, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (401, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (487, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (476, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (250, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (460, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (301, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (441, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (478, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (403, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (456, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (327, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (455, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (426, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (302, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (317, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (208, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (208, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (331, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (301, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (365, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (243, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (214, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (379, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (399, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (473, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (343, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (327, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (352, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (458, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (428, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (379, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (388, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (333, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (205, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (328, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (258, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (234, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (268, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (374, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (414, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (444, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (339, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (482, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (474, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (417, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (213, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (376, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (256, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (417, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (434, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (338, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (392, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (479, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (445, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (330, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (484, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (402, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (475, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (281, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (351, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (402, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (202, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (353, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (341, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (250, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (274, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (292, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (460, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (306, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (466, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (486, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (441, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (484, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (285, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (238, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (477, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (470, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (405, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (459, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (280, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (295, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (475, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (430, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (202, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (316, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (429, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (369, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (297, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (230, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (466, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (442, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (399, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (259, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (293, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (364, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (246, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (205, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (231, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (379, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (431, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (375, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (228, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (200, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (331, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (231, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (479, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (408, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (426, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (493, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (435, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (412, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (429, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (423, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (272, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (461, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (341, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (221, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (229, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (219, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (488, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (393, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (232, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (287, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (269, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (358, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (392, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (371, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (459, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (385, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (278, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (223, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (261, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (240, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (256, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (314, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (492, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (306, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (285, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (237, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (313, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (332, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (373, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (373, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (492, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (421, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (332, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (243, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (360, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (228, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (210, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (444, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (404, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (431, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (444, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (499, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (201, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (258, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (490, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (428, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (497, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (256, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (268, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (353, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (491, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (487, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (303, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (330, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (312, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (274, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (376, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (200, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (393, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (424, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (292, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (294, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (475, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (435, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (248, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (357, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (379, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (331, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (424, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (310, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (248, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (303, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (263, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (207, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (421, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (315, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (435, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (217, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (426, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (461, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (234, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (486, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (369, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (425, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (475, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (324, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (242, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (210, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (420, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (498, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (224, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (390, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (348, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (239, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (350, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (472, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (212, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (209, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (298, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (439, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (373, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (367, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (394, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (454, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (369, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (227, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (358, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (408, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (296, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (485, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (288, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (317, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (312, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (226, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (355, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (332, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (256, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (496, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (294, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (385, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (316, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (461, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (285, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (357, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (383, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (321, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (221, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (483, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (212, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (308, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (359, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (330, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (428, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (392, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (342, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (458, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (214, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (329, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (431, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (209, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (429, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (265, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (483, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (291, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (208, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (349, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (212, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (358, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (440, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (286, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (232, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (337, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (309, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (269, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (364, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (271, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (416, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (348, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (443, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (314, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (355, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (271, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (322, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (386, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (420, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (327, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (228, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (416, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (274, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (353, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (400, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (404, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (412, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (459, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (449, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (392, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (438, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (409, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (370, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (420, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (381, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (293, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (201, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (353, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (277, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (235, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (379, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (334, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (266, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (375, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (470, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (242, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (318, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (496, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (328, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (370, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (382, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (272, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (434, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (404, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (498, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (488, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (230, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (298, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (257, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (251, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (299, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (221, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (308, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (226, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (213, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (284, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (302, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (318, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (401, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (439, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (443, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (400, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (272, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (478, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (235, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (290, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (227, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (250, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (306, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (247, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (202, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (267, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (317, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (457, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (494, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (438, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (260, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (314, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (330, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (411, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (448, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (211, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (201, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (474, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (347, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (274, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (479, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (349, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (332, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (252, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (420, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (319, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (345, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (397, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (339, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (306, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (360, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (484, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (314, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (345, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (253, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (330, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (295, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (217, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (495, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (464, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (491, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (373, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (336, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (239, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (477, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (415, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (386, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (280, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (273, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (382, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (410, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (488, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (251, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (201, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (350, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (391, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (415, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (382, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (432, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (415, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (325, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (228, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (311, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (426, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (345, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (354, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (359, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (228, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (427, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (200, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (446, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (360, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (266, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (319, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (272, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (342, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (290, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (276, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (236, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (290, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (204, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (439, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (233, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (418, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (358, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (278, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (445, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (339, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (426, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (266, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (488, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (451, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (467, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (267, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (463, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (209, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (287, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (258, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (405, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (402, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (459, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (331, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (475, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (346, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (376, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (359, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (426, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (485, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (360, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (254, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (475, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (317, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (252, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (369, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (291, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (331, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (474, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (219, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (377, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (330, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (316, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (279, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (305, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (350, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (323, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (294, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (404, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (434, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (287, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (424, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (494, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (336, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (464, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (473, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (285, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (385, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (274, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (487, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (246, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (495, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (220, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (473, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (277, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (424, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (210, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (480, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (307, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (393, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (443, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (470, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (373, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (427, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (248, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (252, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (393, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (480, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (222, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (299, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (429, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (451, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (282, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (469, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (463, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (419, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (332, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (286, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (357, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (423, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (457, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (428, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (264, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (234, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (462, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (315, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (233, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (419, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (459, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (364, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (365, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (280, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (341, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (261, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (433, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (354, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (244, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (500, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (330, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (223, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (250, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (420, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (373, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (202, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (487, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (232, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (451, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (296, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (329, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (334, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (233, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (489, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (333, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (287, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (382, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (421, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (428, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (448, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (315, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (218, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (278, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (466, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (378, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (448, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (290, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (273, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (393, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (361, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (500, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (244, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (240, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (354, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (492, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (469, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (226, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (420, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (349, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (497, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (256, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (220, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (448, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (347, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (354, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (261, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (302, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (252, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (304, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (479, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (316, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (389, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (437, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (323, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (349, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (427, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (377, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (311, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (487, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (401, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (345, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (235, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (324, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (470, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (302, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (499, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (300, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (495, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (434, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (282, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (456, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (389, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (303, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (467, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (453, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (411, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (334, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (419, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (405, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (320, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (393, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (310, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (266, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (204, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (338, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (367, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (263, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (288, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (398, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (410, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (390, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (306, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (292, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (346, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (292, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (409, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (278, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (289, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (484, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (451, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (465, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (398, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (403, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (334, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (309, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (236, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (370, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (486, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (268, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (218, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (482, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (212, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (436, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (227, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (494, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (236, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (301, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (321, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (493, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (486, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (319, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (432, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (450, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (487, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (418, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (301, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (390, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (257, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (283, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (257, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (251, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (440, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (373, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (453, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (339, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (344, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (481, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (487, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (268, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (255, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (478, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (208, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (202, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (380, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (293, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (429, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (402, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (322, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (222, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (359, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (238, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (392, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (204, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (483, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (255, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (348, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (208, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (500, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (361, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (314, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (311, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (492, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (484, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (475, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (301, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (496, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (393, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (256, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (270, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (404, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (463, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (308, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (458, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (496, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (385, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (351, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (350, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (261, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (466, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (205, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (461, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (446, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (213, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (259, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (341, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (300, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (485, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (233, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (435, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (271, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (478, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (271, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (391, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (382, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (474, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (291, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (209, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (475, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (250, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (429, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (214, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (408, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (236, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (228, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (312, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (391, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (493, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (331, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (273, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (359, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (309, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (346, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (200, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (375, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (461, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (418, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (283, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (428, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (442, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (234, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (308, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (352, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (392, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (355, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (269, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (488, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (285, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (467, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (301, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (389, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (359, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (322, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (364, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (442, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (399, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (375, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (279, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (292, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (363, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (481, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (473, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (252, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (444, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (303, 2, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (373, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (470, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (279, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (202, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (373, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (333, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (429, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (279, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (214, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (322, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (204, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (200, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (345, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (283, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (497, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (481, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (442, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (297, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (383, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (232, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (418, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (205, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (371, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (462, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (239, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (212, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (358, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (500, 1, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (243, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (231, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (231, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (460, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (412, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (452, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (334, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (477, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (250, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (273, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (418, 1, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (246, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (465, 2, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (362, 1, 3, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (439, 2, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (427, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (374, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (209, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (483, 1, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (237, 1, 2, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (269, 2, 1, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (465, 1, 3, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (414, 2, 1, 1, 1, 1, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (304, 2, 2, 1, 1, 2, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (480, 1, 3, 1, 1, 1, 1);

--CONTRATISTA 2 Y CENTRO DE DISPOSICION 1

insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (387, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (350, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (476, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (250, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (371, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (422, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (215, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (414, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (497, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (482, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (208, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (381, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (245, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (316, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (291, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (439, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (294, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (340, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (379, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (299, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (293, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (454, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (324, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (270, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (488, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (467, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (423, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (410, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (365, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (259, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (350, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (216, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (383, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (234, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (298, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (382, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (452, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (482, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (235, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (310, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (258, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (474, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (326, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (369, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (325, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (285, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (335, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (374, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (324, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (316, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (318, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (268, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (214, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (286, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (381, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (277, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (321, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (272, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (449, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (496, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (426, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (426, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (319, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (387, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (499, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (459, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (421, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (212, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (319, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (396, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (376, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (339, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (326, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (330, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (420, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (242, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (335, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (437, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (286, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (479, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (272, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (279, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (395, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (229, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (482, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (201, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (383, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (296, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (219, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (200, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (311, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (370, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (454, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (282, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (474, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (499, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (375, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (476, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (229, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (451, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (237, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (370, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (473, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (328, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (345, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (207, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (430, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (324, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (307, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (399, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (337, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (312, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (332, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (499, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (252, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (221, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (212, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (475, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (383, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (301, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (417, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (416, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (241, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (499, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (204, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (283, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (439, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (326, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (348, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (264, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (205, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (407, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (343, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (447, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (218, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (478, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (247, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (365, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (437, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (277, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (333, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (210, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (399, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (321, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (210, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (397, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (423, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (252, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (396, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (360, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (262, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (419, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (499, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (481, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (396, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (391, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (471, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (220, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (479, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (201, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (460, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (301, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (360, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (402, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (362, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (217, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (346, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (291, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (453, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (468, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (235, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (219, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (405, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (266, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (452, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (203, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (437, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (227, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (475, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (272, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (448, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (254, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (362, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (326, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (312, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (419, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (339, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (400, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (376, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (360, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (366, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (207, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (271, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (444, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (330, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (247, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (243, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (207, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (419, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (499, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (337, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (358, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (483, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (320, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (481, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (381, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (401, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (479, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (401, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (435, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (344, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (287, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (264, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (351, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (436, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (314, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (445, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (284, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (259, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (353, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (290, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (234, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (213, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (451, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (237, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (345, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (441, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (313, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (267, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (311, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (358, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (359, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (396, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (330, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (382, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (493, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (480, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (450, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (248, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (327, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (344, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (391, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (301, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (214, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (353, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (267, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (399, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (308, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (280, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (328, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (495, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (346, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (252, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (455, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (440, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (493, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (498, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (390, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (291, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (417, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (299, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (236, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (428, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (346, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (283, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (201, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (382, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (330, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (255, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (476, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (264, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (472, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (201, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (429, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (253, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (384, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (377, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (482, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (206, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (470, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (445, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (330, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (257, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (268, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (457, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (228, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (375, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (385, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (367, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (304, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (300, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (320, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (295, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (201, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (299, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (492, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (340, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (473, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (271, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (473, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (276, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (278, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (414, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (397, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (306, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (360, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (316, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (253, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (392, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (276, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (256, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (331, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (402, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (284, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (321, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (383, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (343, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (344, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (446, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (284, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (349, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (266, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (316, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (329, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (495, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (457, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (467, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (335, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (269, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (237, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (303, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (395, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (258, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (236, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (472, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (288, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (252, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (288, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (443, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (230, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (330, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (324, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (421, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (483, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (448, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (426, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (212, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (334, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (358, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (385, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (386, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (458, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (326, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (269, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (450, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (247, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (385, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (493, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (445, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (257, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (408, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (279, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (328, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (247, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (281, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (441, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (450, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (317, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (254, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (387, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (448, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (477, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (363, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (229, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (331, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (466, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (265, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (495, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (387, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (367, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (270, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (361, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (368, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (360, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (387, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (429, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (292, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (427, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (319, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (232, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (489, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (452, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (341, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (244, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (357, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (434, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (338, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (288, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (419, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (420, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (307, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (432, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (287, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (387, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (281, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (437, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (279, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (442, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (451, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (364, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (425, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (499, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (238, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (315, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (213, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (228, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (377, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (211, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (396, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (392, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (425, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (353, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (385, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (215, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (390, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (397, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (418, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (273, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (345, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (493, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (314, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (245, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (431, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (456, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (436, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (268, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (296, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (500, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (413, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (289, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (385, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (290, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (343, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (445, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (320, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (308, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (491, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (496, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (253, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (262, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (361, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (324, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (219, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (402, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (296, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (376, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (375, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (346, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (308, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (200, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (279, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (262, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (286, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (268, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (324, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (481, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (490, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (247, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (473, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (355, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (316, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (267, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (225, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (411, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (297, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (314, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (391, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (257, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (396, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (266, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (421, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (441, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (465, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (206, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (214, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (298, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (352, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (439, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (310, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (443, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (227, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (200, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (370, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (374, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (395, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (388, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (443, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (270, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (328, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (261, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (465, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (328, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (495, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (329, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (309, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (360, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (273, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (490, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (205, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (459, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (485, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (473, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (397, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (342, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (477, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (240, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (299, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (248, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (431, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (239, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (402, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (219, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (227, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (449, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (328, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (414, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (481, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (232, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (300, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (357, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (244, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (468, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (254, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (385, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (300, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (255, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (363, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (278, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (485, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (452, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (448, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (207, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (205, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (325, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (327, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (464, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (497, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (494, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (214, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (440, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (458, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (304, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (408, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (455, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (476, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (315, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (289, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (394, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (460, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (435, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (489, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (460, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (232, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (486, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (201, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (235, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (284, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (249, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (465, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (456, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (231, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (486, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (419, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (378, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (365, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (459, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (468, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (345, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (385, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (253, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (229, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (241, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (380, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (223, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (374, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (397, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (343, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (266, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (372, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (365, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (319, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (322, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (376, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (467, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (312, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (343, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (487, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (441, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (349, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (301, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (418, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (304, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (269, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (276, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (226, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (441, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (283, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (420, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (368, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (331, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (308, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (254, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (237, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (427, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (270, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (454, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (233, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (351, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (377, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (433, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (206, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (488, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (494, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (357, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (235, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (217, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (294, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (448, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (393, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (310, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (333, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (433, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (263, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (436, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (489, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (444, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (453, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (275, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (335, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (324, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (440, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (266, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (288, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (439, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (360, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (363, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (472, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (429, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (444, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (491, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (287, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (395, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (341, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (407, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (241, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (281, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (247, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (336, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (401, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (211, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (408, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (464, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (486, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (238, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (480, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (327, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (298, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (388, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (462, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (323, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (459, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (413, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (451, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (229, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (298, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (290, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (468, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (293, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (304, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (416, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (477, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (297, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (321, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (389, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (352, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (442, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (417, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (376, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (401, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (352, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (485, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (203, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (220, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (472, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (262, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (344, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (276, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (258, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (272, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (386, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (280, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (335, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (496, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (406, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (230, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (345, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (338, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (273, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (279, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (231, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (371, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (477, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (254, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (302, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (225, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (281, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (443, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (207, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (492, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (305, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (396, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (347, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (331, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (220, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (394, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (349, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (293, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (343, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (230, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (352, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (217, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (251, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (231, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (219, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (337, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (285, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (369, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (455, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (309, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (499, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (420, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (292, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (373, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (408, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (438, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (397, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (332, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (460, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (229, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (291, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (349, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (322, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (472, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (450, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (498, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (343, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (472, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (444, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (246, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (249, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (452, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (442, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (411, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (220, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (331, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (349, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (225, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (326, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (391, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (378, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (225, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (472, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (333, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (471, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (435, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (304, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (469, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (302, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (434, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (393, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (267, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (474, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (322, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (276, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (491, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (303, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (384, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (242, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (317, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (384, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (330, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (309, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (451, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (407, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (241, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (396, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (374, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (353, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (455, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (369, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (319, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (206, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (407, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (204, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (241, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (365, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (299, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (354, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (246, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (340, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (267, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (333, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (221, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (491, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (431, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (224, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (435, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (474, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (271, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (459, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (479, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (350, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (294, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (425, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (479, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (345, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (300, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (467, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (481, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (385, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (460, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (215, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (467, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (294, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (464, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (206, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (441, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (208, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (391, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (444, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (479, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (325, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (490, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (403, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (483, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (385, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (268, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (294, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (360, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (386, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (267, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (260, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (352, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (411, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (384, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (478, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (329, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (219, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (243, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (301, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (416, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (480, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (482, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (420, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (236, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (285, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (386, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (287, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (448, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (268, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (285, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (337, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (457, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (226, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (417, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (428, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (352, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (355, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (344, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (422, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (391, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (229, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (245, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (426, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (450, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (418, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (329, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (420, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (471, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (237, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (297, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (335, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (356, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (424, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (448, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (248, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (485, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (335, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (478, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (428, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (408, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (358, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (457, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (245, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (445, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (397, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (349, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (234, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (368, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (242, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (424, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (474, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (452, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (255, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (207, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (414, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (301, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (446, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (369, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (261, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (456, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (379, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (266, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (257, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (276, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (244, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (309, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (382, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (396, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (368, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (366, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (309, 2, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (452, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (357, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (264, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (341, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (314, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (274, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (407, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (341, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (251, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (240, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (273, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (463, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (208, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (382, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (373, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (387, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (369, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (297, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (370, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (206, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (440, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (438, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (236, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (457, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (220, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (330, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (326, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (254, 2, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (469, 1, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (295, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (331, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (258, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (265, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (358, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (346, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (254, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (365, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (398, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (255, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (281, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (484, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (289, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (217, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (306, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (423, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (327, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (332, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (353, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (432, 1, 3, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (336, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (470, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (286, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (242, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (318, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (459, 2, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (424, 2, 3, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (392, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (438, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (469, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (334, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (266, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (315, 1, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (294, 1, 2, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (206, 1, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (368, 1, 2, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (238, 2, 1, 1, 2, 3, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (295, 2, 1, 1, 2, 4, 1);
insert into INSERCION (ingreso_peso, conductor_id, desecho_id, trabajador_id, contratista_id, vehiculo_id, centro_disposicion_id) values (398, 2, 2, 1, 2, 4, 1);
/
COMMIT;