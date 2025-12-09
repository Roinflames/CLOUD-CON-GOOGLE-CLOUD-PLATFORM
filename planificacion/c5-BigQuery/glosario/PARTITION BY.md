PARTITION BY se usa principalmente en funciones analíticas (window functions) en SQL.
Sirve para dividir los datos en grupos (particiones) sin colapsarlos, a diferencia de GROUP BY.

🧠 ¿Qué hace PARTITION BY?

Divide las filas en “ventanas” lógicas, y dentro de cada ventana se calcula una función analítica como:

ROW_NUMBER()

RANK()

SUM()

AVG()

LAG()

LEAD()

COUNT()

etc.

El resultado no agrupa, sino que agrega columnas con cálculos sobre las particiones.

✨ Ejemplo sencillo

Supongamos una tabla de ventas:
| vendedor | mes | ventas |
| -------- | --- | ------ |
| Ana      | Ene | 100    |
| Ana      | Feb | 200    |
| Ana      | Mar | 150    |
| Luis     | Ene | 120    |
| Luis     | Feb | 80     |
| Luis     | Mar | 90     |

👉 Queremos calcular el total de ventas por vendedor, pero sin perder el detalle por mes.

SELECT
  vendedor,
  mes,
  ventas,
  SUM(ventas) OVER (PARTITION BY vendedor) AS total_vendedor
FROM ventas;

Resultado:
| vendedor | mes | ventas | total_vendedor |
| -------- | --- | ------ | -------------- |
| Ana      | Ene | 100    | 450            |
| Ana      | Feb | 200    | 450            |
| Ana      | Mar | 150    | 450            |
| Luis     | Ene | 120    | 290            |
| Luis     | Feb | 80     | 290            |
| Luis     | Mar | 90     | 290            |

📌 ¿Cómo pensarlo?

GROUP BY: agrupa y reduce filas
(1 fila por grupo)

PARTITION BY: define ventanas para cálculos
(mantiene todas las filas)

🏁 En resumen

PARTITION BY crea grupos lógicos para funciones analíticas, permitiendo:

✔ total por grupo
✔ promedio por grupo
✔ ranking por grupo
✔ diferencias entre filas
✔ acumulados (running totals)

🔥 Sin perder las filas originales.