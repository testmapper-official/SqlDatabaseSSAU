-- Выводит ID объекта с наибольшим количеством слотов.
-- WITH fac_slots AS (
--     SELECT facid, facility, SUM(book.slots) as rent_count
--     FROM cd.facilities as fac
--     LEFT JOIN cd.bookings as book ON book.facid = fac.facid
--     GROUP BY fac.facid
-- );

SELECT facility, rent_count
FROM cd.facilities as fac, (
    SELECT MAX(SUM(book.slots)) as max_rent
    FROM cd.facilities as fac
    LEFT JOIN cd.bookings as book ON book.facid = fac.facid
)
WHERE rent_count = max_rent;