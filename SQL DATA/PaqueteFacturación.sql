--------------------------------------------------------
-- Archivo creado  - domingo-julio-11-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package FACTURACION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "DEMO_TEAMB"."FACTURACION" AS

    PROCEDURE facturacion_masiva;

    PROCEDURE generar_facturas_centro (
        centro          IN  NUMBER,
        inicio_periodo  IN  DATE,
        fin_periodo     IN  DATE
    );


END facturacion;


/
