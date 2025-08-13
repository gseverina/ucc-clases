-- =====================================================
-- Comandos de Referencia para MySQL - Clase 02 - Unidad 1
-- Base de Datos Aplicada - UCC 2025
-- =====================================================

-- =====================================================
-- 1. COMANDOS BÁSICOS DE CONEXIÓN Y VERIFICACIÓN
-- =====================================================

-- Verificar versión de MySQL
SELECT VERSION();

-- Verificar usuario actual
SELECT USER(), CURRENT_USER();

-- Verificar base de datos actual
SELECT DATABASE();

-- Verificar configuración del servidor
SHOW VARIABLES LIKE 'sql_mode';
SHOW VARIABLES LIKE 'character_set%';
SHOW VARIABLES LIKE 'collation%';

-- =====================================================
-- 2. GESTIÓN DE BASES DE DATOS
-- =====================================================

-- Mostrar todas las bases de datos
SHOW DATABASES;

-- Crear una nueva base de datos
CREATE DATABASE IF NOT EXISTS mi_base_datos;

-- Usar una base de datos específica
USE mi_base_datos;

-- Eliminar una base de datos (¡CUIDADO!)
-- DROP DATABASE mi_base_datos;

-- =====================================================
-- 3. GESTIÓN DE USUARIOS Y PRIVILEGIOS
-- =====================================================

-- Ver todos los usuarios del sistema
SELECT User, Host FROM mysql.user;

-- Crear un nuevo usuario
CREATE USER 'nuevo_usuario'@'localhost' IDENTIFIED BY 'password_seguro';

-- Ver privilegios de un usuario específico
SHOW GRANTS FOR 'nuevo_usuario'@'localhost';

-- Otorgar privilegios
GRANT SELECT, INSERT, UPDATE, DELETE ON mi_base_datos.* TO 'nuevo_usuario'@'localhost';

-- Otorgar todos los privilegios en una base de datos
GRANT ALL PRIVILEGES ON mi_base_datos.* TO 'nuevo_usuario'@'localhost';

-- Otorgar privilegios globales (¡CUIDADO!)
-- GRANT ALL PRIVILEGES ON *.* TO 'nuevo_usuario'@'localhost';

-- Revocar privilegios
REVOKE DELETE ON mi_base_datos.* FROM 'nuevo_usuario'@'localhost';

-- Aplicar cambios de privilegios
FLUSH PRIVILEGES;

-- Eliminar un usuario
-- DROP USER 'nuevo_usuario'@'localhost';

-- =====================================================
-- 4. EXPLORACIÓN DE BASES DE DATOS DEL SISTEMA
-- =====================================================

-- Explorar base de datos mysql (usuarios y privilegios)
USE mysql;
SHOW TABLES;
DESCRIBE user;
SELECT User, Host, Select_priv, Insert_priv FROM user LIMIT 5;

-- Explorar base de datos information_schema (metadatos)
USE information_schema;
SHOW TABLES;
SELECT TABLE_NAME, TABLE_SCHEMA FROM TABLES WHERE TABLE_SCHEMA = 'mysql' LIMIT 10;

-- Explorar base de datos performance_schema (rendimiento)
USE performance_schema;
SHOW TABLES;
SELECT * FROM threads LIMIT 5;

-- =====================================================
-- 5. MONITORIZACIÓN DEL SERVIDOR
-- =====================================================

-- Ver procesos activos
SHOW PROCESSLIST;

-- Ver estado del servidor
SHOW STATUS LIKE 'Threads_connected';
SHOW STATUS LIKE 'Questions';
SHOW STATUS LIKE 'Uptime';

-- Ver variables globales del servidor
SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_reads';
SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_read_requests';

-- Ver variables de configuración
SHOW VARIABLES LIKE 'max_connections';
SHOW VARIABLES LIKE 'innodb_buffer_pool_size';

-- =====================================================
-- 6. BACKUP Y RESTAURACIÓN
-- =====================================================

-- Crear una tabla de prueba para backup
USE clase_02_unidad1_db;

CREATE TABLE IF NOT EXISTS productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0
);

-- Insertar datos de prueba
INSERT INTO productos (nombre, precio, stock) VALUES
('Laptop', 1200.00, 10),
('Teclado', 75.50, 50),
('Mouse', 25.99, 100);

-- Verificar datos insertados
SELECT * FROM productos;

-- =====================================================
-- 7. COMANDOS DE MANTENIMIENTO
-- =====================================================

-- Analizar tabla
ANALYZE TABLE productos;

-- Optimizar tabla
OPTIMIZE TABLE productos;

-- Verificar tabla
CHECK TABLE productos;

-- Reparar tabla (si es necesario)
-- REPAIR TABLE productos;

-- =====================================================
-- 8. CONFIGURACIÓN DE LOGS
-- =====================================================

-- Verificar estado de logs
SHOW VARIABLES LIKE 'general_log%';
SHOW VARIABLES LIKE 'slow_query_log%';
SHOW VARIABLES LIKE 'log_error';

-- Habilitar log general (en tiempo de ejecución)
-- SET GLOBAL general_log = 'ON';
-- SET GLOBAL general_log_file = '/tmp/mysql.log';

-- Verificar logs habilitados
SHOW VARIABLES LIKE 'general_log';

-- =====================================================
-- 9. CONFIGURACIÓN DE SEGURIDAD
-- =====================================================

-- Verificar conexiones SSL
SHOW VARIABLES LIKE 'have_ssl';
SHOW VARIABLES LIKE 'ssl_ca';
SHOW VARIABLES LIKE 'ssl_cert';

-- Verificar políticas de contraseñas
SHOW VARIABLES LIKE 'validate_password%';

-- =====================================================
-- 10. COMANDOS DE DIAGNÓSTICO
-- =====================================================

-- Ver información del motor InnoDB
SHOW ENGINE INNODB STATUS;

-- Ver información de tablas
SHOW TABLE STATUS;

-- Ver información de índices
SHOW INDEX FROM productos;

-- Ver información de columnas
SHOW COLUMNS FROM productos;

-- =====================================================
-- NOTAS IMPORTANTES
-- =====================================================

/*
1. Siempre usar FLUSH PRIVILEGES después de modificar privilegios
2. Ser cuidadoso con GRANT ALL PRIVILEGES ON *.*
3. Usar DROP DATABASE y DROP USER con precaución
4. Verificar permisos antes de ejecutar comandos administrativos
5. Documentar cambios en la configuración
6. Hacer backups antes de cambios importantes
7. Probar comandos en entorno de desarrollo primero
*/

-- =====================================================
-- COMANDOS PARA EJECUTAR DESDE LÍNEA DE COMANDOS
-- =====================================================

/*
-- Backup de una base de datos
mysqldump -u root -p clase_02_unidad1_db > backup_clase02.sql

-- Restaurar desde backup
mysql -u root -p < backup_clase02.sql

-- Backup de estructura sin datos
mysqldump -u root -p --no-data clase_02_unidad1_db > estructura_clase02.sql

-- Backup de datos sin estructura
mysqldump -u root -p --no-create-info clase_02_unidad1_db > datos_clase02.sql

-- Conectar a MySQL
mysql -u root -p

-- Conectar a una base de datos específica
mysql -u root -p clase_02_unidad1_db

-- Ejecutar script SQL
mysql -u root -p < script.sql

-- Ejecutar comando específico
mysql -u root -p -e "SELECT VERSION();"
*/
