# MySQL SQLSTATE Codes & SIGNAL Examples

## 📋 Códigos SQLSTATE Comunes

### 🔴 Errores de Integridad
```sql
'23000'  -- Integrity constraint violation
'23502'  -- NOT NULL constraint violation
'23503'  -- FOREIGN KEY constraint violation
'23505'  -- UNIQUE constraint violation
'23514'  -- CHECK constraint violation
```

### 🔴 Errores de Datos
```sql
'22001'  -- String data, right truncation
'22003'  -- Numeric value out of range
'22007'  -- Invalid datetime format
'22008'  -- Datetime field overflow
'22012'  -- Division by zero
```

### 🔴 Errores de Usuario (Nuestro caso)
```sql
'45000'  -- Unhandled user-defined exception
'45001'  -- User-defined exception
'45002'  -- User-defined exception
```

---

## ⚡ Ejemplos de SIGNAL

### ✅ Validación de Stock
```sql
IF NEW.cantidad > stock_disponible THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Stock insuficiente para el producto seleccionado';
END IF;
```

### ✅ Validación de Precio
```sql
IF NEW.precio_unitario <= 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'El precio unitario debe ser mayor a cero';
END IF;
```

### ✅ Validación de Fecha
```sql
IF NEW.fecha < CURDATE() THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'La fecha no puede ser anterior a hoy';
END IF;
```

### ✅ Validación de Email
```sql
IF NEW.email NOT LIKE '%@%' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'El formato de email no es válido';
END IF;
```

### ✅ Validación de Comisión
```sql
IF NEW.comision < 0 OR NEW.comision > 100 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'La comisión debe estar entre 0 y 100';
END IF;
```

### ✅ Validación de Cantidad
```sql
IF NEW.cantidad <= 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'La cantidad debe ser mayor a cero';
END IF;
```

---

## 🎯 Uso en Triggers

### ✅ Trigger de Validación de Stock
```sql
DELIMITER //
CREATE TRIGGER tr_validar_stock_before_insert
BEFORE INSERT ON detalle_pedidos
FOR EACH ROW
BEGIN
    DECLARE stock_disponible INT;
    
    -- Obtener stock disponible del producto
    SELECT stock INTO stock_disponible
    FROM productos
    WHERE id = NEW.id_producto;
    
    -- Validar que hay stock suficiente
    IF NEW.cantidad > stock_disponible THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock insuficiente para el producto seleccionado';
    END IF;
END//
DELIMITER ;
```

### ✅ Trigger de Validación de Precio
```sql
DELIMITER //
CREATE TRIGGER tr_validar_precio_before_insert
BEFORE INSERT ON productos
FOR EACH ROW
BEGIN
    IF NEW.precio_unitario <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El precio unitario debe ser mayor a cero';
    END IF;
END//
DELIMITER ;
```

---

## 📝 Sintaxis Completa

```sql
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Mensaje de error personalizado';
```

### Parámetros:
- **SQLSTATE**: Código de error estándar
- **MESSAGE_TEXT**: Mensaje descriptivo del error

### Comportamiento:
- **Genera un error** personalizado
- **Interrumpe la ejecución** del trigger/procedimiento
- **Cancela la operación** (INSERT, UPDATE, DELETE)
- **Revierte cambios** pendientes

---

*Documento enfocado en códigos SQLSTATE y ejemplos de SIGNAL para validaciones de negocio.*
