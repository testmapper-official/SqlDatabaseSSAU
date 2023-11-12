-- Выводит количество объектов в БД чья гостевая стоимость не меньше 10.
SELECT COUNT(facid) as 'Кол-во объектов'
FROM cd.facilities
WHERE guestcost >= 10;