# Clase 01 - Base de Datos PEDIDOS

**📅 Fecha:** 7 de Agosto de 2025

## 📋 Descripción del Ejercicio

**Unidad Académica:** FACULTAD DE INGENIERÍA  
**Asignatura:** BASE DE DATOS APLICADA  
**Año académico:** 2025  
**Régimen:** SEMESTRAL  
**Horas Totales:** 60  
**Carácter:** TEÓRICA/PRÁCTICA  

### 🎯 Objetivo de la Clase
**Repaso de conceptos obtenidos en la materia anterior (Base de Datos I)** mediante la resolución práctica de la **Consigna 1 del Ejercicio Complementario**.

Los alumnos debían implementar:
- Diseño e implementación de una base de datos para un sistema de pedidos
- Creación de tablas con restricciones apropiadas
- Implementación de claves primarias y foráneas
- Poblado de datos de prueba
- Creación de vistas para consultas específicas
- Aplicación de reglas de gestión mediante constraints y triggers

---

## 📁 Archivos del Proyecto

### ✅ Solución Implementada
- **`consigna1_solucion.sql`** - Solución completa de la Consigna 1
  - Creación de base de datos `PEDIDOS`
  - 6 tablas con estructura profesional
  - 8 vistas para consultas específicas
  - Triggers para validaciones de negocio
  - CHECK constraints para integridad de datos

### 📚 Documentación
- **`mysql_code_style_best_practices.md`** - Mejores prácticas de MySQL
- **`mysql_sqlstate_examples.md`** - Ejemplos de SIGNAL y códigos SQLSTATE
- **`ejercicio_complementario.md`** - Enunciado del ejercicio
- **`figura1.png`** - Diagrama ER del sistema

### 📄 Documento Original
- **`Ejercicio Complementario.docx`** - Documento original del ejercicio

---

## 🏗️ Estructura de la Base de Datos

### 📊 Tablas Implementadas
1. **`clientes`** - Información de clientes
2. **`proveedores`** - Datos de proveedores
3. **`vendedores`** - Información de vendedores
4. **`productos`** - Catálogo de productos
5. **`pedidos`** - Cabecera de pedidos
6. **`detalle_pedidos`** - Líneas de pedidos

### 👁️ Vistas Creadas
1. **`v_clientes_entre_fechas`** - Clientes con pedidos entre fechas
2. **`v_vendedores_con_pedidos`** - Vendedores con cantidad de pedidos
3. **`v_pedidos_con_total_alto`** - Pedidos con total > $50,000
4. **`v_productos_vendidos_entre_fechas`** - Productos vendidos entre fechas
5. **`v_proveedor_mas_ventas`** - Proveedor con más ventas
6. **`v_clientes_sin_pedidos`** - Clientes sin pedidos
7. **`v_clientes_menos_de_dos_pedidos`** - Clientes con < 2 pedidos
8. **`v_ventas_por_origen`** - Ventas por origen (Nacional/Importado)

---

## 🎯 Reglas de Gestión Implementadas

### ✅ Consigna 1 (Completamente implementada)
- **RG1**: Origen Nacional/Importado → CHECK constraint
- **RG2**: Solo clientes registrados → FOREIGN KEY
- **RG3**: Stock suficiente → Trigger de validación
- **RG5**: Precio unitario por renglón → Campo específico
- **RG6**: Totalización por renglón → Campo calculado
- **RG7**: Clientes sin pedidos → Vista para identificación
- **RG8**: Campos obligatorios → NOT NULL
- **RG9**: Stock entre límites → CHECK constraint
- **RG10**: Anulación de pedidos → Estado 'anulado'

### 🔄 Consigna 2 (Por implementar)
- **RG4**: Actualización de stock al confirmar pedido
- **RG11**: Auditoría de pedidos anulados
- **RG12**: Recomposición de stock al anular pedido

---

## 🛠️ Características Técnicas

### ✅ Mejores Prácticas Implementadas
- **Nomenclatura**: snake_case en tablas y columnas
- **Claves foráneas**: Patrón `id_[tabla_referenciada]`
- **Sintaxis inline**: Para FOREIGN KEYs simples
- **CHECK constraints**: Para validaciones de dominio
- **Triggers**: Para lógica compleja de negocio
- **Vistas**: Para consultas frecuentes

### ✅ Validaciones Implementadas
- **Stock suficiente** antes de insertar detalle
- **Precios positivos** en productos y detalles
- **Cantidades positivas** en detalles
- **Estados válidos** en pedidos
- **Orígenes válidos** en productos

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

### 1. Ejecutar la Solución
```bash
mysql -u usuario -p < consigna1_solucion.sql
```

### 2. Verificar la Instalación
```sql
USE PEDIDOS;
SHOW TABLES;
SELECT * FROM clientes LIMIT 5;
```

### 3. Probar las Vistas
```sql
SELECT * FROM v_clientes_entre_fechas;
SELECT * FROM v_ventas_por_origen;
```

---

## 📊 Datos de Prueba Incluidos

### 👥 Clientes (5 registros)
- García, María
- López, Juan Carlos
- Martínez, Ana Sofía
- Rodríguez, Carlos Alberto
- Fernández, Lucía

### 🏢 Proveedores (3 registros)
- TecnoPro S.A.
- ImportTech Ltda.
- NacionalElectronics

### 👨‍💼 Vendedores (3 registros)
- González, Roberto
- Silva, Patricia
- Herrera, Miguel

### 📦 Productos (12 registros)
- Laptops, mouses, teclados, monitores, etc.

### 📋 Pedidos (10 registros)
- Con diferentes cantidades de renglones (1-3)

---

## 🔗 Enlaces Útiles

- **Repositorio GitHub**: https://github.com/gseverina/ucc-clases.git
- **Documentación MySQL**: https://dev.mysql.com/doc/
- **SQLSTATE Codes**: https://dev.mysql.com/doc/refman/8.0/en/signal.html

---

*Documento creado para la clase de Base de Datos Aplicada - UCC 2025*
