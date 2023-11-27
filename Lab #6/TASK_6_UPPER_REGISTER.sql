-- Выводит список объектов, если содержится слово теннис, пишет в верхнем регистре.

SELECT
    UPPER(facility) as facility
FROM cd.facilities
WHERE facility LIKE '%Tennis%';