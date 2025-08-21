# Soluciones - Unidad 2 - Parte D: Backup, Restauración y Estrategias de Respaldo

**Base de Datos Aplicada - UCC 2025**

---

## **D. Backup, Restauración y Estrategias de Respaldo**

### **1. Backup y Restauración**

#### **1.1 Diferencia entre backup lógico y físico**

**Respuesta:**

**Backup Lógico:**
- **Definición:** Exporta la estructura y datos de la base de datos en formato SQL legible
- **Herramienta principal:** `mysqldump`
- **Contenido:** Sentencias CREATE, INSERT, DROP, etc.
- **Ventajas:**
  - Portable entre diferentes versiones de MySQL
  - Fácil de leer y modificar
  - Restauración selectiva de tablas o bases de datos
  - Comprimible eficientemente
- **Desventajas:**
  - Más lento para bases de datos grandes
  - Requiere más espacio de almacenamiento
  - Puede tener problemas de consistencia en transacciones largas

**Backup Físico:**
- **Definición:** Copia directa de los archivos de datos del sistema de archivos
- **Herramientas principales:** `mysqlbackup`, `xtrabackup`, `mariabackup`
- **Contenido:** Archivos de datos binarios (.ibd, .frm, .MYD, etc.)
- **Ventajas:**
  - Muy rápido para bases de datos grandes
  - Menor uso de espacio de almacenamiento
  - Mantiene la integridad física de los datos
  - Ideal para restauración completa
- **Desventajas:**
  - No portable entre versiones o sistemas operativos
  - Difícil de leer o modificar
  - Restauración más compleja
  - Requiere detener el servidor o usar herramientas especializadas

**Comparación resumida:**
```
| Aspecto           | Backup Lógico | Backup Físico |
|-------------------|---------------|---------------|
| Velocidad         | Lento         | Muy rápido    |
| Espacio           | Mayor         | Menor         |
| Portabilidad      | Alta          | Baja          |
| Flexibilidad      | Alta          | Baja          |
| Consistencia      | Media         | Alta          |
| Herramienta       | mysqldump     | mysqlbackup   |
```

#### **1.2 Tipos de backup por estrategia**

**Respuesta:**

**a) Backup Completo (Full Backup):**
- **Definición:** Copia completa de todos los datos y estructura de la base de datos
- **Contenido:** Todas las tablas, índices, procedimientos, funciones, triggers
- **Frecuencia:** Generalmente semanal o mensual
- **Ventajas:** Restauración completa y rápida, independiente de otros backups
- **Desventajas:** Mayor tiempo de ejecución, mayor uso de espacio
- **Ejemplo:** `mysqldump --all-databases > full_backup_$(date +%Y%m%d).sql`

**b) Backup Incremental:**
- **Definición:** Solo respalda los cambios realizados desde el último backup (completo o incremental)
- **Contenido:** Solo archivos modificados o nuevos desde el último backup
- **Frecuencia:** Diario o cada pocas horas
- **Ventajas:** Muy rápido, mínimo uso de espacio
- **Desventajas:** Restauración compleja, requiere cadena completa de backups
- **Ejemplo:** `mysqlbackup --incremental --incremental-base=dir:backup_20250101`

**c) Backup Diferencial:**
- **Definición:** Respalda todos los cambios realizados desde el último backup completo
- **Contenido:** Diferencia acumulada desde el último backup completo
- **Frecuencia:** Diario o semanal
- **Ventajas:** Balance entre velocidad y espacio, restauración más simple que incremental
- **Desventajas:** Tiempo de ejecución crece con el tiempo
- **Ejemplo:** `mysqldump --single-transaction --routines --triggers db_name > diff_backup_$(date +%Y%m%d).sql`

**Comparación de estrategias:**
```
| Estrategia        | Tiempo Ejecución | Espacio Usado | Complejidad Restauración |
|-------------------|-------------------|---------------|---------------------------|
| Completo          | Largo            | Alto          | Baja                      |
| Incremental       | Muy corto        | Muy bajo      | Alta                      |
| Diferencial       | Medio            | Medio         | Media                     |
```

---

### **2. Estrategias y Plan de Respaldo**

#### **2.1 Componentes clave de un Plan de Respaldo**

**Respuesta:**

**a) Inventario de Activos:**
- **Bases de datos críticas:** Identificar qué bases de datos son esenciales
- **Volumen de datos:** Tamaño actual y tasa de crecimiento
- **Frecuencia de cambios:** Qué tan frecuentemente cambian los datos
- **Dependencias:** Relaciones entre bases de datos y aplicaciones

**b) Objetivos de Recuperación:**
- **RTO (Recovery Time Objective):** Tiempo máximo aceptable para restaurar el servicio
- **RPO (Recovery Point Objective):** Pérdida máxima de datos aceptable
- **SLA (Service Level Agreement):** Acuerdos de nivel de servicio con usuarios
- **Prioridades:** Orden de restauración de bases de datos

**c) Estrategia de Backup:**
- **Tipo de backup:** Completo, incremental, diferencial o híbrido
- **Frecuencia:** Horarios de ejecución de cada tipo de backup
- **Retención:** Tiempo que se mantienen los backups
- **Compresión:** Técnicas de compresión para optimizar espacio

**d) Medios de Almacenamiento:**
- **Local:** Discos locales para backups inmediatos
- **Remoto:** Almacenamiento en la nube o ubicaciones geográficamente separadas
- **Redundancia:** Múltiples copias en diferentes ubicaciones
- **Rotación:** Estrategia de rotación de medios (GFS, Tower of Hanoi)

**e) Procedimientos de Restauración:**
- **Pasos detallados:** Instrucciones paso a paso para cada escenario
- **Roles y responsabilidades:** Quién hace qué durante la restauración
- **Comunicación:** Cómo informar a usuarios y stakeholders
- **Validación:** Cómo verificar que la restauración fue exitosa

**f) Monitoreo y Testing:**
- **Verificación automática:** Scripts para verificar integridad de backups
- **Pruebas de restauración:** Restauraciones regulares en entornos de prueba
- **Alertas:** Notificaciones cuando fallan los backups
- **Métricas:** Medición de tiempo de backup y restauración

#### **2.2 Importancia de las pruebas de restauración**

**Respuesta:**

**¿Por qué son importantes las pruebas de restauración?**

**a) Verificación de Integridad:**
- **Datos completos:** Confirmar que no se perdieron datos durante el backup
- **Estructura correcta:** Verificar que tablas, índices y relaciones se mantienen
- **Funcionalidad:** Asegurar que las aplicaciones funcionan correctamente
- **Consistencia:** Verificar que no hay inconsistencias en los datos

**b) Validación de Procedimientos:**
- **Documentación:** Confirmar que los procedimientos están actualizados
- **Tiempo de restauración:** Medir el tiempo real vs. RTO esperado
- **Recursos necesarios:** Identificar qué recursos se requieren realmente
- **Dependencias:** Descubrir dependencias no documentadas

**c) Capacitación del Equipo:**
- **Práctica:** El equipo adquiere experiencia en restauraciones
- **Identificación de problemas:** Descubrir problemas antes de una crisis real
- **Mejora continua:** Refinar procedimientos basándose en la experiencia
- **Confianza:** El equipo se siente más seguro para manejar incidentes reales

**d) Cumplimiento y Auditoría:**
- **Requisitos regulatorios:** Muchas regulaciones requieren pruebas regulares
- **Auditorías internas:** Demostrar que los procedimientos funcionan
- **Gestión de riesgos:** Identificar y mitigar riesgos en el proceso
- **Continuidad del negocio:** Asegurar que se pueden cumplir los objetivos de recuperación

**Frecuencia recomendada de pruebas:**
- **Mensual:** Para bases de datos críticas
- **Trimestral:** Para bases de datos importantes
- **Semestral:** Para bases de datos estándar
- **Anual:** Para bases de datos de desarrollo/prueba

---

### **3. Backup Completo con mysqldump**

#### **3.1 Ejecución del backup completo**

```bash
# Conectarse al servidor MySQL y crear backup completo
mysqldump -u root -p tp_aplicadas_db > tp_db_full_backup.sql

# Alternativa con más opciones de configuración
mysqldump \
  --user=root \
  --password \
  --single-transaction \
  --routines \
  --triggers \
  --events \
  --add-drop-database \
  --add-drop-table \
  --create-options \
  --complete-insert \
  --extended-insert \
  --lock-tables=false \
  tp_aplicadas_db > tp_db_full_backup_$(date +%Y%m%d_%H%M%S).sql

# Verificar que el archivo se creó correctamente
ls -la tp_db_full_backup*.sql

# Verificar el tamaño del archivo
du -h tp_db_full_backup*.sql
```

**Explicación de opciones importantes:**
- **`--single-transaction`:** Mantiene consistencia sin bloquear la base de datos
- **`--routines`:** Incluye procedimientos almacenados y funciones
- **`--triggers`:** Incluye triggers de las tablas
- **`--events`:** Incluye eventos programados
- **`--add-drop-database`:** Agrega sentencias DROP DATABASE antes de CREATE
- **`--add-drop-table`:** Agrega sentencias DROP TABLE antes de CREATE
- **`--complete-insert`:** Incluye nombres de columnas en INSERT
- **`--extended-insert`:** Agrupa múltiples INSERT en una sola sentencia
- **`--lock-tables=false`:** No bloquea tablas durante el backup

#### **3.2 Verificación del contenido del backup**

```bash
# Ver las primeras líneas del archivo
head -20 tp_db_full_backup.sql

# Ver las últimas líneas del archivo
tail -20 tp_db_full_backup.sql

# Buscar sentencias específicas
grep "CREATE TABLE" tp_db_full_backup.sql
grep "INSERT INTO" tp_db_full_backup.sql | head -5
grep "DROP TABLE" tp_db_full_backup.sql

# Contar sentencias por tipo
grep -c "CREATE TABLE" tp_db_full_backup.sql
grep -c "INSERT INTO" tp_db_full_backup.sql
grep -c "CREATE PROCEDURE" tp_db_full_backup.sql
grep -c "CREATE TRIGGER" tp_db_full_backup.sql

# Verificar estructura del archivo
grep -n "USE \`tp_aplicadas_db\`" tp_db_full_backup.sql
```

**Contenido típico del archivo de backup:**
```sql
-- MySQL dump 10.13  Distrib 8.0.33, for Linux (x86_64)
--
-- Host: localhost    Database: tp_aplicadas_db
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!50503 SET time_zone = '+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `tp_aplicadas_db`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tp_aplicadas_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `tp_aplicadas_db`;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int DEFAULT '0',
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=50001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Laptop Gamer',1500.00,10),(2,'Mouse Inalámbrico',25.99,50),(3,'Teclado Mecánico',89.99,20);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
```

**Tipos de sentencias SQL contenidas:**
1. **Configuración:** Variables de sesión y configuración
2. **Estructura:** CREATE DATABASE, CREATE TABLE, DROP TABLE
3. **Datos:** INSERT INTO con todos los registros
4. **Configuración final:** Restauración de variables de sesión

---

### **4. Simulación de Desastre y Restauración**

#### **4.1 Eliminación de la base de datos**

```sql
-- Conectarse como root
mysql -u root -p

-- Verificar que la base de datos existe
SHOW DATABASES LIKE 'tp_aplicadas_db';

-- Verificar el contenido antes de eliminar
USE tp_aplicadas_db;
SHOW TABLES;
SELECT COUNT(*) as total_productos FROM productos;

-- Eliminar la base de datos (SIMULACIÓN DE DESASTRE)
DROP DATABASE tp_aplicadas_db;

-- Verificar que se eliminó
SHOW DATABASES LIKE 'tp_aplicadas_db';
```

**Resultado esperado:**
```
+------------------------+
| Database (tp_aplicadas_db) |
+------------------------+
| tp_aplicadas_db        |
+------------------------+

mysql> DROP DATABASE tp_aplicadas_db;
Query OK, 1 row affected (0.05 sec)

mysql> SHOW DATABASES LIKE 'tp_aplicadas_db';
Empty set (0.00 sec)
```

#### **4.2 Restauración desde el backup**

```bash
# Salir de MySQL
exit

# Restaurar la base de datos desde el archivo de backup
mysql -u root -p < tp_db_full_backup.sql

# Verificar que la restauración fue exitosa
mysql -u root -p -e "SHOW DATABASES LIKE 'tp_aplicadas_db';"
mysql -u root -p -e "USE tp_aplicadas_db; SHOW TABLES;"
mysql -u root -p -e "USE tp_aplicadas_db; SELECT COUNT(*) as total_productos FROM productos;"
```

**Resultado esperado de la restauración:**
```
mysql> SHOW DATABASES LIKE 'tp_aplicadas_db';
+------------------------+
| Database (tp_aplicadas_db) |
+------------------------+
| tp_aplicadas_db        |
+------------------------+

mysql> USE tp_aplicadas_db;
Database changed

mysql> SHOW TABLES;
+----------------------------+
| Tables_in_tp_aplicadas_db |
+----------------------------+
| productos                 |
+----------------------------+

mysql> SELECT COUNT(*) as total_productos FROM productos;
+------------------+
| total_productos  |
+------------------+
|            50000 |
+------------------+
```

#### **4.3 Verificación completa de la restauración**

```sql
-- Conectarse a la base de datos restaurada
mysql -u root -p

-- Verificar estructura de la tabla
USE tp_aplicadas_db;
DESCRIBE productos;

-- Verificar algunos registros de ejemplo
SELECT * FROM productos LIMIT 5;

-- Verificar que los índices se restauraron
SHOW INDEX FROM productos;

-- Verificar estadísticas de la tabla
SHOW TABLE STATUS LIKE 'productos';

-- Probar algunas consultas para verificar funcionalidad
SELECT COUNT(*) as total FROM productos WHERE precio > 100;
SELECT AVG(precio) as precio_promedio FROM productos;
SELECT nombre, precio FROM productos ORDER BY precio DESC LIMIT 3;
```

**Verificaciones importantes:**
1. **Estructura:** La tabla tiene las mismas columnas y tipos de datos
2. **Datos:** Se restauraron todos los registros (50,000 productos)
3. **Índices:** Los índices se recrearon correctamente
4. **Funcionalidad:** Las consultas funcionan como esperado
5. **Integridad:** No hay errores de datos o referencias rotas

---

### **5. Estrategias de Respaldo (Conceptual)**

#### **5.1 Estrategia para base de datos de producción 24/7**

**Respuesta:**

**Estrategia de respaldo para base de datos crítica de producción:**

**a) Backup Completo Semanal:**
- **Frecuencia:** Cada domingo a las 2:00 AM (bajo tráfico)
- **Tipo:** Backup completo con mysqldump
- **Retención:** 4 semanas (4 archivos)
- **Compresión:** Usar gzip para reducir espacio
- **Verificación:** Validar integridad después de cada backup

**b) Backup Incremental Diario:**
- **Frecuencia:** Cada día a las 3:00 AM
- **Tipo:** Backup incremental usando mysqlbackup o xtrabackup
- **Base:** Incremental desde el último backup completo
- **Retención:** 7 días (7 archivos incrementales)
- **Verificación:** Restaurar en entorno de prueba semanalmente

**c) Binary Log Backup:**
- **Frecuencia:** Cada hora
- **Tipo:** Backup de archivos de binary log
- **Retención:** 7 días
- **Uso:** Point-in-time recovery para RPO bajo

**d) Herramientas y características de MySQL:**
- **mysqldump:** Para backups completos semanales
- **mysqlbackup/xtrabackup:** Para backups incrementales diarios
- **Binary Log:** Para recuperación point-in-time
- **Replicación:** Para alta disponibilidad y backups sin interrupción

**e) Script de automatización:**
```bash
#!/bin/bash
# backup_strategy.sh

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backup/mysql"
RETENTION_DAYS=28

# Backup completo semanal (domingo)
if [ $(date +%u) -eq 7 ]; then
    echo "Iniciando backup completo semanal..."
    mysqldump \
        --user=root \
        --password \
        --single-transaction \
        --routines \
        --triggers \
        --events \
        --all-databases \
        | gzip > $BACKUP_DIR/full_backup_$DATE.sql.gz
    
    # Limpiar backups antiguos
    find $BACKUP_DIR -name "full_backup_*.sql.gz" -mtime +$RETENTION_DAYS -delete
fi

# Backup incremental diario
echo "Iniciando backup incremental diario..."
mysqlbackup \
    --user=root \
    --password \
    --incremental \
    --incremental-base=dir:$BACKUP_DIR/last_full_backup \
    --backup-dir=$BACKUP_DIR/incremental_$DATE

# Limpiar incrementales antiguos
find $BACKUP_DIR -name "incremental_*" -mtime +7 -delete

echo "Backup completado: $DATE"
```

#### **5.2 Diseño de Registro de Respaldo**

**Respuesta:**

**Registro de Respaldo - Información mínima requerida:**

**a) Información de Identificación:**
- **ID único:** Identificador único del backup
- **Fecha y hora:** Cuándo se inició y completó el backup
- **Tipo:** Completo, incremental, diferencial
- **Base de datos:** Qué base de datos se respaldó

**b) Información Técnica:**
- **Herramienta utilizada:** mysqldump, mysqlbackup, xtrabackup
- **Tamaño del backup:** Tamaño del archivo generado
- **Duración:** Tiempo que tomó completar el backup
- **Estado:** Exitoso, fallido, parcial

**c) Información de Almacenamiento:**
- **Ubicación:** Ruta donde se almacenó el backup
- **Medio:** Disco local, cinta, nube, SAN
- **Retención:** Hasta cuándo se mantendrá
- **Compresión:** Si se aplicó compresión y qué tipo

**d) Información de Verificación:**
- **Checksum:** Hash para verificar integridad
- **Verificación:** Si se verificó la integridad del backup
- **Prueba de restauración:** Si se probó en entorno de prueba
- **Notas:** Problemas encontrados o acciones tomadas

**Ejemplo de registro de respaldo:**
```sql
-- Tabla para registrar backups
CREATE TABLE backup_log (
    id INT PRIMARY KEY AUTO_INCREMENT,
    backup_id VARCHAR(50) UNIQUE NOT NULL,
    backup_date DATETIME NOT NULL,
    completion_date DATETIME,
    backup_type ENUM('FULL', 'INCREMENTAL', 'DIFFERENTIAL') NOT NULL,
    database_name VARCHAR(100) NOT NULL,
    tool_used VARCHAR(50) NOT NULL,
    file_size BIGINT,
    duration_seconds INT,
    status ENUM('SUCCESS', 'FAILED', 'PARTIAL') NOT NULL,
    location VARCHAR(500) NOT NULL,
    retention_date DATE NOT NULL,
    compression_type VARCHAR(20),
    checksum VARCHAR(64),
    verified BOOLEAN DEFAULT FALSE,
    tested_restore BOOLEAN DEFAULT FALSE,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índices para consultas eficientes
CREATE INDEX idx_backup_date ON backup_log(backup_date);
CREATE INDEX idx_backup_type ON backup_log(backup_type);
CREATE INDEX idx_status ON backup_log(status);
CREATE INDEX idx_retention_date ON backup_log(retention_date);
```

**Ejemplo de entrada en el registro:**
```sql
INSERT INTO backup_log (
    backup_id, backup_date, completion_date, backup_type, 
    database_name, tool_used, file_size, duration_seconds, 
    status, location, retention_date, compression_type, 
    checksum, verified, tested_restore, notes
) VALUES (
    'BK_20250114_020000', '2025-01-14 02:00:00', '2025-01-14 02:15:30',
    'FULL', 'tp_aplicadas_db', 'mysqldump', 52428800, 930,
    'SUCCESS', '/backup/mysql/full_backup_20250114_020000.sql.gz',
    '2025-02-11', 'gzip', 
    'a1b2c3d4e5f6...', TRUE, TRUE,
    'Backup semanal exitoso. Verificado y probado en entorno de desarrollo.'
);
```

**Consultas útiles para el registro:**
```sql
-- Últimos 10 backups exitosos
SELECT backup_id, backup_date, backup_type, database_name, duration_seconds
FROM backup_log 
WHERE status = 'SUCCESS' 
ORDER BY backup_date DESC 
LIMIT 10;

-- Backups que requieren limpieza (pasada la fecha de retención)
SELECT backup_id, backup_date, backup_type, location
FROM backup_log 
WHERE retention_date < CURDATE() 
AND status = 'SUCCESS';

-- Estadísticas de backups por tipo
SELECT backup_type, 
       COUNT(*) as total_backups,
       AVG(duration_seconds) as avg_duration,
       AVG(file_size) as avg_size
FROM backup_log 
WHERE status = 'SUCCESS'
GROUP BY backup_type;

-- Backups que no han sido verificados
SELECT backup_id, backup_date, backup_type, database_name
FROM backup_log 
WHERE verified = FALSE 
AND status = 'SUCCESS'
ORDER BY backup_date DESC;
```

---

## **Resumen de la Parte D**

### **Conceptos Clave Aprendidos:**

1. **Tipos de Backup:**
   - Diferencia entre backup lógico y físico
   - Estrategias de backup completo, incremental y diferencial
   - Selección de herramientas apropiadas para cada tipo

2. **Planificación de Respaldo:**
   - Componentes esenciales de un plan de respaldo
   - Importancia de las pruebas de restauración
   - Definición de RTO y RPO

3. **Implementación Práctica:**
   - Uso de mysqldump para backups completos
   - Proceso de restauración paso a paso
   - Verificación de integridad post-restauración

4. **Estrategias Avanzadas:**
   - Diseño de estrategias para entornos de producción
   - Registro y monitoreo de backups
   - Automatización de procesos de respaldo

### **Comandos SQL Utilizados:**

- `mysqldump` (línea de comandos)
- `mysql` para restauración
- `CREATE TABLE`, `INSERT` para registro de backups
- `SHOW DATABASES`, `SHOW TABLES` para verificación

### **Herramientas de Backup:**

1. **mysqldump:** Backup lógico completo
2. **mysqlbackup:** Backup físico incremental
3. **xtrabackup:** Alternativa open source para backup físico
4. **Binary Log:** Para recuperación point-in-time

### **Mejores Prácticas Implementadas:**

1. **Estrategia Híbrida:** Combinar backups completos e incrementales
2. **Verificación Sistemática:** Validar integridad de cada backup
3. **Pruebas Regulares:** Restauraciones de prueba en entornos controlados
4. **Documentación Completa:** Registro detallado de todos los backups
5. **Automatización:** Scripts para reducir errores humanos

Esta parte proporciona las habilidades fundamentales para diseñar, implementar y mantener un sistema de respaldo robusto, esencial para la continuidad del negocio y la protección de datos críticos.
