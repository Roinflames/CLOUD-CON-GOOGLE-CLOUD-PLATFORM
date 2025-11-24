# Cloud_SQL

```bash
gcloud auth application-default login
cloud-sql-proxy --port 3306 clase-2-478918:southamerica-west1:clase-2
```

2025/11/20 22:31:33 Authorizing with Application Default Credentials
2025/11/20 22:31:33 [plantiwuisserviceacc:southamerica-west1:free-trial-first-project] Listening on 127.0.0.1:3306
2025/11/20 22:31:33 The proxy has started successfully and is ready for new connections!

```bash
pipenv install pymysql sqlalchemy
python main.py
```

```bash
# ENABLE API
https://console.cloud.google.com/apis/library/sqladmin.googleapis.com?project=plantiwuisserviceacc
```

Ahora ya puedes:

- crear tablas
- insertar datos
- probar ORM con SQLAlchemy
- hacer un pool de conexiones
- montar tu backend Flask/FastAPI
- crear un script de inicialización de base