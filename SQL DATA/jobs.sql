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
