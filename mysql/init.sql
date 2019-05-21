UPDATE mysql.user SET user.Host ='%' WHERE user.User = 'root';
FLUSH PRIVILEGES;
SET GLOBAL sql_mode = 'NO_ENGINE_SUBSTITUTION';
