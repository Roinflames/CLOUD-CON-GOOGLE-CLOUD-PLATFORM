# Taller Práctico (Parte 1)

## Actividad: Migración simple con Cloud SQL

### Objetivo:
Subir un archivo CSV a Cloud SQL mediante herramienta de importación.

### Pasos:
- Cargar el archivo CSV en Cloud Storage.
- Crear la tabla destino en Cloud SQL:

```sql
CREATE TABLE alumnos (
  id INT PRIMARY KEY,
  nombre VARCHAR(100),
  correo VARCHAR(100)
);
```

- Desde Cloud SQL: Import → Seleccionar bucket → Import CSV.
- Validar datos cargados con una consulta SQL.

