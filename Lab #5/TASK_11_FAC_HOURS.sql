-- Выводит объекты с общим количеством часа
SELECT
    fac.facid,
    fac.facility,
    SUM(book.slots) * 0.5 AS fachours
FROM cd.facilities as fac
LEFT JOIN cd.bookings as book ON book.facid = fac.facid
GROUP BY fac.facid
ORDER BY fac.facid;