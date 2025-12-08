# 1. SQL para Análisis Avanzado en BigQuery (2 horas)

🔹 Repaso de conceptos fundamentales

- JOIN: INNER, LEFT, RIGHT, FULL
- UNION vs UNION ALL
- Buenas prácticas de joins con BigQuery (evitar cross joins accidentales)

🔹 Funciones de Agregación Avanzadas
```sql
SELECT categoria,
       AVG(precio) AS precio_promedio,
       APPROX_COUNT_DISTINCT(cliente_id) AS clientes_unicos
FROM `tienda.productos`
GROUP BY categoria;
```

BigQuery incluye funciones adicionales:

- APPROX_TOP_COUNT
- APPROX_QUANTILES
- Funciones estadísticas (STDDEV, CORR, COVAR_POP, etc.)

# 2. Funciones de Ventana (Window Functions)

Explicación:

Permiten calcular métricas "sobre una ventana" de datos, sin agrupar ni perder granularidad.

Ejemplos esenciales:

a) Ranking
```sql
SELECT nombre, ventas,
       RANK() OVER (ORDER BY ventas DESC) AS ranking
FROM `demo.vendedores`;
```

b) Cálculo progresivo

```sql
SELECT fecha, ventas,
       SUM(ventas) OVER (ORDER BY fecha) AS ventas_acumuladas
FROM `demo.ventas`;
```

c) Particiones por grupo

```sql
SELECT categoria, producto, precio,
       AVG(precio) OVER (PARTITION BY categoria) AS promedio_categoria
FROM `demo.productos`;
```

Casos de uso en negocios:

- Ranking de productos
- Tendencias de ventas
- Comparaciones dentro de un mismo grupo

# 3. Expresiones de Tabla Comunes (CTEs) con WITH
Permiten organizar consultas complejas.

Ejemplo:
```sql
WITH ventas_diarias AS (
  SELECT fecha, SUM(monto) AS total
  FROM `demo.ventas`
  GROUP BY fecha
)
SELECT fecha,
       total,
       LAG(total) OVER (ORDER BY fecha) AS total_dia_anterior
FROM ventas_diarias;
```

# 4. Optimización de Consultas y Costos (1 hora)
🔹 Modelo de Precios

BigQuery cobra por:
- Almacenamiento
- Procesamiento de consultas (según TB leídos)
- Opcional: slots reservados (flat-rate)

Para estudiantes: solo usaremos on-demand, es decir:

Se cobra por los bytes que la consulta lee, no por lo que devuelve.

Buenas Prácticas de Optimización

✔ Evitar SELECT *
Causa costos innecesarios.

✔ Usar LIMIT en exploración

✔ Leer solo columnas necesarias
```sql
SELECT id, nombre FROM tabla;
```

✔ Filtrar temprano y correctamente
Especialmente en particiones:
```sql
WHERE fecha BETWEEN '2024-01-01' AND '2024-01-31'
```

✔ Revisar el Execution Details del Query Plan
- Bytes leídos
- Etapas de ejecución
- Operadores más costosos
✔ Usar clustering para columnas filtradas frecuentemente
✔ Usar particiones para tablas de millones de filas

# 5. Optimización del Almacenamiento (1 hora)
## Tablas Particionadas

Tipos:
- Por fecha de ingesta
- Por columna DATE/TIMESTAMP
- Por entero (NUMERIC partitioning)

Ventajas:
- Menos costo en consultas
- Acceso más rápido
- Fácil gestión por periodos (_PARTITIONTIME)

Ejemplo:
```sql
SELECT *
FROM `ventas.ventas_diarias`
WHERE _PARTITIONDATE = '2024-02-05';
```

## Tablas Clusterizadas
Permiten ordenar físicamente por columnas clave.

Ventajas:
- Queries más rápidas
- Menor cantidad de bytes leídos

Ejemplo:
```sql
CREATE TABLE dataset.tabla_cluster
PARTITION BY fecha
CLUSTER BY cliente, categoria AS
SELECT * FROM dataset.origen;
```

# 🧪 Actividad Práctica
Los estudiantes realizarán ejercicios prácticos:

1. Crear una tabla particionada
- Subir un CSV
- Definir partición por fecha

2. Crear una tabla clusterizada
- Clusterizar por una columna filtrada

3. Ejecutar consultas optimizadas
- Comparar bytes leídos con y sin particiones
- Probar ranking y funciones ventana
- Crear un CTE con WITH