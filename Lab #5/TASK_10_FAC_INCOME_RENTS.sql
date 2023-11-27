-- Выводит кол-во бронирований каждого объекта клуба в месяц за 2012 год
-- с итогами кол-ва бронирований всех объектов
WITH incomes as (
    SELECT
        fac.facid
    ,   MONTH(book.starttime) AS month
    ,   SUM(book.slots) as slots
    FROM facilities as fac
    JOIN bookings as book ON fac.facid = book.facid
    WHERE YEAR(book.starttime) = 2012
    GROUP BY fac.facid, month
)
SELECT
    IF(GROUPING(facid)=1,0,facid) as facid
,   IF(GROUPING(month)=1,0,month) as month
,   SUM(slots) as total_slots
FROM incomes
GROUP BY facid, month WITH ROLLUP;
-- SELECT
--     IFNULL(facid, 0) as facid
-- ,   IFNULL(month, 'Total') as month
-- ,   SUM(slots) as total_slots
-- FROM incomes
-- GROUP BY facid, month WITH ROLLUP;