--7. Подключитесь к пользователю U1_XXX_PDB, с помощью SQL Developer,
--создайте таблицу XXX_table, добавьте в нее строки, выполните SELECT-запрос к таблице
create table  sam_table(
id int,
name varchar(15)
);

insert into sam_table values (1,'David');
insert into sam_table values(2,'Helen');
insert into sam_table values(3,'Nick');
insert into sam_table values(4,'Lui');

select * from sam_table;
drop table sam_table;