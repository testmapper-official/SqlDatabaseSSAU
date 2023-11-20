-- Выводит список членов клуба с их первым бронированием после 2021-09-01
SELECT
    mem.memid,
    mem.firstname,
    mem.surname,
    MIN(book.starttime) as firstdate
FROM cd.members as mem
LEFT JOIN cd.bookings as book ON mem.memid = book.memid
GROUP BY mem.memid
HAVING DATE(firstdate) > '2012-09-01'