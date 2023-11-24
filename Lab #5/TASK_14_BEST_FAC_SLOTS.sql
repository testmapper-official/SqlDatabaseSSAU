-- Выводит ID объекта с наибольшим количеством слотов (учитывая все записи на каждый объект)
WITH
slots_table AS(
    SELECT
        fac.facid
    ,   SUM(book.slots) as slots 
    FROM cd.facilities as fac
    LEFT JOIN cd.bookings as book ON fac.facid = book.facid
    GROUP BY fac.facid
),
rank_table AS(
    SELECT
        facid
    ,   slots
    ,   RANK() OVER (ORDER BY slots DESC) as self_rank 
    FROM slots_table
)
SELECT DISTINCT facid
FROM rank_table
WHERE self_rank = 1;