-- выбирает членов клуба рекомендованных к вступлению другими членам клуба и людей рекомендавших их в алфавитном порядке.
SELECT
    DISTINCT CONCAT(mem1.surname, ' ', mem1.firstname) as 'Участник',
    CONCAT(mem2.surname, ' ', mem2.firstname) as 'Рекомендован'
FROM cd.members as mem1
    LEFT JOIN cd.members as mem2 ON mem1.recommendedby = mem2.memid
ORDER BY Участник;