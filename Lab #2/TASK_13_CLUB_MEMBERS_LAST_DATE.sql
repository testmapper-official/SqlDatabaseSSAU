-- Выбирает последних зарегистрировавшихся людей клуба за все время.
SELECT surname, firstname, joindate from cd.members ORDER BY joindate DESC;