# [🧪 Guía de Laboratorio](https://lookerstudio.google.com/u/0/reporting/dd3f13ad-9b55-47ee-9775-3296ca6437e9/page/7C1iF/edit)
## BigQuery ML + Looker Studio

### Caso: Supervivencia del Titanic

---

## 1. Información General

**Asignatura:** Taller de Proyecto / Big Data / Analítica / ML en GCP
**Duración:** 4 horas
**Modalidad:** Laboratorio práctico guiado
**Herramientas:** Google Cloud Platform, BigQuery, BigQuery ML, Looker Studio
**Dataset:** Titanic

---

## 2. Objetivo del Laboratorio

Al finalizar este laboratorio, el estudiante será capaz de:

* Entrenar un modelo de clasificación usando **BigQuery ML**
* Evaluar métricas de desempeño del modelo
* Generar predicciones mediante SQL
* Visualizar resultados y métricas en **Looker Studio**
* Interpretar resultados desde una perspectiva analítica

---

## 3. Contexto del Problema

El hundimiento del Titanic es uno de los casos clásicos de análisis de datos.
El objetivo es **predecir si un pasajero sobrevivió (1) o no (0)** en función de variables como:

* Sexo
* Edad
* Clase del pasajero
* Tarifa pagada

Este problema corresponde a una **clasificación binaria supervisada**.

---

## 4. Estructura del Laboratorio

| Bloque | Actividad                      | Tiempo |
| ------ | ------------------------------ | ------ |
| 1      | Exploración de datos           | 45 min |
| 2      | Entrenamiento del modelo       | 60 min |
| 3      | Evaluación y predicciones      | 45 min |
| 4      | Visualización en Looker Studio | 60 min |
| 5      | Análisis y conclusiones        | 30 min |

---

## 5. Parte 1 – Exploración de Datos (45 min)

### 5.1 Cargar dataset Titanic en BigQuery

Se asume que el dataset `titanic` ya se encuentra cargado en BigQuery.

Ejemplo de consulta exploratoria:

```sql
SELECT
  survived,
  sex,
  pclass,
  COUNT(*) AS total
FROM `tu_dataset.titanic`
GROUP BY survived, sex, pclass
ORDER BY survived DESC;
```

### 5.2 Análisis inicial

Responder:

* ¿Existe desbalance entre sobrevivientes y no sobrevivientes?
* ¿Qué variables parecen más influyentes?

---

## 6. Parte 2 – Entrenamiento del Modelo (60 min)

### 6.1 Crear modelo de clasificación

```sql
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
FROM `tu_dataset.titanic`
WHERE age IS NOT NULL;
```

### 6.2 Confirmar entrenamiento

```sql
SELECT *
FROM ML.TRAINING_INFO(MODEL `tu_dataset.modelo_titanic`);
```

---

## 7. Parte 3 – Evaluación del Modelo (45 min)

### 7.1 Métricas de evaluación

```sql
SELECT *
FROM ML.EVALUATE(MODEL `tu_dataset.modelo_titanic`);
```

Analizar:

* Accuracy
* Precision
* Recall
* F1-score
* ROC AUC

### 7.2 Preguntas de análisis

* ¿Por qué accuracy no es suficiente?
* ¿Qué métrica es más relevante en este caso?

---

## 8. Parte 4 – Predicciones (45 min)

### 8.1 Generar predicciones

```sql
CREATE OR REPLACE VIEW `tu_dataset.vw_titanic_predicciones` AS
SELECT
  PassengerId,
  survived AS survived_real,
  predicted_survived,
  predicted_survived_probs[OFFSET(1)] AS prob_survive,
  sex,
  pclass,
  age,
  fare
FROM ML.PREDICT(
  MODEL `tu_dataset.modelo_titanic`,
  (SELECT * FROM `tu_dataset.titanic` WHERE age IS NOT NULL)
);
```

---

## 9. Parte 5 – Looker Studio (60 min)

### 9.1 Conexión

* Crear informe en Looker Studio
* Fuente de datos: BigQuery
* Tabla/Vista: `vw_titanic_predicciones`

### 9.2 Campos calculados

**Predicción correcta:**

```text
IF(survived_real = predicted_survived, "Correcta", "Incorrecta")
```

**Tipo de resultado:**

```text
CASE
  WHEN survived_real = 1 AND predicted_survived = 1 THEN "TP"
  WHEN survived_real = 0 AND predicted_survived = 0 THEN "TN"
  WHEN survived_real = 0 AND predicted_survived = 1 THEN "FP"
  WHEN survived_real = 1 AND predicted_survived = 0 THEN "FN"
END
```

### 9.3 Visualizaciones mínimas

* Scorecard: Accuracy
* Barras: Sobrevivencia por sexo
* Barras: Probabilidad por clase
* Histograma: prob_survive
* Tabla: Matriz de confusión

---

## 10. Parte 6 – Conclusiones (30 min)

Responder:

1. ¿Qué variables influyen más en la predicción?
2. ¿Dónde falla el modelo?
3. ¿Cómo mejorarías el desempeño?

---

## 11. Entregables

* Captura del modelo entrenado en BigQuery
* Consulta `ML.EVALUATE`
* Dashboard en Looker Studio
* Conclusiones escritas (máx. 1 página)

---

## 12. Criterios de Evaluación (referencial)

| Criterio                       | Puntaje |
| ------------------------------ | ------- |
| Modelo entrenado correctamente | 30%     |
| Interpretación de métricas     | 30%     |
| Dashboard funcional            | 25%     |
| Análisis crítico               | 15%     |

---

## ✅ Fin del Laboratorio

Este laboratorio integra **SQL, Machine Learning y Visualización**, replicando un flujo real de analítica en la nube.
