-- Выводит объекты с общим количеством часа
SELECT
    fac.facid,
    fac.facility,
    ROUND(SUM(book.slots) / 2, 2) AS fachours
FROM cd.facilities as fac
LEFT JOIN cd.bookings as book ON book.facid = fac.facid
GROUP BY fac.facid
ORDER BY fac.facid;