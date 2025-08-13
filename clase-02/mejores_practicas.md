# Mejores Prácticas para MySQL - Clase 02

**Base de Datos Aplicada - UCC 2025**

## 📋 Índice

1. [Nomenclatura y Convenciones](#nomenclatura-y-convenciones)
2. [Diseño de Tablas](#diseño-de-tablas)
3. [Índices y Rendimiento](#índices-y-rendimiento)
4. [Consultas SQL](#consultas-sql)
5. [Seguridad](#seguridad)
6. [Mantenimiento](#mantenimiento)
7. [Herramientas Recomendadas](#herramientas-recomendadas)

---

## 🏷️ Nomenclatura y Convenciones

### ✅ Nombres de Tablas
- **Usar plural** para tablas de entidades: `clientes`, `productos`, `pedidos`
- **Usar snake_case**: `detalle_pedidos`, `historial_ventas`
- **Evitar abreviaciones**: `usr` → `usuarios`, `prod` → `productos`

### ✅ Nombres de Columnas
- **Claves primarias**: `id_[nombre_tabla]` → `id_cliente`, `id_producto`
- **Claves foráneas**: `id_[tabla_referenciada]` → `id_cliente`, `id_categoria`
- **Campos de fecha**: `fecha_[accion]` → `fecha_creacion`, `fecha_modificacion`
- **Campos de estado**: `estado`, `activo`, `habilitado`

### ✅ Nombres de Bases de Datos
- **Usar minúsculas**: `clase_02_db`, `sistema_ventas`
- **Evitar caracteres especiales**: No usar espacios, guiones o caracteres especiales

---

## 🏗️ Diseño de Tablas

### ✅ Estructura Básica
```sql
CREATE TABLE nombre_tabla (
    id_nombre_tabla INT AUTO_INCREMENT PRIMARY KEY,
    campo1 VARCHAR(100) NOT NULL,
    campo2 DECIMAL(10,2) DEFAULT 0.00,
    campo3 TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    campo4 TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índices
    INDEX idx_campo1 (campo1),
    INDEX idx_campo2_campo3 (campo2, campo3),
    
    -- Constraints
    CONSTRAINT fk_campo1 FOREIGN KEY (campo1) REFERENCES otra_tabla(id_otra_tabla),
    CONSTRAINT chk_campo2 CHECK (campo2 >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### ✅ Tipos de Datos Recomendados
- **Enteros**: `INT` para IDs, `BIGINT` para números grandes
- **Decimales**: `DECIMAL(10,2)` para monedas, `FLOAT` para cálculos científicos
- **Texto**: `VARCHAR(255)` para nombres, `TEXT` para contenido largo
- **Fechas**: `DATE` para fechas, `TIMESTAMP` para timestamps automáticos
- **Booleanos**: `TINYINT(1)` o `BOOLEAN` (alias de TINYINT(1))

### ✅ Constraints Importantes
```sql
-- NOT NULL para campos obligatorios
campo_obligatorio VARCHAR(100) NOT NULL,

-- DEFAULT para valores por defecto
campo_con_default INT DEFAULT 0,

-- CHECK para validaciones
campo_validado DECIMAL(10,2) CHECK (campo_validado >= 0),

-- UNIQUE para valores únicos
campo_unico VARCHAR(100) UNIQUE,

-- FOREIGN KEY para referencias
campo_referencia INT,
CONSTRAINT fk_nombre FOREIGN KEY (campo_referencia) REFERENCES otra_tabla(id)
```

---

## 🚀 Índices y Rendimiento

### ✅ Tipos de Índices
```sql
-- Índice simple
CREATE INDEX idx_nombre ON tabla(campo);

-- Índice compuesto
CREATE INDEX idx_campo1_campo2 ON tabla(campo1, campo2);

-- Índice único
CREATE UNIQUE INDEX idx_campo_unico ON tabla(campo);

-- Índice parcial (MySQL 8.0+)
CREATE INDEX idx_campo_parcial ON tabla(campo) WHERE campo IS NOT NULL;
```

### ✅ Estrategias de Indexación
1. **Claves primarias**: Automáticamente indexadas
2. **Claves foráneas**: Siempre indexar para JOINs
3. **Campos de búsqueda**: Indexar campos usados en WHERE
4. **Campos de ordenamiento**: Indexar campos usados en ORDER BY
5. **Campos de agrupación**: Indexar campos usados en GROUP BY

### ✅ Análisis de Rendimiento
```sql
-- Analizar consulta
EXPLAIN SELECT * FROM tabla WHERE campo = 'valor';

-- Ver índices existentes
SHOW INDEX FROM tabla;

-- Estadísticas de uso
SHOW TABLE STATUS LIKE 'tabla';
```

---

## 🔍 Consultas SQL

### ✅ Consultas Básicas
```sql
-- Siempre especificar columnas
SELECT id, nombre, email FROM clientes;  -- ✅ Correcto
SELECT * FROM clientes;                  -- ❌ Evitar en producción

-- Usar alias para tablas
SELECT c.nombre, p.fecha FROM clientes c JOIN pedidos p ON c.id = p.id_cliente;

-- Limitar resultados en desarrollo
SELECT * FROM tabla LIMIT 100;
```

### ✅ JOINs Eficientes
```sql
-- Usar INNER JOIN cuando sea necesario
SELECT c.nombre, p.fecha 
FROM clientes c 
INNER JOIN pedidos p ON c.id = p.id_cliente;

-- Usar LEFT JOIN para incluir todos los registros de la izquierda
SELECT c.nombre, COUNT(p.id) as total_pedidos
FROM clientes c 
LEFT JOIN pedidos p ON c.id = p.id_cliente
GROUP BY c.id, c.nombre;
```

### ✅ Subconsultas y CTEs
```sql
-- Usar CTEs para consultas complejas
WITH ventas_mensuales AS (
    SELECT MONTH(fecha) as mes, SUM(total) as ventas
    FROM pedidos 
    WHERE YEAR(fecha) = 2025
    GROUP BY MONTH(fecha)
)
SELECT * FROM ventas_mensuales WHERE ventas > 10000;

-- Evitar subconsultas en WHERE cuando sea posible
-- ❌ Lento
SELECT * FROM productos WHERE precio > (SELECT AVG(precio) FROM productos);

-- ✅ Más eficiente con JOIN
SELECT p.* FROM productos p 
CROSS JOIN (SELECT AVG(precio) as precio_promedio FROM productos) avg_table
WHERE p.precio > avg_table.precio_promedio;
```

---

## 🔒 Seguridad

### ✅ Usuarios y Permisos
```sql
-- Crear usuario específico para la aplicación
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'password_seguro';

-- Otorgar solo permisos necesarios
GRANT SELECT, INSERT, UPDATE, DELETE ON base_datos.* TO 'app_user'@'localhost';

-- No otorgar permisos de administración
-- ❌ Evitar: GRANT ALL PRIVILEGES ON *.* TO 'app_user'@'localhost';
```

### ✅ Prevención de SQL Injection
```sql
-- ❌ Vulnerable a SQL Injection
-- "SELECT * FROM usuarios WHERE nombre = '" + nombreUsuario + "'"

-- ✅ Usar prepared statements
PREPARE stmt FROM 'SELECT * FROM usuarios WHERE nombre = ?';
EXECUTE stmt USING @nombre_usuario;
DEALLOCATE PREPARE stmt;
```

### ✅ Validación de Datos
```sql
-- Usar CHECK constraints
CREATE TABLE productos (
    id INT PRIMARY KEY,
    precio DECIMAL(10,2) CHECK (precio > 0),
    stock INT CHECK (stock >= 0)
);

-- Usar triggers para validaciones complejas
DELIMITER //
CREATE TRIGGER validar_stock
BEFORE INSERT ON detalle_pedidos
FOR EACH ROW
BEGIN
    DECLARE stock_disponible INT;
    SELECT stock INTO stock_disponible FROM productos WHERE id = NEW.id_producto;
    
    IF NEW.cantidad > stock_disponible THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente';
    END IF;
END//
DELIMITER ;
```

---

## 🛠️ Mantenimiento

### ✅ Backups Regulares
```bash
# Backup completo
mysqldump -u usuario -p base_datos > backup_$(date +%Y%m%d_%H%M%S).sql

# Backup de estructura
mysqldump -u usuario -p --no-data base_datos > estructura.sql

# Backup de datos
mysqldump -u usuario -p --no-create-info base_datos > datos.sql
```

### ✅ Optimización de Tablas
```sql
-- Analizar tabla
ANALYZE TABLE nombre_tabla;

-- Optimizar tabla
OPTIMIZE TABLE nombre_tabla;

-- Verificar tabla
CHECK TABLE nombre_tabla;

-- Reparar tabla si es necesario
REPAIR TABLE nombre_tabla;
```

### ✅ Monitoreo de Rendimiento
```sql
-- Variables de estado
SHOW STATUS LIKE 'Slow_queries';
SHOW STATUS LIKE 'Questions';
SHOW STATUS LIKE 'Uptime';

-- Procesos activos
SHOW PROCESSLIST;

-- Variables del servidor
SHOW VARIABLES LIKE 'max_connections';
SHOW VARIABLES LIKE 'query_cache_size';
```

---

## 🛠️ Herramientas Recomendadas

### ✅ Desarrollo
- **MySQL Workbench**: IDE oficial de MySQL
- **DBeaver**: Cliente universal de bases de datos
- **phpMyAdmin**: Interfaz web (para desarrollo)

### ✅ Monitoreo
- **MySQL Enterprise Monitor**: Monitoreo empresarial
- **Percona Monitoring**: Monitoreo open source
- **Prometheus + Grafana**: Monitoreo personalizado

### ✅ Análisis de Rendimiento
- **MySQL Slow Query Log**: Log de consultas lentas
- **pt-query-digest**: Análisis de consultas
- **MySQLTuner**: Optimización automática

---

## 📚 Recursos Adicionales

- **Documentación oficial**: https://dev.mysql.com/doc/
- **MySQL Performance Blog**: https://www.percona.com/blog/
- **MySQL 8.0 Reference Manual**: https://dev.mysql.com/doc/refman/8.0/en/
- **MySQL Cookbook**: O'Reilly Media

---

## 🎯 Checklist de Implementación

### ✅ Antes de Crear una Tabla
- [ ] ¿El nombre sigue las convenciones?
- [ ] ¿Los tipos de datos son apropiados?
- [ ] ¿Se definieron las constraints necesarias?
- [ ] ¿Se planearon los índices?

### ✅ Antes de Ejecutar una Consulta
- [ ] ¿Se usó EXPLAIN para analizar el plan?
- [ ] ¿Se limitaron los resultados en desarrollo?
- [ ] ¿Se especificaron las columnas necesarias?
- [ ] ¿Se usaron los JOINs apropiados?

### ✅ Antes de Hacer Deploy
- [ ] ¿Se crearon los índices necesarios?
- [ ] ¿Se configuraron los usuarios y permisos?
- [ ] ¿Se implementaron las validaciones de datos?
- [ ] ¿Se documentaron las reglas de negocio?

---

*Documento creado para la clase de Base de Datos Aplicada - UCC 2025*
