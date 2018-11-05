--1 �������� ���������� �����������
create tablespace sam_tablespace
datafile 'sam_01.dat'
SIZE  7M
AUTOEXTEND ON NEXT 5M MAXSIZE 20M;

--2 �������� �������� ���������� ������������
create temporary tablespace temp_sam_tablespace
tempfile 'TS_sam_temp'
SIZE  5M
AUTOEXTEND ON NEXT 3M MAXSIZE 30M;

--3 �������� ������ ���� ��������� �����������, ������ ���� ������ � ������� select-������� � �������.
select * from SYS.dba_tablespaces;

--4 �������� ���� � ������ RL_XXXCORE. ��������� �� ��������� ��������� ����������:
--	���������� �� ���������� � ��������;
--	���������� ��������� � ������� �������, �������������, ��������� � �������.
create role C##RL_SAMcore;
commit;

grant create session,
        create table,
        create view,
        create procedure to C##RL_SAMCORE;
        
 --5. ������� � ������� select-������� ���� � �������.
 --������� � ������� select-������� ��� ��������� ����������, ����������� ����.     
select * from  SYS.dba_sys_privs where GRANTEE = 'C##RL_SAMCORE';

--6 �������� ������� ������������ � ������ PF_XXXCORE, ������� �����, ����������� ������� �� ������.

create profile C##PF_SAMCORE limit
    password_life_time 180 --���-�� ���� ����� ������
    sessions_per_user 3 --���-�� ������ ��� ������������
    failed_login_attempts 7
    password_lock_time 1 --���-�� ���� ���������� ����� ������
    password_reuse_time 10 --����� ������� ���� ����� ��������� ������
    password_grace_time default --���-�� ���� �������������� � ����� ������
    connect_time 180
    idle_time 30 --���-�� ����� �������
    ;
    
-- 7 ������������� ������� �� Oracle
-- �������� �������� ���� ���������� ������� PF_XXXCORE. 
select * from dba_profiles where profile = 'C##PF_SAMCORE';
-- �������� �������� ���� ���������� ������� DEFAULT.
select * from dba_profiles where profile = 'DEFAULT';

--8 �������� ������������ � ������ XXXCORE �� ���������� �����������:
-- ��������� ������������ �� ���������: TS_XXX;
-- ��������� ������������ ��� ��������� ������: TS_XXX_TEMP;
-- ������� ������������ PF_XXXCORE;
-- ������� ������ ��������������;
-- ���� �������� ������ �����. 
create user C##SAMCORE identified by s1234567
default tablespace sam_tablespace quota unlimited on sam_tablespace
temporary tablespace temp_sam_tablespace
profile C##PF_SAMCORE
account unlock
password expire;

grant create session to C##SAMCORE
alter user C##SAMCORE account unlock;
alter user C##SAMCORE identified by q12345
account unlock;

drop user C##SAMCORE;
-- �������� ��������� ������������ � ������ XXX_QDATA (10m). 
-- ��� �������� ���������� ��� � ��������� offline. ����� ���������� ��������� ������������
-- � ��������� online. �������� ������������ XXX ����� 2m � ������������ XXX_QDATA. 
--�� ����� ������������ XXX �������� ������� � ������������ XXX_T1.
--� ������� �������� 3 ������.

create tablespace SAM_QDATA 
datafile 'C:\app\SAM_QDATA.dbf'
SIZE 10M reuse
autoextend on next 5M
maxsize 20M
offline
extent management local;

create user C##SAM_XXX
identified by q12345
default tablespace sam_tablespace
quota 2M on SAM_QDATA
account unlock 
password expire;

create table t (c number);

insert into t(c) values(3);
insert into t(c) values(1);
insert into t(c) values(2);

select * from t


