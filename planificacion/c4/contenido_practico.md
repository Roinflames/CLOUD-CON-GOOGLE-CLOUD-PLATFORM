Clase 4: Fin de Migración e Introducción a BigQuery
Resumen de la Clase

En esta sesión de 4 horas finalizaremos el Módulo 3: Migración de Datos, completando el taller práctico iniciado en la clase anterior, para luego introducir uno de los servicios más importantes del ecosistema analítico de Google Cloud: BigQuery.
Esta clase marca el inicio del Módulo 4, donde los estudiantes aprenderán conceptos esenciales de análisis de datos a gran escala.

Módulo(s) Cubierto(s):

Módulo 3: Migración de Datos (2/2) – 2 horas

Módulo 4: Análisis de Datos con BigQuery (1/3) – 2 horas

Objetivos de Aprendizaje

Al finalizar esta clase, el estudiante será capaz de:

Completar un proceso de migración de datos desde un origen local hacia un servicio administrado de Google Cloud.

Verificar la integridad de los datos migrados y reconocer problemas comunes durante el proceso.

Comprender qué es un Data Warehouse y por qué BigQuery es una solución ampliamente usada a nivel empresarial.

Describir la arquitectura base de BigQuery y su separación entre almacenamiento y cómputo.

Crear datasets y tablas, cargar datos y ejecutar consultas SQL básicas dentro del entorno BigQuery.

Contenidos a Cubrir
1. Taller de Migración de Datos (Conclusión) – 2 horas
Finalización del ejercicio práctico iniciado en la Clase 3

Los estudiantes completarán la migración iniciada anteriormente, moviendo datos desde un archivo CSV o base de datos simple hacia Cloud SQL u otro servicio definido para el taller.

Verificación de integridad de datos

Se revisarán aspectos como:

Conteo de filas antes y después de la migración.

Validación de tipos de datos.

Revisión de caracteres especiales o saltos de línea.

Comprobación de llaves primarias o índices, si corresponde.

Ejemplo de verificación:

SELECT COUNT(*) FROM clientes;

Discusión: Retos y buenas prácticas

Entre los puntos a revisar:

Errores comunes durante la importación.

Problemas de encoding (UTF-8 vs ISO-8859-1).

Límites de tamaño de archivos para importaciones.

Recomendaciones sobre monitoreo del proceso.

Buenas prácticas:

Validar piloto antes de migración masiva.

Documentar el flujo fuente → destino.

Realizar auditoría post-migración.

2. Introducción a BigQuery – 2 horas
¿Qué es BigQuery?

BigQuery es un Data Warehouse serverless, altamente escalable y totalmente administrado, diseñado para realizar análisis de datos a gran escala sin necesidad de gestionar infraestructura.

Características clave:

Sin servidores (serverless).

Extremadamente rápido gracias a Dremel.

Cobro por almacenamiento + costo de consultas.

Análisis de petabytes en segundos.

Integración nativa con Google Cloud y herramientas como Looker Studio.

Arquitectura de BigQuery

BigQuery se basa en una arquitectura separada:

1. Colossus (Almacenamiento)

Sistema de archivos distribuido globalmente.

Replicación automática.

Separado del cómputo, escalable de forma independiente.

Desacoplamiento costo/rendimiento.

2. Dremel (Cómputo)

Motor de ejecución de consultas masivamente paralelo.

Opera sobre columnas comprimidas (formato columnar).

Alta velocidad para agregaciones, filtros y análisis exploratorio.

3. Slots

Unidades de cómputo usadas por BigQuery para procesar consultas.

Los estudiantes utilizarán los slots por defecto en modo on-demand.

4. Jobs

Tipos:

Query jobs

Load jobs

Extract jobs

Copy jobs

Cada acción en BigQuery es un job ejecutado y registrado.

Estructura de BigQuery

Un proyecto de BigQuery se organiza así:

Proyecto (Project)

Dataset

Tabla (Table)

Ejemplo:

proyecto-clase4.bigquery_demo.clientes

Carga de Datos

BigQuery permite múltiples formas de carga:

Desde Cloud Storage (CSV, JSON, Parquet, Avro).

Desde el computador local.

Carga Batch.

Carga Streaming (para datos en tiempo real).

Mediante API, CLI o UI web.

BigQuery SQL (primeras consultas)
Ejemplos básicos:
SELECT *
FROM `proyecto.dataset.tabla`
LIMIT 10;


Filtros:

SELECT nombre, edad
FROM `demo.usuarios`
WHERE edad > 25;


Agregaciones:

SELECT ciudad, COUNT(*) AS cantidad
FROM `demo.usuarios`
GROUP BY ciudad
ORDER BY cantidad DESC;

Actividades Prácticas
Hands-On Lab: Introducción a BigQuery
1. Crear un Dataset

Desde el panel de BigQuery → Crear dataset → Definir región y nombre.

2. Cargar datos desde Cloud Storage

Seleccionar archivo CSV o JSON.

Definir esquema manualmente o de forma automática.

Crear tabla.

3. Ejecutar consultas SQL

Los estudiantes practicarán consultas básicas sobre los datos cargados:

Filtrado

Ordenamiento

Agregaciones

Exploración inicial de columnas