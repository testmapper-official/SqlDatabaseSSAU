-- Выбирает ВСЕ ЗАПИСИ членов клуба (повторяющиеся исключены), в какой они объект ходят в формате: Имя объекта - Имя Фамилия.
SELECT DISTINCT CONCAT(facility, ' - ', firstname, ' ', surname) as occupation
    FROM cd.bookings as book
    INNER JOIN
    cd.facilities as fac ON fac.facid = book.facid
    INNER JOIN
    cd.members as mem ON mem.memid = book.memid;