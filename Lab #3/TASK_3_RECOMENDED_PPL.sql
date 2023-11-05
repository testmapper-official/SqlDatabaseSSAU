-- выбирает членов клуба рекомендованных к вступлению другими членам клуба.
SELECT
    mem1.surname,
    mem2.firstname
FROM cd.members as mem1
    JOIN cd.members as mem2
WHERE mem1.recommendedby = mem2.memid