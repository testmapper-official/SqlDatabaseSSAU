-- Выводит кол-во аренд каждого объекта клуба на 12 сентября 2012 года.
SELECT facility, SUM(book.slots) as rent_count
FROM cd.facilities as fac
LEFT JOIN cd.bookings as book ON book.facid = fac.facid
WHERE DATE(book.starttime) = '2012.09.12'
GROUP BY fac.facid;