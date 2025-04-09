-generar una secuencia con departamentos
---------------secuencia para departamentos
--crear un objeto
select * from dept;
create sequence SEQ_DEPT
increment by 10  
start with 40;
-- una secuencia no se puede modificar , solo eliminar y crear de nuevo
--todavia no hemos utilizado  la secuencia
select seq_dept.nextval as SIGUIENTE  from dual;
--no podemos acceder a currval hasta que no hemos ejecutado NEXTVAL
select seq_dept.CURRVAL as ACTUAL  from dual;
-- AÑADIR EL REGISTRO CON EL OBJETO DE SECUENCIA CREADO
INSERT INTO DEPT values (seq_dept.nextval, 'NUEVO', 'NUIEVO'); 
UNA SECUENCIA NO ESTA ASOCIADA A UNA TABLA
SELECT * FROM DEPT
ORDER BY DEPT_NO;
--DELETE FROM DEPT WHERE DEPT_NO = 50; 
--ELIMINAR UNA SECUENCIA
DROP SEQUENCE SEQ_DEPT;
--SE PUEDE EJECUTAR EL OBJETO CON OTRA TABLA
INSERT INTO HOSPITAL VALUES (SEQ_DEPT.NEXTVAL, 'EL CARMEN', 'CALLE PEX', '12345', 125);
SELECT * FROM HOSPITAL;
--NECESITO LAS SIGUIENTE CARACTERISTICAS DENTRO DE NUESTRA BASE DE DATOS
--UNA CLAVE PRIMARIA EN HOSPITAL   PK_EN_HOSPITAL
--UNA CLAVE PRIMARIA EN DOCTOR     PK_EN_DOCTOR
--NECESITO RELACIONAR DOCTORES CON HOSPITALES
--LAS PERSONAS DE LA  TABLA PLANTILLA SOLAMENTE PUEDEN TRABAJAR EN
--TURNOS DE MAÑANA, TARDE O NOCHE (T,N,M)  
--
--UNA CLAVE PRIMARIA EN HOSPITAL   PK_EN_HOSPITAL
ALTER TABLE HOSPITAL
ADD CONSTRAINT PK_HOSPITAL
PRIMARY KEY (HOSPITAL_COD);
--
--UNA CLAVE PRIMARIA EN DOCTOR     PK_EN_DOCTOR
SELECT * FROM DOCTOR;
--
ALTER TABLE DOCTOR
ADD CONSTRAINT PK_DOCTOR
PRIMARY KEY (DOCTOR_NO);
--
--NECESITO RELACIONAR DOCTORES CON HOSPITALES
SELECT * FROM HOSPITAL;
--
alter table DOCTOR
add constraint FK_DOCTOR_HOSPITAL
foreign key (HOSPITAL_COD)
references HOSPITAL(HOSPITAL_COD);
--TURNOS DE MAÑANA, TARDE O NOCHE (T,N,M)  
SELECT * FROM PLANTILLA;
ALTER TABLE PLANTILLA
ADD CONSTRAINT CH_PLANTILLA_TURNO
CHECK (TURNO IN('T','N','M'));
--
--
-UNA CLAVE PRIMARIA EN PROFESORES   PK_EN_HOSPITAL
ALTER TABLE HOSPITAL
ADD CONSTRAINT PK_HOSPITAL
PRIMARY KEY (HOSPITAL_COD);
--
--EJERCICIOS---
--
--TABLA COLEGIOS
--
CREATE TABLE COLEGIOS (
COD_COLEGIO NUMBER (9),
NOMBRE      VARCHAR2 (20) NOT NULLS,
LOCALIDAD   VARCHAR2 (15),
PROVINCIA   VARCHAR2 (15),
ANO_CONSTRUCCION  DATE,
COSTE_CONSTRUCCFION INTERGER,
CODE_REGION INTERGER,
UNICO INTERGER,   
PRIMARY KEY (COD_COLEGIO)
);
--
ALTER TABLE COLEGIOS
ADD CONSTRAINT CLAVE_UNICA_COLEGIO
UNIQUE (UNICO);
--
select * from COLEGIOS;
create sequence SEQ_COLEGIOS
increment by 10  
start with 0;
--
--TABLA PROFESORES
--
CREATE TABLE PROFESORES (
COD_PROFESOR VARCHAR2 (9) NOT NULLS,
NOMBRE      VARCHAR2 (20),
APELLIDO1   VARCHAR2 (15),
APELLIDO2   VARCHAR2 (15),
EDAD        NUMBER (3),
DNI         VARCHAR2 (09),
LOCALIDAD   VARCHAR2 (50), 
PROVINCIA   VARCHAR2 (50),   
SALARIO     INTERGER,
COD_COLEGIO NUMBER (9), 
PRIMARY KEY (COD_PROFESOR)
);
--
ALTER TABLE PROFESORES
ADD CONSTRAINT CLAVE_UNICA_PROF 
UNIQUE (DNI);
--
alter table PROFESORES
add constraint FK_PROFESORES_COLEGIOS
foreign key (COD_COLEGIO)
references COLEGIOS(COD_COLEGIO);
--
--TABLA REGIONES
--
CREATE TABLE REGIONES (
COD_REGION VARCHAR2 (9) NOT NULLS,
REGIONES   VARCHAR2 (20) NOT NULLS,
PRIMARY KEY (COD_REGION)
);
--
--
--TABLA ALUMNOS
--
CREATE TABLE ALUMNOS (
DNI VARCHAR2 (9) NOT NULLS,
NOMBRE VARCHAR2 (20) NOT NULLS,
APELLIDOS VARCHAR2 (50) 
FECHA_INGRESO DATE,
FECHA_NAC DATE,
LOCALIDAD VARCHAR2 (15),
PROVINCIA VARCHAR2 (30),
COD_COLEGIO NUMBER(9),
PRIMARY KEY (DNI)
);
--
alter table COLEGIOS
add constraint FK_COLEGIO_ALUMNOS
foreign key (COD_COLEGIO)
references ALUMNOS(COD_COLEGIO);
--
--
alter table REGION
add constraint FK_REGION_COLEGIO
foreign key (COD_REGION)
references ALUMNOS(COD_REGION);
--
--
ALTER TABLE PROFESORES
ADD (SEXO VARCHAR2(1), FECHA_NACIMIENTO DATE, ESTADO_CIVIL VARCHAR2 (15) NOT NULL);
--
--
ALTER TABLE PROFESORES
DROP COLUMN EDAD;
--
--
ALTER TABLE ALUMNOS
ADD (SEXO VARCHAR2(1), DIRECCION VARCHAR2(50), ESTADO_CIVIL VARCHAR2 (15) NOT NULL);
--
--
ALTER TABLE PROFESORES
DROP CONSTRAINT FK_PROFESORES_COLEGIOS;
--
--
ALTER TABLE ALUMNOS
MODIFY (FECHA_INGRESO SYSDATE);
--
--
INSERT INTO COLEGIO VALUES (1,'ABCDEFGHIJ','AEIOU');
INSERT INTO COLEGIO VALUES (1,'A','A');
INSERT INTO COLEGIO VALUES (1,'A','ABCDE');
--
--
-- 07/04/2025   CLASE
/* Prefijos
--
--USER_ : Los objetos del esquema (= usuario)
--ALL_  : Los objetosw del esquema/usuario y de otros esquemas en los que el usuario tiene algun privilegio
--DBA_  : Todos los objetos de la instancia (solo visible para los DBAs) 
--
*/
--  Multitenant  contenedores muy parecido
CDB_    : Todos los objetos de todos los contenedores si la sesion esta en el contenedor: CDB$ROOT
          Todos los objetos del contenedor en el que se encuentra la sesion, si es una PDB (Pluggable Database)    
DBA_    : Todos losobjetos del contenedor en el que se encuentran la sesion
--
--      show con_id   Validar si existen contenedores
--contenedor 1 > cdb$root 
--contenedor 2 > pdb$seed
--contenedor 3+ > PDBs
--
--show pdbs;
--show con_id
--
select * from dictionary;
select * from user_tab_columns where table_name = 'EMP' order by column_id;
--
--
-- TABLAS PRINCIPALES PARA CONSULTA/DESARROLLO
-- *_objects      - Toodos los objetos
-- *_tables       - Las tablas
-- *_tab_columns  - Columnas de las tablas
-- *_constraints  - Restricciones
-- *_cons_columns - Columnas de las restricciones
-- *_views        - Vistas
-- *_indexes      - Índices
-- *_ind_columns  - Columnas de los índices
-- *_synonyms     - Sinónimos
-- *_sequences    - Secuencias
-- *_tab_comments - Comentarios de las tablas
-- *_col_comments - Comentarios de las columnas de las tablas
--
--evaluar esquema
select * from user_objects;
select * from user_tables;
select * from user_constraints;
select * from user_constraints where table_name = 'EMP'; 
select * from user_tab_columns where table_name = 'EMP';
select * from user_views;
select * from v$session;
select * from v$instance;
select * from v$database;
select * from v$sql; 
--
--
SELECT column_name, data_type, data_length, 
data_precision PRECISION, data_scale SCALE, nullable 
FROM   user_tab_columns 
WHERE  table_name = UPPER('&tabLA_name');
--
COMMENT ON TABLE EMP IS  
'Company department information including name, code, and 
location.'; 
SELECT COMMENTS  
FROM   user_tab_comments 
WHERE  table_name = 'EMP'; 

SELECT ucc.column_name, uc.constraint_name, uc.constraint_type,    
uc.search_condition, uc.status 
FROM   user_constraints uc JOIN user_cons_columns ucc 
ON     uc.table_name = ucc.table_name 
AND    uc.constraint_name = ucc.constraint_name 
AND    uc.table_name = UPPER('&TABLAS_NAMES');  
--
create public synonym td for d; 
select *  from all _synonyms
where synonyms_names = 'TD';

--INDICES--
select * from user_indexes;


/*
--TABLESPACE  <-----  UNA TABLA TIENE LOS DATOS ACA
--DATAFILES   <-----  NOMBRE DEL DISCO
--SEGMENTS    <----- EL NOMBRE DE UN ESPACIO QUE OCUPA UN OBJETO
--EXTENTS     <----- UN CONJUNTO DE BLOQUES CONTIGUOS EN UN DATA FILE
--BLOCK       <----- MINIMA UNIDAD DE ALNACENAMIENTO
*/
--
--FUNCIONES PROPIAS DE ORACLE
--VISUAL STUDIO CODE CON GITHUB
--COMENZAR CON PL/SLQ (CODIGO)
--LOWER    Mayusculas convertir todo
--UPPER    Minusculas convertir todo
--INITCAP  Primera letra en mayuscula convertir
--
select * from EMP
where LOWER(oficio) = 'analista'; 
UPDATE EMP SET OFICIO = 'analiSTA' where  EMP_NO = 7902; 
--
--valores dinamicos por lo que tendremos convertir ambas comparaciones
--
select * from EMP
where UPPER(oficio) =  UPPER ('&dato'); 
--
--en oracle tenemos la posibilidad de concatenar textos en una
--sola columna (CAMPO CALCULADO)
--Concatenar
select APELLIDO || ' ' || OFICIO as DESCRIPCION from EMP; 
--
--CONCAT  Concatenar
select concat('Nuestro Empleado ES....', APELLIDO) as RESULTADO from EMP;
--
--SUBSTR (Cad, m(,n))
--
select substr('FLORERO',1,4) as dato from DUAL;
--
--NO PASA NADA SI TE PASAS DE LARGO
select substr('FLORERO',5 ,40) as dato from DUAL; 
--
select LENGTH('LIBRO') as LONGITUD from DUAL;
select * FROM emp where LENGTH(APELLIDO) = 4;
--
SELECT INSTR ('BENITO', 'NIP') as POSICION from DUAL;  
select * from DUAL where INSTR('mail', '@' ) > 0;
--
--relleno
--
--POR LA DERECHA R PAD
select RPAD(DEPT_NO, 5, '$') from EMP; 
--
--FUNCIONES MATEMATICAS
--REDONDEO 
select ROUND(45.923) as REDONDEO from DUAL;
select ROUND(45.423) as REDONDEO from DUAL;
--
--CON DECIMALES
select ROUND(45.923, 2) as REDONDEO from DUAL;
select ROUND(45.929, 2) as REDONDEO from DUAL;
select TRUNC (ROUND(156.00, -1),-1) from dual;
--

--TRUNC
--
select TRUNC(45.923) as TRUNCAR from DUAL;
select TRUNC(45.423) as TRUNCAR from DUAL;
--CON DECIMALES
select TRUNC(45.923, 2) as TRUNCAR from DUAL;
select TRUNC(45.929, 2) as TRUNCAR from DUAL;
--
--DEVUELVE EL RESTO DE LA DIVISION ENTRE DOS NUMEROS   (MOD)
-- AVERIGUAL SI EL NUMERO ES PAR
select mod(9, 2) as RESTO from DUAL;
Select mod(8, 2) as RESTO from DUAL;
--
--MOSTRAR LOS EMPLEADOS CUYOS SALRIOS SEA PAR
SELECT * FROM EMP;
SELECT EMP_NO , MOD(SALARIO, 2) FROM EMP
WHERE MOD(SALARIO, 2) = 0;
SELECT EMP_NO , MOD(EMP_NO, 2) FROM EMP
WHERE MOD(EMP_NO, 2) = 0;
SELECT EMP_NO , MOD(EMP_NO, 2) FROM EMP
WHERE MOD(EMP_NO, 2) = 1;
--
--FECHAS
--SUMA DE DIAS
select SYSDATE AS FECHA_ ACTUAL FROM DUAL;
select SYSDATE + 10 AS FECHA FROM DUAL;
select SYSDATE + 30 AS FECHA FROM DUAL;
select SYSDATE - 10 AS FECHA FROM DUAL;
--
MESES ENTRE FECHA 1 Y FECHA 2
--
--MOSTRAR CUANTO MESES LLEVAN LOS EMPLEADOS DADOS DE ALTA EN LA EMPRESA
SELECT APELLIDO, MONTHS_BETWEEN(SYSDATE, FECHA_ALT) AS MESE FROM EMP;
--
SELECT ADD_MONTHS(SYSDATE, 5) AS ADICIONOMESES FROM DUAL;
--
--
--MOSTRAR CUANDO ES EL PROXIMO LUNES
SELECT NEXT_DAY(SYSDATE, 'MONDAY') AS PROXIMOLUNES FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 'SUNDAY') AS PROXIMODOMINGO FROM DUAL;
--
--ULTIMO DIA DEL MES
SELECT LAST_DAY(SYSDATE) AS FINDEMES FROM DUAL;
--
--REDONDEO DE FECHA
select apellido, fecha_alt, round(fecha_alt, 'MM') roundmes from emp;
select apellido, fecha_alt, round(fecha_alt, 'YY') roundmes from emp;
--
--
--TRUNC  FECHA
select apellido, fecha_alt, TRUNC(fecha_alt, 'MM') TRUNCMES from emp;
select apellido, fecha_alt, TRUNC(fecha_alt, 'YY') TRUNCYEAR from emp;
--
-- TO CHAR  
--CONVERSION DE FORMATO
--
SELECT  APELLIDO, FECHA_ALT, TO_CHAR(FECHA_ALT, 'MM-DD-YYYY') AS FORMATO FROM EMP;
SELECT  TO_CHAR(SYSDATE, 'MONTH') AS NOMBREMES FROM DUAL;
SELECT  TO_CHAR(SYSDATE, 'DAY MONTH') AS NOMBREDIAMES FROM DUAL;
--
--FORMATO DE NUMEROS
--
SELECT TO_CHAR(7458, '0000$') AS ZERO FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS HORA_SISTEMA FROM DUAL;
--
--SI DESEAMOS INCLUIR TEXTO ENTRE TO_CHAR Y LOS FORMATOS SE REALIZA CONCOMILLAS DOBLE
--DENTRO DE LAS SIMPLES
SELECT TO_CHAR(SYSDATE, '"LA FECHA DE HOY ES" DD "DEL MES DE" MONTH') AS FROMATO FROM DUAL; 
SELECT TO_CHAR(SYSDATE, '"LA FECHA DE HOY ES" DD "DEL MES DE" MONTH', 'NLS_DATE_LANGUAGE = KATAKANO') AS FROMATO FROM DUAL; 
--
--FUNCIONES DE CONVERSION
SELECT '08/04/2025' + 2 AS RESULTADO FROM DUAL;
SELECT '12'+2 AS RESULTADO FROM DUAL;
SELECT 12+2 AS RESULTADO FROM DUAL;
SELECT TO_NUMBER('12')+2 AS RESULTADO FROM DUAL;
--
--NVL SIRVE PARA EVITAR LOS NULOS Y SUSTITUIR
--SI ENCUENTRA UN NULO, LO SUSTITUYE, SI NO, MUESTRA VALOR
--MOSTRAR APELLIDO, SALARIO Y COMISION DE TODOS LOS EMPLEADOS
SELECT APELLIDO, SALARIO, COMISION FROM EMP;
--PODEMOS INDICAR QUE EN LUGAR DE PONER NULL, ESCRIBA OTRO VALOR
--
SELECT APELLIDO, SALARIO, NVL(COMISION, -1) AS COMISION FROM EMP;
SELECT APELLIDO, SALARIO + NVL(COMISION, 0) AS TOTAL FROM EMP;
--
--
DECODE
--
--MOSTRAR EL TURNO EN PALABRA ('MAÑANA', 'TARDE', 'NOCHE') DE LA PLANTILLA
select apellido, decode(turno, 'M', 'MAÑANA',
                               'N', 'NOCHE',
                               'T', 'TARDE' ) as turno 
                               from plantilla;
--
--
--QUIERO SABER LA FECHA DEL PROXIMO MIERCOLES QUE JUEGA EL MADRID
--QUIERO VER EL MIERCOLES 09 DE ABRIL
SELECT NEXT_DAY(SYSDATE, 'WEDNESDAYS') + 2  AS CHAMPIONS FROM DUAL;
--
SELECT TO_CHAR(
    NEXT_DAY((SYSDATE + 2), 'WEDNESDAYS') ,
    '"EL DIA " DAY DD "JUEGA EL MADRID" ')  AS CHAMPIONS FROM DUAL;
--    
-prueba  --  
--
SELECT TO_CHAR(
    NEXT_DAY((SYSDATE + 86), 'MONDAY') ,
    '"MI CUMPLE ANOS " MONTH MM "ES HOY" DAY DD ')  AS CUMPLEANOS FROM DUAL;
--
--
--CONSULTA DE FUNCIONES
select * from EMP;
select * from DEPT;

SELECT D.DNOMBRE, E.APELLIDO, decode(D.LOC, 'BARCELONA', 'A TABARNIA',
                                     'NO CAMBIA DE LOCALIDAD' ) as TRASLADO 
FROM EMP E
INNER JOIN DEPT D
ON E.DEPT_NO = D.DEPT_NO;
--
select RPAD(DEPT_NO, 16, '.') AS DEPT_NUM,
       RPAD(DNOMBRE, 55, '.'), 
       RPAD(LOC, 55, '.' ) FROM DEPT; 
--
DESCRIBE DEPT;
