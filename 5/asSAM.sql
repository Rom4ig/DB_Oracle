--�� ����� XXX �  ������������ XXX_T1 �������� ������� �� ���� ��������, ���� �� ������� ����� �������� ��������� ������.
--� ������� �������� 3 ������.

create table SAM_T1
(
id int primary key,
name varchar(15)
)
tablespace SAM_QDATA;

select * from user_objects;

insert into SAM_T1 values (1,'oil');
insert into SAM_T1 values (2,'solt');
insert into SAM_T1 values (3,'milk');

select * from SAM_T1;

--������ lab05

--4. ������� (DROP) ������� XXX_T1.

DROP TABLE SAM_T1;

--��������� SELECT-������ � ������������� USER_RECYCLEBIN, �������� ���������.
SELECT * FROM user_recyclebin;

--5. ������������ (FLASHBACK) ��������� �������. 
flashback table SAM_T1 to BEFORE DROP;

--6. ��������� PL/SQL-������, ����������� ������� XXX_T1 ������� (10000 �����). 

DECLARE N INT := 4;
begin 
    for i IN 1..10000 LOOP
    insert into SAM_T1 values (N, concat('stroka',N));
    N := N+1;
    END LOOP;
END;

SELECT COUNT(*) FROM SAM_T1;

--lab05 