-- Выбирает членов клуба с таблицы members БД cd и связывает с объектами, в которых они рекомендованы
SELECT CONCAT(facility, " - ", firstname, " ", surname) as occupation
    FROM cd.members as mem
    INNER JOIN
    cd.facilities as fac ON fac.facid = mem.recommendedby;