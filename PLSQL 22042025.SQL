--
--cursor para mostrar el apellido, salario y oficio de empleados  

declare  
  cursor cursor_emp is     
  select apellido, salario, oficio , salario + comision as total    
  from EMP;     
begin  
  for v_registro in cursor_emp 
  loop
         dbms_output.put_line('Apellido ' || v_registro.apellido
         || ', Salario ' || v_registro.salario  
         || ', Oficio '  || v_registro.oficio
         || ', Total '   || v_registro.total);  
  end loop;    
end;   

--
describe DEPT;
declare
    v_fila dept%rowtype;
    cursor cursor_dept is     
    select * from dept;  
begin     
    open cursor_dept;
    loop   
        fetch cursor_dept into v_fila;  
        exit when cursor_dept%notfound;
        dbms_output.put_line('ID: ' || v_fila.dept_no
        || ',Nombre' || v_fila.dnombre
        || ',Localidad: ' || v_fila.loc);          
    end loop;   
    close cursor_dept;
   end;
--
DECLARE
    v_suma_salarial doctor.salario%type;
BEGIN
    select sum(doctor.salario) into v_suma_salarial
    from DOCTOR
    inner join hospital
    on doctor.hospital_cod = hospital.hospital_cod
    where lower(hospital.nombre)= 'la paz';
     dbms_output.put_line('Suma salarial la paz: ' || v_suma_salarial); 
     if v_suma_salarial > 1000000 Then   
        update doctor set salario = salario - 10000
        where hospital_cod =
        (select hospital_cod from hospital where upper(nombre) = 'LA PAZ');
        dbms_output.put_line('Bajando salarios: ' || sql%rowcount ); 
      ELSE
         update doctor set salario = salario + 10000
        where hospital_cod =
        (select hospital_cod from hospital where upper(nombre) = 'LA PAZ');
        dbms_output.put_line('Doctores Ricos: ' || sql%rowcount );  
end;

--
declare 
    v_hosp_hospital_cod hospital.hospital_cod%type;
    v_suma_salario doctor.salario%type;
begin  
     select hospital_cod into v_hosp_hospital_cod from hospital 
     where upper(nombre) = 'LA PAZ';
     select sum(salario) into v_suma_salario FROM doctor  
     where hospital_cod = v_hosp_hospital_cod; 
     if v_suma_salario > 1000000 then  
        UPDATE doctor set salario = salario - 10000
        where hospital_cod = v_hosp_hospital_cod; 
        dbms_output.put_line('Doctores mas pobres: ' || sql%rowcount ); 
     else
        UPDATE doctor set salario = salario - 10000
        where hospital_cod = v_hosp_hospital_cod; 
        dbms_output.put_line('Doctores menos pobres: ' || sql%rowcount ); 
     end if;
end;
--
select * from hospital;
select * from doctor;  
--
declare
    v_salario emp.salario%type;
    c_salario emp.salario%type := 10000;
    v_emp_no emp.emp_no%type;
 
begin 
    select emp_no, salario into v_emp_no, v_salario from EMP
    where upper(apellido) = 'ARROYO'; 
        if v_salario > 250000 then  
           v_salario := v_salario - c_salario;
        else
           v_salario := v_salario + c_salario;
       end if;
       UPDATE EMP set salario = v_salario
       WHERE emp_no = v_emp_no;
       dbms_output.put_line('salario: ' || v_salario); 
end;
--
select * from emp;
--
--
describe emp;
declare
       v_depart dept.dept_no%type;
       v_dnombre dept.dnombre%type;
       v_loc dept.loc%type;
       v_existe dept.dept_no%type; 

       cursor cursordept is 
       select dept_no from DEPT
       where dept_no = v_depart;
begin 
       v_depart := &depa;
       v_dnombre := '&nomb';
       v_loc  := '&loc';
       
       open cursordept;
       LOOP
             FETCH cursordept into v_existe;
             if  (cursordept%found) then    
                 dbms_output.put_line('UPDATE'); 
                 update dept set   dnombre = v_dnombre,
                                   loc = v_loc
                 WHERE DEPT_NO = V_DEPART;                  
             else    
               dbms_output.put_line('INSERT');
                 insert into dept (dept_no, dnombre, loc) values (v_depart, v_dnombre, v_loc);  
             end if;                              
             exit when cursordept%notfound;
       END LOOP;
      close cursordept;
end;
--
select * from dept;
--
declare 
       v_id int;
begin 
      v_id := &numero;
      select * from DEPT where DEPT_NO = v_id;
end; 
--
select * from DEPT
ORDER BY DEPT_NO;
--
--CURSORES---
--IMPLICITOS SOLAMENTE O DEVUELVEN UNA FILAR
--RECUPERAR EL OFICIO DEL EMPLEADO REY
declare
       v_oficio emp.oficio%type; 
begin 
       select oficio into v_oficio from EMP where upper(APELLIDO) = 'REY';
       dbms_output.put_line('El oficio de Rey ES: ' || v_oficio);
end;
--
--CURSOR EXPLICITO
--PUEDENDEVOLVER MAS DE UNA FILA
--MOSTRAR EL APELLIDO Y SALARIO DE TODOS LOS EMPLEADOS
declare
       
       v_ape emp.apellido%type;
       v_sal emp.salario%type; 

       cursor cursoremp is 
       select apellido, salario from emp;
begin 
       open cursoremp;
       LOOP
             FETCH cursoremp into v_ape, v_sal;
             dbms_output.put_line('apellido: ' || v_ape || 'salario' || v_sal );
       exit when cursoremp%notfound;
       END LOOP;
       close cursoremp;
end;
-- incrementar en 1 el salario de los empleados del departamento 10
--mostrar el numero de empleados
declare

begin 
     update emp set salario = salario + 1
     where dept_no = 10;
     dbms_output.put_line('empleados modificados: ' || sql%rowcount);
end;
--
select * from emp
where dept_no = 10;
--
--incrementar en 10.000 al empleado que menos cobre en la empresa
--
declare
       v_salario emp.salario%type;
       v_apellido emp.apellido%type;
 
begin 
       select min(salario) into v_salario from EMP;
       select apellido into v_apellido from emp where salario = v_salario;
       update emp set salario = salario + 10000
       where salario = v_salario;
       dbms_output.put_line('salario incrementado a: ' || sql%rowcount || 'empleados' || v_apellido);
end;
select * from emp;       
--el numero nombre y localidad de un departamento
--si el departamento existe modificamos su nombre y localidad 
--si el departamento no existe , lo insertamos
declare
       v_depart dept.dept_no%type;
       v_dnombre dept.dnombre%type;
       v_loc     dept.loc%type;
       v_existe   dept_no%type;    
begin 
     
       v_depart := &depa;
       v_dnombre := '&nomb';
       v_loc  := '&loc';
       
       cursor cursordept is 
       select dept_no, dnombre, loc from emp
       where dept_no = v_depart;

       open cursordept;

       LOOP
             FETCH cursordept into v_existe;
             if  cursoremp%found then    
                 dbms_output.put_line('UPDATE'); 
                 udpate dept set   dnombre = v_dnombre;
                                   loc = v_loc;
                 WHERE DEPT_NO= V_DEPART;                  
             else    
               dbms_output.put_line('INSERT');
                 insert into dept (dept_no, dnombre, loc) values (v_depart, v_dnombre, v_loc);  
             end if;                              
             exit when cursoremp%notfound;
       END LOOP;
             
       close cursordept;

end;
select * from dept;      