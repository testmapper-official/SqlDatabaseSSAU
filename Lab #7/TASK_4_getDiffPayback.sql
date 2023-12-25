-- Функция расчета предлагаемой стоимости объекта на основе дохода предыдущих месяцев.

USE cd;

DELIMITER &&

DROP FUNCTION IF EXISTS getDiffPayback &&
CREATE FUNCTION getDiffPayback(facid INT, fraction FLOAT, curtime TIMESTAMP)
    RETURNS DECIMAL(10, 2)
    READS SQL DATA
    NOT DETERMINISTIC
BEGIN
    DECLARE income DECIMAL(10, 2);
    DECLARE maintenance DECIMAL(10, 2);
    DECLARE profit DECIMAL(10, 2);
    DECLARE init_cost DECIMAL(10, 2);

    SELECT SUM(p.payment) INTO income
    FROM payments AS p
    JOIN bookings AS b ON b.bookid = p.bookid
    JOIN facilities AS f ON b.facid = f.facid
    WHERE facid = b.facid AND b.starttime <= curtime
    GROUP BY b.facid;

    IF income IS NULL THEN
        RETURN 1;
    END IF;

    -- Расчет расходов за все время с точностью до дня
    SELECT f.monthlymaintenance * (MONTH(curtime) - MONTH(MIN(b.starttime)) + 1) INTO maintenance
    FROM facilities AS f
    JOIN bookings AS b ON b.facid = f.facid
    WHERE facid = b.facid
    GROUP BY b.facid;

    -- Начальная стоимость
    SELECT f.initialoutlay INTO init_cost
    FROM facilities AS f
    WHERE facid = f.facid
    LIMIT 1;

    -- Прибыль
    SET profit = (income - maintenance);

    -- Проверка оккупаемости
    IF profit <= 0 OR init_cost <= profit THEN
        RETURN 1;
    END IF;

    -- Коэффициент стоимости аренды
    RETURN ((1 / fraction) * (init_cost - profit) / init_cost * (1 - maintenance / income) + maintenance / income);
END &&

DELIMITER ;

-- Сохранение данных в CSV-файл.
SELECT getDiffPayback(2, 2, '2012-07-31-23:59:59')
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/output.csv' 
    FIELDS ENCLOSED BY '"' 
    TERMINATED BY ';' 
    ESCAPED BY '"' 
    LINES TERMINATED BY '\r\n';