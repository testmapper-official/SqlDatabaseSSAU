-- выбирает членов клуба покупавших 1й и 2й корты.
SELECT DISTINCT
    CONCAT(firstname, ' ', surname) as 'Участник'
FROM cd.members as mem
    JOIN cd.bookings as book ON book.memid = mem.memid
    JOIN cd.facilities as fac ON book.facid = fac.facid 
WHERE fac.facility REGEXP '.*Court [1-2]+';