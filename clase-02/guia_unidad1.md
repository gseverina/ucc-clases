# Guía de Trabajos Prácticos - UNIDAD 1

**Base de Datos Aplicada - UCC 2025**

## 📋 **UNIDAD 1: Instalación y configuración de Sistemas de Gestión de Bases de Datos (SGBD)**

**Sistemas de Gestión de Base de Datos. Selección. Requisitos del Sistema. Configuración inicial. Seguridad. Bases de datos de Usuario. Bases de Datos del Sistema. Monitorización y mantenimiento. Pruebas y ajustes. Arquitectura Cliente Servidor. Conexión al Sistema de gestión de Base de Datos. Conexión de aplicaciones a base de datos locales y en la nube.**

---

## 🎯 **Trabajo Práctico 1: Instalación y Configuración de Sistemas de Gestión de Bases de Datos**

**Objetivo:** Comprender y aplicar los conceptos fundamentales de los Sistemas de Gestión de Bases de Datos (SGBD) con enfoque en MySQL

---

## 📚 **Sección A: Introducción a los SGBD y Configuración Inicial de MySQL**

### 🎯 **Objetivos:**
- Comprender el rol y la importancia de un SGBD
- Conocer los criterios para la selección de un SGBD
- Realizar una instalación básica de MySQL y su configuración inicial
- Familiarizarse con las herramientas de administración de MySQL

### 🔍 **1. Definición y Rol de un SGBD:**
- ¿Qué es un Sistema de Gestión de Bases de Datos (SGBD) y cuál es su función principal en un sistema informático?
- Mencionar al menos 3 ventajas de utilizar un SGBD en lugar de almacenar datos en archivos planos

### 🔍 **2. Selección de un SGBD:**
- Enumere y describa brevemente al menos 5 criterios clave a considerar al seleccionar un SGBD para un proyecto

### 🔍 **3. Requisitos del Sistema:**
- Investigar los requisitos mínimos de hardware (RAM, CPU, espacio en disco) y software (Sistema Operativo) para instalar MySQL Server en un entorno de desarrollo

### 🚀 **4. Instalación de MySQL:**
- Instalar MySQL Community Server en su equipo
- Configurar usuario root y su contraseña
- Acceder a la línea de comandos de MySQL (mysql client) utilizando: `mysql -u root -p`
- Desde la línea de comandos, verificar la versión de MySQL usando: `SELECT VERSION();`
- Salir de la línea de comandos (`exit;`)

### 🛠️ **5. Acceso y Configuración Inicial:**
- Instalar MySQL Workbench y crear una nueva conexión a la instancia local de MySQL
- Explique brevemente qué es y para qué sirve MySQL Workbench
- En MySQL Workbench, "Server Status", identificar la versión de MySQL instalada

---

## 🔒 **Sección B: Seguridad en MySQL y Bases de Datos del Sistema/Usuario**

### 🎯 **Objetivos:**
- Comprender la importancia de la seguridad en un SGBD
- Administrar usuarios y privilegios en MySQL
- Diferenciar entre bases de datos del sistema y de usuario
- Explorar las bases de datos del sistema en MySQL

### 🔒 **1. Seguridad en Bases de Datos:**
- Justificar por qué es importante implementar medidas de seguridad en un SGBD
- Mencionar al menos 3 riesgos de seguridad comunes en bases de datos
- Explicar el concepto de "privilegios" en MySQL
- ¿Por qué es una buena práctica asignar el mínimo privilegio necesario a los usuarios?

### 🗄️ **2. Bases de Datos del Sistema vs. Bases de Datos de Usuario:**
- ¿Qué son las bases de datos del sistema en MySQL? ¿Cuál es su propósito principal?
- Nombrar algunas de las bases de datos del sistema
- Definir qué son las bases de datos de usuario

### 👥 **3. Gestión de Usuarios y Privilegios:**
- Conectarse a MySQL utilizando algún cliente (mysql client, Workbench como root)
- Crear un nuevo usuario llamado `admin_db` con una contraseña
- Asignar al usuario creado privilegios para crear, modificar y eliminar bases de datos:
  ```sql
  CREATE USER 'admin_db'@'localhost' IDENTIFIED BY 'su_contraseña_segura';
  GRANT CREATE, ALTER, DROP ON *.* TO 'admin_db'@'localhost';
  FLUSH PRIVILEGES;
  ```
- Crear otro usuario llamado `app_user` con una contraseña. Inicialmente, no asignar ningún privilegio a este usuario:
  ```sql
  CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'otra_contraseña_segura';
  FLUSH PRIVILEGES;
  ```
- Intentar acceder a MySQL Workbench con el usuario `app_user` y verificar:
  - ¿Qué bases de datos puede ver?
  - ¿Puede crear una nueva base de datos? Explicar
- Conectarse nuevamente como root
- Otorgar al usuario `app_user` privilegios para seleccionar, insertar, actualizar y eliminar datos en **cualquier tabla de una base de datos específica (ej: mi_db)**:
  ```sql
  GRANT SELECT, INSERT, UPDATE, DELETE ON mi_db.* TO 'app_user'@'localhost';
  FLUSH PRIVILEGES;
  ```
- Si mi_db no existe, ¿el comando anterior da error?
- Intente nuevamente acceder a MySQL Workbench con el usuario `app_user`
- ¿Puede este usuario crear la base de datos mi_db? ¿Por qué sí o por qué no?

### 🔍 **4. Exploración de Bases de Datos del Sistema:**
- Conectarse a MySQL Workbench como root
- Explorar las bases de datos `mysql`, `information_schema` y `performance_schema`
- En la base de datos `mysql`, buscar la tabla `user`. ¿Qué información contiene esta tabla?
- En la base de datos `information_schema`, explorar la tabla `SCHEMATA`. ¿Qué información proporciona sobre las bases de datos existentes?
- En la base de datos `performance_schema`, explorar algunas tablas `threads` y `events_statements_summary_by_digest`. ¿Qué tipo de información se almacena en estas tablas?

---

## 📊 **Sección C: Monitorización y Mantenimiento de MySQL**

### 🎯 **Objetivos:**
- Comprender la importancia de la monitorización y el mantenimiento regular de un SGBD
- Familiarizarse con herramientas y comandos para la monitorización básica de MySQL
- Realizar tareas básicas de mantenimiento como backups y optimización

### 📊 **1. Monitorización:**
- ¿Por qué es fundamental monitorizar el rendimiento y el estado de un servidor MySQL?
- Mencionar al menos 3 métricas importantes que deberían ser monitoreadas
- ¿Qué herramientas o comandos nativos de MySQL se pueden utilizar para obtener información sobre el estado del servidor?

### 🛠️ **2. Mantenimiento:**
- Explicar la importancia de los backups regulares en un entorno de base de datos
- ¿Qué estrategias de backup existen?
- ¿Qué es la optimización de bases de datos y por qué es importante para el rendimiento?
- Mencionar 2 técnicas de optimización

### 🔧 **3. Monitorización Básica:**
- Conectarse a la línea de comandos de MySQL como root
- Ejecutar el comando `SHOW PROCESSLIST;`. ¿Qué información muestra y cuál es su utilidad?
- Ejecutar `SHOW STATUS LIKE 'Threads_connected%';`. ¿Qué representa este valor?
- Ejecutar `SHOW GLOBAL STATUS LIKE 'Com_select%';`. ¿Qué muestra este comando?
- En MySQL Workbench, "Server Status", observar la información en tiempo real

### 💾 **4. Mantenimiento: Backup y Restauración (Simulado):**
- Crear una nueva base de datos llamada `db_backup_test`
- Crear una tabla dentro de `db_backup_test` con algunos datos de prueba:
  ```sql
  CREATE TABLE db_backup_test.productos (
      id INT PRIMARY KEY AUTO_INCREMENT,
      nombre VARCHAR(100),
      precio DECIMAL(10, 2)
  );
  INSERT INTO db_backup_test.productos (nombre, precio) VALUES 
      ('Laptop', 1200.00), ('Teclado', 75.50);
  ```
- Desde la línea de comandos realizar un backup de la base de datos:
  ```bash
  mysqldump -u root -p db_backup_test > db_backup_test_backup.sql
  ```
- Simula situación de "desastre": eliminar la base de datos `db_backup_test`
- Restaurar la base de datos desde el archivo de backup:
  ```bash
  mysql -u root -p < db_backup_test_backup.sql
  ```
- Verificar que la base de datos ha sido restaurada correctamente

### 🔍 **5. Mantenimiento: Optimización (Conceptual):**
- Investigar el comando `OPTIMIZE TABLE` en MySQL. ¿Para qué se utiliza y en qué situaciones sería beneficioso?
- ¿Por qué es importante el uso de índices en la optimización de consultas? Explicar brevemente

---

## 🔧 **Sección D: Pruebas y Ajustes, Arquitectura Cliente-Servidor y Conexión de Aplicaciones**

### 🎯 **Objetivos:**
- Comprender la importancia de las pruebas y ajustes en bases de datos
- Entender la arquitectura cliente-servidor en el contexto de bases de datos
- Conectar una aplicación simple a una base de datos MySQL local
- Discutir los desafíos y consideraciones de conexión a bases de datos en la nube

### 🔍 **1. Pruebas y Ajustes:**
- ¿Por qué son importantes las fases de pruebas y ajustes en el ciclo de vida de una base de datos?
- Mencionar al menos 3 tipos de pruebas que se pueden realizar en una base de datos

### 🌐 **2. Arquitectura Cliente-Servidor:**
- Explicar el concepto de arquitectura Cliente-Servidor en el contexto de los SGBD
- Identificar el "cliente" y el "servidor" en esta arquitectura
- ¿Cuáles son las ventajas de una arquitectura cliente-servidor para las bases de datos?

### 🔗 **3. Conexión a Bases de Datos:**
- ¿Qué es una cadena de conexión (connection string) y qué información suele contener para conectarse a una base de datos MySQL?
- ¿Cuáles son las principales diferencias y consideraciones al conectar una aplicación a una base de datos MySQL local versus una base de datos MySQL en la nube (ej: Amazon RDS, Google Cloud SQL)?

### 🚀 **4. Simulación de Pruebas de Rendimiento:**
- Suponiendo una tabla con millones de registros. ¿Cómo se podría simular una "prueba de rendimiento" para evaluar la velocidad de una consulta SELECT compleja?
- ¿Qué métricas interesan?
- ¿Qué ajustes podría considerar para mejorar el rendimiento de esa consulta?

### 💻 **5. Conexión de Aplicación a MySQL Local:**
- **Crear una Base de Datos y Tabla de Prueba:**
  - Crear una nueva base de datos llamada `mi_db`
  - Crear una tabla llamada `usuarios` con los siguientes campos:
    - `id` (PRIMARY KEY, AUTO_INCREMENT)
    - `nombre` (VARCHAR)
    - `email` (VARCHAR único)
  ```sql
  CREATE DATABASE mi_app_db;
  USE mi_app_db;
  CREATE TABLE usuarios (
      id INT PRIMARY KEY AUTO_INCREMENT,
      nombre VARCHAR(100) NOT NULL,
      email VARCHAR(100) UNIQUE NOT NULL
  );
  ```

- **Escribir un Script de Conexión:**
  - Escriba un script que realice las siguientes operaciones:
    1. **Conectarse** a la base de datos `mi_db` utilizando el usuario `app_user` o `root`
    2. **Insertar** al menos 2 registros en la tabla `usuarios`
    3. **Consultar** todos los registros de la tabla `usuarios` y mostrarlos por consola
    4. **Cerrar** la conexión a la base de datos

### ☁️ **6. Conexión a la Nube (Investigación y Debate):**
- Investigar al menos un servicio de base de datos MySQL gestionado en la nube (ej: Amazon RDS for MySQL, Google Cloud SQL for MySQL, Azure Database for MySQL)
- Enumerar al menos 3 ventajas y 2 desventajas de utilizar una base de datos en la nube en comparación con una base de datos local
- ¿Qué consideraciones de seguridad adicionales se deben tener en cuenta al conectar una aplicación a una base de datos en la nube?

---

## 📝 **Entregables del Trabajo Práctico 1**

### ✅ **Documentación Requerida:**
1. **Respuestas teóricas** a todas las preguntas planteadas
2. **Capturas de pantalla** de la instalación y configuración de MySQL
3. **Capturas de pantalla** de la configuración de MySQL Workbench
4. **Capturas de pantalla** de la creación de usuarios y asignación de privilegios
5. **Capturas de pantalla** de la exploración de bases de datos del sistema
6. **Scripts SQL** implementados para cada ejercicio
7. **Reflexión personal** sobre la experiencia de aprendizaje

### 🔍 **Verificaciones Técnicas:**
- [ ] MySQL Community Server instalado correctamente
- [ ] Usuario root configurado con contraseña segura
- [ ] MySQL Workbench instalado y configurado
- [ ] Conexión a instancia local establecida
- [ ] Usuarios creados con privilegios apropiados
- [ ] Bases de datos del sistema exploradas
- [ ] Backup y restauración funcionando
- [ ] Script de conexión de aplicación funcionando

---

## 🎯 **Criterios de Evaluación**

- **Correctitud**: Las configuraciones se implementan correctamente
- **Seguridad**: Los principios de seguridad se aplican apropiadamente
- **Documentación**: Código y pasos bien documentados
- **Funcionalidad**: Todas las funcionalidades solicitadas funcionan correctamente
- **Buenas prácticas**: Seguimiento de convenciones y estándares de MySQL

---

*Guía extraída de la "Base de Datos Aplicadas - Guía de Trabajos Prácticos" - UCC 2025*
