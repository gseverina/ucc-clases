# Soluciones - Unidad 2 - Parte C: Auditoría, Registro de Eventos y Seguridad en Base de Datos

**Base de Datos Aplicada - UCC 2025**

---

## **C. Auditoría, Registro de Eventos y Seguridad en Base de Datos**

### **1. Auditoría y Registro de Eventos**

#### **1.1 Diferencia entre tipos de logs en MySQL**

**Respuesta:**

**a) General Query Log:**
- **Propósito:** Registra todas las consultas SQL ejecutadas en el servidor
- **Contenido:** Sentencias SQL completas, timestamps, información del cliente
- **Uso:** Debugging, auditoría completa, análisis de patrones de uso
- **Configuración:** `general_log = 1`, `general_log_file = /path/to/file`
- **Impacto en rendimiento:** Alto (registra cada consulta)

**b) Error Log:**
- **Propósito:** Registra errores, advertencias y eventos críticos del servidor
- **Contenido:** Mensajes de error, stack traces, información de inicio/parada
- **Uso:** Diagnóstico de problemas, monitoreo de salud del servidor
- **Configuración:** `log_error = /path/to/error.log`
- **Impacto en rendimiento:** Mínimo (solo errores)

**c) Slow Query Log:**
- **Propósito:** Registra consultas que exceden un umbral de tiempo
- **Contenido:** Consultas lentas, tiempo de ejecución, información de usuario
- **Uso:** Identificación de consultas problemáticas, optimización
- **Configuración:** `slow_query_log = 1`, `long_query_time = 10`
- **Impacto en rendimiento:** Bajo (solo consultas lentas)

**Comparación resumida:**
```
| Tipo de Log        | Propósito                    | Rendimiento | Uso Principal        |
|--------------------|-------------------------------|-------------|----------------------|
| General Query      | Todas las consultas          | Alto        | Auditoría completa   |
| Error              | Solo errores                 | Mínimo      | Diagnóstico          |
| Slow Query         | Consultas lentas             | Bajo        | Optimización         |
```

#### **1.2 Binary Log (Binlog)**

**Respuesta:**

**¿Qué es el Binary Log?**
El Binary Log (Binlog) es un archivo que registra todas las modificaciones de datos (INSERT, UPDATE, DELETE, CREATE, DROP, ALTER) realizadas en las bases de datos MySQL.

**Características principales:**
- **Formato binario:** No es legible directamente por humanos
- **Registro secuencial:** Mantiene el orden cronológico de las operaciones
- **Configurable:** Se puede habilitar/deshabilitar por base de datos
- **Rotación:** Se pueden configurar archivos de tamaño máximo y retención

**Importancia principal en la administración:**

**a) Replicación:**
- **Master-Slave:** Permite que servidores esclavos repliquen cambios del maestro
- **Sincronización:** Mantiene consistencia entre múltiples instancias
- **Escalabilidad:** Distribuye la carga de lectura entre servidores

**b) Recuperación ante desastres:**
- **Point-in-time recovery:** Restaurar hasta un momento específico
- **Incremental backup:** Solo respaldar cambios desde el último backup
- **Consistencia:** Asegurar integridad de datos durante la recuperación

**c) Auditoría y cumplimiento:**
- **Traza de cambios:** Registrar quién hizo qué y cuándo
- **Cumplimiento normativo:** Cumplir con regulaciones de auditoría
- **Investigación:** Analizar incidentes de seguridad

**Configuración del Binary Log:**
```ini
[mysqld]
# Habilitar binary log
log-bin = mysql-bin

# Formato del log (ROW, STATEMENT, MIXED)
binlog_format = ROW

# Tiempo de expiración (días)
expire_logs_days = 7

# Tamaño máximo del archivo
max_binlog_size = 100M
```

---

### **2. Seguridad en Base de Datos**

#### **2.1 Prácticas de seguridad adicionales**

**Respuesta:**

**a) Encriptación de datos:**
- **Encriptación en reposo:** Proteger datos almacenados en disco
- **Encriptación en tránsito:** Usar SSL/TLS para conexiones cliente-servidor
- **Encriptación de columnas:** Proteger datos sensibles específicos
- **Implementación:** Usar `innodb_encrypt_tables` y certificados SSL

**b) Auditoría y logging:**
- **Audit log:** Registrar todas las acciones administrativas
- **Login tracking:** Monitorear intentos de conexión exitosos y fallidos
- **Query logging:** Registrar consultas sensibles o privilegiadas
- **Herramientas:** MySQL Enterprise Audit, MariaDB Audit Plugin

**c) Configuración de red:**
- **Firewall:** Restringir acceso por IP y puerto
- **Bind address:** Limitar a qué interfaces se puede conectar MySQL
- **Puerto no estándar:** Cambiar del puerto 3306 por defecto
- **VPN:** Usar redes privadas virtuales para acceso remoto

**d) Políticas de contraseñas:**
- **Complejidad:** Requerir mayúsculas, minúsculas, números y símbolos
- **Expiración:** Forzar cambio periódico de contraseñas
- **Historial:** Evitar reutilización de contraseñas recientes
- **Implementación:** Usar `validate_password` plugin

**e) Actualizaciones y parches:**
- **Versiones:** Mantener MySQL actualizado con la última versión estable
- **Parches de seguridad:** Aplicar actualizaciones de seguridad inmediatamente
- **Vulnerabilidades:** Monitorear reportes de seguridad de MySQL
- **Testing:** Probar actualizaciones en entornos de desarrollo

#### **2.2 Inyección SQL y prevención**

**Respuesta:**

**¿Qué es la inyección SQL?**
La inyección SQL es una técnica de ataque que permite a un atacante ejecutar código SQL malicioso en una base de datos, aprovechando vulnerabilidades en la validación de entrada de aplicaciones.

**Mecanismo de ataque:**
```sql
-- Entrada maliciosa del usuario:
'; DROP TABLE usuarios; --

-- Consulta vulnerable:
SELECT * FROM usuarios WHERE id = '$input_usuario'

-- Resultado después de la sustitución:
SELECT * FROM usuarios WHERE id = ''; DROP TABLE usuarios; --'
```

**Tipos de inyección SQL:**
1. **Inyección por unión:** `' UNION SELECT * FROM passwords --`
2. **Inyección por error:** `' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(VERSION(),FLOOR(RAND(0)*2))x FROM INFORMATION_SCHEMA.TABLES GROUP BY x)a) --`
3. **Inyección ciega:** `' AND SUBSTRING(password,1,1)='a' --`
4. **Inyección por tiempo:** `' AND IF(SUBSTRING(password,1,1)='a',SLEEP(5),0) --`

**Prevención en el desarrollo de aplicaciones:**

**a) Prepared Statements (Recomendado):**
```php
// PHP con PDO
$stmt = $pdo->prepare("SELECT * FROM usuarios WHERE id = ?");
$stmt->execute([$id_usuario]);

// PHP con MySQLi
$stmt = $mysqli->prepare("SELECT * FROM usuarios WHERE id = ?");
$stmt->bind_param("i", $id_usuario);
$stmt->execute();
```

**b) Validación y sanitización de entrada:**
```php
// Validar tipo de dato
if (!is_numeric($id_usuario)) {
    die("ID inválido");
}

// Sanitizar entrada
$nombre_usuario = filter_var($_POST['nombre'], FILTER_SANITIZE_STRING);
```

**c) Principio del mínimo privilegio:**
```sql
-- Usuario de aplicación con privilegios limitados
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'AppPass123!';
GRANT SELECT, INSERT, UPDATE, DELETE ON app_db.* TO 'app_user'@'localhost';

-- NO dar privilegios administrativos
-- NO dar acceso a bases de datos del sistema
```

**d) Encriptación de datos sensibles:**
```sql
-- Usar funciones de hash para contraseñas
INSERT INTO usuarios (username, password) 
VALUES ('admin', SHA2('mi_contraseña', 256));

-- Encriptar datos sensibles
INSERT INTO datos_personales (dni, nombre) 
VALUES (AES_ENCRYPT('12345678', 'clave_secreta'), 'Juan Pérez');
```

---

### **3. Configuración y Exploración de Logs**

#### **3.1 Configuración del archivo my.cnf/my.ini**

**Ubicación del archivo de configuración:**
```bash
# Linux/macOS
/etc/mysql/my.cnf
/etc/my.cnf
~/.my.cnf

# Windows
C:\ProgramData\MySQL\MySQL Server 8.0\my.ini
C:\Program Files\MySQL\MySQL Server 8.0\my.ini
```

**Configuración para habilitar logs:**
```ini
[mysqld]
# General Query Log
general_log = 1
general_log_file = /var/log/mysql/mysql.log

# Error Log
log_error = /var/log/mysql/error.log

# Slow Query Log
slow_query_log = 1
slow_query_log_file = /var/log/mysql/slow.log
long_query_time = 2

# Binary Log
log-bin = mysql-bin
binlog_format = ROW
expire_logs_days = 7

# Configuración de seguridad
bind-address = 127.0.0.1
port = 3306
```

#### **3.2 Habilitación en tiempo de ejecución**

```sql
-- Habilitar General Query Log
SET GLOBAL general_log = 'ON';
SET GLOBAL general_log_file = '/var/log/mysql/mysql.log';

-- Verificar estado
SHOW VARIABLES LIKE 'general_log%';

-- Habilitar Slow Query Log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 2;

-- Verificar estado
SHOW VARIABLES LIKE 'slow_query_log%';
```

#### **3.3 Diferencia entre métodos de configuración**

**Configuración por archivo:**
- **Ventajas:** Persistente, se mantiene después de reinicios
- **Desventajas:** Requiere reiniciar el servicio MySQL
- **Uso:** Configuración permanente, entornos de producción

**Configuración en tiempo de ejecución:**
- **Ventajas:** Cambios inmediatos, no requiere reinicio
- **Desventajas:** Se pierde después de reiniciar el servicio
- **Uso:** Pruebas temporales, debugging, entornos de desarrollo

#### **3.4 Reinicio del servicio MySQL**

```bash
# Linux (systemd)
sudo systemctl restart mysql

# Linux (init.d)
sudo service mysql restart

# macOS
sudo /usr/local/mysql/support-files/mysql.server restart

# Windows
net stop mysql
net start mysql
```

#### **3.5 Exploración de logs habilitados**

```sql
-- Realizar algunas operaciones para generar logs
USE tp_aplicadas_db;

-- Operaciones que se registrarán en General Query Log
SELECT * FROM productos LIMIT 5;
INSERT INTO productos (nombre, precio, stock) VALUES ('Test Product', 99.99, 1);
UPDATE productos SET stock = stock + 1 WHERE nombre = 'Test Product';
DELETE FROM productos WHERE nombre = 'Test Product';

-- Consulta lenta para Slow Query Log
SELECT SLEEP(3);
SELECT * FROM productos WHERE nombre LIKE '%Producto%';
```

#### **3.6 Verificación de archivos de log**

```bash
# Verificar General Query Log
sudo tail -f /var/log/mysql/mysql.log

# Verificar Error Log
sudo tail -f /var/log/mysql/error.log

# Verificar Slow Query Log
sudo tail -f /var/log/mysql/slow.log

# Buscar entradas específicas
sudo grep "INSERT INTO productos" /var/log/mysql/mysql.log
sudo grep "SELECT SLEEP" /var/log/mysql/slow.log
```

**Ejemplo de contenido del General Query Log:**
```
2025-01-14T10:30:15.123456Z         1 Query     SELECT * FROM productos LIMIT 5
2025-01-14T10:30:16.234567Z         1 Query     INSERT INTO productos (nombre, precio, stock) VALUES ('Test Product', 99.99, 1)
2025-01-14T10:30:17.345678Z         1 Query     UPDATE productos SET stock = stock + 1 WHERE nombre = 'Test Product'
2025-01-14T10:30:18.456789Z         1 Query     DELETE FROM productos WHERE nombre = 'Test Product'
```

#### **3.7 Deshabilitación de logs**

```sql
-- Deshabilitar General Query Log
SET GLOBAL general_log = 'OFF';

-- Verificar estado
SHOW VARIABLES LIKE 'general_log%';

-- Deshabilitar Slow Query Log
SET GLOBAL slow_query_log = 'OFF';

-- Verificar estado
SHOW VARIABLES LIKE 'slow_query_log%';
```

#### **3.8 Verificación de ubicación de logs del sistema**

```sql
-- Verificar ubicación del Error Log
SHOW VARIABLES LIKE 'log_error';

-- Verificar ubicación del Binary Log
SHOW VARIABLES LIKE 'log_bin_basename';

-- Verificar archivos de Binary Log
SHOW BINARY LOGS;

-- Verificar configuración de logs
SHOW VARIABLES LIKE '%log%';
```

---

### **4. Seguridad Avanzada (Conceptual)**

#### **4.1 Configuración de SSL/TLS para MySQL**

**¿Por qué es importante SSL/TLS?**
- **Confidencialidad:** Encripta la comunicación entre cliente y servidor
- **Integridad:** Previene manipulación de datos en tránsito
- **Autenticación:** Verifica la identidad del servidor
- **Cumplimiento:** Requerido por muchas regulaciones de seguridad

**Configuración del servidor:**
```ini
[mysqld]
# Habilitar SSL
ssl-ca = /path/to/ca-cert.pem
ssl-cert = /path/to/server-cert.pem
ssl-key = /path/to/server-key.pem

# Forzar conexiones SSL
require_secure_transport = ON
```

**Configuración del cliente:**
```bash
# Conectar con SSL
mysql -h localhost -u root -p --ssl-mode=REQUIRED

# Verificar conexión SSL
mysql> \s
mysql> SHOW STATUS LIKE 'Ssl_cipher';
```

#### **4.2 Política de contraseñas robusta**

**Implementación de política de contraseñas:**

**a) Plugin validate_password:**
```sql
-- Instalar plugin
INSTALL PLUGIN validate_password SONAME 'validate_password.so';

-- Configurar política
SET GLOBAL validate_password.policy = MEDIUM;
SET GLOBAL validate_password.length = 12;
SET GLOBAL validate_password.mixed_case_count = 1;
SET GLOBAL validate_password.number_count = 1;
SET GLOBAL validate_password.special_char_count = 1;

-- Verificar configuración
SHOW VARIABLES LIKE 'validate_password%';
```

**b) Política personalizada:**
```sql
-- Crear función para validar contraseñas
DELIMITER //
CREATE FUNCTION validate_password_strength(password VARCHAR(255))
RETURNS BOOLEAN
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE has_upper BOOLEAN DEFAULT FALSE;
    DECLARE has_lower BOOLEAN DEFAULT FALSE;
    DECLARE has_digit BOOLEAN DEFAULT FALSE;
    DECLARE has_special BOOLEAN DEFAULT FALSE;
    DECLARE i INT DEFAULT 1;
    DECLARE char_at_pos CHAR(1);
    
    -- Verificar longitud mínima
    IF LENGTH(password) < 12 THEN
        RETURN FALSE;
    END IF;
    
    -- Verificar caracteres
    WHILE i <= LENGTH(password) DO
        SET char_at_pos = SUBSTRING(password, i, 1);
        
        IF char_at_pos REGEXP '[A-Z]' THEN
            SET has_upper = TRUE;
        ELSEIF char_at_pos REGEXP '[a-z]' THEN
            SET has_lower = TRUE;
        ELSEIF char_at_pos REGEXP '[0-9]' THEN
            SET has_digit = TRUE;
        ELSEIF char_at_pos REGEXP '[!@#$%^&*(),.?":{}|<>]' THEN
            SET has_special = TRUE;
        END IF;
        
        SET i = i + 1;
    END WHILE;
    
    -- Verificar que cumple todos los criterios
    RETURN has_upper AND has_lower AND has_digit AND has_special;
END //
DELIMITER ;

-- Usar la función
SELECT validate_password_strength('MiContraseña123!');
```

**c) Política de expiración:**
```sql
-- Configurar expiración de contraseñas
ALTER USER 'dev_user'@'localhost' PASSWORD EXPIRE INTERVAL 90 DAY;

-- Verificar usuarios con contraseñas expiradas
SELECT User, Host, password_expired, password_lifetime 
FROM mysql.user 
WHERE password_expired = 'Y' OR password_lifetime IS NOT NULL;
```

---

## **Resumen de la Parte C**

### **Conceptos Clave Aprendidos:**

1. **Sistema de Logs:**
   - Diferencia entre General Query, Error y Slow Query Logs
   - Configuración y habilitación de logs
   - Interpretación de contenido de logs

2. **Binary Log:**
   - Propósito y configuración del binlog
   - Importancia para replicación y recuperación
   - Configuración de retención y formato

3. **Seguridad Avanzada:**
   - Prácticas de seguridad más allá de usuarios y privilegios
   - Prevención de inyección SQL
   - Configuración de SSL/TLS

4. **Políticas de Contraseñas:**
   - Implementación de políticas robustas
   - Plugin validate_password
   - Funciones personalizadas de validación

### **Comandos SQL Utilizados:**

- `SET GLOBAL`, `SHOW VARIABLES`, `SHOW STATUS`
- `INSTALL PLUGIN`, `CREATE FUNCTION`
- `ALTER USER`, `PASSWORD EXPIRE`

### **Archivos de Configuración:**

- `my.cnf` / `my.ini`
- Archivos de log del sistema
- Certificados SSL/TLS

### **Mejores Prácticas Implementadas:**

1. **Logging Estratégico:** Habilitar solo los logs necesarios
2. **Seguridad por Capas:** Múltiples niveles de protección
3. **Validación de Entrada:** Prevención de ataques de inyección
4. **Encriptación:** Protección de datos en tránsito y reposo
5. **Políticas de Contraseñas:** Cumplimiento de estándares de seguridad

Esta parte establece las bases para implementar un sistema de auditoría completo y medidas de seguridad avanzadas en MySQL, esenciales para entornos de producción críticos.
