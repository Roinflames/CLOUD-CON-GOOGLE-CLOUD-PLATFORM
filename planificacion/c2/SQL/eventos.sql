-- 💳 2. Crear un evento que marque tarjetas como CADUCADAS automáticamente
SELECT INDSITUAR FROM SITUACION WHERE DESCRIPCION = 'CADUCADA';

CREATE EVENT IF NOT EXISTS ev_actualizar_tarjetas_caducadas
ON SCHEDULE EVERY 1 DAY
DO
    UPDATE TARJETA
    SET INDSITUAR = 7
    WHERE FECCADU < CURDATE();

-- 💳 2. Crear un evento que marque tarjetas como CADUCADAS automáticamente
SELECT INDSITUAR FROM SITUACION WHERE DESCRIPCION = 'CADUCADA';

CREATE EVENT IF NOT EXISTS ev_actualizar_tarjetas_caducadas
ON SCHEDULE EVERY 1 DAY
STARTS (TIMESTAMP(CURRENT_DATE) + INTERVAL 1 DAY)
DO
    UPDATE TARJETA
    SET INDSITUAR = 7
    WHERE FECCADU < CURDATE();

-- 📅 3. Evento que cierre cuentas vencidas (ejemplo)
CREATE EVENT IF NOT EXISTS ev_cerrar_cuentas
ON SCHEDULE EVERY 1 DAY
DO
    UPDATE CUENTA
    SET CODESTCTA = 2  -- NO ACTIVA
    WHERE FECBAJA = CURDATE();

-- 🧹 4. Evento para limpieza automática (archivar tarjetas destruidas)
SELECT INDSITUAR FROM SITUACION WHERE DESCRIPCION = 'DESTRUIDA';


CREATE EVENT IF NOT EXISTS ev_limpiar_tarjetas_destruidas
ON SCHEDULE EVERY 1 WEEK
DO
    DELETE FROM TARJETA
    WHERE INDSITUAR = 9;


-- 📝 5. Evento con logs (ejemplo profesional)
CREATE TABLE IF NOT EXISTS LOG_TAREAS (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    FECHA DATETIME,
    DESCRIPCION VARCHAR(255)
);

CREATE EVENT IF NOT EXISTS ev_log_diario
ON SCHEDULE EVERY 1 DAY
DO
    INSERT INTO LOG_TAREAS (FECHA, DESCRIPCION)
    VALUES (NOW(), 'Tarea diaria ejecutada correctamente');

-- 🔍 6. Ver eventos creados
SHOW EVENTS FROM Banco;

-- ❌ 7. Eliminar evento
DROP EVENT IF EXISTS ev_cerrar_cuentas;
