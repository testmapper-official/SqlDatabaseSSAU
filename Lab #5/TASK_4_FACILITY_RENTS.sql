-- Выводит кол-во аренд каждого объекта клуба.
SELECT facility, SUM(book.slots) as rent_count
FROM cd.facilities as fac
LEFT JOIN cd.bookings as book ON book.facid = fac.facid
GROUP BY fac.facid;