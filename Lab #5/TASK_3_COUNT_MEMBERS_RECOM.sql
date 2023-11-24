-- Выводит членов клуба, которые давали рекомендации как минимум ОДИН РАЗ и их количество.
SELECT
    mem1.firstname
,   mem1.surname
,   COUNT(mem2.memid) as recommendation_count
FROM cd.members as mem1
JOIN cd.members as mem2 ON mem2.recommendedby = mem1.memid
GROUP BY mem1.memid;