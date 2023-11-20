-- Выводит нумерованный список участников с датой присоединения
SELECT
    ROW_NUMBER() OVER (
        ORDER BY mem.joindate
    ) as '#',
    mem.memid,
    mem.firstname,
    mem.surname,
    mem.joindate
FROM cd.members as mem
GROUP BY mem.memid
ORDER BY mem.joindate