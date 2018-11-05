--1.	Получите полный список фоновых процессов. 
select name, description from v$bgprocess order by name;

--2.	Определите фоновые процессы, которые запущены и работают в настоящий момент.
select name, description from v$bgprocess where paddr!=hextoraw('00') order by name;

--3.	Определите, сколько процессов DBWn работает в настоящий момент.
select name, description from v$bgprocess where name='DBWn' and paddr!=hextoraw('00') order by name;

--4.	Получите перечень текущих соединений с экземпляром.
select * from v$session where username is not null;

--5.	Определите режимы этих соединений.
select username, status, server from v$session where username is not null;

--6.	Определите сервисы (точки подключения экземпляра).
SELECT * FROM V$SERVICES;

--7.	Получите известные вам параметры диспетчера и их значений.
SHOW PARAMETER DISPATCHER;

--8.	Укажите в списке Windows-сервисов сервис, реализующий процесс LISTENER.

--9.	Получите перечень текущих соединений с инстансом. (dedicated, shared). 
SELECT * FROM V$SESSION WHERE USERNAME IS NOT NULL;

--10.	Продемонстрируйте и поясните содержимое файла LISTENER.ORA. 

--12.	Получите список служб инстанса, обслуживаемых процессом LISTENER. 
--services
