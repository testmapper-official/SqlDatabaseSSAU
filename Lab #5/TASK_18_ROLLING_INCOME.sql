-- Выводит скользящий средний общий доход за предыдущие 15 дней каждого дня августа 2012 года.
SET @start_date = '2012-08-01', @end_date = '2012-08-31';
WITH
    RECURSIVE dArray(dateDay) AS (
        SELECT @start_date as dateDay
        UNION ALL
        SELECT DATE_ADD(dateDay, INTERVAL 1 day) FROM dArray WHERE dateDay < @end_date
    ),
    rolling_income AS (
        SELECT
            DATE_FORMAT(book.starttime, '%m %d') as dayMonth
        ,   SUM(IF(book.memid = 0, fac.guestcost, fac.membercost) * book.slots) AS income
        ,   ROUND(
                AVG(
                    SUM(
                        IF(
                            book.memid = 0,
                            fac.guestcost,
                            fac.membercost
                        ) * book.slots
                    )
                ) OVER win
            ) as roll_avg
        FROM cd.bookings as book
        LEFT JOIN cd.facilities as fac ON book.facid = fac.facid
        WHERE MONTH(book.starttime) IN (7, 8)
        GROUP BY dayMonth
        WINDOW win as (
            ORDER BY DATE_FORMAT(book.starttime, '%m %d') ROWS BETWEEN 14 PRECEDING AND CURRENT ROW 
        )
        ORDER BY dayMonth
    )
SELECT
    dayMonth
,   IFNULL(income, 0) as income
,   IFNULL(roll_avg, 0) as roll_avg
FROM dArray as DA
LEFT JOIN rolling_income as RI ON RI.dayMonth = DATE_FORMAT(DA.dateDay, '%m %d')
WHERE SUBSTRING(dayMonth, 1, 2) = '08';
