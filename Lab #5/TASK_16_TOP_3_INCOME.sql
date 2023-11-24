-- Выбирает топ-3 объектов по доходу.

SELECT 
    fac.facility
,   DENSE_RANK() OVER(
        ORDER BY SUM(
            IF(
            book.memid = 0,
            fac.guestcost,
            fac.membercost
            ) * book.slots
        ) - fac.monthlymaintenance * COUNT(DISTINCT MONTH(book.starttime)) DESC
    ) as ranking
FROM cd.bookings as book
JOIN cd.facilities as fac ON book.facid = fac.facid
GROUP BY book.facid
LIMIT 3;