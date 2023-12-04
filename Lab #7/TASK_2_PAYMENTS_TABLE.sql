-- Создание таблицы payments.
USE cd;

DROP TABLE IF EXISTS payments;
CREATE TABLE IF NOT EXISTS payments (
    payid INT PRIMARY KEY AUTO_INCREMENT,
    bookid INT,
    payment DECIMAL DEFAULT 0,
    FOREIGN KEY (bookid) REFERENCES bookings (bookid)
);
-- Редактирование таблицы bookings если она еще не имеет этих изменений.
ALTER TABLE bookings ADD payed TINYINT DEFAULT 0;

DELIMITER $$

-- Событие на запрет удаления оплаченного бронирования.
DROP TRIGGER IF EXISTS onBookingDelete $$

CREATE TRIGGER onBookingDelete BEFORE DELETE ON bookings FOR EACH ROW
BEGIN
    IF (OLD.payed = 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "You can't delete already paid booking";
    END IF;
END $$

-- Событие при изменении статуса оплаты в bookings.
DROP TRIGGER IF EXISTS onBookingPay $$
CREATE TRIGGER onBookingPay AFTER UPDATE ON bookings FOR EACH ROW
BEGIN
    -- Если бронь изменила свой статус оплаты, то удаляет\добавляет оплату (в ином случае делает ничего).
    CASE
        WHEN NEW.payed = OLD.payed THEN BEGIN END;
        WHEN NEW.payed = 1 THEN
            INSERT INTO payments(bookid, payment)
            VALUES(NEW.bookid, getRentCost(NEW.memid, NEW.facid, NEW.slots));
        WHEN NEW.payed = 0 THEN
            DELETE FROM payments as pay WHERE pay.bookid = NEW.bookid;
    END CASE;
END $$

DROP TRIGGER IF EXISTS onBookingCreatePayed $$
CREATE TRIGGER onBookingCreatePayed AFTER INSERT ON bookings FOR EACH ROW
BEGIN
    -- Если бронь уже оплачена при регистрации (payed = 1), добавляет оплату.
    IF NEW.payed = 1 THEN
        INSERT INTO payments(bookid, payment)
        VALUES(NEW.bookid, getRentCost(NEW.memid, NEW.facid, NEW.slots));
    END IF;
END $$

DELIMITER ;

-- Изменение статуса записей
UPDATE bookings
  SET payed = 1
  WHERE DATE(starttime) < '2012-08-01' AND DATE(starttime) >= '2012-07-01';

-- Подсчет суммы оплаченных аренд двумя способами
SELECT SUM(payment) FROM payments;
SELECT SUM(getRentCost(memid, facid, slots))
    FROM bookings
    WHERE DATE(starttime) < '2012-08-01' AND DATE(starttime) >= '2012-07-01';