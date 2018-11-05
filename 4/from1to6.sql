--1.Получите список всех существующих PDB в рамках экземпляра ORA12W. Определите их текущее состояние.
select * from v$pdbs;
--2. Выполните запрос к ORA12W, позволяющий получить перечень экземпляров.
select * from v$instance;
--3. Выполните запрос к ORA12W, позволяющий получить перечень установленных компонентов СУБД Oracle 12c и их версии. 
select * from v$version;
--4. Создайте собственный экземпляр PDB (необходимо подключиться к серверу с серверного компьютера
--и используйте Database Configuration Assistant) с именем XXX_PDB, где XXX – инициалы студента. 
--5. Получите список всех существующих PDB в рамках экземпляра ORA12W. Убедитесь, что созданная PDB-база данных существует.
select * from v$pdbs;
--6. Подключитесь к XXX_PDB c помощью SQL Developer создайте инфраструктурные объекты 
--(табличные пространства, роль, профиль безопасности, пользователя с именем U1_XXX_PDB).
 
CREATE TABLESPACE TS_pdb1 
DATAFILE 'TS_pdb1' SIZE 7M 
REUSE AUTOEXTEND ON NEXT 5M MAXSIZE 20M;

create temporary tablespace temp_pdb1_tablespace
tempfile 'temp_pdb1_tablespace' SIZE  5M
AUTOEXTEND ON NEXT 3M MAXSIZE 30M;

create role с##rl_pdb1;
grant create session,
        create table,
        create view to c##rl_pdb1;

create profile C##pf_pdb1 limit
    password_life_time 180 --кол-во дней жизни пароля
    sessions_per_user 3 --кол-во сессий для пользователя
    failed_login_attempts 7
    password_lock_time 1 --кол-во дней блокировки после ошибки
    password_reuse_time 10 --через сколько дней можно повторить пароль
    password_grace_time default --кол-во дней предупреждений о смене пароля
    connect_time 180
    idle_time 30 --кол-во минут простоя
    ;
    
    create user C##u1_pdb1 identified by s1234567;
    alter user C##u1_pdb1
    default tablespace TS_pdb1 
    temporary tablespace temp_pdb1_tablespace
    profile C##pf_pdb1;

    grant create session to C##U1_SAM_PDB;
    alter user C##U1_SAM_PDB identified by q12345;
    
    drop user C##U1_SAM_PDB;