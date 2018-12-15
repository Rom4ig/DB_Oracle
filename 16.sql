alter tablespace ts3 add datafile 'ts31.dbf' size 4m reuse AUTOEXTEND ON MAXSIZE UNLIMITED ;

drop table T_RANGE;
drop table T_INTERVAL;
drop table T_HASH;
drop table T_LIST;

create tablespace ts1
datafile 'ts1.dat' size 2m;
create tablespace ts2
datafile 'ts2.dat' size 2m;
create tablespace ts3
datafile 'ts3.dat' size 2m;

--T_RANGE
drop table T_RANGE;

create table T_RANGE(
ticket_no NUMBER,
movie varchar(20))
partition by range(ticket_no)
(
partition range1 values less than (5)
tablespace ts1,
partition range2 values less than (10)
tablespace ts2,
partition range3 values less than (15)
tablespace ts3
)

insert into T_RANGE values(2, 'movie 5');
insert into T_RANGE values(7, 'movie 7');
insert into T_RANGE values(12, 'movie 12');
insert into T_RANGE values(20, 'movie 12');

select * from T_RANGE PARTITION(range1);
select * from T_RANGE PARTITION(range2);
select * from T_RANGE PARTITION(range3);

alter table T_RANGE MERGE PARTITIONS range1, range2 INTO partition newRange;

alter table T_RANGE split partition range2 at (5)
into (partition range1, partition range2 );

CREATE TABLE T_RANGE2(
ticket_no NUMBER,
movie varchar(20));

alter table T_RANGE 
EXCHANGE PARTITION range3 WITH TABLE T_RANGE2;

select * from T_RANGE2;

--T_INTERVAL
create table T_INTERVAL(
prod_id number,
sale date
)
partition by range(sale)
interval(numtoyminterval(1,'month'))
(partition p1 values less than (TO_DATE('1-1-2006','DD-MM-YYYY')),
partition p2 values less than (TO_DATE('1-1-2007','DD-MM-YYYY')),
partition p3 values less than (TO_DATE('1-1-2008','DD-MM-YYYY')))

insert into T_INTERVAL values(1, '12-05-2009');
insert into T_INTERVAL values(2, '12-05-2007');
insert into T_INTERVAL values(4, '12-05-2005');

select * from  T_INTERVAL PARTITION(p1);
select * from  T_INTERVAL PARTITION(p2);
select * from  T_INTERVAL PARTITION(p3);


--T_HASH
create table T_HASH(
id number,
author varchar2(30),
book varchar2(30))
partition by hash(author)
partitions 3
store in(ts1, ts2, ts3)

insert into T_HASH values(1, 'HH', 'book1');
insert into T_HASH values(2, 'AH', 'book2');
insert into T_HASH values(3, 'KH', 'book3');

SELECT * FROM DBA_SEGMENTS WHERE OWNER='ALENA'AND SEGMENT_NAME='T_INTERVAL' AND TABLESPACE_NAME = 'TS2';

select * from  T_HASH PARTITION(SYS_P328);
select * from  T_HASH PARTITION(SYS_P329);
select * from  T_HASH PARTITION();

update T_HASH set author = 'LS' where id=2;


--T_LIST
create table T_LIST(
department_no number,
country char(15)
)
partition by list(country)
(
partition gr1 values('Russia', 'Belarus', 'Ukraine') tablespace ts1,
partition gr2 values('Poland', 'Monaco', 'USA') tablespace ts2,
partition gr3 values('Norway', 'Germany', 'France') tablespace ts3
)

insert into T_LIST values (1, 'Belarus');
insert into T_LIST values (3, 'Monaco');
insert into T_LIST values (3, 'Germany');

select * from  T_LIST PARTITION(gr1);
select * from  T_LIST PARTITION(gr2);
select * from  T_LIST PARTITION(gr3);

