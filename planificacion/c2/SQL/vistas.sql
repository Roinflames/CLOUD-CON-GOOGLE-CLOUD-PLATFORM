-- 🏦 1. Vista: cuentas con toda su información (cliente, banco, sucursal, estado)
CREATE OR REPLACE VIEW vw_cuentas_detalle AS
SELECT 
    c.NUMCONTRATO,
    e.BANCO,
    s.SUCURSAL,
    est.DESCRIPCION AS ESTADO_CUENTA,
    p.RUT,
    CONCAT(p.NOMBRES, ' ', p.APE_PAT, ' ', IFNULL(p.APE_MAT,'')) AS CLIENTE,
    c.FECALTA,
    c.FECBAJA
FROM CUENTA c
JOIN ENTIDAD e ON c.COD_BCO = e.COD_BCO
JOIN SUCURSAL s ON c.COD_SUC = s.COD_SUC
JOIN ESTADO est ON c.CODESTCTA = est.CODESTCTA
JOIN PERSONA p ON c.RUT = p.RUT;

-- 💳 2. Vista: tarjetas con situación, banco, sucursal y titular
CREATE OR REPLACE VIEW vw_tarjetas_detalle AS
SELECT 
    t.PAN,
    e.BANCO,
    s.SUCURSAL,
    si.DESCRIPCION AS SITUACION_TARJETA,
    t.FECCADU,
    t.TIPPER,
    p.RUT,
    CONCAT(p.NOMBRES, ' ', p.APE_PAT, ' ', IFNULL(p.APE_MAT,'')) AS TITULAR
FROM TARJETA t
JOIN ENTIDAD e ON t.ENTIDAD = e.COD_BCO
JOIN SUCURSAL s ON t.SUCURSAL = s.COD_SUC
JOIN SITUACION si ON t.INDSITUAR = si.INDSITUAR
JOIN PERSONA p ON t.RUT = p.RUT;

-- 👤 3. Vista: clientes con cantidad de cuentas y tarjetas
CREATE OR REPLACE VIEW vw_clientes_resumen AS
SELECT
    p.RUT,
    CONCAT(p.NOMBRES, ' ', p.APE_PAT, ' ', IFNULL(p.APE_MAT,'')) AS CLIENTE,
    COUNT(DISTINCT c.NUMCONTRATO) AS TOTAL_CUENTAS,
    COUNT(DISTINCT t.PAN) AS TOTAL_TARJETAS
FROM PERSONA p
LEFT JOIN CUENTA c ON p.RUT = c.RUT
LEFT JOIN TARJETA t ON p.RUT = t.RUT
GROUP BY p.RUT;

-- 📊 4. Vista: tarjetas operativas
CREATE OR REPLACE VIEW vw_tarjetas_operativas AS
SELECT *
FROM vw_tarjetas_detalle
WHERE SITUACION_TARJETA = 'OPERATIVA';

-- 📅 5. Vista: cuentas vigentes vs cerradas
CREATE OR REPLACE VIEW vw_cuentas_estado_vigencia AS
SELECT 
    NUMCONTRATO,
    RUT,
    IF(FECBAJA IS NULL, 'VIGENTE', 'CERRADA') AS ESTADO_VIGENCIA,
    FECALTA,
    FECBAJA
FROM CUENTA;

-- 🏦 6. Vista: resumen bancario por banco (cuentas + tarjetas)
CREATE OR REPLACE VIEW vw_resumen_banco AS
SELECT 
    e.BANCO,
    COUNT(DISTINCT c.NUMCONTRATO) AS TOTAL_CUENTAS,
    COUNT(DISTINCT t.PAN) AS TOTAL_TARJETAS
FROM ENTIDAD e
LEFT JOIN CUENTA c ON e.COD_BCO = c.COD_BCO
LEFT JOIN TARJETA t ON e.COD_BCO = t.ENTIDAD
GROUP BY e.COD_BCO;

-- 🏁 7. Vista para análisis de riesgo (cuentas en morosidad, castigo, aceleración)
CREATE OR REPLACE VIEW vw_cuentas_riesgo AS
SELECT 
    c.NUMCONTRATO,
    p.RUT,
    CONCAT(p.NOMBRES, ' ', p.APE_PAT) AS CLIENTE,
    est.DESCRIPCION AS ESTADO_RIESGO
FROM CUENTA c
JOIN ESTADO est ON c.CODESTCTA = est.CODESTCTA
JOIN PERSONA p ON c.RUT = p.RUT
WHERE est.DESCRIPCION IN ('MOROSIDAD LEVE','ACELERACIÓN','CASTIGADA');
