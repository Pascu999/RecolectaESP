--------------------------------------------------------
-- Archivo creado  - domingo-julio-11-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body FACTURACION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "DEMO_TEAMB"."FACTURACION" AS



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
