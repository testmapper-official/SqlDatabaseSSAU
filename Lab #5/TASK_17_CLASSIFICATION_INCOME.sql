-- Выводит классификацию каждого объекта по доходу (высокий, средний и низкий)
WITH sum_table AS (
    SELECT
        book.facid
    ,   fac.facility
    ,   SUM(
            IF(
                book.memid = 0,
                fac.guestcost,
                fac.membercost
            ) * book.slots
        ) - fac.monthlymaintenance * COUNT(DISTINCT MONTH(book.starttime)) AS income
    FROM bookings AS book
    JOIN facilities AS fac ON book.facid = fac.facid
    GROUP BY book.facid
)

SELECT
    facility
,   income
,   CASE 
        WHEN NTILE(3) OVER (ORDER BY income DESC) = 1 THEN 'Высокий доход'
        WHEN NTILE(3) OVER (ORDER BY income DESC) = 2 THEN 'Средний доход'
        WHEN NTILE(3) OVER (ORDER BY income DESC) = 3 THEN 'Низкий доход'
    END AS incomegroup
FROM sum_table;
