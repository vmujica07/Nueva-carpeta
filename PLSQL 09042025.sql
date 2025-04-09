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
