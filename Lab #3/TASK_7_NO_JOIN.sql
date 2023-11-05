-- выбирает членов клуба рекомендованных к вступлению другими членам клуба и людей рекомендавших их в алфавитном порядке БЕЗ использования JOIN.
SELECT DISTINCT
      CONCAT(mem1.surname, " ", mem1.firstname) as 'Участник',
      IF(mem1.recommendedby IS NULL, "NULL", CONCAT(mem2.surname, " ", mem2.firstname)) as 'Рекомендован'
  FROM cd.members as mem1, cd.members mem2
  WHERE (mem1.recommendedby = mem2.memid OR mem1.recommendedby IS NULL)
        and mem1.surname NOT LIKE "GUEST"
  ORDER BY Участник;