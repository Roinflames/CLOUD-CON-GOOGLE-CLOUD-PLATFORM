1️⃣ Ajustar umbral de clasificación

SELECT *
FROM ML.PREDICT(
  MODEL `dataset.modelo_titanic`,
  (SELECT * FROM dataset.titanic),
  STRUCT(0.6 AS threshold)
);


2️⃣ Ver matriz de confusión

SELECT *
FROM ML.CONFUSION_MATRIX(
  MODEL `dataset.modelo_titanic`,
  (SELECT * FROM dataset.titanic)
);


3️⃣ Feature engineering

Convertir sex a variable binaria explícita

Agrupar age en rangos

Usar family_size