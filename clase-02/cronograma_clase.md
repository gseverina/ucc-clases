# Cronograma Detallado - Clase 02 - Unidad 1

**Base de Datos Aplicada - UCC 2025**  
**Fecha:** Jueves 14 de Agosto de 2025  
**Duración Total:** 90 minutos

---

## ⏰ Distribución del Tiempo

### 🚀 **Fase 1: Introducción y Contexto (15 min)**

#### 00:00 - 05:00 | Bienvenida y Repaso
- Saludo y presentación de objetivos de la clase
- Repaso rápido de conceptos clave de la clase anterior
- Explicación de la metodología de trabajo práctico integrador

#### 05:00 - 10:00 | Presentación de la Unidad 1 Completa
- Descripción general de la Unidad 1: Instalación y Configuración de SGBD
- **Estructura integrada**: Ejercicio 1 (Sección A) + Ejercicio 2 (Secciones B, C, D)
- Criterios de evaluación y entregables esperados

#### 10:00 - 15:00 | Configuración del Entorno de Trabajo
- Verificación de instalación de MySQL
- Configuración de la base de datos de trabajo
- Explicación de las herramientas disponibles

---

### 🛠️ **Fase 2: Desarrollo de Ejercicios Integrados (60 min)**

#### 15:00 - 35:00 | **Ejercicio 1: Sección A - Introducción a SGBD y Configuración Inicial**
- **Análisis del Problema (10 min)**
  - Lectura y comprensión del enunciado
  - Identificación de objetivos de aprendizaje
  - Discusión de conceptos fundamentales de SGBD

- **Implementación Práctica (15 min)**
  - Verificación de instalación de MySQL
  - Configuración de usuario root
  - Instalación y configuración de MySQL Workbench
  - Verificación de versiones y conexiones

- **Verificación y Testing (10 min)**
  - Pruebas de conexión desde línea de comandos
  - Pruebas de conexión desde MySQL Workbench
  - Verificación de funcionalidades básicas

#### 35:00 - 75:00 | **Ejercicio 2 Integrador: Secciones B, C y D - Seguridad, Monitorización y Conexiones**
- **Sección B: Seguridad y Gestión de Usuarios (20 min)**
  - **Análisis de Seguridad (5 min)**
    - Comprensión de conceptos de seguridad
    - Identificación de mejores prácticas
    - Planificación de la implementación

  - **Implementación del Sistema de Seguridad (10 min)**
    - Creación de usuarios específicos (admin_db, app_user)
    - Asignación de privilegios apropiados
    - Implementación del principio del mínimo privilegio

  - **Exploración de Bases del Sistema (5 min)**
    - Exploración de base de datos mysql
    - Exploración de information_schema
    - Exploración de performance_schema

- **Sección C: Monitorización y Mantenimiento (20 min)**
  - **Monitorización Básica (10 min)**
    - Comandos SHOW PROCESSLIST, SHOW STATUS
    - Análisis de métricas de rendimiento
    - Interpretación de resultados

  - **Mantenimiento y Backup (10 min)**
    - Creación de base de datos de prueba
    - Proceso completo de backup con mysqldump
    - Simulación de desastre y restauración

- **Sección D: Pruebas, Arquitectura y Conexiones (20 min)**
  - **Conceptos Teóricos (5 min)**
    - Arquitectura cliente-servidor
    - Importancia de pruebas y ajustes
    - Cadenas de conexión

  - **Implementación Práctica (10 min)**
    - Creación de base de datos y tabla de usuarios
    - Script de conexión en Python
    - Pruebas de conectividad

  - **Investigación de Nube (5 min)**
    - Servicios MySQL gestionados (RDS, Cloud SQL, Azure)
    - Ventajas y desventajas de nube vs local

#### 75:00 - 80:00 | **Integración y Testing**
- Verificación de funcionalidades implementadas
- Pruebas de seguridad y permisos
- Validación de usuarios y privilegios
- Verificación de backup y restauración
- Prueba de script de conexión

---

### 🎯 **Fase 3: Puesta en Común y Conclusiones (15 min)**

#### 80:00 - 85:00 | **Presentación de Soluciones**
- Demostración de instalaciones exitosas
- Discusión de desafíos encontrados
- Compartir mejores prácticas identificadas

#### 85:00 - 90:00 | **Cierre y Próximos Pasos**
- Resumen de aprendizajes clave de toda la Unidad 1
- Asignación de tareas para la próxima clase
- Recursos adicionales recomendados

---

## 📋 Actividades por Alumno

### 👥 **Grupos de Trabajo Integrados**
- **Grupo A**: Ejercicio 1 (Sección A) + Ejercicio 2 (Secciones B, C, D)
- **Grupo B**: Ejercicio 1 (Sección A) + Ejercicio 2 (Secciones B, C, D)
- **Grupo C**: Ejercicio 1 (Sección A) + Ejercicio 2 (Secciones B, C, D)
- **Grupo D**: Ejercicio 1 (Sección A) + Ejercicio 2 (Secciones B, C, D)

### 🎯 **Roles en Cada Grupo**
- **Líder Técnico**: Coordina la implementación integral
- **Especialista en Instalación**: Responsable de la configuración de MySQL
- **Especialista en Seguridad**: Implementa usuarios y privilegios
- **Especialista en Monitorización**: Ejecuta comandos de monitoreo y backup
- **Especialista en Conexiones**: Desarrolla scripts de conexión
- **Documentador**: Registra todos los pasos y hallazgos

---

## 🛠️ Herramientas y Recursos

### 💻 **Software Requerido**
- MySQL 8.0+ instalado y funcionando
- MySQL Workbench instalado y configurado
- Cliente de línea de comandos MySQL funcionando
- Python 3.x con mysql-connector-python (opcional)

### 📚 **Documentación Disponible**
- `guia_unidad1.md` - Extracto organizado de la guía oficial
- `mejores_practicas_seguridad.md` - Guía de seguridad para MySQL
- `ejemplos_comandos.sql` - Comandos de referencia para todas las secciones
- `mysql_setup.sql` - Script de configuración inicial
- `ejercicio_1/enunciado.md` - Sección A completa
- `ejercicio_2/enunciado.md` - Secciones B, C, D integradas

### 🔗 **Recursos Online**
- Documentación oficial de MySQL
- Guías de instalación y configuración
- Mejores prácticas de seguridad
- Documentación de MySQL Connectors

---

## 📊 Métricas de Evaluación

### ✅ **Criterios de Éxito**
- **Instalación y Configuración (Sección A)**: 25%
  - MySQL funcionando correctamente
  - MySQL Workbench configurado
  - Conexiones funcionando

- **Seguridad Implementada (Sección B)**: 25%
  - Usuarios creados correctamente
  - Privilegios asignados apropiadamente
  - Principio del mínimo privilegio aplicado

- **Monitorización y Mantenimiento (Sección C)**: 25%
  - Comandos de monitorización ejecutados
  - Backup y restauración funcionando
  - Análisis de métricas realizado

- **Conexiones y Arquitectura (Sección D)**: 25%
  - Script de conexión funcionando
  - Base de datos de prueba creada
  - Investigación de servicios en nube

---

## 🚨 Puntos de Atención

### ⚠️ **Desafíos Anticipados**
1. **Problemas de Instalación**: MySQL puede tener dependencias específicas del sistema
2. **Configuración de Seguridad**: Los privilegios deben ser precisos
3. **Conexiones**: Problemas de red o configuración pueden impedir conexiones
4. **Permisos del Sistema**: Algunos comandos requieren permisos de administrador
5. **Backup y Restauración**: Espacio en disco y permisos de escritura
6. **Scripts de Conexión**: Dependencias de Python y librerías

### 💡 **Estrategias de Apoyo**
- **Pair Programming**: Trabajar en parejas para resolver problemas
- **Consultas Rápidas**: 5 minutos de consulta por grupo
- **Ejemplos de Referencia**: Código de ejemplo disponible
- **Documentación**: Guías paso a paso para cada ejercicio
- **División de Tareas**: Cada especialista se enfoca en su área

---

## 📝 Entregables de la Clase

### 🎯 **Al Final de la Clase**
- [ ] MySQL instalado y funcionando correctamente
- [ ] MySQL Workbench configurado y conectando
- [ ] Usuarios y privilegios configurados según especificaciones
- [ ] Exploración de bases de datos del sistema completada
- [ ] Comandos de monitorización ejecutados y analizados
- [ ] Proceso de backup y restauración funcionando
- [ ] Script de conexión de aplicación funcionando
- [ ] Investigación sobre servicios en la nube completada

### 📚 **Para la Próxima Clase**
- [ ] Revisión y mejora de la configuración de seguridad
- [ ] Documentación completa de la solución integral
- [ ] Análisis de vulnerabilidades potenciales
- [ ] Propuestas de mejora en monitorización
- [ ] Reflexión sobre aprendizajes y desafíos de toda la Unidad 1

---

## 🔄 Flujo de Trabajo Recomendado

### 1️⃣ **Planificación (10 min)**
- Leer y entender ambos enunciados
- Identificar objetivos de aprendizaje de todas las secciones
- Planificar la implementación integral
- Distribuir roles y responsabilidades

### 2️⃣ **Implementación (50 min)**
- **Sección A (15 min)**: Instalar y configurar MySQL
- **Sección B (20 min)**: Crear usuarios y asignar privilegios
- **Sección C (20 min)**: Monitorización, backup y restauración
- **Sección D (20 min)**: Conexiones y scripts de aplicación

### 3️⃣ **Testing (15 min)**
- Verificar conexiones y permisos
- Probar funcionalidades de backup
- Validar script de conexión
- Comprobar exploración de bases del sistema

### 4️⃣ **Documentación (15 min)**
- Capturar pantallas importantes
- Documentar decisiones de configuración
- Preparar presentación integral
- Reflexionar sobre aprendizajes

---

## 🎯 Objetivos de Aprendizaje Integrales

### 📚 **Conceptos Técnicos (Unidad 1 Completa)**
- Instalación y configuración de MySQL
- Gestión de usuarios y privilegios
- Exploración de bases de datos del sistema
- Implementación de medidas de seguridad básicas
- Monitorización y mantenimiento de bases de datos
- Arquitectura cliente-servidor
- Conexión de aplicaciones a bases de datos

### 🛠️ **Habilidades Prácticas**
- Instalación de software de base de datos
- Configuración de herramientas de administración
- Gestión de seguridad en bases de datos
- Exploración y documentación de sistemas
- Procesos de backup y restauración
- Desarrollo de scripts de conexión
- Análisis de métricas de rendimiento

### 🚀 **Competencias Profesionales**
- Trabajo en equipo en proyectos técnicos complejos
- Resolución de problemas de instalación y configuración
- Aplicación de mejores prácticas de seguridad
- Documentación técnica efectiva
- Gestión integral de sistemas de bases de datos
- Evaluación de soluciones en la nube

---

## 📚 **Contenido Completo de la Unidad 1**

### 🔍 **Todas las Secciones Cubiertas**
1. **Sección A**: Introducción a SGBD y Configuración Inicial
   - Conceptos fundamentales de SGBD
   - Instalación de MySQL
   - Configuración de MySQL Workbench

2. **Sección B**: Seguridad en MySQL y Gestión de Usuarios
   - Principios de seguridad en bases de datos
   - Creación y gestión de usuarios
   - Asignación de privilegios
   - Exploración de bases del sistema

3. **Sección C**: Monitorización y Mantenimiento
   - Comandos de monitorización básica
   - Estrategias de backup y restauración
   - Procesos de mantenimiento y optimización

4. **Sección D**: Pruebas, Arquitectura y Conexiones
   - Arquitectura cliente-servidor
   - Conexión de aplicaciones a bases de datos
   - Servicios de base de datos en la nube

### 🎯 **Resultado Final**
**¡Cobertura completa de la Unidad 1 en una sola clase integradora!**

---

*Cronograma actualizado para la clase de Base de Datos Aplicada - UCC 2025*
