-- Выводит список объектов, если содержится слово теннис, пишет в верхнем регистре.

SELECT
    IF(facility LIKE '%Tennis%', UPPER(facility), facility) as facility
FROM cd.facilities;