--------------------------------------------------------------------------------
-- NOTA IMPORTANTE: LOS SIGUIENTES FRAGMENTOS DE CODIGO CORRESPONDES A LA 
--                  SOLUCIÓN ESPECÍFICA DE CADA PUNTO PARA FACILITAR SU 
--                  CALIFICACION Y SON EXTRAIDOS DIRECTAMENTE DEL ARCHIVO 
--                  EXPORTADO. POR ENDE NO PROVEEN LA INFORMACION TOTAL 
--                  REQUERIDA PARA LA COMPROBACION DE SU FUNCIONAMIENTO
--                  SE RECOMIENDA, AL QUERER HACER TESTEADO DE LA SOLUCION, 
--                  EJECUTAR EL SCRIPT DE EXPORTACION COMPLETO, ADJUNTO EN 
--                  LA MISMA CARPETA.
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--  Primer Punto: Manejo de historial y validacion de tipo
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--  DDL for Table DATOS_HISTORICOS_VEHICULOS
--------------------------------------------------------------------------------

  CREATE TABLE "USER_TALLER2"."DATOS_HISTORICOS_VEHICULOS" 
   (	"ID" NUMBER(*,0), 
	"VEHICULO_ID" NUMBER(*,0), 
	"FACTURA_ID" NUMBER(*,0), 
	"FECHA" VARCHAR2(255 BYTE), 
	"TIPO" VARCHAR2(255 BYTE)
   ) ;

--------------------------------------------------------
--  Constraints for Table DATOS_HISTORICOS_VEHICULOS
--------------------------------------------------------

  ALTER TABLE "USER_TALLER2"."DATOS_HISTORICOS_VEHICULOS" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "USER_TALLER2"."DATOS_HISTORICOS_VEHICULOS" MODIFY ("VEHICULO_ID" NOT NULL ENABLE);
  ALTER TABLE "USER_TALLER2"."DATOS_HISTORICOS_VEHICULOS" MODIFY ("TIPO" NOT NULL ENABLE);
  ALTER TABLE "USER_TALLER2"."DATOS_HISTORICOS_VEHICULOS" ADD CONSTRAINT "CHECK_TIPO" 
        CHECK (tipo IN('nuevo','vendido','intercambio')) ENABLE;
  ALTER TABLE "USER_TALLER2"."DATOS_HISTORICOS_VEHICULOS" ADD PRIMARY KEY ("ID") ENABLE;
 
 
--------------------------------------------------------------------------------  
-------------------------------------------------------------------------------- 
--  Segundo Punto: Campo 'UNIDADES_DISPONBLES' agregado a tabla atributos y 
--                 definido con valor con defecto de 30.         
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--  DDL for Table ATRIBUTOS
--------------------------------------------------------------------------------

  CREATE TABLE "USER_TALLER2"."ATRIBUTOS" 
   (	"ID" NUMBER(*,0), 
	"CODIGO" VARCHAR2(255 BYTE), 
	"COSTO" NUMBER, 
	"DESCRIPCION" VARCHAR2(255 BYTE), 
	"NOMBRE_FABRICANTE" VARCHAR2(255 BYTE), 
	"PRECIO_UNIDAD" NUMBER, 
	"UNIDADES_DISPONIBLES" NUMBER(*,0) DEFAULT 30
   ) ;
   
  
--------------------------------------------------------------------------------  
-------------------------------------------------------------------------------- 
--  Tercer Punto: Vista que muestra los productos/atributos que para el momento 
--                tiene menos de 5 unidades disponibles.          
--------------------------------------------------------------------------------  
--------------------------------------------------------------------------------
--  DDL for View PRODUCTO_MENOR_VIEW
--------------------------------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "USER_TALLER2"."PRODUCTO_MENOR_VIEW" ("ID", "DESCRIPCION", "CODIGO", "NOMBRE_FABRICANTE") AS 
  SELECT ID,DESCRIPCION,CODIGO,NOMBRE_FABRICANTE FROM ATRIBUTOS WHERE UNIDADES_DISPONIBLES <5;
  

--------------------------------------------------------------------------------  
-------------------------------------------------------------------------------- 
--  Cuarto Punto: Trigger que disminuye las unidades disponibles de un atributo 
--                al asociarse a una factura.          
--------------------------------------------------------------------------------  
--------------------------------------------------------------------------------
--  DDL for Trigger DISMINUIR_UNIDADES
--------------------------------------------------------------------------------

  CREATE OR REPLACE TRIGGER "USER_TALLER2"."DISMINUIR_UNIDADES" AFTER INSERT ON USER_TALLER2.atributos_facturas
  FOR EACH ROW
BEGIN
  UPDATE ATRIBUTOS SET UNIDADES_DISPONIBLES =  UNIDADES_DISPONIBLES-1 WHERE ATRIBUTOS.ID = :NEW.ATRIBUTO_ID;
END;
/
ALTER TRIGGER "USER_TALLER2"."DISMINUIR_UNIDADES" ENABLE;


--------------------------------------------------------------------------------  
-------------------------------------------------------------------------------- 
--  Quinto Punto: Procedimiento que, a partir de los atributos obtenidos en la 
--                vista del tercer punto, aumenta su existencia en 20 unidades          
--------------------------------------------------------------------------------  
--------------------------------------------------------------------------------
--  DDL for Procedure REORDER_UNITS
--------------------------------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "USER_TALLER2"."REORDER_UNITS" IS
BEGIN
 UPDATE ATRIBUTOS SET UNIDADES_DISPONIBLES = UNIDADES_DISPONIBLES +20 WHERE ID IN (SELECT ID FROM PRODUCTO_MENOR_VIEW); 
END;

/


--------------------------------------------------------------------------------  
-------------------------------------------------------------------------------- 
--  Sexto Punto: Vista que muestra la informacion detallada de las facturas          
--------------------------------------------------------------------------------
--------------------------------------------------------
--  DDL for View INFORMACION_FACTURAS_VIEW
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "USER_TALLER2"."INFORMACION_FACTURAS_VIEW" ("BILL_ID", "SALES_PERSON_ID", "NAME_OF_SALESPERSON", "CLIENT_ID", "NAME_OF_CLIENT", "VEHICLE_ID", "BRAND_OF_VEHICLE", "MANUFACTURER_OF_VEHICLE", "ACCESORY_ID", "NAME_OF_ACCESORY") AS 
  SELECT FACTURAS.ID AS bill_id,VENDEDORES.ID AS sales_person_id,VENDEDORES.NOMBRE AS name_of_salesperson,
       CLIENTES.ID AS client_id,CLIENTES.NOMBRE AS name_of_client, VEHICULOS.ID AS vehicle_id, 
       VEHICULOS.NOMBRE AS brand_of_vehicle, VEHICULOS.NOMBRE_FABRICANTE AS manufacturer_of_vehicle,
       ATRIBUTOS.ID AS accesory_id, ATRIBUTOS.DESCRIPCION AS name_of_accesory FROM FACTURAS
INNER JOIN VENDEDORES ON FACTURAS.VENDEDOR_ID = VENDEDORES.ID
INNER JOIN CLIENTES ON FACTURAS.CLIENTE_ID = CLIENTES.ID
INNER JOIN VEHICULOS ON FACTURAS.VEHICULO_ID = VEHICULOS.ID
INNER JOIN ATRIBUTOS_FACTURAS ON FACTURAS.ID = ATRIBUTOS_FACTURAS.FACTURA_ID
INNER JOIN ATRIBUTOS ON ATRIBUTOS_FACTURAS.ATRIBUTO_ID = ATRIBUTOS.ID
;


--------------------------------------------------------------------------------  
-------------------------------------------------------------------------------- 
--  Septimo Punto: Explain Plan para la vista creada en el sexto punto          
--------------------------------------------------------------------------------

EXPLAIN PLAN SET STATEMENT_ID = 'bad1' FOR 
        SELECT * FROM "USER_TALLER2"."INFORMACION_FACTURAS_VIEW" 
        WHERE BILL_ID = 6021;


---------------------------------------------------------------------------------------------------------        
-- Plan hash value: 1483839320                                                                           | 
--------------------------------------------------------------------------------------------------------
--| Id  | Operation                         | Name               | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------------------
--|   0 | SELECT STATEMENT                  |                    |     1 |   101 |     8   (0)| 00:00:01 |
--|   1 |  NESTED LOOPS                     |                    |       |       |            |          |
--|   2 |   NESTED LOOPS                    |                    |     1 |   101 |     8   (0)| 00:00:01 |
--|   3 |    NESTED LOOPS                   |                    |     1 |    87 |     7   (0)| 00:00:01 |
--|   4 |     NESTED LOOPS                  |                    |     1 |    79 |     4   (0)| 00:00:01 |
--|   5 |      NESTED LOOPS                 |                    |     1 |    63 |     3   (0)| 00:00:01 |
--|   6 |       NESTED LOOPS                |                    |     1 |    44 |     2   (0)| 00:00:01 |
--|   7 |        TABLE ACCESS BY INDEX ROWID| FACTURAS           |     1 |    15 |     1   (0)| 00:00:01 |
--|*  8 |         INDEX UNIQUE SCAN         | SYS_C007080        |     1 |       |     0   (0)| 00:00:01 |
--|   9 |        TABLE ACCESS BY INDEX ROWID| VEHICULOS          |    51 |  1479 |     1   (0)| 00:00:01 |
--|* 10 |         INDEX UNIQUE SCAN         | SYS_C007072        |     1 |       |     0   (0)| 00:00:01 |
--|  11 |       TABLE ACCESS BY INDEX ROWID | CLIENTES           |    20 |   380 |     1   (0)| 00:00:01 |
--|* 12 |        INDEX UNIQUE SCAN          | SYS_C007059        |     1 |       |     0   (0)| 00:00:01 |
--|  13 |      TABLE ACCESS BY INDEX ROWID  | VENDEDORES         |    10 |   160 |     1   (0)| 00:00:01 |
--|* 14 |       INDEX UNIQUE SCAN           | SYS_C007053        |     1 |       |     0   (0)| 00:00:01 |
--|* 15 |     TABLE ACCESS FULL             | ATRIBUTOS_FACTURAS |     1 |     8 |     3   (0)| 00:00:01 |
--|* 16 |    INDEX UNIQUE SCAN              | SYS_C007066        |     1 |       |     0   (0)| 00:00:01 |
--|  17 |   TABLE ACCESS BY INDEX ROWID     | ATRIBUTOS          |     1 |    14 |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------------------
 
--Predicate Information (identified by operation id):
---------------------------------------------------
 
--   8 - access("FACTURAS"."ID"=6021)
--  10 - access("FACTURAS"."VEHICULO_ID"="VEHICULOS"."ID")
--  12 - access("FACTURAS"."CLIENTE_ID"="CLIENTES"."ID")
--  14 - access("FACTURAS"."VENDEDOR_ID"="VENDEDORES"."ID")
--  15 - filter("ATRIBUTOS_FACTURAS"."FACTURA_ID"=6021)
--  16 - access("ATRIBUTOS_FACTURAS"."ATRIBUTO_ID"="ATRIBUTOS"."ID")