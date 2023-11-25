-- Выводит кол-во аренд каждого объекта клуба каждый месяц.
SELECT
    facility
,   SUM(book.slots) as rent_count
,   MONTH(book.starttime) as month
FROM cd.facilities as fac
JOIN cd.bookings as book ON book.facid = fac.facid
GROUP BY fac.facid, month;