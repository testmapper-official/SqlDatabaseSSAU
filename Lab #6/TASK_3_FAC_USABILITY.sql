-- Выводит процент использования объектов каждый месяц (отношение количества аренд объекта в месяц на количество аренд всех объектов в месяц)
WITH slots as (
    SELECT
        facility
    ,   SUM(book.slots) as rent_count
    ,   MONTH(book.starttime) as month
    FROM cd.facilities as fac
    JOIN cd.bookings as book ON book.facid = fac.facid
    GROUP BY fac.facid, month
)
SELECT
    s1.facility
,   CONCAT(ROUND(s1.rent_count / SUM(s2.rent_count) * 100, 1), '%') as usability
,   s1.month
FROM slots as s1
JOIN slots as s2 ON s1.month = s2.month
GROUP BY s1.facility, s1.rent_count, s1.month
ORDER BY CAST(usability as FLOAT) ASC;