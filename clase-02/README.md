# Clase 02 - UNIDAD 1: Instalación y Configuración de SGBD

**📅 Fecha:** 14 de Agosto de 2025

## 📋 Descripción de la Clase

**Unidad Académica:** FACULTAD DE INGENIERÍA  
**Asignatura:** BASE DE DATOS APLICADA  
**Año académico:** 2025  
**Régimen:** SEMESTRAL  
**Horas Totales:** 60  
**Carácter:** TEÓRICA/PRÁCTICA  

### 🎯 Objetivo de la Clase
**Desarrollo del Trabajo Práctico 1** de la **Unidad 1: Instalación y configuración de Sistemas de Gestión de Bases de Datos (SGBD)** con enfoque en MySQL.

Los alumnos trabajarán en:
- Instalación y configuración inicial de MySQL
- Gestión de usuarios y privilegios
- Monitorización y mantenimiento básico
- Pruebas y ajustes del sistema
- Conexión de aplicaciones a bases de datos

---

## 📁 Archivos del Proyecto

### 📚 Guía de Trabajos Prácticos
- **`guia_unidad1.md`** - Extracto de la Unidad 1 de la guía oficial
- **`guia_unidad1.pdf`** - Referencia al documento original

### 🎯 Ejercicios de la Unidad 1
- **`ejercicio_1/`** - Sección A: Introducción a SGBD y Configuración Inicial
  - `enunciado.md` - Descripción detallada del ejercicio
  - `solucion.sql` - Scripts de solución
  - `checklist.md` - Checklist de verificación
- **`ejercicio_2/`** - Sección B: Seguridad y Gestión de Usuarios
  - `enunciado.md` - Descripción detallada del ejercicio
  - `solucion.sql` - Scripts de solución
  - `checklist.md` - Checklist de verificación

### 🛠️ Herramientas y Recursos
- **`mysql_setup.sql`** - Script de configuración inicial
- **`ejemplos_comandos.sql`** - Comandos de referencia para MySQL
- **`mejores_practicas_seguridad.md`** - Guía de seguridad para MySQL

---

## 🎯 Contenido de la Unidad 1

### 📖 **Sección A: Introducción a SGBD y Configuración Inicial**
1. **Definición y Rol de un SGBD**
   - Conceptos fundamentales de SGBD
   - Ventajas sobre archivos planos
   - Criterios de selección

2. **Requisitos del Sistema**
   - Hardware mínimo (RAM, CPU, disco)
   - Software requerido (Sistema Operativo)
   - Compatibilidad de versiones

3. **Instalación de MySQL**
   - MySQL Community Server
   - Configuración de usuario root
   - Acceso a línea de comandos

4. **Configuración Inicial**
   - MySQL Workbench
   - Conexiones y configuración
   - Verificación de instalación

### 🔒 **Sección B: Seguridad y Gestión de Usuarios**
1. **Seguridad en Bases de Datos**
   - Importancia de la seguridad
   - Riesgos comunes
   - Concepto de privilegios

2. **Bases de Datos del Sistema vs Usuario**
   - Diferencias y propósitos
   - Exploración de bases del sistema
   - Gestión de bases de usuario

3. **Gestión de Usuarios y Privilegios**
   - Creación de usuarios
   - Asignación de privilegios
   - Pruebas de permisos

### 📊 **Sección C: Monitorización y Mantenimiento**
1. **Monitorización**
   - Métricas importantes
   - Herramientas nativas de MySQL
   - Comandos de estado

2. **Mantenimiento**
   - Backups regulares
   - Optimización de bases de datos
   - Técnicas de mantenimiento

3. **Prácticas de Backup**
   - mysqldump
   - Simulación de desastres
   - Restauración de datos

### 🔧 **Sección D: Pruebas, Arquitectura y Conexiones**
1. **Pruebas y Ajustes**
   - Importancia de las pruebas
   - Tipos de pruebas
   - Ciclo de vida de BD

2. **Arquitectura Cliente-Servidor**
   - Concepto y componentes
   - Ventajas de la arquitectura
   - Implementación en MySQL

3. **Conexión de Aplicaciones**
   - Cadenas de conexión
   - Conexión local vs nube
   - Consideraciones de seguridad

---

## 🏗️ Estructura de Trabajo

### 📋 Metodología de Desarrollo
1. **Análisis del Problema**
   - Comprensión de requerimientos
   - Identificación de objetivos
   - Planificación de implementación

2. **Implementación Práctica**
   - Instalación y configuración
   - Creación de usuarios y privilegios
   - Implementación de seguridad

3. **Testing y Validación**
   - Verificación de funcionalidades
   - Pruebas de seguridad
   - Validación de backups

4. **Documentación**
   - Registro de pasos realizados
   - Capturas de pantalla
   - Conclusiones y aprendizajes

---

## 🛠️ Características Técnicas

### ✅ Tecnologías Utilizadas
- **MySQL 8.0+** - Sistema de gestión de bases de datos
- **MySQL Workbench** - Herramienta de administración
- **Línea de comandos** - Cliente MySQL nativo
- **mysqldump** - Herramienta de backup

### ✅ Conceptos Clave
- **SGBD**: Sistemas de Gestión de Bases de Datos
- **Arquitectura Cliente-Servidor**: Modelo de comunicación
- **Privilegios**: Sistema de permisos de MySQL
- **Backup y Restauración**: Estrategias de respaldo
- **Monitorización**: Seguimiento del rendimiento

---

## 📝 Notas de la Clase

### 👥 Participación de Alumnos
*[Aquí puedes agregar notas sobre la participación, preguntas, dudas, etc.]*

### 💡 Conceptos Clave Explicados
*[Aquí puedes agregar los conceptos más importantes que se trataron]*

### ❓ Dudas Frecuentes
*[Aquí puedes agregar las dudas más comunes de los alumnos]*

### 🎯 Puntos de Atención
*[Aquí puedes agregar aspectos que requieren especial atención]*

### 📚 Recursos Adicionales
*[Aquí puedes agregar enlaces, referencias, etc.]*

---

## 🚀 Cómo Usar

### 1. Configurar el Entorno
```bash
# Verificar instalación de MySQL
mysql --version

# Conectar como root
mysql -u root -p

# Verificar versión
SELECT VERSION();
```

### 2. Ejecutar Scripts de Configuración
```bash
# Ejecutar configuración inicial
mysql -u root -p < mysql_setup.sql

# Ejecutar ejercicios específicos
mysql -u root -p < ejercicio_1/solucion.sql
mysql -u root -p < ejercicio_2/solucion.sql
```

### 3. Verificar Configuración
```sql
-- Verificar usuarios creados
SELECT User, Host FROM mysql.user;

-- Verificar bases de datos
SHOW DATABASES;

-- Verificar privilegios
SHOW GRANTS FOR 'usuario'@'localhost';
```

---

## 🔗 Enlaces Útiles

- **Repositorio GitHub**: https://github.com/gseverina/ucc-clases.git
- **Documentación MySQL**: https://dev.mysql.com/doc/
- **MySQL Workbench**: https://dev.mysql.com/downloads/workbench/
- **Guía de Trabajos Prácticos**: `docs/guia_de_trabajos_practicos.md`

---

## 📅 Cronograma de la Clase

### ⏰ Distribución del Tiempo
- **15 min**: Introducción y explicación de objetivos
- **60 min**: Desarrollo de ejercicios prácticos de la Unidad 1
- **15 min**: Puesta en común y conclusiones

### 🎯 Entregables Esperados
- MySQL instalado y configurado correctamente
- Usuarios y privilegios configurados según especificaciones
- Backups y restauraciones funcionando
- Conexiones de aplicación probadas
- Documentación completa de la implementación

---

*Documento creado para la clase de Base de Datos Aplicada - UCC 2025*
