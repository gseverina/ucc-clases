# 🎓 UCC - Clases de Base de Datos

## 📁 Estructura del Proyecto

```
ucc/clases/
├── clase-01/           # Material de la primera clase
│   ├── README.md       # Notas de la clase
│   ├── consigna1_solucion.sql  # Solución de la consigna
│   └── ...
├── clase-02/           # Material de la segunda clase
│   ├── README.md       # Notas de la clase
│   ├── guia_unidad1.md # Guía de la Unidad 1
│   ├── ejercicio_1/    # Ejercicios de la Unidad 1
│   ├── ejercicio_2/    # Ejercicios de la Unidad 1
│   └── ...
├── clase-03/           # Material de la tercera clase
│   ├── README.md       # Notas de la clase
│   ├── guia_unidad2.md # Guía de la Unidad 2
│   ├── soluciones_unidad2_parteA.md # Soluciones Parte A
│   ├── soluciones_unidad2_parteB.md # Soluciones Parte B
│   ├── soluciones_unidad2_parteC.md # Soluciones Parte C
│   ├── soluciones_unidad2_parteD.md # Soluciones Parte D
│   ├── soluciones_unidad2_parteE.md # Soluciones Parte E
│   ├── soluciones_unidad2_parteF.md # Soluciones Parte F
│   └── indice_unidad2_completa.md  # Índice completo
├── mysql/              # Entorno de desarrollo MySQL
│   ├── compose.yaml    # Configuración Docker
│   ├── init.sql        # Script de inicialización
│   └── README.md       # Documentación del entorno
├── docs/               # Documentación general
│   └── guia_de_trabajos_practicos.md # Guía oficial del curso
├── tmp/                # Archivos temporales (excluidos del repo)
│   └── README.md       # Explicación de archivos temporales
└── .gitignore          # Archivos excluidos del repositorio
```

## 🚀 Inicio Rápido

### 1. Configurar el entorno MySQL
```bash
cd mysql
docker-compose up -d
```

### 2. Ejecutar la solución de la clase
```bash
mysql -h 127.0.0.1 -P 3306 -u gseverina -p < clase-01/consigna1_solucion.sql
```

## 📋 Características

- **Entorno Docker**: MySQL 8.4 con configuración automática
- **Usuario de desarrollo**: `gseverina` con todos los privilegios
- **Base de datos**: `PEDIDOS` con todas las tablas y vistas
- **Archivos temporales**: Carpeta `tmp/` para distribuciones y backups

## 🎯 Contenido de las Clases

### **Clase 01 - Unidad 1: Instalación y Configuración de SGBD**
- Conceptos fundamentales de SGBD
- Instalación y configuración inicial de MySQL
- MySQL Workbench y herramientas de administración

### **Clase 02 - Unidad 1: Instalación y Configuración de SGBD (Continuación)**
- Seguridad y gestión de usuarios
- Monitorización y mantenimiento básico
- Pruebas y ajustes del sistema
- Conexión de aplicaciones a bases de datos

### **Clase 03 - Unidad 2: Administración y Gestión de Bases de Datos**
- Gestión avanzada de usuarios y privilegios
- Monitorización de rendimiento y mantenimiento
- Auditoría, registro de eventos y seguridad avanzada
- Backup, restauración y estrategias de respaldo
- Plan de recuperación ante incidentes y redundancia
- Estrategias de caché y optimización de rendimiento

## 🔧 Configuración

### Usuarios MySQL
- **Root**: Contraseña `root`
- **gseverina**: Contraseña `gseverina` (usuario de desarrollo)

### Puertos
- **MySQL**: 3306

## 📦 Archivos Temporales

La carpeta `tmp/` está destinada para archivos que no deben incluirse en el repositorio:
- Distribuciones ZIP del proyecto
- Archivos de backup temporales
- Logs y archivos de desarrollo

## 📝 Notas

- Usar `127.0.0.1` en lugar de `localhost` para conexiones MySQL
- El contenedor se reinicia automáticamente
- Los datos se mantienen en volumen Docker persistente
- Cada clase tiene su propia carpeta con material organizado
- Las soluciones están separadas por partes para facilitar el estudio
