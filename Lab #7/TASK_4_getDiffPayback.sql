-- Функция расчета предлагаемой стоимости объекта на основе дохода предыдущих месяцев. 
USE cd;

DELIMITER $$

-- TODO: уточнить задание.

DROP PROCEDURE IF EXISTS getNewCostPreviousBased $$
CREATE FUNCTION getNewCostPreviousBased(facid INT, currentCost DECIMAL(10, 2), percent DECIMAL(10,2)) RETURNS DECIMAL(10, 2)
    READS SQL DATA
    NOT DETERMINISTIC
BEGIN
    DECLARE newCost DECIMAL(10, 2);

    SELECT () INTO newCost
    FROM payments;

    -- SELECT b.facid, f.facility,
    -- SUM(p.payment) - f.monthlymaintenance AS income
    -- FROM bookings AS b
    -- JOIN payments AS p ON b.bookid = p.bookid
    -- JOIN facilities AS f ON b.facid = f.facid
    -- WHERE DATE_FORMAT(starttime, '%y %m') = DATE_FORMAT(whichDate, '%y %m')
    -- GROUP BY b.facid
    -- ORDER BY b.facid;

    RETURN newCost;
END $$

DELIMITER ;

-- SELECT
--     facid
-- ,   getNewCostPreviousBased(facid, , 0.1) as cost
-- FROM facilities;