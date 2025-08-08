# 🐳 MySQL Development Environment

## 📋 Descripción

Esta carpeta contiene la configuración de Docker Compose para crear un entorno de desarrollo MySQL consistente y aislado.

## 🏗️ Configuración

### Servicios
- **MySQL 8.4**: Base de datos principal
- **Puerto**: 3306 (expuesto al host)
- **Base de datos inicial**: `example`
- **Volumen persistente**: `db_data`

### Usuarios
- **Root**: Contraseña `root`
- **gseverina**: Contraseña `gseverina` (usuario de desarrollo)

## 🚀 Uso

### Iniciar el entorno
```bash
cd mysql
docker-compose up -d
```

### Conectar con MySQL
```bash
# Conectar como gseverina
mysql -h 127.0.0.1 -P 3306 -u gseverina -p

# Conectar directamente a la base de datos example
mysql -h 127.0.0.1 -P 3306 -u gseverina -p example

# Conectar como root
mysql -h 127.0.0.1 -P 3306 -u root -p
```

### Ejecutar scripts SQL
```bash
# Ejecutar script de la clase-01
mysql -h 127.0.0.1 -P 3306 -u gseverina -p example < ../clase-01/consigna1_solucion.sql
```

### Verificar estado
```bash
docker-compose ps
```

### Detener el entorno
```bash
docker-compose down
```

## 🔧 Características

- **Healthcheck**: Monitoreo automático del estado del contenedor
- **Persistencia**: Los datos se mantienen entre reinicios
- **Aislamiento**: Entorno independiente del sistema host
- **Portabilidad**: Funciona igual en cualquier máquina con Docker

## 📝 Notas

- Usar `127.0.0.1` en lugar de `localhost` para evitar problemas con sockets
- Los datos se almacenan en el volumen `db_data` de Docker
- El contenedor se reinicia automáticamente si se detiene
