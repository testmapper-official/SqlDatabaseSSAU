-- Выводит список объектов, если содержится слово 'Tennis' в точном регистре. 
SELECT
    UPPER(facility) as facility
FROM cd.facilities
WHERE facility LIKE BINARY '%Tennis%' ;