create table SAM_t (x number(3), s varchar2(50));

insert into SAM_t values (1,'Dasha');
insert into SAM_t values (1,'Sasha');
insert into SAM_t values (1,'Masha');
commit;

update SAM_t set x = 2 where s = 'Sasha';
update SAM_t set x = 3 where s = 'Masha';
commit;

select count(*) from SAM_t;
select * from SAM_t  order by s;
select * from SAM_t where s like 'M%';

delete from SAM_t where x =2;
commit;

drop table SAM_t;



