# [Clase 5: Profundizando en BigQuery](https://console.cloud.google.com/bigquery?referrer=search&project=cursogcp-478515&ws=!1m0)

## Resumen de la Clase

Esta sesión de 4 horas está dedicada íntegramente a la segunda parte del **Módulo 4**, donde los participantes pasarán de las consultas básicas a un análisis más sofisticado y aprenderán técnicas clave para la optimización del rendimiento y los costos en BigQuery.

---

### **Módulo(s) Cubierto(s):**
*   **Módulo 4:** Análisis de Datos con BigQuery (Parte 2 de 3)

### **Objetivos de Aprendizaje:**
*   Escribir consultas SQL más complejas para análisis de datos.
*   Comprender y aplicar funciones analíticas (window functions).
*   Entender el modelo de costos de BigQuery y cómo gestionarlo.
*   Aprender a optimizar consultas y el diseño de tablas para mejorar el rendimiento.

### **Contenidos a Cubrir:**
1.  **SQL para Análisis en BigQuery:**
    *   Repaso de `JOINs` y `UNIONs`.
    *   Funciones de agregación avanzadas.
    *   Funciones de ventana (`OVER (PARTITION BY ... ORDER BY ...)`).
    *   Uso de `WITH` para Expresiones de Tabla Comunes (CTEs).
2.  **Optimización de Consultas y Costos:**
    *   **Modelo de Precios:** On-demand vs. flat-rate.
    *   **Buenas Prácticas de Optimización:**
        *   Evitar `SELECT *`.
        *   Usar `LIMIT` en la exploración.
        *   Entender el plan de ejecución de la consulta.
        *   Filtrar temprano y en la partición correcta.
3.  **Optimización del Almacenamiento:**
    *   **Tablas Particionadas:** Por tiempo de ingesta o por columna.
    *   **Tablas Clusterizadas:** Ordenar datos para un acceso más rápido.
    *   Vistas y Vistas Materializadas.

### **Actividades Prácticas:**
*   **Sesión de Práctica de SQL:**
    *   Resolver una serie de problemas de negocio utilizando consultas SQL sobre un conjunto de datos público de BigQuery.
*   **Laboratorio de Optimización:**
    *   Crear una tabla particionada y una clusterizada.
    *   Ejecutar consultas de comparación para observar la diferencia en los datos procesados y el tiempo de ejecución.
