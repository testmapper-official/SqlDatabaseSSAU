-- Выводит список объектов, если содержится слово теннис в произвольном регистре.
SELECT
    facility as facility
FROM cd.facilities
WHERE facility LIKE '%Tennis%';