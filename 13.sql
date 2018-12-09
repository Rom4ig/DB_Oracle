select * from pulpit;
select * from faculty;
select * from teacher;
select * from subject;


--1

declare procedure get_teachers(pcode teacher.pulpit%type)
is
cursor cs is select * from teacher where lower(pulpit) like lower('%' || pcode || '%') ;
buffer teacher%rowtype;
begin
open cs;
loop
fetch cs into buffer;
exit when cs%notfound;
dbms_output.put_line(buffer.teacher_name);
end loop;
close cs;
end;

begin
get_teachers('»—Ë“');
end;

--2. 
declare res number;
function get_num_teachers(pcode char) return number
is
buff number;
begin
select count(*) into buff from teacher where lower(pulpit) like lower('%' || pcode || '%') ;
return buff;
end get_num_teachers;
begin
res := get_num_teachers('»—Ë“');
dbms_output.put_line('result = ' || res);
end;

--3.
declare procedure get_teachers(fcode pulpit.FACULTY%type)
is
cursor cs
is
select TEACHER.TEACHER_NAME, pulpit.FACULTY from teacher, pulpit
where teacher.pulpit = pulpit.pulpit and lower(pulpit.faculty) like lower('%' || fcode || '%');
tname teacher.TEACHER_NAME%type;
fname pulpit.faculty%type;
begin
open cs;
loop
  fetch cs into tname, fname;
  exit when cs%notfound;
  dbms_output.put_line(tname);
end loop;
close cs;
end;
begin
  get_teachers('»ƒËœ');
end;

-- 

declare procedure GET_SUBJECTS(pcode pulpit.pulpit%type)
is
cursor cs is select * from subject where lower(pulpit) like lower('%' || pcode || '%') ;
buffer SUBJECT%rowtype;
begin
  open cs;
  loop
    fetch cs into buffer;
    exit when cs%notfound;
    dbms_output.put_line(buffer.subject_name);
  end loop;
  close cs;
  end;
begin
  GET_SUBJECTS('»—Ë“');
end;


--4. 

declare
res number;
function get_num_teachers(fcode FACULTY.FACULTY%TYPE) return number
is
buff number;
begin
select count(*) into buff from teacher , pulpit
where teacher.pulpit = pulpit.pulpit and lower(pulpit.faculty) like lower('%' || fcode || '%');
return buff-2;
end get_num_teachers;
begin
res := get_num_teachers('»ƒËœ');
dbms_output.put_line('result = ' || res);
end;


declare
res number;
function get_num_subjects(pcode pulpit.pulpit%TYPE) return number
is
buff number;
begin
select count(*) into buff from subject where lower(pulpit) like lower('%' || pcode || '%');
return buff;
end get_num_subjects;
begin
res := get_num_subjects('“À');
dbms_output.put_line('result = ' || res);
end;

--5. –‡Á‡·ÓÚ‡ÈÚÂ Ô‡ÍÂÚ TEACHERS

CREATE OR REPLACE PACKAGE TEACHERS IS
  PROCEDURE get_teachers(pcode teacher.pulpit%type);
  procedure GET_SUBJECTS(pcode pulpit.pulpit%type);
  function get_num_teachers(fcode FACULTY.FACULTY%TYPE) return number;
  function get_num_subjects(pcode pulpit.pulpit%TYPE) return number;
END;

CREATE OR REPLACE PACKAGE BODY TEACHERS IS

    PROCEDURE get_teachers(pcode teacher.pulpit%type) IS
    cursor cs is select * from teacher where lower(pulpit) like lower('%' || pcode || '%') ;
    buffer teacher%rowtype;
    begin
    open cs;
    loop
    fetch cs into buffer;
    exit when cs%notfound;
    dbms_output.put_line(buffer.teacher_name);
    end loop;
    close cs;
    end;
    
    procedure GET_SUBJECTS(pcode pulpit.pulpit%type)
    IS
    cursor cs is select * from subject where lower(pulpit) like lower('%' || pcode || '%') ;
    buffer SUBJECT%rowtype;
    begin
    open cs;
    loop
      fetch cs into buffer;
    exit when cs%notfound;
    dbms_output.put_line(buffer.subject_name);
  end loop;
  close cs;
  end;
  
function get_num_teachers(fcode FACULTY.FACULTY%TYPE) return number
is
buff number;
begin
select count(*) into buff from teacher , pulpit
where teacher.pulpit = pulpit.pulpit and lower(pulpit.faculty) like lower('%' || fcode || '%');
return buff-2;
end get_num_teachers;

function get_num_subjects(pcode pulpit.pulpit%TYPE) return number
IS
buff number;
begin
select count(*) into buff from subject where lower(pulpit) like lower('%' || pcode || '%');
return buff;
end get_num_subjects;

END TEACHERS;

--6.
declare
res number;
res2 number;
BEGIN
  dbms_output.put_line('*****TEACERS*****');
  TEACHERS.get_teachers('»—Ë“');
  dbms_output.put_line('*****SUBJECTS*****');
  TEACHERS.get_subjects('»—Ë“'); 
  dbms_output.put_line('*****COUNT OF TEACERS*****');
  res := TEACHERS.get_num_teachers('»ƒËœ');
  dbms_output.put_line(res);
  dbms_output.put_line('*****COUNT OF SUBJECTS*****');
  res2 := TEACHERS.get_num_subjects('“À');
  dbms_output.put_line(res2);
END;
