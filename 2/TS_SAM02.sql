--1 —оздание табличного пространста
create tablespace sam_tablespace
datafile 'sam_01.dat'
SIZE  7M
AUTOEXTEND ON NEXT 5M MAXSIZE 20M;

--2 —оздание временно табличного пространства
create temporary tablespace temp_sam_tablespace
tempfile 'TS_sam_temp'
SIZE  5M
AUTOEXTEND ON NEXT 3M MAXSIZE 30M;

--3 ѕолучите список всех табличных пространств, списки всех файлов с помощью select-запроса к словарю.
select * from SYS.dba_tablespaces;

--4 —оздайте роль с именем RL_XXXCORE. Ќазначьте ей следующие системные привилегии:
--	разрешение на соединение с сервером;
--	разрешение создавать и удал€ть таблицы, представлени€, процедуры и функции.
create role C##RL_SAMcore;
commit;

grant create session,
        create table,
        create view,
        create procedure to C##RL_SAMCORE;
        
 --5. Ќайдите с помощью select-запроса роль в словаре.
 --Ќайдите с помощью select-запроса все системные привилегии, назначенные роли.     
select * from  SYS.dba_sys_privs where GRANTEE = 'C##RL_SAMCORE';

--6 —оздайте профиль безопасности с именем PF_XXXCORE, имеющий опции, аналогичные примеру из лекции.

create profile C##PF_SAMCORE limit
    password_life_time 180 --кол-во дней жизни парол€
    sessions_per_user 3 --кол-во сессий дл€ пользовател€
    failed_login_attempts 7
    password_lock_time 1 --кол-во дней блокировки после ошибки
    password_reuse_time 10 --через сколько дней можно повторить пароль
    password_grace_time default --кол-во дней предупреждений о смене парол€
    connect_time 180
    idle_time 30 --кол-во минут просто€
    ;
    
-- 7 представлени€ словар€ Ѕƒ Oracle
-- ѕолучите значени€ всех параметров профил€ PF_XXXCORE. 
select * from dba_profiles where profile = 'C##PF_SAMCORE';
-- ѕолучите значени€ всех параметров профил€ DEFAULT.
select * from dba_profiles where profile = 'DEFAULT';

--8 —оздайте пользовател€ с именем XXXCORE со следующими параметрами:
-- табличное пространство по умолчанию: TS_XXX;
-- табличное пространство дл€ временных данных: TS_XXX_TEMP;
-- профиль безопасности PF_XXXCORE;
-- учетна€ запись разблокирована;
-- срок действи€ парол€ истек. 
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
-- —оздайте табличное пространство с именем XXX_QDATA (10m). 
-- ѕри создании установите его в состо€ние offline. «атем переведите табличное пространство
-- в состо€ние online. ¬ыделите пользователю XXX квоту 2m в пространстве XXX_QDATA. 
--ќт имени пользовател€ XXX создайте таблицу в пространстве XXX_T1.
--¬ таблицу добавьте 3 строки.

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


