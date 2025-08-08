# 🎓 UCC - Clases de Base de Datos

## 📁 Estructura del Proyecto

```
ucc/clases/
├── clase-01/           # Material de la primera clase
│   ├── README.md       # Notas de la clase
│   ├── consigna1_solucion.sql  # Solución de la consigna
│   └── ...
├── mysql/              # Entorno de desarrollo MySQL
│   ├── compose.yaml    # Configuración Docker
│   ├── init.sql        # Script de inicialización
│   └── README.md       # Documentación del entorno
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
