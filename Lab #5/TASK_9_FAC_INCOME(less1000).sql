-- Выводит общий доход каждого объекта который меньше 1000.
SELECT
    fac.facility,
    SUM(
        IF(
            mem.surname LIKE 'GUEST',
            fac.guestcost * book.slots,
            fac.membercost * book.slots
            )
        ) as income
FROM cd.facilities as fac
    LEFT JOIN cd.bookings as book ON book.facid = fac.facid
    LEFT JOIN cd.members as mem ON book.memid = mem.memid
GROUP BY fac.facility
HAVING income < 1000
ORDER BY income;