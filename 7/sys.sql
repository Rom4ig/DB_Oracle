--1.	�������� ������ ������ ������� ���������. 
select name, description from v$bgprocess order by name;

--2.	���������� ������� ��������, ������� �������� � �������� � ��������� ������.
select name, description from v$bgprocess where paddr!=hextoraw('00') order by name;

--3.	����������, ������� ��������� DBWn �������� � ��������� ������.
select name, description from v$bgprocess where name='DBWn' and paddr!=hextoraw('00') order by name;

--4.	�������� �������� ������� ���������� � �����������.
select * from v$session where username is not null;

--5.	���������� ������ ���� ����������.
select username, status, server from v$session where username is not null;

--6.	���������� ������� (����� ����������� ����������).
SELECT * FROM V$SERVICES;

--7.	�������� ��������� ��� ��������� ���������� � �� ��������.
SHOW PARAMETER DISPATCHER;

--8.	������� � ������ Windows-�������� ������, ����������� ������� LISTENER.

--9.	�������� �������� ������� ���������� � ���������. (dedicated, shared). 
SELECT * FROM V$SESSION WHERE USERNAME IS NOT NULL;

--10.	����������������� � �������� ���������� ����� LISTENER.ORA. 

--12.	�������� ������ ����� ��������, ������������� ��������� LISTENER. 
--services
