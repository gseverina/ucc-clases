# Soluciones - Unidad 2 - Parte B: Monitorización de Rendimiento y Mantenimiento de Base de Datos

**Base de Datos Aplicada - UCC 2025**

---

## **B. Monitorización de Rendimiento y Mantenimiento de Base de Datos**

### **1. Monitorización de Rendimiento**

#### **1.1 Métricas de rendimiento importantes en MySQL**

**Respuesta:**
Las siguientes métricas son fundamentales para el monitoreo del rendimiento de MySQL:

**a) `Threads_connected`**
- **Qué mide:** Número de conexiones activas al servidor
- **Por qué es relevante:** Indica la carga de usuarios concurrentes y puede revelar problemas de conexiones huérfanas
- **Valor normal:** Depende de la aplicación, pero debe ser menor que `max_connections`
- **Alerta:** Si se acerca al límite de `max_connections`

**b) `Questions`**
- **Qué mide:** Número total de consultas ejecutadas desde el inicio del servidor
- **Por qué es relevante:** Indica la actividad general de la base de datos
- **Monitoreo:** Se puede calcular la tasa de consultas por segundo comparando valores en diferentes momentos

**c) `Slow_queries`**
- **Qué mide:** Número de consultas que exceden el umbral de `long_query_time`
- **Por qué es relevante:** Identifica consultas problemáticas que afectan el rendimiento
- **Configuración:** `long_query_time` (por defecto 10 segundos)

**d) `Innodb_buffer_pool_reads` vs `Innodb_buffer_pool_read_requests`**
- **Qué miden:** 
  - `read_requests`: Total de lecturas solicitadas
  - `read_reads`: Lecturas que requirieron acceso al disco
- **Por qué es relevante:** La relación entre ambos indica la eficiencia del buffer pool
- **Cálculo:** Hit ratio = (read_requests - read_reads) / read_requests
- **Objetivo:** Hit ratio > 95%

**e) `Uptime`**
- **Qué mide:** Tiempo que el servidor ha estado funcionando
- **Por qué es relevante:** Indica estabilidad del servidor y tiempo desde el último reinicio

**f) `Bytes_received` y `Bytes_sent`**
- **Qué miden:** Volumen de datos transferidos entre cliente y servidor
- **Por qué es relevante:** Ayuda a identificar patrones de uso y optimizar el ancho de banda

#### **1.2 EXPLAIN de una consulta SQL**

**Respuesta:**
`EXPLAIN` es un comando que muestra el plan de ejecución de una consulta SQL, revelando cómo MySQL procesa internamente la consulta.

**Propósito:**
- **Análisis de rendimiento:** Identifica cuellos de botella en la ejecución
- **Optimización:** Ayuda a determinar si se están usando índices correctamente
- **Debugging:** Revela problemas en la estructura de la consulta

**Información que proporciona:**
- **`id`:** Orden de ejecución de las subconsultas
- **`select_type`:** Tipo de consulta (SIMPLE, PRIMARY, SUBQUERY, etc.)
- **`table`:** Tabla o alias que se está procesando
- **`type`:** Tipo de acceso a la tabla (ALL, index, range, ref, eq_ref, const)
- **`possible_keys`:** Índices que MySQL considera usar
- **`key`:** Índice que MySQL realmente usa
- **`key_len`:** Longitud del índice usado
- **`ref`:** Columnas o constantes comparadas con el índice
- **`rows`:** Número estimado de filas que MySQL debe examinar
- **`Extra`:** Información adicional sobre la ejecución

**Ejemplo de uso:**
```sql
-- Consulta a analizar
EXPLAIN SELECT * FROM productos WHERE nombre LIKE 'Laptop%';

-- Resultado típico:
-- +----+-------------+-----------+-------+---------------+------+---------+------+------+-------------+
-- | id | select_type | table     | type  | possible_keys | key  | key_len | ref  | rows | Extra       |
-- +----+-------------+-----------+-------+---------------+------+---------+------+------+-------------+
-- |  1 | SIMPLE      | productos | ALL   | NULL          | NULL | NULL    | NULL |    3 | Using where |
-- +----+-------------+-----------+-------+---------------+------+---------+------+------+-------------+
```

**Interpretación:**
- `type: ALL` indica que se está haciendo un escaneo completo de la tabla (ineficiente)
- `rows: 3` muestra que MySQL estima examinar 3 filas
- `Extra: Using where` indica que se aplica un filtro WHERE

---

### **2. Mantenimiento de Base de Datos**

#### **2.1 Importancia del mantenimiento regular**

**Respuesta:**
El mantenimiento regular es crucial por las siguientes razones:

**a) Rendimiento:**
- **Fragmentación:** Las tablas se fragmentan con el tiempo, reduciendo la eficiencia de lectura
- **Estadísticas desactualizadas:** MySQL usa estadísticas para optimizar consultas
- **Índices:** Los índices pueden volverse ineficientes con el uso

**b) Integridad de datos:**
- **Verificación:** Detectar y corregir inconsistencias en los datos
- **Corrupción:** Identificar problemas de corrupción tempranamente
- **Backup:** Asegurar que los backups sean consistentes

**c) Espacio en disco:**
- **Recuperación:** Liberar espacio no utilizado
- **Optimización:** Reorganizar datos para mejor acceso
- **Crecimiento:** Monitorear el crecimiento de las bases de datos

**d) Estabilidad del sistema:**
- **Prevención:** Evitar problemas antes de que afecten la producción
- **Monitoreo:** Identificar tendencias de degradación del rendimiento
- **Planificación:** Programar mantenimiento durante ventanas de bajo tráfico

#### **2.2 Diferencia entre OPTIMIZE TABLE y ANALYZE TABLE**

**Respuesta:**

**`OPTIMIZE TABLE`:**
- **Propósito:** Reorganiza físicamente los datos de la tabla para mejorar el rendimiento
- **Acciones realizadas:**
  - Elimina espacios vacíos y fragmentación
  - Reorganiza páginas de datos
  - Actualiza estadísticas de la tabla
  - Reconstruye índices si es necesario
- **Cuándo usar:**
  - Después de muchas operaciones DELETE o UPDATE
  - Cuando hay mucha fragmentación
  - Para tablas que han crecido significativamente
  - Después de cambios estructurales importantes
- **Tiempo:** Puede tomar mucho tiempo en tablas grandes
- **Bloqueo:** Bloquea la tabla durante la operación

**`ANALYZE TABLE`:**
- **Propósito:** Actualiza las estadísticas de la tabla para el optimizador de consultas
- **Acciones realizadas:**
  - Recalcula estadísticas de distribución de valores
  - Actualiza información sobre cardinalidad de columnas
  - Mejora la precisión del plan de ejecución
- **Cuándo usar:**
  - Después de cambios significativos en los datos
  - Cuando las consultas no usan los índices esperados
  - Para mejorar la precisión del EXPLAIN
  - Como parte del mantenimiento regular
- **Tiempo:** Generalmente rápido
- **Bloqueo:** Mínimo, solo lectura

**Ejemplo práctico:**
```sql
-- Después de muchas operaciones DELETE
OPTIMIZE TABLE productos;

-- Después de cambios en los datos
ANALYZE TABLE productos;

-- Verificar el estado de la tabla
SHOW TABLE STATUS LIKE 'productos';
```

---

### **3. Monitorización Básica**

#### **3.1 Conexión y comandos básicos de monitorización**

```sql
-- Conectarse como root
mysql -u root -p

-- Seleccionar la base de datos
USE tp_aplicadas_db;

-- 1. SHOW PROCESSLIST - Ver conexiones activas
SHOW PROCESSLIST;

-- 2. Verificar conexiones activas
SHOW STATUS LIKE 'Threads_connected';

-- 3. Verificar total de consultas
SHOW STATUS LIKE 'Questions';

-- 4. Verificar métricas del buffer pool de InnoDB
SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_reads';
SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_read_requests';

-- 5. Calcular hit ratio del buffer pool
SELECT 
    VARIABLE_VALUE as read_requests
FROM performance_schema.global_status 
WHERE VARIABLE_NAME = 'Innodb_buffer_pool_read_requests';

SELECT 
    VARIABLE_VALUE as read_reads
FROM performance_schema.global_status 
WHERE VARIABLE_NAME = 'Innodb_buffer_pool_reads';
```

#### **3.2 Interpretación de resultados**

**SHOW PROCESSLIST:**
```
+----+------+-----------+------+---------+------+-------+------------------+
| Id | User | Host      | db   | Command | Time | State | Info             |
+----+------+-----------+------+---------+------+-------+------------------+
|  1 | root | localhost | NULL | Query   |    0 | NULL  | SHOW PROCESSLIST |
|  2 | dev  | localhost | tp   | Sleep   |   15 |       | NULL             |
+----+------+-----------+------+---------+------+-------+------------------+
```

**Interpretación:**
- **Id:** Identificador único de la conexión
- **User:** Usuario que estableció la conexión
- **Host:** Origen de la conexión
- **db:** Base de datos seleccionada
- **Command:** Tipo de comando (Query, Sleep, Connect, etc.)
- **Time:** Tiempo en segundos desde el último comando
- **State:** Estado actual de la conexión
- **Info:** Último comando ejecutado

**Métricas de conexiones:**
```sql
-- Verificar límites de conexiones
SHOW VARIABLES LIKE 'max_connections';

-- Verificar conexiones máximas alcanzadas
SHOW STATUS LIKE 'Max_used_connections';

-- Calcular porcentaje de uso
SELECT 
    (Max_used_connections / max_connections) * 100 as connection_usage_percent
FROM (
    SELECT VARIABLE_VALUE as max_connections
    FROM performance_schema.global_variables 
    WHERE VARIABLE_NAME = 'max_connections'
) vars,
(
    SELECT VARIABLE_VALUE as Max_used_connections
    FROM performance_schema.global_status 
    WHERE VARIABLE_NAME = 'Max_used_connections'
) stats;
```

---

### **4. Análisis y Optimización de Consultas**

#### **4.1 Generación de datos de prueba**

```sql
-- Crear procedimiento para generar datos de prueba
DELIMITER //
CREATE PROCEDURE GenerarDatosPrueba(IN cantidad INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE nombre_producto VARCHAR(100);
    DECLARE precio_producto DECIMAL(10,2);
    DECLARE stock_producto INT;
    
    WHILE i <= cantidad DO
        SET nombre_producto = CONCAT('Producto_', LPAD(i, 5, '0'));
        SET precio_producto = ROUND(RAND() * 1000 + 10, 2);
        SET stock_producto = FLOOR(RAND() * 100);
        
        INSERT INTO productos (nombre, precio, stock) 
        VALUES (nombre_producto, precio_producto, stock_producto);
        
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

-- Generar 50,000 registros de prueba
CALL GenerarDatosPrueba(50000);

-- Verificar la cantidad de registros
SELECT COUNT(*) as total_productos FROM productos;

-- Limpiar el procedimiento
DROP PROCEDURE GenerarDatosPrueba;
```

#### **4.2 Análisis de consulta sin índice**

```sql
-- Consulta a analizar
SELECT * FROM productos WHERE nombre LIKE 'Producto%';

-- Analizar con EXPLAIN
EXPLAIN SELECT * FROM productos WHERE nombre LIKE 'Producto%';

-- Resultado esperado (sin índice):
-- +----+-------------+-----------+------+---------------+------+---------+------+--------+-------------+
-- | id | select_type | table     | type | possible_keys | key  | key_len | ref  | rows   | Extra       |
-- +----+-------------+-----------+------+---------------+------+---------+------+--------+-------------+
-- |  1 | SIMPLE      | productos | ALL  | NULL          | NULL | NULL    | NULL | 50000  | Using where |
-- +----+-------------+-----------+------+---------------+------+---------+------+--------+-------------+
```

**Interpretación:**
- `type: ALL` = Escaneo completo de la tabla (50,000 filas)
- `rows: 50000` = MySQL estima examinar todas las filas
- `Extra: Using where` = Se aplica filtro WHERE

#### **4.3 Creación de índice y análisis posterior**

```sql
-- Crear índice en la columna nombre
CREATE INDEX idx_nombre ON productos (nombre);

-- Verificar que el índice se creó
SHOW INDEX FROM productos;

-- Analizar la misma consulta con EXPLAIN
EXPLAIN SELECT * FROM productos WHERE nombre LIKE 'Producto%';

-- Resultado esperado (con índice):
-- +----+-------------+-----------+-------+---------------+-----------+---------+------+------+-------------+
-- | id | select_type | table     | type  | possible_keys | key       | key_len | ref  | rows | Extra       |
-- +----+-------------+-----------+-------+---------------+-----------+---------+------+------+-------------+
-- |  1 | SIMPLE      | productos | range | idx_nombre    | idx_nombre | 103     | NULL | 5000 | Using where |
-- +----+-------------+-----------+-------+---------------+-----------+---------+------+------+-------------+
```

**Interpretación:**
- `type: range` = Uso de índice para rango de valores
- `key: idx_nombre` = Se está usando el índice creado
- `rows: 5000` = MySQL estima examinar solo 5,000 filas (10% del total)

#### **4.4 Comparación de rendimiento**

```sql
-- Medir tiempo de ejecución sin índice
SET profiling = 1;

SELECT * FROM productos WHERE nombre LIKE 'Producto%';
SHOW PROFILES;

-- Medir tiempo de ejecución con índice
SELECT * FROM productos WHERE nombre LIKE 'Producto%';
SHOW PROFILES;

-- Ver detalles del último perfil
SHOW PROFILE FOR QUERY 2;

-- Desactivar profiling
SET profiling = 0;
```

**Resultados esperados:**
- **Sin índice:** Tiempo mayor, escaneo completo de 50,000 filas
- **Con índice:** Tiempo significativamente menor, uso eficiente del índice

---

### **5. Mantenimiento de Tablas**

#### **5.1 OPTIMIZE TABLE**

```sql
-- Optimizar la tabla productos
OPTIMIZE TABLE productos;

-- Verificar el resultado
SHOW TABLE STATUS LIKE 'productos';
```

**Resultado esperado:**
```
+----------------+--------+---------+------------+--------+----------------+-------------+------------------+--------------+-----------+----------------+---------------------+---------------------+------------+-------------------+----------+----------------+---------+
| Name           | Engine | Version | Row_format | Rows   | Avg_row_length | Data_length | Max_data_length  | Index_length | Auto_increment | Create_time         | Update_time         | Check_time | Collation         | Checksum | Create_options | Comment |
+----------------+--------+---------+------------+--------+----------------+-------------+------------------+--------------+-----------+----------------+---------------------+---------------------+------------+-------------------+----------+----------------+---------+
| productos      | InnoDB |      10 | Dynamic    |  50000 |             45 |     2252800 |                0 |      1081344 |         50001 | 2025-01-14 10:00:00 | 2025-01-14 10:00:00 | NULL       | utf8mb4_unicode_ci |     NULL |                |         |
+----------------+--------+---------+------------+--------+----------------+-------------+------------------+--------------+-----------+----------------+---------------------+---------------------+------------+-------------------+----------+----------------+---------+
```

**Cuándo usar OPTIMIZE TABLE:**
- Después de muchas operaciones DELETE
- Cuando hay fragmentación significativa
- Para tablas que han crecido mucho
- Como parte del mantenimiento programado

#### **5.2 ANALYZE TABLE**

```sql
-- Analizar la tabla productos
ANALYZE TABLE productos;

-- Verificar estadísticas actualizadas
SHOW TABLE STATUS LIKE 'productos';
```

**Propósito de ANALYZE TABLE:**
- Actualiza estadísticas para el optimizador de consultas
- Mejora la precisión de los planes de ejecución
- Ayuda a MySQL a elegir los mejores índices
- Debe ejecutarse regularmente después de cambios en los datos

---

## **Resumen de la Parte B**

### **Conceptos Clave Aprendidos:**

1. **Monitorización de Rendimiento:**
   - Identificación de métricas clave (conexiones, consultas, buffer pool)
   - Interpretación de comandos SHOW STATUS
   - Cálculo de ratios de eficiencia

2. **Análisis de Consultas:**
   - Uso del comando EXPLAIN
   - Interpretación de planes de ejecución
   - Identificación de cuellos de botella

3. **Optimización:**
   - Creación y uso de índices
   - Medición de impacto en el rendimiento
   - Comparación antes y después de optimizaciones

4. **Mantenimiento:**
   - Diferencia entre OPTIMIZE y ANALYZE
   - Cuándo aplicar cada tipo de mantenimiento
   - Generación de datos de prueba para análisis

### **Comandos SQL Utilizados:**

- `SHOW PROCESSLIST`, `SHOW STATUS`, `SHOW VARIABLES`
- `EXPLAIN`, `CREATE INDEX`, `SHOW INDEX`
- `OPTIMIZE TABLE`, `ANALYZE TABLE`
- `SET profiling`, `SHOW PROFILES`

### **Métricas de Rendimiento Clave:**

1. **Conexiones:** `Threads_connected`, `Max_used_connections`
2. **Actividad:** `Questions`, `Slow_queries`
3. **Buffer Pool:** `Innodb_buffer_pool_reads`, `Innodb_buffer_pool_read_requests`
4. **Tiempo:** `Uptime`, tiempo de ejecución de consultas

### **Mejores Prácticas Implementadas:**

1. **Monitoreo Regular:** Verificación periódica de métricas clave
2. **Análisis Sistemático:** Uso de EXPLAIN para todas las consultas problemáticas
3. **Optimización Incremental:** Creación de índices basada en análisis de rendimiento
4. **Mantenimiento Programado:** Uso de OPTIMIZE y ANALYZE en momentos apropiados
5. **Documentación:** Registro de métricas y cambios de rendimiento

Esta parte proporciona las herramientas fundamentales para monitorear, analizar y optimizar el rendimiento de bases de datos MySQL, habilidades esenciales para cualquier administrador de bases de datos.
