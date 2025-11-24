DROP PROCEDURE IF EXISTS ConsultarCuenta;

CREATE PROCEDURE ConsultarCuenta(
    IN pCodBco INT,
    IN pCodSuc INT,
    IN pNumContrato VARCHAR(12),
    IN pCodEstcta INT
)
BEGIN
    -- Verificar que la cuenta exista
    IF NOT EXISTS (
        SELECT 1 
        FROM CUENTA
        WHERE COD_BCO = pCodBco
          AND COD_SUC = pCodSuc
          AND NUMCONTRATO = pNumContrato
          AND CODESTCTA = pCodEstcta
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cuenta no existe';
    END IF;

    -- Retornar información de la cuenta
    SELECT *
    FROM CUENTA
    WHERE COD_BCO = pCodBco
      AND COD_SUC = pCodSuc
      AND NUMCONTRATO = pNumContrato
      AND CODESTCTA = pCodEstcta;
END;
