# [✅ 1. ¿Qué es BigQuery ML?](https://docs.cloud.google.com/bigquery/docs/create-machine-learning-model?hl=es-419)
BigQuery ML permite crear y entrenar modelos de Machine Learning usando solo SQL, sin salir de BigQuery.
Puedes entrenar modelos de:
- Regresión (regression)
- Clasificación (logistic_reg)
- Series de tiempo (ARIMA, ETS)
- Clustering (kmeans)
- Recomendación (matrix factorization)
- Redes neuronales (DNN)
- XGBoost (boosted trees)

¡Muchos más!

## ⭐ Ejemplo completo para clase: Modelo de Clasificación con SQL
Vamos a predecir si un pasajero sobrevivirá el Titanic usando datos públicos de BigQuery.

### Paso 1. Cargar el dataset de ejemplo
Puedes usar un dataset público de BigQuery:

bigquery-public-data.ml_datasets.titanic

### Paso 2. Crear el modelo (CREATE MODEL)
Vamos a entrenar un modelo de regresión logística (logistic_reg) para predecir survived.

CREATE OR REPLACE MODEL `tu_dataset.modelo_titanic`
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


✔ Esto entrena el modelo
✔ Usa automáticamente validación
✔ Maneja variables categóricas

### Paso 3. Evaluar el modelo
```sql
SELECT *
FROM ML.EVALUATE(MODEL `tu_dataset.modelo_titanic`);
```

Verás métricas como:
- accuracy
- precision
- recall
- log_loss

Perfecto para explicar qué significa cada una.

### Paso 4. Usar el modelo para predecir (ML.PREDICT)
SELECT *
FROM ML.PREDICT(
  MODEL `tu_dataset.modelo_titanic`,
  (
    SELECT
      pclass,
      sex,
      age,
      fare,
      embarked
    FROM `bigquery-public-data.ml_datasets.titanic`
    LIMIT 5
  )
);

El resultado incluye:
- predicted_survived
- predicted_survived_probs
- probabilidades por clase

### ⭐ Extra: Explicar en clase cómo funciona BigQuery ML
🔹 BigQuery ML no mueve datos
El entrenamiento ocurre dentro del mismo data warehouse → súper eficiente.

🔹 Usa SQL estándar
Ideal para analistas, no requiere Python.

🔹 Escala automáticamente
BigQuery distribuye el entrenamiento.

🔹 Se puede exportar a Vertex AI
👉 Para producción real.