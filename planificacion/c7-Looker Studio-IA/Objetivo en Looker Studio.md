# 6️⃣ Storytelling para la clase 🎓
“El modelo no solo predice si alguien sobrevive, sino con qué probabilidad.
Al mover los filtros vemos cómo el riesgo cambia según sexo, edad y clase social.”

🔥 Esto conecta:
- ML
- SQL
- Visualización
- Negocio

# Visualizar:
- Predicciones de supervivencia
- Métricas del modelo
- Comparación real vs predicho
- Análisis por sexo, clase y edad

# 1️⃣ Crear la vista de predicciones en BigQuery
Looker NO consume modelos, consume tablas o vistas.
Primero crea una VIEW con ML.PREDICT.
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
  (
    SELECT
      PassengerId,
      survived,
      pclass,
      sex,
      age,
      fare,
      embarked
    FROM `tu_dataset.titanic`
    WHERE age IS NOT NULL
  )
);
```

📌 prob_survive = probabilidad de sobrevivir
📌 predicted_survived = 0 o 1

# 2️⃣ Conectar Looker Studio a BigQuery
Ir a Looker Studio

Crear → Fuente de datos

Conector: BigQuery

Seleccionar:
- Proyecto
- Dataset
- Vista vw_titanic_predicciones

Agregar al informe

# 3️⃣ Campos calculados clave (muy importante)
🎯 Predicción correcta / incorrecta
Campo calculado:

IF(survived_real = predicted_survived, "Correcta", "Incorrecta")

🎯 Tipo de resultado (TP, FP, FN, TN)
CASE
  WHEN survived_real = 1 AND predicted_survived = 1 THEN "TP"
  WHEN survived_real = 0 AND predicted_survived = 0 THEN "TN"
  WHEN survived_real = 0 AND predicted_survived = 1 THEN "FP"
  WHEN survived_real = 1 AND predicted_survived = 0 THEN "FN"
END

🔥 Esto permite simular la matriz de confusión en Looker

# 4️⃣ Visualizaciones recomendadas (orden pedagógico)
📊 1. Scorecards (arriba)
- Total pasajeros
- % sobrevivientes reales
- % sobrevivientes predichos
- Accuracy:

COUNT_IF(survived_real = predicted_survived) / COUNT(PassengerId)

# 📈 2. Histograma de probabilidad
- Gráfico: Histograma
- Dimensión: prob_survive
- Métrica: Recuento
👉 Muestra separación entre clases

# 📊 3. Barras: Sobrevive por sexo
Dimensión: sex
Métrica: Promedio survived_real
Métrica secundaria: Promedio predicted_survived

# 📊 4. Barras: Clase del pasajero
Dimensión: pclass
Métrica: Promedio prob_survive

# 🧮 5. Matriz de confusión (tabla)
Dimensión: tipo_resultado
Métrica: Recuento

# 5️⃣ Filtros interactivos (clave para clase)
Agregar:
- Filtro por sex
- Filtro por pclass
- Slider de age
- Slider de prob_survive

👉 Permite mostrar cómo cambia el modelo

# 7️⃣ Extra (nivel pro / evaluación)
🔁 Simular cambio de umbral

Campo calculado:
IF(prob_survive >= 0.6, 1, 0)

Luego comparar contra survived_real.

# ✅ Resultado final
Tienes un dashboard que:
- Consume BigQuery ML
- Explica métricas reales
- Es 100% SQL + BI
- Perfecto para evaluación final