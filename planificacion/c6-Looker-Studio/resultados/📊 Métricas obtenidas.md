| Métrica       | Valor aprox. | Interpretación                                                    |
| ------------- | ------------ | ----------------------------------------------------------------- |
| **Precision** | **0.80**     | Cuando el modelo predice *“sobrevive”*, acierta ~80% de las veces |
| **Recall**    | **0.75**     | Detecta ~75% de todos los sobrevivientes reales                   |
| **Accuracy**  | **0.84**     | 84% de predicciones correctas en general                          |
| **F1-score**  | **0.77**     | Buen balance entre precision y recall                             |
| **Log Loss**  | **0.39**     | Probabilidades razonablemente bien calibradas                     |
| **ROC AUC**   | **0.90**     | Excelente capacidad de discriminación                             |


🧠 Lectura técnica (nivel BigQuery ML / clase)
1️⃣ Accuracy (0.84)

✔️ Alta, pero ojo:

En Titanic hay desbalance (más muertos que sobrevivientes)

Accuracy sola no basta para evaluar el modelo

👉 Bien como referencia, no como métrica principal

2️⃣ Precision (0.80)

✔️ Muy buena

Significa:

“Si el modelo dice que alguien sobrevive, casi siempre tiene razón”

Útil si:

Quieres evitar falsos positivos

No quieres “prometer sobrevivientes” que no lo son

3️⃣ Recall (0.75)

✔️ Correcta, aunque mejorable

Significa:

“El modelo encuentra 3 de cada 4 sobrevivientes reales”

Si subes recall:

Detectas más sobrevivientes

A costa de bajar precision

4️⃣ F1-score (0.77)

✔️ Muy buen balance

👉 Es la métrica más justa cuando:

Hay desbalance

Te importa tanto precision como recall

5️⃣ Log Loss (0.39)

✔️ Buena

Significa:

El modelo no solo acierta, sino que asigna probabilidades coherentes

Ideal si luego usaras umbrales distintos (ej. 0.6 en vez de 0.5)

6️⃣ ROC AUC (0.90)

🔥 Excelente

Esto es clave:

El modelo distingue muy bien entre sobrevivientes y no sobrevivientes

📌 En problemas reales:

0.7 → aceptable

0.8 → bueno

0.9 → muy sólido

🎯 Conclusión general

✅ Modelo muy bien entrenado para Titanic

No está overfitteado

Buen poder predictivo

Métricas coherentes entre sí

📌 Para una clase o laboratorio, este modelo:

Es totalmente defendible

Ideal para mostrar BigQuery ML funcionando correctamente