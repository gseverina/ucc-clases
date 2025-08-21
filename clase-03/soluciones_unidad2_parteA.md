# Soluciones - Unidad 2 - Parte A: Creación, Configuración y Gestión de Usuarios y Permisos

**Base de Datos Aplicada - UCC 2025**

---

## **A. Creación, Configuración y Gestión de Usuarios y Permisos**

### **1. Creación y Configuración de Bases de Datos**

#### **1.1 Diferencia entre "base de datos" y "esquema" en MySQL**

**Respuesta:**
En MySQL, **"base de datos"** y **"esquema"** son términos sinónimos. MySQL utiliza ambos términos de manera intercambiable para referirse al mismo concepto: un contenedor lógico que agrupa tablas, vistas, procedimientos almacenados y otros objetos de base de datos.

**Ejemplo:**
```sql
-- Estas dos sentencias son equivalentes:
CREATE DATABASE mi_base_datos;
CREATE SCHEMA mi_base_datos;

-- Y estas también:
USE mi_base_datos;
USE mi_schema;
```

**Nota:** En otros SGBD como PostgreSQL, "esquema" y "base de datos" son conceptos diferentes, pero en MySQL son idénticos.

#### **1.2 Parámetros de configuración importantes en my.cnf/my.ini**

**Respuesta:**
Los siguientes parámetros son fundamentales para el rendimiento y comportamiento de MySQL:

**a) `innodb_buffer_pool_size`**
- **Propósito:** Define el tamaño del buffer pool de InnoDB
- **Impacto:** Afecta directamente el rendimiento de lectura/escritura
- **Valor recomendado:** 70-80% de la RAM disponible
- **Ejemplo:** `innodb_buffer_pool_size = 8G`

**b) `max_connections`**
- **Propósito:** Número máximo de conexiones simultáneas permitidas
- **Impacto:** Determina la capacidad de usuarios concurrentes
- **Valor recomendado:** 100-200 para desarrollo, 500+ para producción
- **Ejemplo:** `max_connections = 200`

**c) `query_cache_size`**
- **Propósito:** Tamaño del caché de consultas (eliminado en MySQL 8.0+)
- **Impacto:** Mejora el rendimiento de consultas repetitivas
- **Valor recomendado:** 64M-256M
- **Ejemplo:** `query_cache_size = 128M`

**d) `innodb_log_file_size`**
- **Propósito:** Tamaño de los archivos de log de transacciones
- **Impacto:** Afecta la durabilidad y rendimiento de transacciones
- **Valor recomendado:** 256M-1G
- **Ejemplo:** `innodb_log_file_size = 512M`

**e) `tmp_table_size` y `max_heap_table_size`**
- **Propósito:** Límites para tablas temporales en memoria
- **Impacto:** Afecta consultas con GROUP BY, ORDER BY, DISTINCT
- **Valor recomendado:** 32M-128M
- **Ejemplo:** `tmp_table_size = 64M`

---

### **2. Gestión de Usuarios y Permisos**

#### **2.1 Diferencia entre GRANT ALL PRIVILEGES y privilegios específicos**

**Respuesta:**

**`GRANT ALL PRIVILEGES` sobre una base de datos:**
- **Concede:** Todos los privilegios disponibles en esa base de datos
- **Incluye:** SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EVENT, TRIGGER
- **Cuándo usar:** Solo para usuarios administradores de la base de datos o en entornos de desarrollo
- **Riesgo:** Otorga demasiados privilegios, violando el principio del mínimo privilegio

**`GRANT SELECT, INSERT, UPDATE, DELETE` sobre una base de datos:**
- **Concede:** Solo los privilegios de manipulación de datos básicos
- **Incluye:** SELECT (leer), INSERT (insertar), UPDATE (modificar), DELETE (eliminar)
- **Cuándo usar:** Para usuarios de aplicación que solo necesitan manipular datos, no modificar estructura
- **Ventaja:** Cumple con el principio del mínimo privilegio, más seguro

**Ejemplo práctico:**
```sql
-- Usuario administrador (desarrollo)
GRANT ALL PRIVILEGES ON tp_aplicadas_db.* TO 'admin_user'@'localhost';

-- Usuario de aplicación (producción)
GRANT SELECT, INSERT, UPDATE, DELETE ON tp_aplicadas_db.* TO 'app_user'@'localhost';

-- Usuario de reportes (solo lectura)
GRANT SELECT ON tp_aplicadas_db.* TO 'report_user'@'localhost';
```

---

### **3. Creación y Configuración Básica**

#### **3.1 Conexión al servidor MySQL**

```bash
# Conectar como usuario root
mysql -u root -p
# Ingresar contraseña cuando se solicite
```

#### **3.2 Creación de la base de datos**

```sql
-- Crear la base de datos
CREATE DATABASE tp_aplicadas_db;

-- Verificar que se creó correctamente
SHOW DATABASES;

-- Seleccionar la base de datos para trabajar
USE tp_aplicadas_db;
```

#### **3.3 Creación de la tabla productos**

```sql
-- Crear la tabla productos
CREATE TABLE productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT DEFAULT 0
);

-- Verificar la estructura de la tabla
DESCRIBE productos;
-- o
SHOW CREATE TABLE productos;
```

#### **3.4 Inserción de datos de ejemplo**

```sql
-- Insertar 3 productos de ejemplo
INSERT INTO productos (nombre, precio, stock) VALUES
    ('Laptop Gamer', 1500.00, 10),
    ('Mouse Inalámbrico', 25.99, 50),
    ('Teclado Mecánico', 89.99, 20);

-- Verificar que se insertaron correctamente
SELECT * FROM productos;
```

---

### **4. Gestión de Usuarios y Permisos**

#### **4.1 Creación del usuario dev_user**

```sql
-- Crear usuario dev_user que solo puede conectarse desde localhost
CREATE USER 'dev_user'@'localhost' IDENTIFIED BY 'DevPass123!';

-- Verificar que el usuario se creó
SELECT User, Host FROM mysql.user WHERE User = 'dev_user';
```

#### **4.2 Asignación de privilegios a dev_user**

```sql
-- Asignar privilegios SELECT, INSERT, UPDATE, DELETE sobre tp_aplicadas_db
GRANT SELECT, INSERT, UPDATE, DELETE ON tp_aplicadas_db.* TO 'dev_user'@'localhost';

-- Aplicar los cambios de privilegios
FLUSH PRIVILEGES;

-- Verificar los privilegios otorgados
SHOW GRANTS FOR 'dev_user'@'localhost';
```

#### **4.3 Creación del usuario report_user**

```sql
-- Crear usuario report_user que solo puede conectarse desde localhost
CREATE USER 'report_user'@'localhost' IDENTIFIED BY 'ReportPass!';

-- Verificar que el usuario se creó
SELECT User, Host FROM mysql.user WHERE User = 'report_user';
```

#### **4.4 Asignación de privilegios a report_user**

```sql
-- Asignar solo privilegio SELECT sobre la tabla productos
GRANT SELECT ON tp_aplicadas_db.productos TO 'report_user'@'localhost';

-- Aplicar los cambios de privilegios
FLUSH PRIVILEGES;

-- Verificar los privilegios otorgados
SHOW GRANTS FOR 'report_user'@'localhost';
```

---

### **5. Prueba de Permisos**

#### **5.1 Pruebas con dev_user**

```bash
# Conectar como dev_user
mysql -u dev_user -p
# Ingresar contraseña: DevPass123!
```

```sql
-- Seleccionar la base de datos
USE tp_aplicadas_db;

-- 1. INSERTAR un nuevo producto (debería funcionar)
INSERT INTO productos (nombre, precio, stock) VALUES 
    ('Monitor 24"', 199.99, 15);

-- 2. ELIMINAR un producto (debería funcionar)
DELETE FROM productos WHERE nombre = 'Monitor 24"';

-- 3. CREAR una nueva tabla (debería funcionar)
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

-- Verificar que se creó la tabla
SHOW TABLES;

-- Limpiar: eliminar la tabla de prueba
DROP TABLE categorias;
```

**Resultados esperados para dev_user:**
- ✅ INSERT: Funciona correctamente
- ✅ DELETE: Funciona correctamente  
- ✅ CREATE TABLE: Funciona correctamente
- ✅ Acceso completo a la base de datos tp_aplicadas_db

#### **5.2 Pruebas con report_user**

```bash
# Conectar como report_user
mysql -u report_user -p
# Ingresar contraseña: ReportPass!
```

```sql
-- Seleccionar la base de datos
USE tp_aplicadas_db;

-- 1. SELECCIONAR datos de productos (debería funcionar)
SELECT * FROM productos;

-- 2. INSERTAR un nuevo producto (debería FALLAR)
INSERT INTO productos (nombre, precio, stock) VALUES 
    ('Auriculares', 79.99, 30);
-- Error: Access denied for user 'report_user'@'localhost' to table 'productos'

-- 3. SELECCIONAR datos de otra tabla (debería FALLAR)
SELECT * FROM mysql.user;
-- Error: Access denied for user 'report_user'@'localhost' to table 'user'

-- 4. Intentar acceder a otra base de datos del sistema
USE mysql;
-- Error: Access denied for user 'report_user'@'localhost' to database 'mysql'
```

**Resultados esperados para report_user:**
- ✅ SELECT en productos: Funciona correctamente
- ❌ INSERT en productos: Falla (permiso denegado)
- ❌ SELECT en mysql.user: Falla (permiso denegado)
- ❌ Acceso a base de datos del sistema: Falla (permiso denegado)

---

## **Resumen de la Parte A**

### **Conceptos Clave Aprendidos:**

1. **Gestión de Bases de Datos:**
   - Creación y configuración de bases de datos
   - Creación de tablas con restricciones apropiadas
   - Inserción y manipulación de datos

2. **Sistema de Usuarios:**
   - Creación de usuarios con restricciones de host
   - Asignación de contraseñas seguras
   - Verificación de usuarios creados

3. **Sistema de Privilegios:**
   - Asignación granular de permisos
   - Diferencia entre privilegios amplios y específicos
   - Aplicación del principio del mínimo privilegio

4. **Seguridad:**
   - Restricción de acceso por host (localhost)
   - Separación de responsabilidades entre usuarios
   - Verificación de permisos efectivos

### **Comandos SQL Utilizados:**

- `CREATE DATABASE`, `USE`, `CREATE TABLE`
- `INSERT`, `SELECT`, `DELETE`
- `CREATE USER`, `GRANT`, `FLUSH PRIVILEGES`
- `SHOW GRANTS`, `SHOW TABLES`, `DESCRIBE`

### **Mejores Prácticas Implementadas:**

1. **Principio del Mínimo Privilegio:** Cada usuario recibe solo los permisos necesarios
2. **Seguridad por Host:** Usuarios restringidos a localhost
3. **Contraseñas Seguras:** Uso de caracteres especiales y longitud adecuada
4. **Verificación:** Confirmación de cada operación realizada
5. **Documentación:** Registro de todos los pasos y resultados

Esta parte establece la base fundamental para la administración de bases de datos MySQL, demostrando la importancia de la gestión adecuada de usuarios y permisos en entornos de producción.
