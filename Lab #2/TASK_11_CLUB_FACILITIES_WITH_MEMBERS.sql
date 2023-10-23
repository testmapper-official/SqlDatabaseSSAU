-- Объединяет всех ФИ членов клуба и названия объектов в один столбец запроса.
SELECT DISTINCT CONCAT(firstname, ' ', surname) as 'Members and Facilities' FROM cd.members WHERE firstname != 'GUEST' OR surname != 'GUEST'
UNION
SELECT DISTINCT facility FROM cd.facilities;