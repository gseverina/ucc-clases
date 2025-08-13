# Ejercicio 2 - Secciones B, C y D: Seguridad, Monitorización y Conexiones

**Clase 02 - Unidad 1 - Base de Datos Aplicada - UCC 2025**

## 📋 Descripción del Ejercicio

**Secciones B, C y D: Seguridad, Monitorización y Mantenimiento, Pruebas y Conexiones**

Este ejercicio integra las secciones B, C y D de la Unidad 1, cubriendo seguridad en MySQL, monitorización y mantenimiento, y conexión de aplicaciones a bases de datos.

## 🎯 Objetivos de Aprendizaje

### 🔒 **Sección B: Seguridad**
- Comprender la importancia de la seguridad en un SGBD
- Administrar usuarios y privilegios en MySQL
- Diferenciar entre bases de datos del sistema y de usuario
- Explorar las bases de datos del sistema en MySQL

### 📊 **Sección C: Monitorización y Mantenimiento**
- Comprender la importancia de la monitorización y el mantenimiento regular
- Familiarizarse con herramientas y comandos para la monitorización básica
- Realizar tareas básicas de mantenimiento como backups y optimización

### 🔧 **Sección D: Pruebas, Arquitectura y Conexiones**
- Comprender la importancia de las pruebas y ajustes en bases de datos
- Entender la arquitectura cliente-servidor en el contexto de bases de datos
- Conectar una aplicación simple a una base de datos MySQL local
- Discutir desafíos de conexión a bases de datos en la nube

---

## 🔒 **Parte 1: Seguridad en Bases de Datos**

### 🔍 **Preguntas Teóricas**

#### 1.1 Importancia de la Seguridad
- **Justificar por qué es importante implementar medidas de seguridad en un SGBD. Mencionar al menos 3 riesgos de seguridad comunes en bases de datos.**

**Respuesta esperada:**

**Importancia de la seguridad:**
- **Protección de datos confidenciales**: Información personal, financiera o empresarial
- **Cumplimiento normativo**: Leyes de protección de datos (GDPR, CCPA, etc.)
- **Continuidad del negocio**: Evitar interrupciones por incidentes de seguridad
- **Reputación**: Mantener la confianza de clientes y usuarios

**Riesgos de seguridad comunes:**
1. **Inyección SQL**: Ataques que manipulan consultas SQL
2. **Acceso no autorizado**: Usuarios que acceden a datos sin permisos
3. **Elevación de privilegios**: Usuarios que obtienen acceso administrativo
4. **Exposición de datos**: Información sensible visible públicamente
5. **Denegación de servicio**: Ataques que impiden el funcionamiento normal

#### 1.2 Concepto de Privilegios
- **Explicar el concepto de "privilegios" en MySQL.**

**Respuesta esperada:**
Los privilegios en MySQL son permisos que determinan qué acciones puede realizar un usuario en el sistema. Se dividen en:

**Tipos de privilegios:**
- **Privilegios de datos**: SELECT, INSERT, UPDATE, DELETE
- **Privilegios de estructura**: CREATE, ALTER, DROP, INDEX
- **Privilegios administrativos**: GRANT, SUPER, PROCESS, SHUTDOWN
- **Privilegios de rutinas**: EXECUTE, CREATE ROUTINE, ALTER ROUTINE

**Niveles de aplicación:**
- **Global (*.*)**: Aplican a todas las bases de datos
- **Base de datos (db.*)**: Aplican a una base de datos específica
- **Tabla (db.table)**: Aplican a una tabla específica
- **Columna**: Aplican a columnas específicas

#### 1.3 Principio del Mínimo Privilegio
- **¿Por qué es una buena práctica asignar el mínimo privilegio necesario a los usuarios?**

**Respuesta esperada:**
- **Reducir superficie de ataque**: Menos privilegios = menos oportunidades de abuso
- **Limitación de daños**: Si un usuario es comprometido, el impacto es limitado
- **Cumplimiento normativo**: Muchas regulaciones requieren este principio
- **Auditoría y control**: Facilita el seguimiento de acciones de usuarios
- **Separación de responsabilidades**: Cada usuario tiene solo lo que necesita

---

## 🗄️ **Parte 2: Bases de Datos del Sistema vs. Bases de Datos de Usuario**

### 🔍 **Preguntas de Análisis**

#### 2.1 Bases de Datos del Sistema
- **¿Qué son las bases de datos del sistema en MySQL? ¿Cuál es su propósito principal? Nombrar algunas de las bases de datos del sistema.**

**Respuesta esperada:**

**Definición:**
Las bases de datos del sistema son bases de datos especiales que MySQL crea automáticamente para gestionar su funcionamiento interno.

**Propósito principal:**
- **Metadatos**: Almacenar información sobre la estructura del sistema
- **Configuración**: Gestionar configuraciones del servidor
- **Seguridad**: Controlar usuarios, privilegios y acceso
- **Rendimiento**: Monitorear y optimizar el funcionamiento

**Bases de datos del sistema:**
1. **mysql**: Usuarios, privilegios y configuración
2. **information_schema**: Metadatos de todas las bases de datos
3. **performance_schema**: Métricas de rendimiento del servidor
4. **sys**: Vistas y procedimientos para administración

#### 2.2 Bases de Datos de Usuario
- **Definir qué son las bases de datos de usuario.**

**Respuesta esperada:**
Las bases de datos de usuario son bases de datos creadas por los administradores o desarrolladores para almacenar datos específicos de aplicaciones o sistemas. Contienen:

- **Datos de negocio**: Información específica de la aplicación
- **Estructuras personalizadas**: Tablas diseñadas según necesidades específicas
- **Datos de prueba**: Información para desarrollo y testing
- **Datos de respaldo**: Copias de seguridad de otras bases de datos

---

## 👥 **Parte 3: Gestión de Usuarios y Privilegios**

### 🛠️ **Implementación Práctica**

#### 3.1 Creación de Usuarios
- **Conectarse a MySQL utilizando algún cliente (mysql client, Workbench como root.)**

```bash
mysql -u root -p
```

#### 3.2 Usuario admin_db
- **Crear un nuevo usuario llamado admin_db con una contraseña.**

```sql
CREATE USER 'admin_db'@'localhost' IDENTIFIED BY 'AdminPass123!';
```

- **Asignar al usuario creado privilegios para crear, modificar y eliminar bases de datos (CREATE, ALTER, DROP on *.*).**

```sql
GRANT CREATE, ALTER, DROP ON *.* TO 'admin_db'@'localhost';
FLUSH PRIVILEGES;
```

#### 3.3 Usuario app_user
- **Crear otro usuario llamado app_user con una contraseña. Inicialmente, no asignar ningún privilegio a este usuario.**

```sql
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'AppPass456!';
FLUSH PRIVILEGES;
```

#### 3.4 Prueba de Permisos - admin_db
- **Verificar que admin_db puede crear bases de datos:**

```sql
-- Conectarse como admin_db
mysql -u admin_db -p

-- Crear una base de datos de prueba
CREATE DATABASE test_admin_db;

-- Verificar que se creó
SHOW DATABASES;

-- Eliminar la base de datos de prueba
DROP DATABASE test_admin_db;
```

#### 3.5 Prueba de Permisos - app_user
- **Intentar acceder a MySQL Workbench con el usuario app_user y verificar:**

**Verificaciones a realizar:**
- [ ] ¿Qué bases de datos puede ver?
- [ ] ¿Puede crear una nueva base de datos? Explicar.

**Resultado esperado:**
- **Bases de datos visibles**: Solo information_schema y performance_schema
- **Creación de BD**: No puede crear bases de datos (sin privilegios)

#### 3.6 Asignación de Privilegios a app_user
- **Conectarse nuevamente como root.**

```bash
mysql -u root -p
```

- **Otorgar al usuario app_user privilegios para seleccionar, insertar, actualizar y eliminar datos (SELECT, INSERT, UPDATE, DELETE) en cualquier tabla de una base de datos específica (ej: mi_db).**

```sql
GRANT SELECT, INSERT, UPDATE, DELETE ON mi_db.* TO 'app_user'@'localhost';
FLUSH PRIVILEGES;
```

#### 3.7 Verificación de Privilegios
- **Si mi_db no existe, ¿el comando anterior da error?**

**Respuesta esperada:**
No, el comando GRANT no da error si la base de datos no existe. MySQL permite otorgar privilegios sobre bases de datos que aún no han sido creadas.

- **Intente nuevamente acceder a MySQL Workbench con el usuario app_user.**

**Verificaciones:**
- [ ] ¿Puede este usuario crear la base de datos mi_db? ¿Por qué sí o por qué no?

**Resultado esperado:**
No puede crear la base de datos mi_db porque solo tiene privilegios de datos (SELECT, INSERT, UPDATE, DELETE) pero no de estructura (CREATE, ALTER, DROP).

---

## 🔍 **Parte 4: Exploración de Bases de Datos del Sistema**

### 📊 **Exploración Práctica**

#### 4.1 Base de Datos mysql
- **Conectarse a MySQL Workbench como root.**

- **Explorar las bases de datos mysql, information_schema y performance_schema.**

- **En la base de datos mysql, buscar la tabla user. ¿Qué información contiene esta tabla?**

**Comandos de exploración:**
```sql
USE mysql;
SHOW TABLES;
DESCRIBE user;
SELECT User, Host, Select_priv, Insert_priv, Update_priv, Delete_priv 
FROM user LIMIT 5;
```

**Información de la tabla user:**
- **User**: Nombre del usuario
- **Host**: Desde dónde puede conectarse
- **Privilegios**: Permisos específicos (Y/N)
- **Autenticación**: Método de autenticación
- **Restricciones**: Límites de conexión

#### 4.2 Base de Datos information_schema
- **En la base de datos information_schema, explorar la tabla SCHEMATA. ¿Qué información proporciona sobre las bases de datos existentes en su sistema MySQL?**

**Comandos de exploración:**
```sql
USE information_schema;
SHOW TABLES;
SELECT * FROM SCHEMATA LIMIT 10;
```

**Información de SCHEMATA:**
- **CATALOG_NAME**: Catálogo de la base de datos
- **SCHEMA_NAME**: Nombre de la base de datos
- **DEFAULT_CHARACTER_SET_NAME**: Charset por defecto
- **DEFAULT_COLLATION_NAME**: Collation por defecto
- **SQL_PATH**: Ruta SQL (generalmente NULL)

#### 4.3 Base de Datos performance_schema
- **En la base de datos performance_schema, explorar algunas tablas threads y events_statements_summary_by_digest. ¿Qué tipo de información se almacena en estas tablas?**

**Comandos de exploración:**
```sql
USE performance_schema;
SHOW TABLES;
SELECT * FROM threads LIMIT 5;
SELECT * FROM events_statements_summary_by_digest LIMIT 5;
```

**Información de las tablas:**
- **threads**: Información sobre hilos de ejecución del servidor
- **events_statements_summary_by_digest**: Resumen de consultas SQL ejecutadas

---

## 📊 **Sección C: Monitorización y Mantenimiento de MySQL**

### 🎯 **Objetivos:**
- Comprender la importancia de la monitorización y el mantenimiento regular de un SGBD
- Familiarizarse con herramientas y comandos para la monitorización básica de MySQL
- Realizar tareas básicas de mantenimiento como backups y optimización

### 📊 **1. Monitorización:**
- **¿Por qué es fundamental monitorizar el rendimiento y el estado de un servidor MySQL? Mencionar al menos 3 métricas importantes que deberían ser monitoreadas.**

**Respuesta esperada:**
- **Detección temprana de problemas**: Identificar cuellos de botella antes de que afecten a los usuarios
- **Optimización del rendimiento**: Ajustar configuraciones basándose en métricas reales
- **Planificación de capacidad**: Anticipar necesidades de recursos
- **Cumplimiento de SLAs**: Garantizar niveles de servicio acordados

**Métricas importantes:**
1. **Conexiones activas**: Threads_connected, max_connections
2. **Rendimiento de consultas**: Questions, Slow_queries, Com_select
3. **Uso de recursos**: CPU, memoria, espacio en disco
4. **Tiempo de respuesta**: Query response time, connection time

### 🛠️ **2. Mantenimiento:**
- **Explicar la importancia de los backups regulares en un entorno de base de datos. ¿Qué estrategias de backup existen?**

**Respuesta esperada:**
- **Protección contra pérdida de datos**: Recuperación ante fallos de hardware o errores humanos
- **Cumplimiento normativo**: Muchas regulaciones requieren backups regulares
- **Continuidad del negocio**: Minimizar tiempo de inactividad

**Estrategias de backup:**
1. **Backup completo**: Copia completa de la base de datos
2. **Backup incremental**: Solo cambios desde el último backup
3. **Backup diferencial**: Cambios desde el último backup completo
4. **Backup en caliente**: Sin detener el servicio
5. **Backup en frío**: Con el servicio detenido

### 🔧 **3. Monitorización Básica:**
- **Conectarse a la línea de comandos de MySQL como root y ejecutar los siguientes comandos:**

```sql
-- Ver procesos activos
SHOW PROCESSLIST;

-- Ver estado del servidor
SHOW STATUS LIKE 'Threads_connected%';
SHOW STATUS LIKE 'Questions';
SHOW STATUS LIKE 'Uptime';

-- Ver variables globales
SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_reads%';
SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_read_requests%';
```

**Análisis de resultados:**
- **SHOW PROCESSLIST**: Muestra consultas activas y su estado
- **Threads_connected**: Número de conexiones activas
- **Questions**: Total de consultas ejecutadas
- **Uptime**: Tiempo de funcionamiento del servidor

### 💾 **4. Mantenimiento: Backup y Restauración:**
- **Crear una nueva base de datos llamada `db_backup_test`:**

```sql
CREATE DATABASE db_backup_test;
USE db_backup_test;

CREATE TABLE productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    precio DECIMAL(10, 2)
);

INSERT INTO productos (nombre, precio) VALUES 
    ('Laptop', 1200.00), 
    ('Teclado', 75.50),
    ('Mouse', 25.99);
```

- **Realizar backup desde línea de comandos:**

```bash
mysqldump -u root -p db_backup_test > db_backup_test_backup.sql
```

- **Simular desastre y restaurar:**

```sql
-- Eliminar la base de datos
DROP DATABASE db_backup_test;

-- Restaurar desde backup
-- mysql -u root -p < db_backup_test_backup.sql
```

### 🔍 **5. Optimización (Conceptual):**
- **¿Qué es el comando OPTIMIZE TABLE y cuándo es beneficioso?**

**Respuesta esperada:**
`OPTIMIZE TABLE` reorganiza el almacenamiento físico de las tablas para mejorar el rendimiento. Es beneficioso cuando:
- Se han eliminado muchos registros
- Se han actualizado campos de longitud variable
- Se han modificado índices
- Las tablas han crecido significativamente

---

## 🔧 **Sección D: Pruebas, Arquitectura y Conexiones**

### 🎯 **Objetivos:**
- Comprender la importancia de las pruebas y ajustes en bases de datos
- Entender la arquitectura cliente-servidor en el contexto de bases de datos
- Conectar una aplicación simple a una base de datos MySQL local
- Discutir desafíos de conexión a bases de datos en la nube

### 🔍 **1. Pruebas y Ajustes:**
- **¿Por qué son importantes las fases de pruebas y ajustes en el ciclo de vida de una base de datos?**

**Respuesta esperada:**
- **Validación de funcionalidad**: Verificar que el sistema funciona como se espera
- **Identificación de problemas**: Detectar cuellos de botella y errores
- **Optimización**: Ajustar configuraciones para mejor rendimiento
- **Reducción de riesgos**: Minimizar problemas en producción

**Tipos de pruebas:**
1. **Pruebas de funcionalidad**: Verificar operaciones CRUD
2. **Pruebas de rendimiento**: Evaluar velocidad de consultas
3. **Pruebas de carga**: Simular múltiples usuarios
4. **Pruebas de recuperación**: Verificar backups y restauración

### 🌐 **2. Arquitectura Cliente-Servidor:**
- **Explicar el concepto de arquitectura Cliente-Servidor en el contexto de los SGBD.**

**Respuesta esperada:**
La arquitectura cliente-servidor separa las responsabilidades entre:
- **Cliente**: Aplicación que solicita servicios (aplicación web, móvil, etc.)
- **Servidor**: Base de datos que proporciona los servicios solicitados

**Ventajas:**
- **Escalabilidad**: Múltiples clientes pueden conectarse al mismo servidor
- **Mantenimiento**: Actualizaciones centralizadas en el servidor
- **Seguridad**: Control centralizado de acceso y permisos
- **Recursos compartidos**: Múltiples aplicaciones usan la misma infraestructura

### 🔗 **3. Conexión a Bases de Datos:**
- **¿Qué es una cadena de conexión (connection string) y qué información contiene?**

**Respuesta esperada:**
Una cadena de conexión es una cadena de texto que especifica cómo conectarse a una base de datos. Contiene:
- **Servidor**: Hostname o IP del servidor MySQL
- **Puerto**: Puerto de conexión (por defecto 3306)
- **Base de datos**: Nombre de la base de datos
- **Usuario**: Nombre de usuario para autenticación
- **Contraseña**: Contraseña del usuario
- **Parámetros adicionales**: Charset, timezone, SSL, etc.

**Ejemplo:**
```
mysql://usuario:contraseña@localhost:3306/mi_base_datos?charset=utf8mb4
```

### 💻 **4. Conexión de Aplicación a MySQL Local:**
- **Crear una base de datos y tabla de prueba:**

```sql
CREATE DATABASE mi_app_db;
USE mi_app_db;

CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

- **Insertar datos de prueba:**

```sql
INSERT INTO usuarios (nombre, email) VALUES
    ('Juan Pérez', 'juan.perez@email.com'),
    ('María García', 'maria.garcia@email.com'),
    ('Carlos López', 'carlos.lopez@email.com');
```

- **Crear script de conexión (ejemplo en Python):**

```python
import mysql.connector

# Configuración de conexión
config = {
    'host': 'localhost',
    'user': 'app_user',
    'password': 'AppPass456!',
    'database': 'mi_app_db'
}

try:
    # Conectar a la base de datos
    connection = mysql.connector.connect(**config)
    cursor = connection.cursor()
    
    # Consultar usuarios
    cursor.execute("SELECT * FROM usuarios")
    usuarios = cursor.fetchall()
    
    print("Usuarios registrados:")
    for usuario in usuarios:
        print(f"ID: {usuario[0]}, Nombre: {usuario[1]}, Email: {usuario[2]}")
    
    # Cerrar conexión
    cursor.close()
    connection.close()
    
except mysql.connector.Error as error:
    print(f"Error: {error}")
```

### ☁️ **5. Conexión a la Nube:**
- **Investigar servicios de base de datos MySQL gestionados en la nube:**

**Servicios populares:**
1. **Amazon RDS for MySQL**: Servicio gestionado de AWS
2. **Google Cloud SQL for MySQL**: Servicio de Google Cloud
3. **Azure Database for MySQL**: Servicio de Microsoft Azure

**Ventajas vs Desventajas:**

**Ventajas:**
- **Mantenimiento automático**: Parches, backups y actualizaciones automáticas
- **Escalabilidad**: Ajuste automático de recursos según demanda
- **Alta disponibilidad**: Replicación y failover automáticos
- **Seguridad**: Firewalls, encriptación y compliance integrados

**Desventajas:**
- **Costo**: Puede ser más caro a largo plazo
- **Vendor lock-in**: Dependencia del proveedor específico
- **Latencia**: Posible aumento en tiempo de respuesta
- **Limitaciones**: Restricciones en configuraciones personalizadas

---

## 📝 **Entregables del Ejercicio**

### ✅ **Documentación Requerida**
1. **Respuestas teóricas** a todas las preguntas planteadas en las secciones B, C y D
2. **Capturas de pantalla** de la creación de usuarios y asignación de privilegios
3. **Capturas de pantalla** de la exploración de bases de datos del sistema
4. **Capturas de pantalla** de comandos de monitorización y mantenimiento
5. **Capturas de pantalla** de procesos de backup y restauración
6. **Scripts SQL** implementados para cada ejercicio
7. **Script de conexión** (Python u otro lenguaje) funcionando
8. **Reflexión personal** sobre la experiencia de aprendizaje integral

### 🔍 **Verificaciones Técnicas**
- [ ] Usuario admin_db creado con privilegios CREATE, ALTER, DROP
- [ ] Usuario app_user creado sin privilegios iniciales
- [ ] Privilegios de datos asignados a app_user en mi_db
- [ ] Pruebas de permisos realizadas correctamente
- [ ] Exploración de bases de datos del sistema completada
- [ ] Comandos de monitorización ejecutados y analizados
- [ ] Base de datos de prueba creada y poblada con datos
- [ ] Backup y restauración funcionando correctamente
- [ ] Script de conexión de aplicación funcionando
- [ ] Investigación sobre servicios en la nube completada

---

## 💡 **Pistas y Sugerencias**

### 🔍 **Para la Investigación**
- Consultar la documentación oficial de MySQL sobre seguridad
- Revisar ejemplos de configuración de usuarios y privilegios
- Investigar mejores prácticas de seguridad en bases de datos

### 🛠️ **Para la Implementación**
- Usar contraseñas seguras para todos los usuarios
- Probar cada paso antes de continuar
- Documentar cada comando ejecutado
- Verificar que los privilegios se asignen correctamente

### 📊 **Para la Exploración**
- Tomar notas de la estructura de cada base del sistema
- Identificar patrones en la organización de la información
- Relacionar la información encontrada con los conceptos teóricos

---

## 🚨 **Puntos de Atención**

### ⚠️ **Seguridad**
- **Nunca** compartir contraseñas de usuarios
- **Siempre** usar contraseñas seguras
- **Verificar** que los privilegios sean los mínimos necesarios
- **Documentar** todos los cambios realizados

### 🔧 **Técnicos**
- Verificar que FLUSH PRIVILEGES se ejecute después de cambios
- Probar conexiones con cada usuario creado
- Verificar que los privilegios funcionen como se espera
- Hacer backup antes de cambios importantes

### 📚 **Documentación**
- Guardar capturas de pantalla de cada paso
- Documentar cualquier error o problema encontrado
- Anotar las decisiones de configuración tomadas
- Crear un resumen de aprendizajes

---

## 📚 **Recursos Adicionales**

### 🔒 **Seguridad y Usuarios:**
- **MySQL Security Documentation**: https://dev.mysql.com/doc/refman/8.0/en/security.html
- **MySQL User Management**: https://dev.mysql.com/doc/refman/8.0/en/user-management.html
- **MySQL Privileges**: https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html
- **MySQL System Tables**: https://dev.mysql.com/doc/refman/8.0/en/system-schema.html

### 📊 **Monitorización y Mantenimiento:**
- **MySQL Performance Schema**: https://dev.mysql.com/doc/refman/8.0/en/performance-schema.html
- **MySQL Backup and Recovery**: https://dev.mysql.com/doc/refman/8.0/en/backup-methods.html
- **MySQL Optimization**: https://dev.mysql.com/doc/refman/8.0/en/optimization.html

### 🔗 **Conexiones y Aplicaciones:**
- **MySQL Connectors**: https://dev.mysql.com/doc/refman/8.0/en/connectors-apis.html
- **MySQL Python Connector**: https://dev.mysql.com/doc/connector-python/en/
- **MySQL Cloud Services**: https://www.mysql.com/cloud/

---

*Enunciado creado para la clase de Base de Datos Aplicada - UCC 2025*
