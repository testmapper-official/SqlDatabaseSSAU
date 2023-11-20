-- Выводит общий доход каждого объекта.
SELECT
    fac.facility,
    SUM(
        IF(
            mem.surname LIKE 'GUEST',
            fac.guestcost * book.slots,
            fac.membercost * book.slots
            )
        ) - COUNT(DISTINCT MONTH(book.starttime)) * fac.monthlymaintenance as income
FROM cd.facilities as fac
    LEFT JOIN cd.bookings as book ON book.facid = fac.facid
    LEFT JOIN cd.members as mem ON book.memid = mem.memid
GROUP BY fac.facility, fac.monthlymaintenance
ORDER BY income;