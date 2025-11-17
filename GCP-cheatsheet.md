# Guía Rápida de Comandos `gcloud`

Esta guía contiene una selección de comandos útiles de `gcloud` para la gestión de recursos en Google Cloud Platform. Para una referencia más completa, puedes consultar la [hoja de trucos oficial de gcloud](https://docs.cloud.google.com/sdk/docs/cheatsheet?hl=es-419).

---

## 1. Configuración de Proyecto y SDK

Comandos para configurar el proyecto activo en el que `gcloud` ejecutará los comandos.

### Establecer el Proyecto Activo
Define el proyecto de GCP sobre el cual quieres trabajar. Todos los comandos posteriores se ejecutarán en el contexto de este proyecto.
```bash
gcloud config set project ID_DEL_PROYECTO
```

### Obtener el Proyecto Activo
Muestra el ID del proyecto que está configurado actualmente como activo.
```bash
gcloud config get-value project
```

---

## 2. Instancias de Compute Engine

Comandos para gestionar máquinas virtuales en GCP.

### Listar Instancias con Filtro
Muestra una lista de las instancias de Compute Engine. El filtro permite refinar la búsqueda, por ejemplo, para ver instancias en zonas de `us` que no sean del tipo `f1-micro`.
```bash
gcloud compute instances list --filter="zone ~ ^us AND -machineType:f1-micro"
```

---

## 3. Cuentas de Servicio y Permisos (IAM)

Comandos para administrar las Cuentas de Servicio y las políticas de permisos (Identity and Access Management).

### Listar Cuentas de Servicio
Enumera todas las cuentas de servicio que existen en el proyecto activo.
```bash
gcloud iam service-accounts list
```

### Describir una Cuenta de Servicio
Muestra información detallada sobre una cuenta de servicio específica, incluyendo su `displayName` y `description`.
```bash
gcloud iam service-accounts describe NOMBRE@ID_DEL_PROYECTO.iam.gserviceaccount.com
```

### Listar Claves de una Cuenta de Servicio
Enumera las claves (keys) asociadas a una cuenta de servicio. Estas claves se usan para autenticación.
```bash
gcloud iam service-accounts keys list --iam-account=NOMBRE@ID_DEL_PROYECTO.iam.gserviceaccount.com
```

### Obtener Política de Permisos del Proyecto
Muestra la política de IAM completa para el proyecto, detallando qué miembros (usuarios, grupos, cuentas de servicio) tienen qué roles.
```bash
gcloud projects get-iam-policy ID_DEL_PROYECTO
```

---

## 4. APIs y Servicios de GCP

Comandos para gestionar las APIs y servicios disponibles en tu proyecto.

### Listar Servicios Habilitados
Muestra una lista de todos los servicios y APIs que están actualmente habilitados para el proyecto. El `| Select-String "drive"` (PowerShell) o `| grep "drive"` (Bash) filtra la lista para encontrar un servicio específico.
```bash
gcloud services list --enabled | Select-String "drive"
```

### Listar Servicios Disponibles
Muestra todos los servicios que están disponibles para ser habilitados en el proyecto. Es útil para descubrir nuevas APIs.
```bash
gcloud services list --available | Select-String "drive"
```

### Listar Clientes OAuth (Avanzado)
Enumera los clientes OAuth 2.0 asociados a tu proyecto. Esto es útil en contextos de autenticación y autorización de aplicaciones.
```bash
gcloud alpha services oauth-client list
```
