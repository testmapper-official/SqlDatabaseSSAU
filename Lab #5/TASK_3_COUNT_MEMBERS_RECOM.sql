-- Выводит членов клуба, которые давали рекомендации как минимум ОДИН РАЗ и их количество.
SELECT mem1.firstname, mem1.surname, COUNT(mem2.memid) as recommendation_count
FROM cd.members as mem1
LEFT JOIN cd.members as mem2 ON mem2.recommendedby = mem1.memid
WHERE mem2.memid IS NOT NULL
GROUP BY mem1.memid;