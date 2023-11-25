-- Выводит список участников в виде "Surname, Firstname"

SELECT
    CONCAT(surname, ', ', firstname) as initials
FROM cd.members;