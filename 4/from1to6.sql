--1.�������� ������ ���� ������������ PDB � ������ ���������� ORA12W. ���������� �� ������� ���������.
select * from v$pdbs;
--2. ��������� ������ � ORA12W, ����������� �������� �������� �����������.
select * from v$instance;
--3. ��������� ������ � ORA12W, ����������� �������� �������� ������������� ����������� ���� Oracle 12c � �� ������. 
select * from v$version;
--4. �������� ����������� ��������� PDB (���������� ������������ � ������� � ���������� ����������
--� ����������� Database Configuration Assistant) � ������ XXX_PDB, ��� XXX � �������� ��������. 
--5. �������� ������ ���� ������������ PDB � ������ ���������� ORA12W. ���������, ��� ��������� PDB-���� ������ ����������.
select * from v$pdbs;
--6. ������������ � XXX_PDB c ������� SQL Developer �������� ���������������� ������� 
--(��������� ������������, ����, ������� ������������, ������������ � ������ U1_XXX_PDB).
 
CREATE TABLESPACE TS_pdb1 
DATAFILE 'TS_pdb1' SIZE 7M 
REUSE AUTOEXTEND ON NEXT 5M MAXSIZE 20M;

create temporary tablespace temp_pdb1_tablespace
tempfile 'temp_pdb1_tablespace' SIZE  5M
AUTOEXTEND ON NEXT 3M MAXSIZE 30M;

create role �##rl_pdb1;
grant create session,
        create table,
        create view to c##rl_pdb1;

create profile C##pf_pdb1 limit
    password_life_time 180 --���-�� ���� ����� ������
    sessions_per_user 3 --���-�� ������ ��� ������������
    failed_login_attempts 7
    password_lock_time 1 --���-�� ���� ���������� ����� ������
    password_reuse_time 10 --����� ������� ���� ����� ��������� ������
    password_grace_time default --���-�� ���� �������������� � ����� ������
    connect_time 180
    idle_time 30 --���-�� ����� �������
    ;
    
    create user C##u1_pdb1 identified by s1234567;
    alter user C##u1_pdb1
    default tablespace TS_pdb1 
    temporary tablespace temp_pdb1_tablespace
    profile C##pf_pdb1;

    grant create session to C##U1_SAM_PDB;
    alter user C##U1_SAM_PDB identified by q12345;
    
    drop user C##U1_SAM_PDB;