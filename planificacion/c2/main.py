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
        # result = conn.execute(text("SELECT * FROM PERSONA;"))
        # result = conn.execute(text("SELECT c.NUMCONTRATO, e.BANCO, s.SUCURSAL, est.DESCRIPCION AS ESTADO_CUENTA, p.NOMBRES, p.APE_PAT FROM CUENTA c JOIN ENTIDAD e ON c.COD_BCO = e.COD_BCO JOIN SUCURSAL s ON c.COD_SUC = s.COD_SUC JOIN ESTADO est ON c.CODESTCTA = est.CODESTCTA JOIN PERSONA p ON c.RUT = p.RUT;"))
        result = conn.execute(text("SELECT fn_nombre_completo(56789012);"))
        for row in result:
            print(row)

except Exception as e:
    print("❌ Error al conectar:", e)
