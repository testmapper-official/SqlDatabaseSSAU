-- Выводит список всех участников с их округленным количеством забронированных часов.

SELECT
    book.memid
,   mem.surname
,   mem.firstname
,   ROUND(SUM(slots) / 2, -1) AS fachours
,   DENSE_RANK() OVER(ORDER BY ROUND(SUM(slots) / 2, -1)) AS ranking
FROM cd.bookings as book
LEFT JOIN cd.members AS mem ON book.memid = mem.memid
GROUP BY book.memid
ORDER BY ranking, surname, firstname;