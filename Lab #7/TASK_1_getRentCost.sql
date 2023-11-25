-- Функция расчета стоимости аренды записи бронирования.
DROP FUNCTION IF EXISTS getRentCost;

CREATE FUNCTION getRentCost (bid INTEGER) RETURNS INTEGER
    DETERMINISTIC
BEGIN
    DECLARE rent_cost INTEGER DEFAULT 0;
    -- Хотя это должно быть очень плохо, на каждую запись одного запроса создавать еще запрос. Но поскольку функция должна что-то возвращать, то...
	SELECT IF(
            book.memid = 0,
            fac.guestcost,
            fac.membercost
        ) * book.slots INTO rent_cost
    FROM cd.bookings as book
    JOIN cd.facilities as fac ON book.facid = fac.facid
    WHERE book.bookid = bid;
    RETURN rent_cost;
END;

SELECT bookid, getRentCost(bookid) as rent_cost FROM cd.bookings;
