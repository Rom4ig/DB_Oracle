--7. ������������ � ������������ U1_XXX_PDB, � ������� SQL Developer,
--�������� ������� XXX_table, �������� � ��� ������, ��������� SELECT-������ � �������
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