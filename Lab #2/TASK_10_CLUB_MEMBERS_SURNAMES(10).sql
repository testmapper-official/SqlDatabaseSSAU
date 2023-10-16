-- ВЫБИРАЕТ 10 УНИКАЛЬНЫХ ФАМИЛИЙ ЧЛЕН КЛУБА С ТАБЛИЦЫ members БД cd
SELECT DISTINCT surname FROM cd.members ORDER BY surname LIMIT 10;