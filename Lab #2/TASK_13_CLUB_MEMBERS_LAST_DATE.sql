-- Выбирает людей клуба c последней датой регистрации.
SELECT surname, firstname, joindate from cd.members WHERE joindate IN(
    SELECT MAX(joindate) FROM cd.members
)