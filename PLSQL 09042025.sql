---
declare 
       v_id int;
begin 
      v_id := &numero;
      select * from DEPT where DEPT_NO = v_id;
end; 
--
--
declare
   v_texto varchar2(50);
   v_longitud int;
   v_letra varchar2(1);
   final varchar2(50);

begin
v_texto := '&valori'; 
Final := length(v_texto);
     for i in 1..final  loop
     v_letra := substr(final, i, 1);
     dbms_output.put_line(v_letra);
end loop;
       dbms_output.put_line('fin del programa');
end;
----
declare
   v_texto varchar2(50);
   v_longitud int;
   v_letra varchar2(1);
   final varchar2(50);

begin
v_texto := '&valori'; 
Final := length(v_texto);
v_numero := to_number(v_letra);
 /*  <-------   convertir de string a number  */
     for i in 1..final  loop
     v_letra := substr(final, i, 1);
     dbms_output.put_line(v_letra);
end loop;
       dbms_output.put_line('fin del programa');
end;
----
---- DIA 22/04/2025
--
--
--  cursores
--sobre tabla departamentos
declare
      v_nombre dept.dnombre%type;
      v_loc dept.loc%type;
begin  
     For i in 1..5 loop
         v_nombre := 'Departamento ' || i;
         v_loc    := 'Localidad ' || i;
         insert into DEPT values (i, v_nombre, v_loc);
     end loop;
     dbms_output.put_line('fin del programa');
end;
--
--
select * from DEPT
ORDER BY DEPT_NO;
--
--
declare
      v_nombre dept.dnombre%type;
      v_loc dept.loc%type;
begin  
     For i in 1..5 loop
         v_nombre := 'Departamento ' || i;
         v_loc    := 'Localidad ' || i;
         insert into DEPT values ((select max(DEPT_NO) + 1 from DEPT), v_nombre, v_loc);
     end loop;
     dbms_output.put_line('fin del programa');
end;
--
--
rollback; 
--
--
declare 
       v_id int;
begin 
      v_id := &numero;
      select * from DEPT where DEPT_NO = v_id;
end; 
---------------------------------------------------------
declare
--declaramos una variable
  numero int;
  texto varchar2(50);
begin
  texto := 'mi primer PL/SQL';
  dbms_output.put_line('mensaje = ' || texto); 
  dbms_output.put_line('mi primer bloque anonimo' || numero);
  numero := 44;
  dbms_output.put_line('valor numero: ' || numero);
  numero := numero - 10;
  dbms_output.put_line('valor numero: ' || numero);
end;
--
--
  declare
       nombre varchar2(30);
  begin
       nombre := '&alumno';
       dbms_output.put_line('Su Nombre es:' || nombre);
  end;
  --
  --
  declare
    fecha date;
    texto varchar2(50);
    longitud int;
  begin
     fecha := sysdate;
     texto := '&data';
     --quiero almacenar la longitud del texto
     longitud := length(texto);
     dbms_output.put_line('La longitud del texto es: ' || longitud);       
     --hoy es MIERCOLES
     dbms_output.put_line('Hoy es: ' || to_char(fecha, 'day'));
     dbms_output.put_line(texto);
  end;
--
--
  declare 
     numero1 int;
     numero2 int;
     suma int;
       begin
     numero1 := '&dato1';
     numero2 := '&dato2';
     suma := numero1 + numero2;
      dbms_output.put_line('Valor primer numero es : ' || numero1);  
      dbms_output.put_line('Valor primer numero es : ' || numero2);  
      dbms_output.put_line('Resultado es: ' || (numero1 - numero2));
      dbms_output.put_line('Resultado es: ' || suma);    
end;
-- quitar el valor a la variable solicitada
undefine dato1;
undefine dato2;
--
--
declare 
     v_departamento int;
Begin
     v_departamento := '&dpto';
--
     update EMP 
     set SALARIO = SALARIO + 1 
     WHERE DEPT_NO = V_DEPARTAMENTO;
End;
undefine dpto;
select * from EMP
ORDER BY DEPT_NO;
--
--
declare 
     v_numero    DEPT.dept_no%type;
     v_nombre    DEPT.dnombre%type;
     v_localidad DEPT.LOC%TYPE;
Begin
     v_numero := '&numero';
     v_nombre := '&nombre';
     v_localidad := '&localidad';
     --
     insert into DEPT values (v_numero, v_nombre, v_localidad); 
End;
--
select * from DEPT;
--
--PRACTICA
--
declare 
     v_emp_no    EMP.emp_no%type;
     v_apellido  EMP.apellido%type;
     v_oficio    EMP.oficio%type;
     v_dept_no   emp.dept_no%TYPE;

     Begin
     v_emp_no   := 9999;
     v_apellido := 'PEREZ';
     v_oficio   := 'ANALISTA';
     v_dept_no  := '10';
          insert into EMP(emp_no, apellido, oficio, fecha_alt, dept_no)  
          values (v_emp_no, v_apellido, v_oficio, sysdate, v_dept_no); 
End;
select * from EMP
where oficio = 'ANALISTA' ;
--
--
declare 
     v_salario  EMP.salario%type;    
     Begin
     v_salario := v_salario + 200;
     update EMP 
     set SALARIO = v_salario 
     WHERE oficio = 'ANALISTA'; 
End;
ROLLBACK;
--
--
--
--
--

declare
v_numero int;
begin  
  v_numero := &numero;  
  if (v_numero = 1) then 
     dbms_output.put_line('Positivo: ' || v_numero );  
  else 
     dbms_output.put_line('Negativo: ' || v_numero );  
  end if;
   dbms_output.put_line('Fin de Programa'  );  
end;
undefine numero;
--
--
declare
v_numero int;
begin  
  v_numero := &numero;  
  if (v_numero > 0) then 
     dbms_output.put_line('Positivo: ' || v_numero );  
  elsif (v_numero = 0) then 
     dbms_output.put_line('Es cero: ' || v_numero );
  elsif (v_numero < 0) then
      dbms_output.put_line('Negativo: ' || v_numero );  
  end if;
   dbms_output.put_line('Fin de Programa2'  );  
end;
--
--
declare
v_numero int;
begin  
  v_numero := &numero;  
  if (v_numero = 1) then 
     dbms_output.put_line('Primavera: ' || v_numero );  
  elsif (v_numero = 2) then 
     dbms_output.put_line('Verano: ' || v_numero );
  elsif (v_numero = 3) then
      dbms_output.put_line('Otoño: ' || v_numero );
  elsif (v_numero = 4) then
      dbms_output.put_line('Invierno: ' || v_numero );
  else
      dbms_output.put_line('Otro: ' || v_numero );   
  end if;
   dbms_output.put_line('Fin de Programa3'  );  
end;
--
--
declare
v_numero1 int;
v_numero2 int;
begin  
  v_numero1 := &numero1;
  v_numero2 := &numero2;  
  if (v_numero1 > v_numero2 ) then 
     dbms_output.put_line('Primer valor ingresado es mayor: ' || v_numero1);  
  else
      dbms_output.put_line('Segundo valor ingresado es mayor: ' || v_numero2);   
  end if;
   dbms_output.put_line('Fin de Programa4'  );  
end;
undefine numero1;
undefine numero2;
--
--
declare
v_numero int;
begin  
  v_numero := &numero;
  if (mod(v_numero,2) = 0 then 
     dbms_output.put_line('resulatdo es par: ' || v_numero );  
  else
      dbms_output.put_line('resultado es impar ' || v_numero );   
  end if;
   dbms_output.put_line('Fin de Programa5'  );  
end;
undefine numero;
--
--
/
declare
v_letra varchar2(1);
begin  
  v_letra := lower('&letra');
  if (v_letra = 'a' or 
      v_letra = 'e' or 
      v_letra = 'i' or 
      v_letra = 'o' or 
      v_letra = 'u') then 
     dbms_output.put_line('Vocal: ' || v_letra);  
  else
      dbms_output.put_line('Consonante ' || v_letra);   
  end if;
   dbms_output.put_line('Fin de Programa6'  );  
end;
/
undefine numero1;
undefine numero2;
undefine numero3;
--
declare
v_numero1 int;
v_numero2 int;
v_numero3 int;
begin  
  v_numero1 := &numero1;
  v_numero2 := &numero2;
  v_numero3 := &numero3;  
  if (v_numero1 > v_numero2) and (v_numero1 > v_numero3 )  then 
     dbms_output.put_line('Primer valor es el mayor: ' || v_numero1);  
  elsif (v_numero2 > v_numero3) then 
      dbms_output.put_line('Segundo valor es el mayor: ' || v_numero2);   
  else 
      dbms_output.put_line('Tercer valor es el mayor: ' || v_numero3);       
  end if;
   dbms_output.put_line('Fin de Programa7'  );  
end;
--
--
declare
v_numero1 int;
v_numero2 int;
v_numero3 int;
begin  
  v_numero1 := &numero1;
  v_numero2 := &numero2;
  v_numero3 := &numero3;  
  if (v_numero1 > v_numero2) and (v_numero1 < v_numero3 )  then 
     dbms_output.put_line('Primer valor es el del medio: ' || v_numero1);  
--  elsif (v_numero2 > v_numero3) then 
--      dbms_output.put_line('Segundo valor es el mayor: ' || v_numero2);   
--  else 
--      dbms_output.put_line('Tercer valor es el mayor: ' || v_numero3);       
  end if;
   dbms_output.put_line('Fin de Programa8'  );  
end;
--
--
declare
v_dia int;
v_mes int;
v_ano int;
v_ano1 int;
v_ano2 int;
v_resultado int;
begin  
  v_dia := &dia;
  v_mes := &mes;
  v_ano := &ano; 
  v_ano1 := v_ano; 
--
  if (v_mes = 1) then
     v_mes := 13
     v_ano := v_ano - 1;
  end if;
--
  if (v_mes = 2) then
     v_mes := 14
     v_ano := v_ano - 1;
  end if;
  --
    (((v_mes := v_mes + 1) * 3) / 5); 
--
    (v_ano := v_ano / 4);
--
    (v_ano1 := v_ano1 / 100);
--
    (v_ano2 := v_ano2 / 400); 
--
     (v_resultado)
-
   dbms_output.put_line('Fin de Programa8'  );  
end;
--
--
---  21/04/2025---
--
--   LOOP   entra y luego evalua
--
declare
       i int;
       suma int;
begin
i := 1;
suma := 0;
loop
   suma:= suma + i;
    i := i +1;
    exit when i > 100;
end loop;
    dbms_output.put_line('Lasuma de los primeros 100 numeros es: ' || suma);
end;
--
--
--
--   WHILE ... LOOP   evalua y luego entra
--
--
declare
       i int;
       suma int;
begin
i := 1;
suma := 100;
while i <= 100  loop
   suma := suma + i;
    i := i + 1;
end loop;
    dbms_output.put_line('Lasuma de los primeros 100 numeros es: ' || suma);
end;
--
--
--    FOR.... LOOP (CONTADOR)
--
declare
        suma int;
begin
     suma := 0;
     for  i in 1..101  loop
     suma := suma + i;
     end loop; 
    dbms_output.put_line('Lasuma de los primeros 100 numeros es: ' || suma);
end; 
--
--
-- ETIQUETRA GOTO PARA UN BUCLE
declare
        suma int;
begin
     suma := 0;
     dbms_output.put_line('inicio');
     goto codigo;
     dbms_output.put_line('antes del bucle');
     for  i in 1..101  loop
     suma := suma + i;
     end loop;
     << codigo >>
     dbms_output.put_line('despues del bucle');
     dbms_output.put_line('Lasuma de los primeros 100 numeros es: ' || suma);
end;
--
--
-- EJEMPLOS
--BUCLE PARA MOSTRAR LOS NUMEROS ENTRE 1 Y 10
-- BUCLE WHILE
-- BUCLE FOR
declare
       i int;
       suma int;
begin
i := 1;
while i <= 10  loop
   dbms_output.put_line('Numeros del 1 al 10: ' || i);
   i := i + 1; 
   end loop;
end;    
--
declare
        begin
        for  i in 1..10  loop
        dbms_output.put_line('valor de i : ' || i);
        end loop;
     end;
--
--pedir al usuario un numero inicial y un numero final
--montrar los numeros comprendidios entre dicho rango
declare
        inicio int;
        final int;  
        begin
        inicio := &inicial;
        final := &fina;
        if inicio >= final then
         dbms_output.put_line('numero inicio es mayor' || inicio ); 
          dbms_output.put_line('que numero final' || final );
        else 
        for  i in inicio..final  loop
        dbms_output.put_line('valor de i : ' || i);
        end loop;
        end if;
        dbms_output.put_line('Final de Programa');  
     end;
     undefine inicial;
     undefine fina;
     --
     --
     imprimir los numero pares entre dos numeros
    --
    declare
        inicio int;
        final int;  
        begin
        inicio := &inicial;
        final := &fina;
        for  i in inicio..final  loop
        if (mod(i, 2) <> 0) then  
        dbms_output.put_line('valor de i : ' || i);
        end if;
        end loop;
        dbms_output.put_line('Final de Programa');  
     end; 
--
--
declare
            valor int;
begin
valor := &entarda;
while valor <> 1  loop
   if (mod(valor, 2) = 0) then
      valor := valor / 2;
       dbms_output.put_line('par: ' || valor);
   else   
      valor := valor * 3; 
      valor := valor + 1;
      dbms_output.put_line('impar: ' || valor);
   end if;   
end loop;
    dbms_output.put_line('resultado: ' || valor);
end;
--
--
mostra la tabla de multipiclar del numero que ingresado por pantalla
--
--
declare
       i int;
       multiplica int;
begin
i := 1;
multiplica := &valor;
loop
   multiplica := multiplica * i;
   dbms_output.put_line(&valor|| ' ' || '*' || ' ' || i || ' '|| '=' || ' ' || multiplica);
    i := i + 1;
     multiplica := &valor;
    exit when i > 10;
end loop;
    dbms_output.put_line('fin del programa');
end;
--
--
declare
   v_texto varchar2(50);
   v_longitud int;
   v_letra varchar2(1);
   final varchar2(50);

begin
v_texto := '&valori'; 
Final := length(v_texto);
     for i in 1..final  loop
     v_letra := substr(final, i, 1);
     dbms_output.put_line(v_letra);
end loop;
       dbms_output.put_line('fin del programa');
end;
