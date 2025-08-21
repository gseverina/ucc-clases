# Guía de Trabajos Prácticos - UNIDAD 2

**Base de Datos Aplicada - UCC 2025**

---

## **[UNIDAD 2]{.underline}**

**Unidad 2: Administración y gestión de bases de datos.**

Creación y configuración de Base de datos. Gestión de Usuarios y permisos. Monitorización de rendimiento. Mantenimiento de Base de Datos. Auditoría y registro de eventos. Seguridad en base de datos. Backup. Restauración. Estrategias. Estrategias de Respaldo y Restauración. Plan de respaldo. Pruebas de restauración. Registro de respaldo. Plan de recuperación ante incidentes. Medios de almacenamiento. Redundancia. Redundancia de datos. Redundancia de hardware. Estrategias de caché en bases de datos. Caché de datos. Caché de consulta.

**Trabajo Práctico 2: Administración y gestión de bases de datos**

---

## **A. Creación, Configuración y Gestión de Usuarios y Permisos**

**Objetivos:**

- Crear y configurar bases de datos en MySQL.
- Administrar usuarios y asignar/revocar privilegios.
- Comprender el modelo de seguridad basado en privilegios de MySQL.

### **1. Creación y Configuración de Bases de Datos:**

- **¿Cuál es la diferencia entre una "base de datos" y un "esquema" en MySQL?**

- **Mencione y explique brevemente al menos tres parámetros de configuración importantes que se pueden ajustar en el archivo my.cnf (o my.ini) de MySQL para influir en el rendimiento o comportamiento del servidor.**

### **2. Gestión de Usuarios y Permisos:**

- **Describir la diferencia entre los privilegios GRANT ALL PRIVILEGES y GRANT SELECT, INSERT, UPDATE, DELETE sobre una base de datos específica. ¿Cuándo usaría cada uno?**

### **3. Creación y Configuración Básica:**

- **Conectarse al servidor MySQL local como root.**

- **Crear una base de datos llamada tp_db.**
  ```sql
  CREATE DATABASE tp_aplicadas_db;
  ```

- **Dentro de tp_db, crear una tabla llamada productos con las siguientes columnas:**
  - id_producto (INT, PRIMARY KEY, AUTO_INCREMENT)
  - nombre (VARCHAR(100), NOT NULL)
  - precio (DECIMAL(10, 2), NOT NULL)
  - stock (INT, DEFAULT 0)

  ```sql
  USE tp_aplicadas_db;
  CREATE TABLE productos (
      id_producto INT PRIMARY KEY AUTO_INCREMENT,
      nombre VARCHAR(100) NOT NULL,
      precio DECIMAL(10, 2) NOT NULL,
      stock INT DEFAULT 0
  );
  ```

- **Inserta 3 registros de ejemplo en la tabla productos.**
  ```sql
  INSERT INTO productos (nombre, precio, stock) VALUES
      ('Laptop Gamer', 1500.00, 10),
      ('Mouse Inalámbrico', 25.99, 50),
      ('Teclado Mecánico', 89.99, 20);
  ```

### **4. Gestión de Usuarios y Permisos:**

- **Crear un nuevo usuario llamado dev_user que solo pueda conectarse desde localhost.**
  ```sql
  CREATE USER 'dev_user'@'localhost' IDENTIFIED BY 'DevPass123!';
  ```

- **Asignar a dev_user los privilegios SELECT, INSERT, UPDATE, DELETE sobre la base de datos tp_db.**
  ```sql
  GRANT SELECT, INSERT, UPDATE, DELETE ON tp_db.* TO 'dev_user'@'localhost';
  FLUSH PRIVILEGES;
  ```

- **Crear otro usuario llamado report_user que también sólo pueda conectarse desde localhost.**
  ```sql
  CREATE USER 'report_user'@'localhost' IDENTIFIED BY 'ReportPass!';
  ```

- **Asignar a report_user únicamente el privilegio SELECT sobre la tabla productos dentro de tp_db.**

### **5. Prueba de Permisos:**

- **Intentar conectarse a MySQL como dev_user.**
  - INSERTAR un nuevo producto.
  - ELIMINAR un producto.
  - CREAR una nueva tabla en tp_db. Documentar resultados.

- **Intente conectarse a MySQL como report_user.**
  - SELECCIONAR datos de tp_db.productos.
  - INSERTAR un nuevo producto en tp_db.productos.
  - SELECCIONAR datos de otra tabla (si existe) en tp_db o de una base de datos del sistema como mysql.user. Documentar sus resultados.

---

## **B. Monitorización de Rendimiento y Mantenimiento de Base de Datos**

**Objetivos:**

- Identificar métricas clave de rendimiento en MySQL.
- Utilizar comandos y herramientas para monitorizar el estado del servidor.
- Realizar tareas básicas de mantenimiento para optimizar el rendimiento.

### **1. Monitorización de Rendimiento:**

- **Mencionar al menos 4 métricas de rendimiento importantes que un administrador de bases de datos debería monitorizar en MySQL y explique brevemente por qué son relevantes.**

- **¿Qué es el EXPLAIN de una consulta SQL y cómo ayuda a la optimización del rendimiento?**

### **2. Mantenimiento de Base de Datos:**

- **¿Por qué es importante realizar tareas de mantenimiento regular en una base de datos?**

- **Explicar la diferencia entre OPTIMIZE TABLE y ANALYZE TABLE en MySQL. ¿Cuándo se aplica cada uno de los comandos?**

### **3. Monitorización Básica:**

- **Conectarse a la línea de comandos de MySQL como root.**

- **Ejecutar SHOW PROCESSLIST;. Verificar información y cómo podría usarla para identificar problemas.**

- **Ejecutar los SHOW STATUS LIKE 'Threads_connected'; y SHOW STATUS LIKE 'Questions';. Explique qué representan estos valores.**

- **Ejecutar SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_reads'; y SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_read_requests';. ¿Qué indican estos dos valores sobre el uso del buffer pool de InnoDB?**

- **En MySQL Workbench, explorar la sección "Performance Dashboard" o "Server Status". Identifique al menos 3 métricas que considere útiles para la monitorización en tiempo real.**

### **4. Análisis y Optimización de Consultas:**

- **En tp_db.productos, insertar registros de prueba (10,000 a 50,000) con datos aleatorios para nombre, precio y stock.**

- **Ejecutar la siguiente consulta y observe su tiempo de ejecución:**
  ```sql
  SELECT * FROM productos WHERE nombre LIKE 'Producto%';
  ```

- **Ejecutar EXPLAIN para la misma consulta:**
  ```sql
  EXPLAIN SELECT * FROM productos WHERE nombre LIKE 'Producto%';
  ```

- **Analizar la salida de EXPLAIN. Verificar información de cómo MySQL ejecuta la consulta.**

- **Crear un índice en la columna nombre:**
  ```sql
  CREATE INDEX idx_nombre ON productos (nombre);
  ```

- **Ejecutar la consulta nuevamente:**
  ```sql
  SELECT * FROM productos WHERE nombre LIKE 'Producto%';
  ```

- **Ejecutar EXPLAIN para la misma consulta y comparar los tiempos de ejecución y la salida de EXPLAIN antes y después de crear el índice. ¿Qué diferencias se observan y por qué?**

### **5. Mantenimiento de Tablas:**

- **Ejecutar OPTIMIZE TABLE productos; en tp_db. ¿Qué mensaje obtiene y cuándo es útil este comando?**

- **Ejecutar ANALYZE TABLE productos;. ¿Cuál es el propósito de este comando?**

---

## **C. Auditoría, Registro de Eventos y Seguridad en Base de Datos**

**Objetivos:**

- Comprender la importancia de la auditoría y el registro de eventos en bases de datos.
- Familiarizarse con los diferentes tipos de logs de MySQL.
- Aplicar conceptos de seguridad avanzada.

### **1. Auditoría y Registro de Eventos:**

- **Verificar la diferencia entre General Query Log, Error Log y Slow Query Log en MySQL**

- **¿Qué es el Binary Log (Binlog) y cuál es su importancia principal en la administración de bases de datos MySQL?**

### **2. Seguridad en Base de Datos:**

- **Mencione y explique al menos 3 prácticas de seguridad adicionales (más allá de la gestión de usuarios y privilegios) que se deben implementar para proteger una base de datos MySQL.**

- **¿Qué es la inyección SQL y cómo se puede prevenir en el desarrollo de aplicaciones?**

### **3. Configuración y Exploración de Logs:**

- **Importante: Modificar el archivo de configuración de MySQL puede requerir reiniciar el servicio. Asegúrese de tener permisos y de entender los pasos.**

- **Localizar el archivo de configuración de MySQL (my.cnf en Linux/macOS, my.ini en Windows).**

- **Habilitación por archivo:**
  - Habilitar General Query Log agregando o modificando las siguientes líneas en la sección [mysqld]:
    ```
    general_log = 1
    general_log_file = /var/log/mysql/mysql.log # O la ruta adecuada para su SO
    ```

- **Habilitar en tiempo de ejecución:**
  ```sql
  SET GLOBAL general_log = 'ON';
  SET GLOBAL general_log_file = '/path/to/mysql.log';
  ```
  **¿Cuál es la diferencia entre ambos métodos?**

- **Reiniciar el servicio MySQL para tomar modificaciones del archivo de configuración.**

- **Conectarse a MySQL y realizar algunas operaciones.**

- **Localizar el archivo general_log_file y abrir con un editor de texto. Verificar las entradas generadas por las operaciones realizadas en el punto anterior.**

- **Deshabilitar General Query Log.**

- **Verificar la ubicación de Error Log y Slow Query Log en la instalación de MySQL.**

### **4. Seguridad Avanzada (Conceptual):**

- **Investigar cómo se configura el uso de conexiones SSL/TLS para MySQL. ¿Por qué es importante para la seguridad de la comunicación entre cliente y servidor?**

- **Describa cómo implementaría una política de contraseñas robusta para los usuarios de MySQL.**

---

## **D. Backup, Restauración y Estrategias de Respaldo**

**Objetivos:**

- Comprender la importancia de los backups y las diferentes estrategias.
- Realizar backups lógicos de bases de datos utilizando mysqldump.
- Restaurar bases de datos a partir de backups.
- Diseñar un plan de respaldo básico.

### **1. Backup y Restauración:**

- **Explicar la diferencia entre un backup lógico y un backup físico en MySQL. Ejemplo de herramienta para cada uno.**

- **Describa en qué consiste un backup completo, un backup incremental y un backup diferencial. ¿en qué se diferencian?**

### **2. Estrategias y Plan de Respaldo:**

- **¿Cuáles son los componentes clave que debe incluir un "Plan de Respaldo" para una base de datos crítica?**

- **¿Por qué es importante realizar "Pruebas de Restauración" de forma regular?**

### **3. Backup Completo con mysqldump:**

- **Desde la línea de comandos de su sistema operativo realizar un backup completo de la base de datos tp_db en un archivo SQL.**
  ```bash
  mysqldump -u root -p tp_aplicadas_db > tp_db_full_backup.sql
  ```

- **Abrir el archivo tp_db_full_backup.sql con un editor de texto. Verificar contenido. ¿Qué tipo de sentencias SQL contiene?**

### **4. Simulación de Desastre y Restauración:**

- **Eliminar la base de datos tp_db del servidor MySQL.**
  ```sql
  DROP DATABASE tp_aplicadas_db;
  ```

- **Restaurar la base de datos tp_db desde el archivo de backup creado.**
  ```bash
  mysql -u root -p < tp_aplicadas_db_full_backup.sql
  ```

- **Verificar que la base de datos tp_db y sus datos han sido restaurados correctamente.**

### **5. Estrategias de Respaldo (Conceptual):**

- **Describir una estrategia de respaldo para una base de datos de producción que maneja transacciones 24/7, considerando backups completos semanales y backups incrementales diarios. ¿Qué herramientas o características de MySQL usarías?**

- **Diseñar un "Registro de Respaldo" simple. ¿Qué información mínima debería contener cada entrada de este registro?**

---

## **E. Plan de Recuperación ante Incidentes, Redundancia y Medios de Almacenamiento**

**Objetivos:**

- Comprender la importancia de un plan de recuperación ante incidentes.
- Explorar conceptos de redundancia de datos y hardware.
- Identificar diferentes medios de almacenamiento para bases de datos.

### **1. Plan de Recuperación ante Incidentes (DRP):**

- **¿Qué es un Plan de Recuperación ante Incidentes (DRP) y por qué es esencial para la continuidad del negocio?**

- **Defina RTO (Recovery Time Objective) y RPO (Recovery Point Objective). ¿Cómo influyen estos en el diseño de un DRP?**

### **2. Redundancia de Datos y Hardware:**

- **Explique el concepto de "Redundancia de Datos" en bases de datos. Mencione al menos dos formas de lograrla en MySQL.**

- **¿Qué es la "Redundancia de Hardware" en el contexto de un servidor de bases de datos?**

### **3. Medios de Almacenamiento:**

- **Compare y contraste los discos HDD (Hard Disk Drive) y SSD (Solid State Drive) como medios de almacenamiento para bases de datos en términos de rendimiento, costo y durabilidad.**

- **¿Qué es una SAN (Storage Area Network) o una NAS (Network Attached Storage) y cómo pueden contribuir a la redundancia y escalabilidad del almacenamiento de bases de datos?**

### **4. Diseño de un Plan de Recuperación ante Incidentes (Esquemático):**

- **Elaborar un esquema de un Plan de Recuperación ante Incidentes para la base de datos tp_db, asumiendo que es crítica para una pequeña aplicación web. Incluya al menos los siguientes puntos:**
  - Detección del incidente.
  - Roles y responsabilidades del equipo de recuperación.
  - Procedimientos de restauración.
  - Pruebas del plan.
  - Comunicación.
  - RTO y RPO deseados para este escenario.

### **5. Redundancia de Datos (Conceptual):**

- **Investigar el concepto de "Replicación Master-Slave" en MySQL. Explicar sus beneficios para la redundancia y escalabilidad de lectura.**

- **¿Cómo podría la replicación de MySQL ayudar a cumplir con un RPO bajo?**

### **6. Redundancia de Hardware (Conceptual):**

- **Investigue y explique brevemente al menos dos niveles de RAID (ej: RAID 1, RAID 5, RAID 10) y cómo contribuyen a la redundancia de hardware para el almacenamiento de datos.**

- **¿Qué otros componentes de hardware en un servidor de bases de datos deberían ser redundantes para asegurar alta disponibilidad?**

---

## **F. Estrategias de Caché en Bases de Datos**

**Objetivos:**

- Comprender la importancia del caché para el rendimiento de las bases de datos.
- Diferenciar entre caché de datos y caché de consultas.
- Identificar las principales estrategias de caché en MySQL.

### **1. Estrategias de Caché:**

- **¿Cuál es el propósito principal de utilizar caché en un sistema de bases de datos?**

- **Explicar la diferencia fundamental entre "Caché de Datos" y "Caché de Consultas".**

### **2. Caché en MySQL:**

- **Describir el rol del InnoDB Buffer Pool en MySQL. ¿Qué tipo de información almacena y por qué es importante para el rendimiento de las bases de datos InnoDB?**

- **Investigar sobre el Query Cache de MySQL. Verificar alternativas en versiones más recientes de MySQL (MySQL 8.0 en adelante)**

### **3. Configuración del InnoDB Buffer Pool (Conceptual y Verificación):**

- **Conectarse a la línea de comandos de MySQL como root.**

- **Ejecutar SHOW VARIABLES LIKE 'innodb_buffer_pool_size';. Verificar que valor tiene y que representa.**

- **Investigar cómo se ajustaría este parámetro en el archivo my.cnf (o my.ini).**

- **¿Qué consideraciones se deben tomar para decidir un tamaño adecuado para un servidor de producción?**

- **Ejecutar:**
  ```sql
  SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_read_requests';
  SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_reads';
  ```
  **Explicar cómo la relación entre estos dos números puede indicar la eficiencia del buffer pool.**

### **4. Caché de Consultas (Verificación y Debate):**

- **Ejecutar:**
  ```sql
  SHOW VARIABLES LIKE 'query_cache%';
  SHOW STATUS LIKE 'Qcache%';
  ```
  **Verificar salida de los comandos.**

- **¿Qué otras estrategias de optimización de consultas son más relevantes? (Tener en cuenta que en nuevas versiones de MySQL, el Cache de consulta fue eliminado)**

---

## **Resumen de la Unidad 2**

La **Unidad 2: Administración y gestión de bases de datos** cubre los siguientes temas fundamentales:

1. **Gestión de Usuarios y Permisos** - Creación, configuración y administración de bases de datos y usuarios
2. **Monitorización y Mantenimiento** - Herramientas para optimizar el rendimiento y mantener la salud de la base de datos
3. **Auditoría y Seguridad** - Logs, monitoreo de eventos y prácticas de seguridad avanzada
4. **Backup y Restauración** - Estrategias de respaldo, recuperación ante desastres y planes de contingencia
5. **Redundancia y Alta Disponibilidad** - Conceptos de replicación, RAID y planes de recuperación
6. **Optimización y Caché** - Estrategias para mejorar el rendimiento mediante caché y optimización de consultas

Esta unidad proporciona las habilidades prácticas necesarias para administrar bases de datos MySQL en entornos de producción, con un enfoque especial en seguridad, rendimiento y recuperación ante incidentes.
