# Mejores Prácticas de Seguridad para MySQL - Unidad 1

**Base de Datos Aplicada - UCC 2025**

## 📋 Índice

1. [Principios Fundamentales de Seguridad](#principios-fundamentales-de-seguridad)
2. [Gestión de Usuarios](#gestión-de-usuarios)
3. [Gestión de Privilegios](#gestión-de-privilegios)
4. [Configuración del Servidor](#configuración-del-servidor)
5. [Conexiones y Redes](#conexiones-y-redes)
6. [Backup y Recuperación](#backup-y-recuperación)
7. [Monitorización y Auditoría](#monitorización-y-auditoría)
8. [Checklist de Seguridad](#checklist-de-seguridad)

---

## 🔒 Principios Fundamentales de Seguridad

### ✅ **Principio del Mínimo Privilegio**
- **Definición**: Cada usuario debe tener solo los privilegios mínimos necesarios para realizar su trabajo
- **Aplicación**: 
  - Crear usuarios específicos para cada aplicación
  - Asignar solo permisos READ si solo necesita consultar
  - Evitar GRANT ALL PRIVILEGES ON *.*

### ✅ **Defensa en Profundidad**
- **Concepto**: Implementar múltiples capas de seguridad
- **Niveles**:
  1. **Nivel de Red**: Firewalls, VPNs
  2. **Nivel de Aplicación**: Autenticación, autorización
  3. **Nivel de Base de Datos**: Usuarios, privilegios, encriptación
  4. **Nivel de Sistema**: Actualizaciones, parches

### ✅ **Separación de Responsabilidades**
- **Administradores**: Acceso completo al servidor
- **Desarrolladores**: Acceso a bases de datos específicas
- **Usuarios de Aplicación**: Acceso limitado a tablas específicas
- **Usuarios de Reportes**: Solo acceso de lectura

---

## 👥 Gestión de Usuarios

### ✅ **Creación de Usuarios**
```sql
-- Usuario para aplicación web
CREATE USER 'web_app'@'localhost' IDENTIFIED BY 'Password123!';

-- Usuario para reportes
CREATE USER 'report_user'@'localhost' IDENTIFIED BY 'ReportPass456!';

-- Usuario para desarrollo
CREATE USER 'dev_user'@'192.168.1.%' IDENTIFIED BY 'DevPass789!';
```

### ✅ **Políticas de Contraseñas**
- **Longitud mínima**: 12 caracteres
- **Complejidad**: Mayúsculas, minúsculas, números, símbolos
- **Rotación**: Cambiar cada 90 días
- **Historial**: No reutilizar las últimas 5 contraseñas

### ✅ **Restricciones de Conexión**
```sql
-- Solo desde localhost
CREATE USER 'local_user'@'localhost' IDENTIFIED BY 'password';

-- Solo desde red específica
CREATE USER 'network_user'@'192.168.1.%' IDENTIFIED BY 'password';

-- Solo desde dominio específico
CREATE USER 'domain_user'@'%.empresa.com' IDENTIFIED BY 'password';
```

---

## 🔑 Gestión de Privilegios

### ✅ **Privilegios por Nivel**

#### **Nivel Global (¡CUIDADO!)**
```sql
-- Solo para administradores del sistema
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;
```

#### **Nivel de Base de Datos**
```sql
-- Usuario de aplicación
GRANT SELECT, INSERT, UPDATE, DELETE ON mi_app_db.* TO 'web_app'@'localhost';

-- Usuario de reportes
GRANT SELECT ON mi_app_db.* TO 'report_user'@'localhost';
```

#### **Nivel de Tabla**
```sql
-- Usuario con acceso limitado
GRANT SELECT, INSERT ON mi_app_db.usuarios TO 'limited_user'@'localhost';
GRANT SELECT ON mi_app_db.productos TO 'limited_user'@'localhost';
```

#### **Nivel de Columna**
```sql
-- Usuario con acceso a columnas específicas
GRANT SELECT (id, nombre, email) ON mi_app_db.usuarios TO 'public_user'@'localhost';
```

### ✅ **Privilegios Específicos por Rol**

#### **Rol: Administrador de Base de Datos**
```sql
GRANT CREATE, ALTER, DROP, INDEX, CREATE TEMPORARY TABLES, 
      LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, 
      CREATE ROUTINE, ALTER ROUTINE, EVENT, TRIGGER 
ON mi_app_db.* TO 'db_admin'@'localhost';
```

#### **Rol: Desarrollador**
```sql
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, 
      ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, 
      CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, 
      EVENT, TRIGGER 
ON mi_app_db.* TO 'developer'@'localhost';
```

#### **Rol: Usuario de Aplicación**
```sql
GRANT SELECT, INSERT, UPDATE, DELETE ON mi_app_db.* TO 'app_user'@'localhost';
```

#### **Rol: Usuario de Reportes**
```sql
GRANT SELECT ON mi_app_db.* TO 'report_user'@'localhost';
```

### ✅ **Revocación de Privilegios**
```sql
-- Revocar privilegios específicos
REVOKE DELETE ON mi_app_db.usuarios FROM 'app_user'@'localhost';

-- Revocar todos los privilegios
REVOKE ALL PRIVILEGES ON mi_app_db.* FROM 'user'@'localhost';

-- Revocar privilegios de grant
REVOKE GRANT OPTION ON mi_app_db.* FROM 'admin'@'localhost';
```

---

## ⚙️ Configuración del Servidor

### ✅ **Archivo de Configuración (my.cnf/my.ini)**

#### **Sección [mysqld] - Seguridad**
```ini
[mysqld]
# Deshabilitar acceso anónimo
skip-name-resolve

# Puerto no estándar (opcional)
port = 3307

# Bind solo a localhost
bind-address = 127.0.0.1

# Tiempo de timeout de conexiones
wait_timeout = 600
interactive_timeout = 600

# Límite de conexiones
max_connections = 100

# Logs de seguridad
log_error = /var/log/mysql/error.log
general_log = 0
slow_query_log = 1
slow_query_log_file = /var/log/mysql/slow.log
long_query_time = 2

# Configuración SSL
ssl-ca = /etc/mysql/ca-cert.pem
ssl-cert = /etc/mysql/server-cert.pem
ssl-key = /etc/mysql/server-key.pem
require_ssl = 1
```

#### **Sección [mysql] - Cliente**
```ini
[mysql]
# Configuración del cliente
default-character-set = utf8mb4
prompt = "\u@\h [\d]> "
```

### ✅ **Variables de Seguridad Importantes**
```sql
-- Verificar configuración de seguridad
SHOW VARIABLES LIKE 'local_infile';
SHOW VARIABLES LIKE 'secure_file_priv';
SHOW VARIABLES LIKE 'sql_mode';
SHOW VARIABLES LIKE 'max_connections';
SHOW VARIABLES LIKE 'wait_timeout';
```

---

## 🌐 Conexiones y Redes

### ✅ **Configuración de Red**

#### **Firewall y Acceso**
- **Puerto MySQL**: 3306 (cambiar a puerto no estándar en producción)
- **Acceso**: Solo desde IPs autorizadas
- **VPN**: Usar VPN para conexiones remotas

#### **Configuración de Hosts**
```sql
-- Usuario solo desde localhost
CREATE USER 'local_user'@'localhost' IDENTIFIED BY 'password';

-- Usuario desde red específica
CREATE USER 'network_user'@'192.168.1.%' IDENTIFIED BY 'password';

-- Usuario desde cualquier lugar (¡CUIDADO!)
-- CREATE USER 'remote_user'@'%' IDENTIFIED BY 'password';
```

### ✅ **Conexiones SSL/TLS**
```sql
-- Verificar estado SSL
SHOW VARIABLES LIKE 'have_ssl';
SHOW VARIABLES LIKE 'ssl_ca';
SHOW VARIABLES LIKE 'ssl_cert';

-- Forzar conexiones SSL
ALTER USER 'user'@'localhost' REQUIRE SSL;

-- Requerir certificado X.509
ALTER USER 'user'@'localhost' REQUIRE X509;
```

---

## 💾 Backup y Recuperación

### ✅ **Estrategias de Backup**

#### **Backup Completo**
```bash
# Backup completo de base de datos
mysqldump -u root -p --single-transaction --routines --triggers \
  --all-databases > backup_completo_$(date +%Y%m%d_%H%M%S).sql

# Backup de base de datos específica
mysqldump -u root -p --single-transaction --routines --triggers \
  mi_app_db > mi_app_db_backup_$(date +%Y%m%d_%H%M%S).sql
```

#### **Backup Incremental**
```bash
# Habilitar binary log
# En my.cnf: log-bin = mysql-bin

# Backup incremental usando binary log
mysqlbinlog --start-datetime="2025-08-14 10:00:00" \
  --stop-datetime="2025-08-14 18:00:00" \
  mysql-bin.000001 > incremental_backup.sql
```

### ✅ **Seguridad en Backups**
- **Encriptación**: Encriptar archivos de backup
- **Acceso**: Restringir acceso a archivos de backup
- **Almacenamiento**: Separar backups del servidor principal
- **Verificación**: Probar restauraciones regularmente

---

## 📊 Monitorización y Auditoría

### ✅ **Logs de Seguridad**

#### **Error Log**
```ini
# En my.cnf
log_error = /var/log/mysql/error.log
log_error_verbosity = 2
```

#### **General Query Log**
```ini
# En my.cnf (solo para debugging)
general_log = 1
general_log_file = /var/log/mysql/general.log
```

#### **Slow Query Log**
```ini
# En my.cnf
slow_query_log = 1
slow_query_log_file = /var/log/mysql/slow.log
long_query_time = 2
log_queries_not_using_indexes = 1
```

### ✅ **Comandos de Monitorización**
```sql
-- Ver conexiones activas
SHOW PROCESSLIST;

-- Ver usuarios conectados
SELECT User, Host, db, Command, Time, State 
FROM information_schema.processlist;

-- Ver intentos de conexión fallidos
SHOW STATUS LIKE 'Connection_errors%';

-- Ver consultas lentas
SHOW STATUS LIKE 'Slow_queries';
```

---

## ✅ Checklist de Seguridad

### 🔒 **Configuración Inicial**
- [ ] Cambiar contraseña de root por defecto
- [ ] Eliminar usuarios anónimos
- [ ] Eliminar bases de datos de prueba
- [ ] Configurar archivo de configuración seguro
- [ ] Habilitar logs de seguridad

### 👥 **Gestión de Usuarios**
- [ ] Crear usuarios específicos para cada aplicación
- [ ] Implementar políticas de contraseñas fuertes
- [ ] Restringir acceso por IP/host
- [ ] Revisar usuarios regularmente
- [ ] Eliminar usuarios no utilizados

### 🔑 **Gestión de Privilegios**
- [ ] Aplicar principio del mínimo privilegio
- [ ] Revisar privilegios de usuarios regularmente
- [ ] Usar roles específicos por función
- [ ] Evitar privilegios globales innecesarios
- [ ] Documentar asignación de privilegios

### 🌐 **Seguridad de Red**
- [ ] Configurar firewall apropiadamente
- [ ] Usar puertos no estándar (opcional)
- [ ] Habilitar SSL/TLS para conexiones
- [ ] Restringir acceso por IP
- [ ] Usar VPN para conexiones remotas

### 💾 **Backup y Recuperación**
- [ ] Implementar estrategia de backup regular
- [ ] Encriptar archivos de backup
- [ ] Separar backups del servidor principal
- [ ] Probar restauraciones regularmente
- [ ] Documentar procedimientos de recuperación

### 📊 **Monitorización**
- [ ] Habilitar logs de seguridad
- [ ] Monitorear intentos de conexión
- [ ] Revisar logs regularmente
- [ ] Configurar alertas de seguridad
- [ ] Mantener auditoría de cambios

---

## 🚨 Comandos de Emergencia

### ⚠️ **Deshabilitar Usuario Comprometido**
```sql
-- Bloquear usuario temporalmente
ALTER USER 'compromised_user'@'localhost' ACCOUNT LOCK;

-- Cambiar contraseña inmediatamente
ALTER USER 'compromised_user'@'localhost' IDENTIFIED BY 'NewSecurePass123!';

-- Revocar todos los privilegios
REVOKE ALL PRIVILEGES ON *.* FROM 'compromised_user'@'localhost';
```

### 🔍 **Investigación de Incidentes**
```sql
-- Ver conexiones recientes
SELECT * FROM mysql.general_log 
WHERE event_time > DATE_SUB(NOW(), INTERVAL 1 HOUR)
ORDER BY event_time DESC;

-- Ver usuarios con privilegios administrativos
SELECT User, Host, Grant_priv, Super_priv 
FROM mysql.user 
WHERE Grant_priv = 'Y' OR Super_priv = 'Y';
```

---

## 📚 Recursos Adicionales

- **Documentación oficial MySQL**: https://dev.mysql.com/doc/refman/8.0/en/security.html
- **MySQL Security Best Practices**: https://dev.mysql.com/doc/refman/8.0/en/security-best-practices.html
- **OWASP Database Security**: https://owasp.org/www-project-top-ten/
- **CIS MySQL Benchmark**: https://www.cisecurity.org/benchmark/mysql/

---

*Documento creado para la clase de Base de Datos Aplicada - UCC 2025*
