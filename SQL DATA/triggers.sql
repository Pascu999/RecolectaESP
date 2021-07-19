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
