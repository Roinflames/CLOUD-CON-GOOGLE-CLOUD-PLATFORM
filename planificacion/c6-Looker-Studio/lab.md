🎓 LAB DE 4 HORAS – BigQuery ML (Modelo de Clasificación con SQL)

Duración total: 4 horas
Nivel: Intermedio
Requerimientos: Cuenta de GCP, proyecto activo, BigQuery habilitado
Dataset: bigquery-public-data.ml_datasets.titanic

🧱 Estructura del LAB (4 horas)
Bloque 1 – Introducción + Configuración (20 min)

Objetivo:

Entender qué es BigQuery ML.

Abrir BigQuery y configurar entorno.

Actividades:

Ingresa a BigQuery → SQL Workspace.

Crear un dataset personal en su proyecto:

mi_lab_ml


Pregunta guía:

¿Qué ventajas tiene entrenar ML en BigQuery?

🧪 Bloque 2 – Exploración del Dataset (40 min)

Objetivo: Explorar datos antes de modelar (mini EDA con SQL).

Actividad 1 – Vista previa del dataset

SELECT *
FROM `bigquery-public-data.ml_datasets.titanic`
LIMIT 20;


Actividad 2 – Revisar cantidad de nulos

SELECT
  COUNTIF(age IS NULL) AS age_nulls,
  COUNTIF(fare IS NULL) AS fare_nulls
FROM `bigquery-public-data.ml_datasets.titanic`;


Actividad 3 – Distribuciones clave

SELECT survived, COUNT(*) AS total
FROM `bigquery-public-data.ml_datasets.titanic`
GROUP BY survived;


Actividad 4 – Pregunta guiada

¿Qué variables parecen más relevantes para predecir la supervivencia?

🤖 Bloque 3 – Entrenamiento del Modelo (50 min)

Objetivo: Crear un modelo de clasificación con BigQuery ML usando SQL.

Actividad 5 – Crear el modelo

CREATE OR REPLACE MODEL `mi_lab_ml.modelo_titanic`
OPTIONS(
  model_type = 'logistic_reg',
  input_label_cols = ['survived']
) AS

SELECT
  survived,
  pclass,
  sex,
  age,
  fare,
  embarked
FROM `bigquery-public-data.ml_datasets.titanic`
WHERE age IS NOT NULL
  AND fare IS NOT NULL;


Explicar:

Por qué logistic_reg

BigQuery entrena automáticamente

📈 Bloque 4 – Evaluación del Modelo (30 min)

Objetivo: Interpretar métricas ML.EVALUATE.

Actividad 6 – Evaluar

SELECT *
FROM ML.EVALUATE(MODEL `mi_lab_ml.modelo_titanic`);


Preguntas guiadas:

¿El accuracy es bueno?

¿Precision o recall importa más en el Titanic?

¿Qué significa log_loss?

Mini ejercicio:
Cada estudiante debe escribir en 2–3 líneas si su modelo es “bueno” y por qué.

🔮 Bloque 5 – Predicción (40 min)

Objetivo: Usar ML.PREDICT para hacer inferencias.

Actividad 7 – Predecir casos reales

SELECT *
FROM ML.PREDICT(
  MODEL `mi_lab_ml.modelo_titanic`,
  (
    SELECT
      pclass,
      sex,
      age,
      fare,
      embarked
    FROM `bigquery-public-data.ml_datasets.titanic`
    ORDER BY RAND()
    LIMIT 10
  )
);


Los estudiantes deben:

Interpretar predicted_survived

Interpretar predicted_survived_probs

🧩 Bloque 6 – Laboratorio personal (40 min)

El estudiante ahora debe modificar el modelo usando:

✔ Nuevas variables
✔ Filtros distintos
✔ Opciones de entrenamiento
✔ Evaluación comparativa

Actividad 8 – Añadir nuevas features
Ejemplo recomendado:

CREATE OR REPLACE MODEL `mi_lab_ml.modelo_titanic_v2`
OPTIONS(
  model_type = 'logistic_reg',
  input_label_cols = ['survived']
) AS

SELECT
  survived,
  pclass,
  sex,
  age,
  fare,
  sibsp,
  parch,
  cabin,
  embarked
FROM `bigquery-public-data.ml_datasets.titanic`
WHERE age IS NOT NULL
  AND fare IS NOT NULL;


Actividad 9 – Comparar versiones:

SELECT 'v1' AS modelo, * 
FROM ML.EVALUATE(MODEL `mi_lab_ml.modelo_titanic`)
UNION ALL
SELECT 'v2' AS modelo, * 
FROM ML.EVALUATE(MODEL `mi_lab_ml.modelo_titanic_v2`);


Actividad 10 – Conclusión personal

¿Cuál modelo es mejor?

¿Qué variable ayudó más?

🎯 Bloque 7 – Cierre (10 min)

Preguntas finales.

Recordatorio del entregable:
✔ SQL del modelo final
✔ Evaluación comparativa
✔ Pantallazo de predicciones

📘 Material entregable para los estudiantes

Te dejo el entregable estándar del LAB:

Entrega (1 página + SQL):

Nombre del modelo creado.

Código SQL del modelo final (versión 2).

Tabla de métricas comparadas (v1 vs v2).

Explicación corta (máx 6 líneas):

¿Qué mejoró?

¿Qué no mejoró?

¿Qué cambiarías?

Pantallazo de predicciones reales.

🏁 Rúbrica (para ti como profe)