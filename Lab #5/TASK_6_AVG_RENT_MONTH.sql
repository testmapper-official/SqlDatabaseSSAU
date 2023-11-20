-- Выводит кол-во бронирований каждого объекта клуба в месяц за 2012 год.
SELECT facility, MONTH(book.starttime) as month, COUNT(book.bookid) as rent_month
FROM cd.facilities as fac
LEFT JOIN cd.bookings as book ON book.facid = fac.facid
WHERE YEAR(book.starttime) = '2012'
GROUP BY fac.facid, MONTH(book.starttime);