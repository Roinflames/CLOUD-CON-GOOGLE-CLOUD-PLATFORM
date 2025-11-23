-- 🧩 1. Función: obtener nombre completo del cliente
DELIMITER $$

CREATE FUNCTION fn_nombre_completo(rut_in INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE nombre VARCHAR(100);

    SELECT CONCAT(NOMBRES, ' ', APE_PAT, ' ', IFNULL(APE_MAT, ''))
    INTO nombre
    FROM PERSONA
    WHERE RUT = rut_in;

    RETURN nombre;
END$$

DELIMITER ;

SELECT fn_nombre_completo(12345678);

-- 🏦 2. Función: obtener estado textual de una cuenta
DELIMITER $$

CREATE FUNCTION fn_estado_cuenta(cod INT)
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
    DECLARE estado VARCHAR(30);

    SELECT DESCRIPCION
    INTO estado
    FROM ESTADO
    WHERE CODESTCTA = cod;

    RETURN estado;
END$$

DELIMITER ;

SELECT fn_estado_cuenta(1);

-- 💳 3. Función: obtener situación de tarjeta
DELIMITER $$

CREATE FUNCTION fn_situacion_tarjeta(id_situacion INT)
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
    DECLARE situacion VARCHAR(30);

    SELECT DESCRIPCION
      INTO situacion
      FROM SITUACION
     WHERE INDSITUAR = id_situacion;

    RETURN situacion;
END$$

DELIMITER ;

SELECT fn_situacion_tarjeta(5);

-- 🗓️ 4. Función: calcular años vigencia de la cuenta
DELIMITER $$

CREATE FUNCTION fn_antiguedad_cuenta(fecha_alta DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, fecha_alta, CURDATE());
END$$

DELIMITER ;

SELECT fn_antiguedad_cuenta('2020-05-10');


-- 🔐 5. Función: validar RUT sencillo (formato numérico)
DELIMITER $$

CREATE FUNCTION fn_validar_rut(rut_in INT)
RETURNS TINYINT
DETERMINISTIC
BEGIN
    IF rut_in < 5000000 OR rut_in > 30000000 THEN
        RETURN 0;  -- inválido
    END IF;

    RETURN 1;      -- válido
END$$

DELIMITER ;

SELECT fn_validar_rut(12345678);

-- 📊 6. Función: contar tarjetas activas de un cliente
DELIMITER $$

CREATE FUNCTION fn_tarjetas_activas(rut_in INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COUNT(*) INTO total
    FROM TARJETA t
    JOIN SITUACION s ON t.INDSITUAR = s.INDSITUAR
    WHERE t.RUT = rut_in
      AND s.DESCRIPCION = 'OPERATIVA';

    RETURN total;
END$$

DELIMITER ;

SELECT fn_tarjetas_activas(12345678);
