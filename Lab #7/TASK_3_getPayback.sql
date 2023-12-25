-- Функция расчета окупаемости каждого объекта на основании оплаты аренд за месяц
USE cd;

DELIMITER $$

DROP PROCEDURE IF EXISTS getPayback $$
CREATE PROCEDURE getPayback(facid INT, m INT, y INT)
    READS SQL DATA
    NOT DETERMINISTIC
BEGIN
    SELECT
        b.facid
    ,   f.facility
    ,   f.initialoutlay / (SUM(p.payment) - f.monthlymaintenance) AS occupacy
    FROM bookings AS b
    JOIN payments AS p ON b.bookid = p.bookid
    JOIN facilities AS f ON b.facid = f.facid
    WHERE facid = b.facid AND MONTH(b.starttime) = m AND YEAR(b.starttime) = y
    GROUP BY b.facid
    ORDER BY b.facid;
END $$

CALL getPayback(4, MONTH('2012-07-03'), YEAR('2012-07-03'));