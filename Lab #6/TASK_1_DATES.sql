-- Выборка начальных и конечных дат последних 10 аренд
SELECT
    facid
,   starttime
,   DATE_ADD(starttime, INTERVAL (30 * slots) MINUTE) as endtime
FROM cd.bookings
ORDER BY endtime DESC
LIMIT 10;