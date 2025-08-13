-- Script de inicialización para MySQL
-- Se ejecuta automáticamente al arrancar el contenedor

-- el usuario gseverina es el usuario que se crea en el contenedor
-- Otorgar todos los privilegios al usuario gseverina
GRANT ALL PRIVILEGES ON *.* TO 'gseverina'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
