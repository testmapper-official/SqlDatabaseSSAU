-- выбирает список покупок времени члена клуба David Farrell
SELECT
    starttime as "David's time"
FROM cd.bookings as book
    INNER JOIN cd.members as mem ON book.memid = mem.memid
WHERE mem.firstname = 'David' and mem.surname = 'Farrell';