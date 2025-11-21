# [Clase 2: Almacenamiento y Gestión de Datos (Parte 1)](https://gamma.app/docs/Untitled-mafwga48e3t7ew5?mode=doc)

## Resumen de la Clase

Esta clase de 4 horas inicia el **Módulo 2**, enfocándose en las soluciones de almacenamiento de Google Cloud. Se cubrirá la primera parte del módulo, centrada en el almacenamiento de objetos y las bases de datos relacionales administradas.

---

### **Módulo(s) Cubierto(s):**
*   **Módulo 2:** Almacenamiento y Gestión de Datos (Parte 1 de 2)

### **Objetivos de Aprendizaje:**
*   Identificar los servicios de almacenamiento de GCP para diferentes casos de uso (datos no estructurados y estructurados).
*   Aprender a configurar y gestionar Cloud Storage.
*   Comprender cómo aprovisionar y conectarse a una instancia de Cloud SQL.

### **Contenidos a Cubrir:**
1.  **Visión General del Almacenamiento en GCP:**
    *   Diferencias entre almacenamiento de objetos, de archivos, bases de datos SQL y NoSQL.
2.  **Cloud Storage (Datos no estructurados):** <!-- Requiere habilitar facturación -->
    *   Conceptos clave: Buckets, objetos, clases de almacenamiento (Standard, Nearline, etc.).
    *   Control de acceso y permisos a nivel de bucket y objeto.
    *   Políticas de ciclo de vida de los objetos.
3.  **Cloud SQL (Datos estructurados - Relacional):** <!-- Requiere habilitar facturación -->
    
    ![alt text](image.png)
    
    *   Creación y configuración de una instancia (MySQL 8.0, PostgreSQL).
    *   Opciones de conectividad y seguridad (IPs autorizadas, proxy de autenticación).
### **Actividades Prácticas:**
*   **Laboratorio Práctico (Hands-On Lab):**
    *   Crear un bucket en Cloud Storage.
        ![alt text](image-2.png)
        ![alt text](image-1.png)
        ![alt text](image-3.png)
        ![alt text](image-4.png)

        1. Habilitar conexiones seguras (muy importante)
            🔹 Opción A — Cloud SQL Auth Proxy (recomendada)
                Instala el Proxy: 
                [URL](https://cloud.google.com/sql/docs/mysql/sql-proxy?hl=es-419)
                [EXE](https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.18.2/cloud-sql-proxy.x64.exe)
                Lo ejecutas así: cloud-sql-proxy --port 3306 <INSTANCE_CONNECTION_NAME>
            🔹 Opción B — Agregar tu IP pública al Authorized Network
                En Cloud SQL → Tu instancia → Connections → “Add network”.
        2. Crear usuario y base dentro del motor (MySQL/PostgreSQL/SQL Server)
            CREATE DATABASE miclase;
            CREATE USER 'rodrigo'@'%' IDENTIFIED BY 'TuPasswordSegura';
            GRANT ALL PRIVILEGES ON miclase.* TO 'rodrigo'@'%';
        3. Conectarte:
            - Desde tu PC
                Cuando el Proxy esté corriendo:
                ```
                    Host: 127.0.0.1
                    Puerto: 3306
                    Usuario: el que creaste
                    Password: la que definiste
                    Base de datos: miclase
                ```
            - Desde Cloud SQL Studio
                ![alt text](image-5.png)
                ![alt text](image-6.png)
                ![alt text](image-7.png)
        4. Conectar tu backend o aplicación
            ```python
            from sqlalchemy import create_engine

            engine = create_engine(
                "mysql+pymysql://rodrigo:PASS@127.0.0.1:3306/miclase"
            )
            ```
            ```bash
            mysql -u NOMBRE_USUARIO -p -h 127.0.0.1 -P 3306
            ```
        5. (Opcional pero recomendado) Optimizar cosas iniciales
            ✔ Configurar backups automáticos
            ✔ Activar high availability (si es producción)
            ✔ Ajustar el tamaño de la instancia según carga
            ✔ Configurar alertas en Cloud Monitoring
    *   Subir, descargar y gestionar objetos.
    *   Configurar permisos básicos de IAM en el bucket.
