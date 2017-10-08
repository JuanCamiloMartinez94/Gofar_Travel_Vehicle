CREATE TABLESPACE gofar_travel DATAFILE 'C:\oraclexe\app\oracle\oradata\XE\gofar_travel1.dbf' size 333M,
'C:\oraclexe\app\oracle\oradata\XE\gofar_travel2.dbf' size 333M,
'C:\oraclexe\app\oracle\oradata\XE\gofar_travel3.dbf' size 334M;

CREATE TABLESPACE test_purposes DATAFILE 'C:\oraclexe\app\oracle\oradata\XE\test_purposes.dbf' size 500M;

CREATE UNDO TABLESPACE UNDOTBS2 DATAFILE 'C:\oraclexe\app\oracle\oradata\XE\undo_tablespace.dbf' size 5M;

ALTER SYSTEM SET UNDO_TABLESPACE = UNDOTBS2;

CREATE USER dba_user
IDENTIFIED BY dba_user
DEFAULT TABLESPACE gofar_travel
QUOTA UNLIMITED ON gofar_travel; 

GRANT DBA TO dba_user;

CREATE PROFILE manager LIMIT
PASSWORD_LIFE_TIME 40
SESSIONS_PER_USER 1
IDLE_TIME 15
FAILED_LOGIN_ATTEMPTS 4;

CREATE PROFILE finance LIMIT
PASSWORD_LIFE_TIME 15
SESSIONS_PER_USER 1
IDLE_TIME 3
FAILED_LOGIN_ATTEMPTS 2;

CREATE PROFILE development LIMIT
PASSWORD_LIFE_TIME 100
SESSIONS_PER_USER 2
IDLE_TIME 30
FAILED_LOGIN_ATTEMPTS 1;

CREATE USER user_manager
IDENTIFIED BY user_manager
DEFAULT TABLESPACE gofar_travel
PROFILE manager;
GRANT CONNECT TO user_manager;

CREATE USER user_finance
IDENTIFIED BY user_finance
DEFAULT TABLESPACE gofar_travel
PROFILE finance;
GRANT CONNECT TO user_finance;

CREATE USER user_development
IDENTIFIED BY user_development
DEFAULT TABLESPACE gofar_travel
PROFILE development;
GRANT CONNECT TO user_development;

CREATE USER user_manager2
IDENTIFIED BY user_manager2
DEFAULT TABLESPACE gofar_travel
PROFILE manager;
GRANT CONNECT TO user_manager2;

ALTER USER user_manager2 ACCOUNT LOCK;
ALTER USER user_manager ACCOUNT LOCK;
ALTER USER user_finance ACCOUNT LOCK;

DROP TABLESPACE test_purposes INCLUDING CONTENTS AND DATAFILES;