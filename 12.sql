--1. 
select * from teacher;

alter table TEACHER add BIRTHDAY DATE default '10/2/1900';
alter table TEACHER add SALARY number(20) default 100;

--2. 
select substr(teacher_name, 1, instr(teacher_name, ' ')) ||
        substr(teacher_name, instr(teacher_name, ' ') + 1, 1) || '.' || ' ' 
                || substr(teacher_name, instr(teacher_name, ' ', instr(teacher_name, ' ') + 1) + 1, 1) || '.' from teacher;

--3. 
select * from teacher where to_char(birthday, 'D') = 1;

--4. 
drop view teachers_birthday_next_month;
create view teachers_birthday_next_month as select teacher_name, birthday from teacher where extract(month from birthday) = 12;
select * from teachers_birthday_next_month;

--5. 
create view teachers_birthdays_by_months 
as
select extract(month from birthday) as month, count(birthday) as n_teacher from teacher group by extract(month from birthday);

select * from teachers_birthdays_by_months;

--6.
set serveroutput on
declare
cursor cs is select * from teacher;
bufline teacher%rowtype;
bufdate date;
begin
open cs;
loop
fetch cs into bufline;
exit when cs%notfound;
bufdate := bufline.birthday;
if mod(extract(year from sysdate) - extract(year from bufdate), 5) = 0 then
dbms_output.put_line(bufline.teacher_name);
end if;
end loop;
close cs;
end;

--7
declare
cursor cs is select avg(salary), pulpit from teacher group by pulpit;
buffersum number(25, 5);
buffername varchar(200);
avgall number(25, 5);
begin
select avg(salary) into avgall from teacher;
dbms_output.put_line('from all pulpit' || ' ' || ceil(avgall));
open cs;
loop
fetch cs into buffersum, buffername;
exit when cs%notfound;
dbms_output.put_line(ceil(buffersum) || ' ' || buffername);
end loop;
close cs;
end;

--8
CREATE TABLE cust_sales_roundup (
customer_id NUMBER (5),
customer_name VARCHAR2 (100),
total_sales NUMBER (15,2)
)

insert into cust_sales_roundup values (1,'dwfff', 25.5);
insert into cust_sales_roundup values (2,'aaaf', 55.5);
insert into cust_sales_roundup values (3,'cdsdd', 45);
insert into cust_sales_roundup values (4,'nhgh', 50);
insert into cust_sales_roundup values (5,'djhg', 98.5);

DECLARE
  CURSOR cust_sales_cur IS SELECT * FROM cust_sales_roundup;
  cust_sales_rec cust_sales_cur%ROWTYPE;
  TYPE customer_sales_rectype IS RECORD
  (
  customer_id NUMBER (5),
  customer_name VARCHAR2 (100),
  total_sales NUMBER (15,2)
  );
  preferred_cust_rec customer_sales_rectype;
BEGIN
  open cust_sales_cur;
  fetch cust_sales_cur into cust_sales_rec;
  preferred_cust_rec := cust_sales_rec;
  dbms_output.put_line(preferred_cust_rec.customer_name ||':'||cust_sales_rec.customer_name);
  preferred_cust_rec := NULL;
  if  preferred_cust_rec.customer_name is NULL
    then dbms_output.put_line('NULL' );
  end if;
END; 


DECLARE
   TYPE phone_rectype IS RECORD
     (
     intl_prefix VARCHAR2(2),
     area_code VARCHAR2(3),
     exchange VARCHAR2(3),
     phn_number VARCHAR2(4),
     extension VARCHAR2(4)
   );
   
   TYPE contact_set_rectype IS RECORD
      (
      day_phone# phone_rectype,
      eve_phone# phone_rectype,
      fax_phone# phone_rectype,
      home_phone# phone_rectype,
      cell_phone# phone_rectype
   );
   auth_rep_info_rec contact_set_rectype;
BEGIN
auth_rep_info_rec.fax_phone#.area_code := 564;
auth_rep_info_rec.home_phone#.area_code := 545;
auth_rep_info_rec.home_phone# := auth_rep_info_rec.fax_phone#;
END;


select floor(-1.21) from dual ;
