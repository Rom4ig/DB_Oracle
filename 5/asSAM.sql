--От имени XXX в  пространстве XXX_T1 создайте таблицу из двух столбцов, один из которых будет являться первичным ключом.
--В таблицу добавьте 3 строки.

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

--скрипт lab05

--4. Удалите (DROP) таблицу XXX_T1.

DROP TABLE SAM_T1;

--Выполните SELECT-запрос к представлению USER_RECYCLEBIN, поясните результат.
SELECT * FROM user_recyclebin;

--5. Восстановите (FLASHBACK) удаленную таблицу. 
flashback table SAM_T1 to BEFORE DROP;

--6. Выполните PL/SQL-скрипт, заполняющий таблицу XXX_T1 данными (10000 строк). 

DECLARE N INT := 4;
begin 
    for i IN 1..10000 LOOP
    insert into SAM_T1 values (N, concat('stroka',N));
    N := N+1;
    END LOOP;
END;

SELECT COUNT(*) FROM SAM_T1;

--lab05 