from sqlalchemy import create_engine, text
import pymysql

# (Opcional) Hace que PyMySQL se comporte como MySQLdb
pymysql.install_as_MySQLdb()

# --- CONFIGURACIÓN ---
USER = "rodrigo"
PASSWORD = "TuPasswordSegura"
DB_NAME = "Banco"
HOST = "127.0.0.1"   # Cloud SQL Proxy
PORT = 3306

# --- CADENA DE CONEXIÓN ---
engine = create_engine(
    f"mysql+pymysql://{USER}:{PASSWORD}@{HOST}:{PORT}/{DB_NAME}"
)

# --- PRUEBA DE CONEXIÓN ---
try:
    with engine.connect() as conn:
        result = conn.execute(text("SELECT 1"))
        print("Conexión exitosa:", result.scalar())

except Exception as e:
    print("❌ Error al conectar:", e)
