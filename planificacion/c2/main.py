from sqlalchemy import create_engine, text
import pymysql

# Para que PyMySQL actúe como MySQLdb
pymysql.install_as_MySQLdb()

# --- CONFIGURACIÓN ---
USER = "rodrigo"
PASSWORD = "TuPasswordSegura1!"
DB_NAME = "Banco"
HOST = "127.0.0.1"   # Cloud SQL Proxy o local
PORT = 3306

# --- CADENA DE CONEXIÓN ESTABLE ---
engine = create_engine(
    f"mysql+pymysql://{USER}:{PASSWORD}@{HOST}:{PORT}/{DB_NAME}",
    pool_pre_ping=True,      # Reasigna conexión si está muerta
    pool_recycle=28000,      # Evita que MySQL cierre conexiones viejas
)

# --- PRUEBA DE CONEXIÓN ---
try:
    with engine.connect() as conn:
        # result = conn.execute(text("SELECT 1"))
        result = conn.execute(text("SELECT * FROM PERSONA"))
        for row in result:
            print(row)

except Exception as e:
    print("❌ Error al conectar:", e)
