# Checklist de Progreso - Clase 02

**Base de Datos Aplicada - UCC 2025**  
**Fecha:** Jueves 14 de Agosto de 2025

---

## 📋 Checklist General de la Clase

### 🚀 **Fase 1: Introducción y Contexto**
- [ ] Entendí los objetivos de la clase
- [ ] Comprendí la metodología de trabajo práctico
- [ ] Revisé la estructura de la Guía de Trabajos Prácticos
- [ ] Configuré mi entorno de trabajo con MySQL
- [ ] Verifiqué que todas las herramientas funcionen correctamente

### 🛠️ **Fase 2: Desarrollo de Ejercicios**
- [ ] Completé el análisis del problema asignado
- [ ] Diseñé el esquema de base de datos
- [ ] Implementé todas las tablas requeridas
- [ ] Creé los constraints necesarios
- [ ] Implementé los triggers de validación
- [ ] Creé las consultas de reporte
- [ ] Implementé las vistas útiles
- [ ] Probé todas las funcionalidades

### 🎯 **Fase 3: Puesta en Común**
- [ ] Presenté mi solución al grupo
- [ ] Participé en la discusión de desafíos
- [ ] Compartí las mejores prácticas que identifiqué
- [ ] Escuché y aprendí de las soluciones de otros grupos
- [ ] Tomé notas de las recomendaciones de mejora

---

## 📚 Checklist Específico por Ejercicio

### 🏛️ **Ejercicio 1: Sistema de Gestión de Biblioteca**

#### ✅ **Análisis y Diseño**
- [ ] Identifiqué todas las entidades principales (libros, usuarios, préstamos, categorías, autores)
- [ ] Definí las relaciones entre entidades
- [ ] Identifiqué todas las reglas de negocio
- [ ] Planifiqué la estructura de tablas

#### ✅ **Implementación del Esquema**
- [ ] Creé la tabla `libros` con todos los campos y constraints
- [ ] Creé la tabla `usuarios` con validaciones apropiadas
- [ ] Creé la tabla `autores` con campos requeridos
- [ ] Creé la tabla `libros_autores` para la relación muchos a muchos
- [ ] Creé la tabla `categorias` con constraints únicos
- [ ] Creé la tabla `prestamos` con validaciones de fechas

#### ✅ **Constraints y Validaciones**
- [ ] Implementé CHECK constraints para años de publicación
- [ ] Implementé UNIQUE constraints para ISBN y DNI
- [ ] Implementé FOREIGN KEY constraints para todas las relaciones
- [ ] Implementé NOT NULL constraints para campos obligatorios

#### ✅ **Triggers de Validación**
- [ ] Creé trigger para validar límite de libros prestados por usuario
- [ ] Creé trigger para validar disponibilidad del libro
- [ ] Creé trigger para actualizar estado del libro en préstamos
- [ ] Implementé manejo de errores con SIGNAL

#### ✅ **Consultas y Vistas**
- [ ] Creé consulta para libros más prestados
- [ ] Creé consulta para usuarios con préstamos vencidos
- [ ] Creé consulta para estadísticas por categoría
- [ ] Creé vista de libros disponibles
- [ ] Creé vista de préstamos activos
- [ ] Creé vista de usuarios con libros prestados

#### ✅ **Testing y Validación**
- [ ] Inserté datos de prueba en todas las tablas
- [ ] Probé todas las reglas de negocio
- [ ] Validé que los triggers funcionen correctamente
- [ ] Verifiqué que las consultas devuelvan resultados esperados

---

### 🍽️ **Ejercicio 2: Sistema de Gestión de Restaurante**

#### ✅ **Análisis y Diseño**
- [ ] Identifiqué todas las entidades principales (restaurantes, mesas, menús, ingredientes, empleados, clientes, pedidos, facturas)
- [ ] Definí las relaciones complejas entre entidades
- [ ] Identifiqué todas las reglas de negocio del restaurante
- [ ] Planifiqué la estructura de tablas considerando la complejidad

#### ✅ **Implementación del Esquema**
- [ ] Creé la tabla `restaurantes` con información básica
- [ ] Creé la tabla `mesas` con gestión de estados y capacidad
- [ ] Creé la tabla `categorias_menu` para organizar platos
- [ ] Creé la tabla `platos` con precios y estados
- [ ] Creé la tabla `ingredientes` con gestión de stock
- [ ] Creé la tabla `platos_ingredientes` para la relación muchos a muchos
- [ ] Creé la tabla `empleados` con roles y salarios
- [ ] Creé la tabla `clientes` para gestión de reservas
- [ ] Creé la tabla `reservas` con validaciones de horarios
- [ ] Creé la tabla `pedidos` con estados de flujo de trabajo
- [ ] Creé la tabla `items_pedido` para detalle de pedidos
- [ ] Creé la tabla `facturas` con cálculo de totales

#### ✅ **Constraints y Validaciones**
- [ ] Implementé CHECK constraints para capacidades de mesa (2-12 personas)
- [ ] Implementé CHECK constraints para precios positivos
- [ ] Implementé CHECK constraints para stock no negativo
- [ ] Implementé UNIQUE constraints para números de mesa por restaurante
- [ ] Implementé FOREIGN KEY constraints para todas las relaciones
- [ ] Implementé ENUM constraints para estados y roles

#### ✅ **Triggers de Validación**
- [ ] Creé trigger para validar disponibilidad de mesas en reservas
- [ ] Creé trigger para controlar stock de ingredientes
- [ ] Creé trigger para actualizar estados de mesas automáticamente
- [ ] Creé trigger para calcular totales de pedidos
- [ ] Creé trigger para calcular totales de facturas
- [ ] Implementé validaciones para reservas superpuestas

#### ✅ **Consultas y Vistas**
- [ ] Creé consulta para ventas por período
- [ ] Creé consulta para platos más vendidos
- [ ] Creé consulta para ocupación de mesas por horario
- [ ] Creé consulta para rendimiento de empleados
- [ ] Creé consulta para análisis de inventario
- [ ] Creé vista de mesas disponibles
- [ ] Creé vista de pedidos pendientes
- [ ] Creé vista de reservas del día
- [ ] Creé vista de inventario bajo
- [ ] Creé vista de facturación diaria

#### ✅ **Testing y Validación**
- [ ] Inserté datos de prueba en todas las tablas
- [ ] Probé el sistema de reservas con diferentes escenarios
- [ ] Validé la gestión de inventario de ingredientes
- [ ] Probé el flujo completo de pedidos y facturación
- [ ] Verifiqué que todas las reglas de negocio funcionen

---

## 🔍 Checklist de Calidad del Código

### 📝 **Documentación**
- [ ] Comenté todas las tablas con su propósito
- [ ] Comenté todos los constraints con su función
- [ ] Comenté todos los triggers con su lógica
- [ ] Documenté las decisiones de diseño importantes
- [ ] Incluí ejemplos de uso en comentarios

### 🏷️ **Nomenclatura y Convenciones**
- [ ] Usé snake_case para nombres de tablas y columnas
- [ ] Seguí el patrón `id_[nombre_tabla]` para claves primarias
- [ ] Seguí el patrón `id_[tabla_referenciada]` para claves foráneas
- [ ] Usé nombres descriptivos para todas las entidades
- [ ] Evité abreviaciones confusas

### 🚀 **Optimización y Rendimiento**
- [ ] Creé índices para todas las claves foráneas
- [ ] Creé índices para campos usados en WHERE frecuentemente
- [ ] Creé índices compuestos para consultas complejas
- [ ] Usé EXPLAIN para analizar consultas críticas
- [ ] Optimicé consultas que pueden ser lentas

### 🔒 **Seguridad y Validación**
- [ ] Implementé todas las validaciones de reglas de negocio
- [ ] Usé CHECK constraints para validaciones simples
- [ ] Usé triggers para validaciones complejas
- [ ] Implementé manejo de errores apropiado
- [ ] Validé que no se puedan insertar datos inválidos

---

## 📊 Checklist de Entregables

### 🎯 **Al Final de la Clase**
- [ ] Script SQL completo con implementación de todas las tablas
- [ ] Triggers implementados para validaciones de negocio
- [ ] Consultas de ejemplo que demuestren la funcionalidad
- [ ] Vistas creadas para facilitar consultas frecuentes
- [ ] Datos de prueba para validar el funcionamiento
- [ ] Documentación de la solución implementada

### 📚 **Para la Próxima Clase**
- [ ] Código revisado y optimizado
- [ ] Documentación completa de la solución
- [ ] Diagrama ER del sistema diseñado
- [ ] Análisis de rendimiento de consultas
- [ ] Propuestas de mejora y optimización
- [ ] Reflexión sobre aprendizajes y desafíos

---

## 🚨 Checklist de Problemas Comunes

### ⚠️ **Errores Frecuentes a Evitar**
- [ ] No olvidé crear índices para claves foráneas
- [ ] No olvidé implementar todas las reglas de negocio
- [ ] No olvidé validar fechas y rangos numéricos
- [ ] No olvidé manejar casos edge en triggers
- [ ] No olvidé probar con datos realistas
- [ ] No olvidé documentar decisiones de diseño

### 💡 **Mejoras a Implementar**
- [ ] Consideré usar CTEs para consultas complejas
- [ ] Consideré crear vistas materializadas para reportes frecuentes
- [ ] Consideré implementar particionamiento para tablas grandes
- [ ] Consideré usar stored procedures para lógica compleja
- [ ] Consideré implementar auditoría de cambios

---

## 🎯 Checklist de Objetivos de Aprendizaje

### 📚 **Conceptos Técnicos**
- [ ] Entendí cómo diseñar esquemas complejos de base de datos
- [ ] Aprendí a implementar reglas de negocio con triggers
- [ ] Comprendí cómo optimizar consultas mediante índices
- [ ] Aprendí a crear vistas para consultas frecuentes
- [ ] Entendí cómo manejar relaciones muchos a muchos

### 🛠️ **Habilidades Prácticas**
- [ ] Practiqué análisis de requerimientos de sistemas
- [ ] Implementé soluciones completas en MySQL
- [ ] Practiqué testing y validación de funcionalidades
- [ ] Documenté soluciones técnicas de manera clara
- [ ] Trabajé en equipo para resolver problemas complejos

### 🚀 **Competencias Profesionales**
- [ ] Desarrollé capacidad de resolución de problemas complejos
- [ ] Mejoré mis habilidades de comunicación técnica
- [ ] Aprendí a aplicar mejores prácticas en bases de datos
- [ ] Desarrollé pensamiento crítico en diseño de sistemas
- [ ] Practiqué trabajo colaborativo en proyectos técnicos

---

## 📝 Notas y Observaciones

### 💭 **Reflexiones Personales**
*[Espacio para que cada alumno escriba sus reflexiones sobre la clase]*

### ❓ **Dudas Pendientes**
*[Espacio para anotar dudas que requieren investigación adicional]*

### 🔗 **Recursos a Consultar**
*[Espacio para anotar recursos adicionales recomendados]*

---

*Checklist creado para la clase de Base de Datos Aplicada - UCC 2025*
