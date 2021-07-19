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

/
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


/

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
/
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