# ¿Qué es Etiquetar (Tagging) en GCP?
Etiquetar en GCP es el proceso de adjuntar pares clave-valor a tus recursos (como proyectos, máquinas virtuales, bases de datos o depósitos de almacenamiento).

Hay dos tipos principales de etiquetado que se usan comúnmente en GCP:

## 1. Etiquetas (Labels)
Son pares clave-valor arbitrarios que puedes crear y asignar a la mayoría de los recursos de GCP.

Propósito: Se utilizan principalmente para la gestión de recursos y la facturación.

Ejemplo:

entorno: desarrollo

equipo: marketing

cost_center: 101

## 2. Etiquetas de Recursos (Tags)
Son pares clave-valor predefinidos y controlados por el Resource Manager de GCP. Este es el tipo de etiqueta al que se refiere el mensaje de advertencia que viste anteriormente.

Propósito: Se utilizan para aplicar políticas jerárquicas de manera más estricta a través de la organización (IAM) y para el cumplimiento de normativas.

Ejemplo: El mensaje de advertencia sugería usar tags para el ambiente:

Clave: environment

Valores Posibles: Production, Development, Test, Staging.

Comando Sugerido: La forma de crear la asociación para una etiqueta de recurso es con el comando:

Bash

gcloud resource-manager tags bindings create ...

## Importancia del Etiquetado
El etiquetado es una buena práctica fundamental en la nube por las siguientes razones:

Administración de Costos: Permite filtrar y agrupar tus costos en los informes de facturación por equipo, entorno, o centro de costo. Esto es crucial para saber dónde se gasta el dinero.

Automatización: Puedes usar etiquetas para dirigir políticas de automatización, como apagar todas las máquinas que tienen la etiqueta entorno: desarrollo fuera del horario laboral.

Organización: Facilita la búsqueda y el inventario de recursos, especialmente en proyectos grandes con cientos o miles de instancias.

Gestión de Políticas (Tags): Las etiquetas de recursos (Tags) te permiten aplicar políticas de Identity and Access Management (IAM) a un recurso, haciendo que la seguridad sea más consistente y escalable.

# gcloud projects update NO permite actualizar labels.
Es normal que te dé error: ese comando solo maneja nombre, org, carpeta y políticas.
Para modificar labels de un proyecto, debes usar gcloud alpha projects update o la API de Resource Manager.

gcloud components install alpha

gcloud alpha projects update PROJECT_ID --update-labels=environment=development

## Si quieres agregar varios labels:
gcloud alpha projects update PROJECT_ID --update-labels environment=development,owner=rodrigo

## Para borrar un label:
gcloud alpha projects update PROJECT_ID --remove-labels=environment
