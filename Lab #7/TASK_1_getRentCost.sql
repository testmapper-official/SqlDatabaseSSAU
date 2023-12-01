-- Функция расчета стоимости аренды записи бронирования.
USE cd;

DELIMITER $$

DROP FUNCTION IF EXISTS getRentCost //
CREATE FUNCTION getRentCost(memid INT, facid INT, slots INT) RETURNS INT
    READS SQL DATA
    NOT DETERMINISTIC
BEGIN
    DECLARE income INT;
    SET income = (
        SELECT IF(memid = 0, guestcost, membercost) * slots
        FROM facilities
        WHERE facid = facilities.facid
    );
    RETURN income;
END $$

DELIMITER ;

SELECT getRentCost(memid, facid, slots)
FROM bookings;