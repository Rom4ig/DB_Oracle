--8 С помощью представлений словаря базы данных определите, все табличные пространства, все  файлы (перманентные и временные), все роли (и выданные им привилегии), 
--профили безопасности, всех пользователей  базы данных 
select * from ALL_USERS;  --все пользователи
select * from DBA_TABLESPACES;  --все таб. простр
select * from DBA_DATA_FILES;   --перман данные 
select * from DBA_TEMP_FILES;  --времен данные
select * from DBA_ROLES; --роли
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS;  --привилег
select * from DBA_PROFILES;  --профил без.

