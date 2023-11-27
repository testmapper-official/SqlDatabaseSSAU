-- Выводит список объектов, если содержится слово теннис с капитализацией первого слова в названии объекта.
SELECT
    CONCAT(UPPER(LEFT(facility, 1)), LOWER(SUBSTRING(facility, 2))) as facility
FROM cd.facilities
WHERE facility LIKE '%Tennis%';