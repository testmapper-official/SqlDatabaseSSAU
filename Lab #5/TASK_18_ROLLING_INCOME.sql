-- Выводит скользящий средний общий доход за предыдущие 15 дней каждого дня августа 2012 года.
WITH rolling_income AS (
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
    JOIN cd.facilities as fac ON book.facid = fac.facid
    WHERE MONTH(book.starttime) IN (7, 8)
    GROUP BY dayMonth
    WINDOW win as (
        ORDER BY DATE_FORMAT(book.starttime, '%m %d') ROWS BETWEEN 14 PRECEDING AND CURRENT ROW 
    )
    ORDER BY dayMonth
)
SELECT * FROM rolling_income WHERE SUBSTRING(dayMonth, 1, 2) = '08';