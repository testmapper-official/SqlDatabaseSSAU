-- Выводит кол-во членов клуба бронировавших минимум один раз.
SELECT COUNT(DISTINCT book.memid) as mem_count
FROM cd.bookings as book;