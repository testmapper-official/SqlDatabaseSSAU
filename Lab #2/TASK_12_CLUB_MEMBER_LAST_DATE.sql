-- Выбирает 1 последнего зарегистрировавшегося человека клуба за все время (и берет с него только дату).
SELECT joindate from cd.members ORDER BY joindate DESC LIMIT 1;