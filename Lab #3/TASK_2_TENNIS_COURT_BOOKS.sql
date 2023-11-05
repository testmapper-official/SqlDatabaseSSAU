-- выбирает тенисные корты забронированные членами на 19 сентября 2012 года.
SELECT DISTINCT
    facility
FROM cd.facilities as fac
    LEFT JOIN cd.bookings as book ON book.facid = fac.facid
WHERE DATE(book.starttime) = '2012.09.19' AND facility LIKE 'Tennis Court%';