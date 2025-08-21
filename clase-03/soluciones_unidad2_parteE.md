# Soluciones - Unidad 2 - Parte E: Plan de Recuperación ante Incidentes, Redundancia y Medios de Almacenamiento

**Base de Datos Aplicada - UCC 2025**

---

## **E. Plan de Recuperación ante Incidentes, Redundancia y Medios de Almacenamiento**

### **1. Plan de Recuperación ante Incidentes (DRP)**

#### **1.1 ¿Qué es un DRP y por qué es esencial?**

**Respuesta:**

**¿Qué es un DRP?**
Un Plan de Recuperación ante Incidentes (DRP) es un documento formal que detalla los procedimientos, roles, responsabilidades y recursos necesarios para restaurar los servicios de TI después de un incidente o desastre.

**¿Por qué es esencial para la continuidad del negocio?**

**a) Minimización del tiempo de inactividad:**
- RTO definido y procedimientos probados
- Recursos asignados para recuperación rápida

**b) Protección de la reputación:**
- Mantener confianza del cliente durante incidentes
- Cumplir con acuerdos de nivel de servicio

**c) Cumplimiento normativo:**
- Cumplir con regulaciones de la industria
- Evitar sanciones por incumplimiento

#### **1.2 Definición de RTO y RPO**

**RTO (Recovery Time Objective):**
- **Definición:** Tiempo máximo aceptable para restaurar un servicio
- **Ejemplo:** "La base de datos debe estar disponible en menos de 4 horas"
- **Factores:** Complejidad del sistema, recursos disponibles

**RPO (Recovery Point Objective):**
- **Definición:** Cantidad máxima de datos que se puede perder
- **Ejemplo:** "Se puede perder como máximo 1 hora de datos"
- **Factores:** Frecuencia de backups, tolerancia a pérdida

**Influencia en el diseño del DRP:**
- **RTO bajo:** Requiere recursos significativos y procedimientos optimizados
- **RPO bajo:** Requiere backups frecuentes y sincronización continua
- **Balance:** Combinar técnicas según criticidad de la aplicación

---

### **2. Redundancia de Datos y Hardware**

#### **2.1 Concepto de "Redundancia de Datos" en MySQL**

**Respuesta:**

**¿Qué es la Redundancia de Datos?**
La redundancia de datos es la duplicación intencional de información en múltiples ubicaciones o sistemas para garantizar la disponibilidad y protección contra pérdida de datos.

**Formas de lograr redundancia en MySQL:**

**a) Replicación Master-Slave:**
- **Configuración:** Un servidor maestro y uno o más esclavos
- **Ventajas:** Distribución de carga, backup sin interrupción
- **Implementación:**
  ```sql
  -- En el maestro
  CREATE USER 'repl_user'@'%' IDENTIFIED BY 'ReplPass123!';
  GRANT REPLICATION SLAVE ON *.* TO 'repl_user'@'%';
  
  -- En el esclavo
  CHANGE MASTER TO
    MASTER_HOST = '192.168.1.100',
    MASTER_USER = 'repl_user',
    MASTER_PASSWORD = 'ReplPass123!';
  START SLAVE;
  ```

**b) Replicación Master-Master:**
- **Configuración:** Dos o más servidores que pueden manejar escrituras
- **Ventajas:** Alta disponibilidad, distribución geográfica
- **Consideraciones:** Conflictos de datos, sincronización compleja

#### **2.2 ¿Qué es la "Redundancia de Hardware"?**

**Respuesta:**

**¿Qué es la Redundancia de Hardware?**
La redundancia de hardware es la duplicación de componentes físicos críticos del sistema para garantizar la continuidad del servicio ante fallos de hardware individuales.

**Componentes que deben ser redundantes:**

**a) Alimentación eléctrica:**
- UPS (Uninterruptible Power Supply)
- Generadores de respaldo
- Fuentes de alimentación duales

**b) Redes:**
- Switches redundantes
- Enlaces de red múltiples
- NICs redundantes

**c) Almacenamiento:**
- Controladores RAID
- Enlaces de almacenamiento múltiples
- Storage pools redundantes

---

### **3. Medios de Almacenamiento**

#### **3.1 Comparación HDD vs SSD para bases de datos**

**Respuesta:**

**Comparación HDD vs SSD:**

**a) Rendimiento:**
- **HDD:** 80-160 MB/s, 5-15 ms acceso, 75-150 IOPS
- **SSD:** 500-7000 MB/s, 0.1-0.2 ms acceso, 50,000-1,000,000+ IOPS

**b) Costo:**
- **HDD:** $0.02-$0.05 por GB, costo inicial bajo
- **SSD:** $0.08-$0.20 por GB, costo inicial alto

**c) Casos de uso recomendados:**

**HDD para:**
- Almacenamiento masivo, datos históricos
- Presupuesto limitado, desarrollo/prueba
- Aplicaciones de lectura, data warehouses

**SSD para:**
- Bases de datos OLTP, transacciones de alta frecuencia
- Sistemas críticos, baja latencia
- Logs de transacciones, sistemas de caché

#### **3.2 ¿Qué es SAN y NAS?**

**Respuesta:**

**SAN (Storage Area Network):**
- **Definición:** Red de alta velocidad dedicada al almacenamiento
- **Protocolo:** Fibre Channel, iSCSI, FCoE
- **Acceso:** A nivel de bloque (block-level)
- **Rendimiento:** Muy alto (múltiples GB/s)
- **Ventajas:** Alto rendimiento, escalabilidad, alta disponibilidad
- **Desventajas:** Costo muy alto, complejidad

**NAS (Network Attached Storage):**
- **Definición:** Dispositivo de almacenamiento conectado a la red
- **Protocolo:** NFS, CIFS/SMB, HTTP
- **Acceso:** A nivel de archivo (file-level)
- **Rendimiento:** Medio (100-1000 MB/s)
- **Ventajas:** Costo relativamente bajo, facilidad de uso
- **Desventajas:** Rendimiento limitado, dependencia de red

---

### **4. Diseño de un Plan de Recuperación ante Incidentes**

#### **4.1 Esquema del DRP para tp_db**

**Respuesta:**

**Plan de Recuperación ante Incidentes para tp_db (Aplicación Web Crítica)**

**a) Detección del Incidente:**
- Monitoreo automático 24/7
- Indicadores: DB no responde, errores de conexión
- Escalación automática a DBA on-call
- Tiempo de detección: <5 minutos

**b) Roles y Responsabilidades:**
- **DBA Principal:** Coordinación general, toma de decisiones
- **DBA Secundario:** Ejecución de procedimientos, monitoreo
- **Administrador de Sistemas:** Infraestructura, recursos de hardware
- **Líder de Proyecto:** Comunicación con usuarios, gestión de expectativas

**c) Procedimientos de Restauración:**

**Escenario 1: Fallo de Servidor Principal**
1. Activar servidor esclavo (failover automático)
2. Verificar integridad de datos
3. Redirigir aplicaciones al nuevo maestro
4. Restaurar servidor principal
5. Sincronizar y revertir al maestro original

**Escenario 2: Corrupción de Datos**
1. Detener aplicaciones afectadas
2. Evaluar extensión del daño
3. Restaurar desde último backup válido
4. Aplicar binary logs para recuperar transacciones
5. Verificar integridad de datos
6. Reactivar aplicaciones

**d) RTO y RPO Deseados:**
- **RTO:** 4 horas (balance entre costo y criticidad)
- **RPO:** 1 hora (pérdida aceptable para el negocio)

---

### **5. Redundancia de Datos (Conceptual)**

#### **5.1 Replicación Master-Slave en MySQL**

**Respuesta:**

**Beneficios para redundancia y escalabilidad:**

**a) Redundancia:**
- Alta disponibilidad: Si falla el maestro, el esclavo puede tomar su lugar
- Failover automático: Cambio automático a servidor de respaldo
- Backup sin interrupción: Backups desde el esclavo sin afectar el maestro

**b) Escalabilidad de lectura:**
- Distribución de carga: Consultas de lectura se distribuyen entre servidores
- Mejora de rendimiento: Reducción de carga en el servidor principal
- Consultas paralelas: Múltiples consultas simultáneas en diferentes servidores

#### **5.2 Cómo ayuda la replicación a cumplir RPO bajo**

**Respuesta:**

**¿Cómo ayuda la replicación a cumplir un RPO bajo?**

**a) Sincronización en tiempo real:**
- Binary log streaming: Cambios se transmiten inmediatamente al esclavo
- Latencia mínima: Solo retraso de red entre maestro y esclavo
- RPO efectivo: <1 minuto en redes locales, <5 minutos en redes WAN

**b) Configuración para RPO bajo:**
- Replicación semisíncrona: Confirmación de escritura después de replicación
- Múltiples niveles de protección: Maestro → Esclavo 1 → Esclavo 2
- Monitoreo continuo: Verificar latencia y estado de replicación

---

### **6. Redundancia de Hardware (Conceptual)**

#### **6.1 Niveles de RAID para redundancia de hardware**

**Respuesta:**

**Niveles de RAID para redundancia:**

**a) RAID 1 (Mirroring):**
- **Configuración:** Mínimo 2 discos, datos duplicados
- **Redundancia:** 100% (puede fallar 1 disco)
- **Capacidad:** 50% del total
- **Casos de uso:** Sistema operativo, logs críticos

**b) RAID 5 (Parity):**
- **Configuración:** Mínimo 3 discos, paridad distribuida
- **Redundancia:** 1 disco (puede fallar 1 disco)
- **Capacidad:** (N-1) discos
- **Casos de uso:** Almacenamiento general, desarrollo

**c) RAID 10 (1+0):**
- **Configuración:** Mínimo 4 discos, combinación de RAID 1 y RAID 0
- **Redundancia:** 50% (puede fallar 1 disco por grupo)
- **Capacidad:** 50% del total
- **Casos de uso:** Bases de datos críticas, alto rendimiento

**d) RAID 6 (Double Parity):**
- **Configuración:** Mínimo 4 discos, doble paridad
- **Redundancia:** 2 discos (pueden fallar 2 discos)
- **Capacidad:** (N-2) discos
- **Casos de uso:** Almacenamiento de largo plazo, backups críticos

#### **6.2 Otros componentes de hardware redundantes**

**Respuesta:**

**Componentes que deben ser redundantes:**

**a) Fuentes de alimentación:**
- Múltiples PSU (Power Supply Units)
- Cada fuente debe poder alimentar todo el servidor
- Monitoreo y alertas si una fuente falla

**b) Ventiladores y refrigeración:**
- Múltiples ventiladores por componente crítico
- Prevención de sobrecalentamiento
- Sensores de temperatura y velocidad

**c) Tarjetas de red (NIC):**
- Múltiples interfaces de red
- Bonding/teaming para alta disponibilidad
- Monitoreo de estado de cada interfaz

**d) Controladores de almacenamiento:**
- Múltiples controladores RAID
- Failover automático entre controladores
- Multipathing para múltiples rutas de acceso

**e) Memoria RAM:**
- Módulos ECC (Error Correction Code)
- Detección y corrección de errores
- Múltiples canales de memoria

**f) Procesadores (CPU):**
- Múltiples sockets de CPU
- Balanceo de carga entre procesadores
- Monitoreo por socket

**g) UPS y generadores:**
- Múltiples fuentes de energía de respaldo
- Transferencia automática entre fuentes
- Monitoreo de baterías y combustible

---

## **Resumen de la Parte E**

### **Conceptos Clave Aprendidos:**

1. **Plan de Recuperación ante Incidentes (DRP):**
   - Definición y componentes esenciales
   - Importancia para la continuidad del negocio
   - Definición de RTO y RPO

2. **Redundancia de Datos:**
   - Replicación Master-Slave en MySQL
   - Beneficios para alta disponibilidad
   - Configuración para RPO bajo

3. **Redundancia de Hardware:**
   - Niveles RAID para protección de datos
   - Componentes críticos que deben ser redundantes
   - Configuraciones recomendadas para bases de datos

4. **Medios de Almacenamiento:**
   - Comparación HDD vs SSD
   - Tecnologías SAN y NAS
   - Contribución a redundancia y escalabilidad

### **Mejores Prácticas Implementadas:**

1. **Planificación Estratégica:** DRP bien documentado y probado
2. **Redundancia por Capas:** Múltiples niveles de protección
3. **Monitoreo Continuo:** Verificación de estado de sistemas
4. **Testing Regular:** Pruebas de recuperación programadas
5. **Documentación Completa:** Procedimientos detallados y actualizados

Esta parte proporciona las habilidades fundamentales para diseñar e implementar sistemas de alta disponibilidad y recuperación ante desastres, esenciales para entornos de producción críticos.
