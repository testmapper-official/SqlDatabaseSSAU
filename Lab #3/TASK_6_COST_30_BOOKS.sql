-- выбирает брони с указанием члена клуба, объекта и ее стоимости.
SELECT DISTINCT
    fac.facility,
    CONCAT(mem.surname, ' ', mem.firstname) AS 'Участник',
    IF(book.memid = 0, fac.guestcost, fac.membercost) * book.slots AS 'Стоимость'
FROM cd.members as mem
    INNER JOIN cd.bookings as book ON book.memid = mem.memid
    INNER JOIN cd.facilities as fac ON book.facid = fac.facid
WHERE DATE(starttime) = '2012.09.14' AND IF(book.memid = 0, fac.guestcost, fac.membercost) * book.slots > 30
ORDER BY Стоимость DESC;