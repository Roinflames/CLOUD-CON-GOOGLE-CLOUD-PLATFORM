-- ✅ 1. Procedimiento: Registrar un movimiento y actualizar saldo
-- Registra depósitos o retiros validando que exista saldo suficiente.
DELIMITER $$

CREATE PROCEDURE RegistrarMovimiento(
    IN pCuentaID INT,
    IN pTipo VARCHAR(20),    -- 'deposito' o 'retiro'
    IN pMonto DECIMAL(10,2)
)
BEGIN
    DECLARE vSaldoActual DECIMAL(10,2);

    -- Obtener saldo actual
    SELECT Saldo INTO vSaldoActual
    FROM Cuentas
    WHERE CuentaID = pCuentaID;

    IF vSaldoActual IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cuenta no existe';
    END IF;

    -- Validaciones
    IF pTipo = 'retiro' AND vSaldoActual < pMonto THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Saldo insuficiente para retiro';
    END IF;

    -- Insertar movimiento
    INSERT INTO Movimientos (CuentaID, Tipo, Monto, FechaMovimiento)
    VALUES (pCuentaID, pTipo, pMonto, NOW());

    -- Actualizar saldo
    IF pTipo = 'deposito' THEN
        UPDATE Cuentas SET Saldo = Saldo + pMonto
        WHERE CuentaID = pCuentaID;
    ELSE
        UPDATE Cuentas SET Saldo = Saldo - pMonto
        WHERE CuentaID = pCuentaID;
    END IF;

END$$

DELIMITER ;


-- ✅ 2. Procedimiento: Transferencia entre cuentas
-- Incluye validación de fondos y rollback en caso de error.
DELIMITER $$

CREATE PROCEDURE Transferir(
    IN pCuentaOrigen INT,
    IN pCuentaDestino INT,
    IN pMonto DECIMAL(10,2)
)
BEGIN
    DECLARE vSaldoOrigen DECIMAL(10,2);

    START TRANSACTION;

    -- Obtener saldo origen
    SELECT Saldo INTO vSaldoOrigen
    FROM Cuentas
    WHERE CuentaID = pCuentaOrigen
    FOR UPDATE;

    IF vSaldoOrigen IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cuenta origen no existe';
    END IF;

    IF vSaldoOrigen < pMonto THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Saldo insuficiente';
    END IF;

    -- Descontar origen
    UPDATE Cuentas SET Saldo = Saldo - pMonto
    WHERE CuentaID = pCuentaOrigen;

    -- Sumar destino
    UPDATE Cuentas SET Saldo = Saldo + pMonto
    WHERE CuentaID = pCuentaDestino;

    -- Registrar movimientos
    INSERT INTO Movimientos (CuentaID, Tipo, Monto, FechaMovimiento)
    VALUES (pCuentaOrigen, 'transferencia_salida', pMonto, NOW());

    INSERT INTO Movimientos (CuentaID, Tipo, Monto, FechaMovimiento)
    VALUES (pCuentaDestino, 'transferencia_entrada', pMonto, NOW());

    COMMIT;

END$$

DELIMITER ;


-- ✅ 3. Procedimiento: Obtener resumen de un cliente
-- Devuelve total de cuentas, saldo total, últimos movimientos.
DELIMITER $$

CREATE PROCEDURE ResumenCliente(IN pUsuarioID INT)
BEGIN
    -- Cuentas del usuario
    SELECT * FROM Cuentas WHERE UsuarioID = pUsuarioID;

    -- Saldo total
    SELECT SUM(Saldo) AS SaldoTotal
    FROM Cuentas
    WHERE UsuarioID = pUsuarioID;

    -- Últimos 10 movimientos
    SELECT M.*
    FROM Movimientos M
    JOIN Cuentas C ON C.CuentaID = M.CuentaID
    WHERE C.UsuarioID = pUsuarioID
    ORDER BY FechaMovimiento DESC
    LIMIT 10;
END$$

DELIMITER ;
