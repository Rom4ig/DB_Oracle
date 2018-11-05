show parameters;

Select tablespace_name from dba_tablespaces;
Select tablespace_name from dba_data_files;
Select role from dba_roles;
Select username from dba_users;

--user c##alena
--table table1

set timing on;
select * from table1;

desc table1;

Select segment_name, segment_type, owner from dba_segments where owner = 'C##ALENA';


create view V1
as
 select count(SEGMENT_NAME) NSEGMENTS,
 COUNT(EXTENTS) NEXTENTS,
 COUNT(BLOCKS) NBLOCKS,
 SUM (BYTES) NSIZE
 FROM DBA_SEGMENTS;
 
 SELECT * FROM V1;