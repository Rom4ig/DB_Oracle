create sequence S1
start with 1000
increment by 10
nominvalue
nomaxvalue
nocycle
nocache
noorder;

create global temporary table temp(
id int
)

insert into temp values (S1.NEXTVAL);
insert into temp values (S1.NEXTVAL);
insert into temp values (S1.NEXTVAL);

select * from temp;

set SERVEROUTPUT on;
declare v varchar2(254) := S1.CURRVAL;
BEGIN
DBMS_OUTPUT.PUT_LINE(v);
END;

drop sequence S2;

create sequence S2
start with 10
increment by 10
nominvalue
maxvalue 100
nocycle
nocache
noorder;

set SERVEROUTPUT on;
begin
    for i in 10..100
    loop
    DBMS_OUTPUT.PUT_LINE(S2.nextval);
    end loop;
end;
 
create sequence S3
start with 10
increment by -10
minvalue -100
maxvalue 100
nocycle
nocache
order;

set SERVEROUTPUT on;
begin
    for i in 0..12
    loop
    DBMS_OUTPUT.PUT_LINE(S3.nextval);
    end loop;
end;

create sequence S4
start with 10
increment by 1
minvalue 10
maxvalue 100
cycle
cache 5
noorder;

set SERVEROUTPUT on;
begin
    for i in 0..110
    loop
    DBMS_OUTPUT.PUT_LINE(S4.nextval);
    end loop;
end;

select * from user_objects where object_type='SEQUENCE';

create table T1(
N1 NUMBER (20),
N2 NUMBER (20),
N3 NUMBER (20),
N4 NUMBER (20)
)
cache storage(buffer_pool keep);

drop SEQUENCE S1;
drop SEQUENCE S2;
drop SEQUENCE S3;

begin
    for i in 0..6
    loop
    insert into T1 values(S1.NEXTVAL, S2.NEXTVAL,S3.NEXTVAL, S4.NEXTVAL);
    end loop;
end;

select * from T1;

CREATE CLUSTER ABC( X NUMBER(10),Y VARCHAR2(12))
SIZE 200
HASHKEYS 2;

CREATE TABLE A( XA NUMBER(10),YA VARCHAR2(12), ZA INT)
CLUSTER ABC(XA, YA);

CREATE TABLE B( XB NUMBER(10),YB VARCHAR2(12), ZB INT)
CLUSTER ABC(XB, YB);

CREATE TABLE C( XC NUMBER(10),YC VARCHAR2(12), ZC INT)
CLUSTER ABC(XC, YC);

SELECT * FROM USER_OBJECTS;

CREATE  SYNONYM SYN_FOR_C  FOR C;
SELECT * FROM SYN_FOR_C;

drop public synonym SYN_FOR_B;
CREATE  PUBLIC SYNONYM SYN_FOR_B  FOR B;
insert into SYN_FOR_B  VALUES(500,'DF',6);
SELECT * FROM SYN_FOR_B;

create user u1 identified by q12345678;

create table b1(
id int primary key,
name varchar(20)
);

create table a1(
id int primary key,
product_name varchar(20),
manufactor_id int,
constraint fk_manufactor foreign key (manufactor_id) references b1(id)
);

drop table a1;
drop table b1;

insert into b1 values(1,  'samsung');
insert into b1 values(2,  'apple');

insert into a1 values(1,  'phone1', 1);
insert into a1 values(2,  'phone2', 1);
insert into a1 values(3,  'phone1', 2);
insert into a1 values(4,  'laptop1', 1);
insert into a1 values(5,  'laptop1', 2);
insert into a1 values(6,  'laptop2', 2);

drop view apple_items;
create view apple_items as
select a1.product_name, b1.name from a1
join b1 on a1.manufactor_id = b1.id
where b1.name = 'apple';

select * from apple_items;

drop materialized view MV;
drop table temp;

create table temp(A int);

create materialized view MV 
refresh complete start with (sysdate) next (sysdate+2/1440)
as select *  from temp;

begin
      for i in 1..10 loop
         insert into temp values (i+1);
      end loop;
end;
commit;

select count(*) from temp;
select count(*) from MV;

EXEC DBMS_MVIEW.REFRESH(list=> 'MV',method => 'C', ATOMIC_REFRESH => FALSE);