-- ⭐ 1. Crear el Dataset
CREATE SCHEMA IF NOT EXISTS clase_bigquery_rreyes;

-- ⭐ 2. Crear tabla Dimensión: dim_productos
CREATE TABLE IF NOT EXISTS clase_bigquery_rreyes.dim_productos (
  producto_id INT64,
  nombre STRING,
  categoria STRING
);

INSERT INTO clase_bigquery_rreyes.dim_productos (producto_id, nombre, categoria)
VALUES
  (1, 'Laptop Gamer X15', 'Tecnología'),
  (2, 'Smartphone Z100', 'Tecnología'),
  (3, 'Aspiradora MaxClean', 'Hogar'),
  (4, 'Cafetera UltraBrew', 'Hogar'),
  (5, 'Monitor UltraWide 32"', 'Tecnología'),
  (6, 'Silla ErgoPro', 'Oficina'),
  (7, 'Escritorio Robusto XL', 'Oficina');

-- ⭐ 3. Crear tabla Fact: fact_ventas
CREATE TABLE IF NOT EXISTS clase_bigquery_rreyes.fact_ventas (
  fecha DATE,
  producto_id INT64,
  cliente_id INT64,
  vendedor_id INT64,
  cantidad INT64,
  monto FLOAT64
)
PARTITION BY fecha
CLUSTER BY producto_id;

INSERT INTO clase_bigquery_rreyes.fact_ventas 
(fecha, producto_id, cliente_id, vendedor_id, cantidad, monto)
VALUES
  ('2024-01-01', 1, 101, 10, 1, 1200000),
  ('2024-01-01', 2, 102, 11, 1, 350000),
  ('2024-01-02', 3, 103, 10, 2, 180000),
  ('2024-01-02', 4, 104, 12, 1, 95000),
  ('2024-01-03', 5, 105, 11, 1, 450000),
  ('2024-01-03', 6, 106, 12, 1, 170000),
  ('2024-01-04', 7, 107, 10, 1, 250000),
  ('2024-01-04', 1, 108, 11, 1, 1200000),
  ('2024-01-05', 2, 109, 12, 2, 700000),
  ('2024-01-05', 3, 110, 10, 1, 90000);

-- ⭐ 4. Confirmar estructura (opcional)
SELECT * FROM clase_bigquery_rreyes.dim_productos;
SELECT * FROM clase_bigquery_rreyes.fact_ventas;

-- 🧪 5. Ejemplos de consultas que podrás hacer con esto
-- ✔ Ranking

SELECT vendedor_id, SUM(monto) AS total,
       RANK() OVER(ORDER BY SUM(monto) DESC) AS ranking
FROM clase_bigquery_rreyes.fact_ventas
GROUP BY vendedor_id;

-- ✔ Ventas acumuladas
SELECT fecha, SUM(monto) AS total,
       SUM(SUM(monto)) OVER(ORDER BY fecha) AS acumulado
FROM clase_bigquery_rreyes.fact_ventas
GROUP BY fecha
ORDER BY fecha;

-- ✔ JOIN + Agregaciones
WITH diario AS (
  SELECT fecha, SUM(monto) AS total
  FROM clase_bigquery_rreyes.fact_ventas
  GROUP BY fecha
)
SELECT fecha, total,
       LAG(total) OVER(ORDER BY fecha) AS dia_anterior
FROM diario;

-- ✔ CTE
WITH diario AS (
  SELECT fecha, SUM(monto) AS total
  FROM clase_bigquery_rreyes.fact_ventas
  GROUP BY fecha
)
SELECT fecha, total,
       LAG(total) OVER(ORDER BY fecha) AS dia_anterior
FROM diario;
