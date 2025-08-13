# Ejercicio 1 - Sección A: Introducción a SGBD y Configuración Inicial

**Clase 02 - Unidad 1 - Base de Datos Aplicada - UCC 2025**

## 📋 Descripción del Ejercicio

**Sección A: Introducción a los SGBD y Configuración Inicial de MySQL**

Este ejercicio se enfoca en los conceptos fundamentales de los Sistemas de Gestión de Bases de Datos (SGBD) y la instalación y configuración inicial de MySQL.

## 🎯 Objetivos de Aprendizaje

- Comprender el rol y la importancia de un SGBD
- Conocer los criterios para la selección de un SGBD
- Realizar una instalación básica de MySQL y su configuración inicial
- Familiarizarse con las herramientas de administración de MySQL

---

## 📚 **Parte 1: Definición y Rol de un SGBD**

### 🔍 **Preguntas Teóricas**

#### 1.1 Conceptos Fundamentales
- **¿Qué es un Sistema de Gestión de Bases de Datos (SGBD) y cuál es su función principal en un sistema informático?**

**Respuesta esperada:**
Un SGBD es un software que permite crear, mantener y administrar bases de datos. Su función principal es proporcionar una interfaz entre los usuarios, las aplicaciones y los datos almacenados, garantizando la integridad, seguridad y eficiencia en el acceso a la información.

#### 1.2 Ventajas de SGBD vs Archivos Planos
- **Mencionar al menos 3 ventajas de utilizar un SGBD en lugar de almacenar datos en archivos planos.**

**Respuesta esperada:**
1. **Integridad de datos**: Validación automática de restricciones y reglas de negocio
2. **Seguridad**: Control de acceso mediante usuarios y privilegios
3. **Concurrencia**: Múltiples usuarios pueden acceder simultáneamente
4. **Backup y recuperación**: Herramientas integradas para respaldo de datos
5. **Independencia de datos**: Separación entre lógica de aplicación y estructura de datos

---

## 🔍 **Parte 2: Selección de un SGBD**

### 📋 **Pregunta de Análisis**

#### 2.1 Criterios de Selección
- **Enumere y describa brevemente al menos 5 criterios clave a considerar al seleccionar un SGBD para un proyecto.**

**Respuesta esperada:**
1. **Rendimiento**: Capacidad de procesar consultas y transacciones eficientemente
2. **Escalabilidad**: Capacidad de crecer con el volumen de datos y usuarios
3. **Costo**: Licencias, mantenimiento y recursos de hardware requeridos
4. **Compatibilidad**: Integración con sistemas operativos y aplicaciones existentes
5. **Soporte**: Calidad del soporte técnico y comunidad de desarrolladores
6. **Funcionalidades**: Características específicas requeridas por el proyecto
7. **Estándares**: Cumplimiento de estándares SQL y compatibilidad

---

## 💻 **Parte 3: Requisitos del Sistema**

### 🔧 **Investigación Técnica**

#### 3.1 Requisitos de Hardware y Software
- **Investigar los requisitos mínimos de hardware (RAM, CPU, espacio en disco) y software (Sistema Operativo) para instalar MySQL Server en un entorno de desarrollo.**

**Respuesta esperada:**

**Hardware Mínimo:**
- **RAM**: 2 GB (recomendado 4 GB)
- **CPU**: Procesador de 1 GHz (recomendado multicore)
- **Disco**: 1 GB de espacio libre (recomendado 5 GB)

**Software:**
- **Sistema Operativo**: Windows 10/11, macOS 10.14+, Linux (Ubuntu 18.04+, CentOS 7+)
- **Arquitectura**: x86_64 (64 bits)

**Requisitos Recomendados para Desarrollo:**
- **RAM**: 8 GB
- **CPU**: Procesador multicore de 2 GHz o superior
- **Disco**: 10 GB de espacio libre (SSD recomendado)

---

## 🚀 **Parte 4: Instalación de MySQL**

### ⚙️ **Instalación Práctica**

#### 4.1 Instalación de MySQL Community Server
- **Instalar MySQL Community Server en su equipo.**

**Pasos a seguir:**
1. Descargar MySQL Community Server desde [mysql.com](https://dev.mysql.com/downloads/mysql/)
2. Ejecutar el instalador
3. Configurar usuario root y contraseña
4. Completar la instalación

#### 4.2 Configuración de Usuario Root
- **Configurar usuario root y su contraseña.**

**Comandos de verificación:**
```bash
# Verificar instalación
mysql --version

# Conectar como root
mysql -u root -p
```

#### 4.3 Acceso a Línea de Comandos
- **Acceder a la línea de comandos de MySQL (mysql client) utilizando el siguiente comando:**

```bash
mysql -u root -p
```

#### 4.4 Verificación de Versión
- **Desde la línea de comandos, verificar la versión de MySQL usando:**

```sql
SELECT VERSION();
```

#### 4.5 Salida del Sistema
- **Salir de la línea de comandos (exit;).**

```sql
exit;
```

---

## 🛠️ **Parte 5: Acceso y Configuración Inicial**

### 🔧 **Configuración de Herramientas**

#### 5.1 Instalación de MySQL Workbench
- **Instalar MySQL Workbench y crear una nueva conexión a la instancia local de MySQL utilizando el usuario root y la contraseña establecida.**

**Pasos a seguir:**
1. Descargar MySQL Workbench desde [mysql.com](https://dev.mysql.com/downloads/workbench/)
2. Instalar la aplicación
3. Abrir MySQL Workbench
4. Crear nueva conexión:
   - **Connection Name**: Local MySQL
   - **Hostname**: localhost
   - **Port**: 3306
   - **Username**: root
   - **Password**: [su contraseña]

#### 5.2 Explicación de MySQL Workbench
- **Explique brevemente qué es y para qué sirve MySQL Workbench.**

**Respuesta esperada:**
MySQL Workbench es una herramienta visual de administración de bases de datos que permite:
- Diseñar y modelar bases de datos
- Administrar servidores MySQL
- Ejecutar consultas SQL
- Monitorear el rendimiento del servidor
- Gestionar usuarios y privilegios
- Realizar backups y restauraciones

#### 5.3 Verificación de Versión en Workbench
- **En MySQL Workbench, "Server Status", identificar la versión de MySQL instalada.**

**Pasos a seguir:**
1. Conectarse a la instancia local
2. Ir a **Server** → **Server Status**
3. Identificar la versión de MySQL en la información del servidor

---

## 📝 **Entregables del Ejercicio**

### ✅ **Documentación Requerida**
1. **Respuestas teóricas** a todas las preguntas planteadas
2. **Capturas de pantalla** de la instalación de MySQL
3. **Capturas de pantalla** de la conexión exitosa en MySQL Workbench
4. **Verificación de versión** desde línea de comandos y Workbench
5. **Reflexión personal** sobre la experiencia de instalación

### 🔍 **Verificaciones Técnicas**
- [ ] MySQL Community Server instalado correctamente
- [ ] Usuario root configurado con contraseña segura
- [ ] Acceso a línea de comandos funcionando
- [ ] MySQL Workbench instalado y configurado
- [ ] Conexión a instancia local establecida
- [ ] Versión de MySQL verificada en ambos entornos

---

## 💡 **Pistas y Sugerencias**

### 🔍 **Para la Investigación**
- Consultar la documentación oficial de MySQL
- Revisar foros de la comunidad MySQL
- Comparar diferentes versiones de MySQL disponibles

### 🛠️ **Para la Instalación**
- Usar contraseñas seguras (mínimo 8 caracteres, mayúsculas, minúsculas, números, símbolos)
- Documentar cada paso de la instalación
- Probar la conexión antes de continuar

### 📊 **Para la Verificación**
- Comparar la versión mostrada en línea de comandos vs Workbench
- Verificar que ambos métodos de conexión funcionen correctamente
- Probar comandos básicos como `SHOW DATABASES;`

---

## 🚨 **Puntos de Atención**

### ⚠️ **Seguridad**
- **Nunca** compartir la contraseña de root
- **Siempre** usar contraseñas seguras
- **Verificar** que la instalación no exponga el servidor a la red

### 🔧 **Técnicos**
- Verificar compatibilidad del sistema operativo
- Asegurar permisos de administrador para la instalación
- Tener suficiente espacio en disco disponible

### 📚 **Documentación**
- Guardar capturas de pantalla de cada paso importante
- Documentar cualquier error o problema encontrado
- Anotar las decisiones de configuración tomadas

---

## 📚 **Recursos Adicionales**

- **Documentación oficial MySQL**: https://dev.mysql.com/doc/
- **MySQL Community Downloads**: https://dev.mysql.com/downloads/
- **MySQL Workbench Documentation**: https://dev.mysql.com/doc/workbench/en/
- **MySQL Installation Guide**: https://dev.mysql.com/doc/refman/8.0/en/installing.html

---

*Enunciado creado para la clase de Base de Datos Aplicada - UCC 2025*
