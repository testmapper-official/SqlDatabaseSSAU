-- Создание таблицы payments.
USE cd;

DROP TABLE IF EXISTS payments;
CREATE TABLE IF NOT EXISTS payments (
    payid INT PRIMARY KEY AUTO_INCREMENT,
    bookid INT,
    payment DECIMAL DEFAULT 0,
    FOREIGN KEY (bookid) REFERENCES bookings (bookid)
);

DELIMITER $$

-- Редактирование таблицы bookings если она еще не имеет этих изменений.
DROP PROCEDURE IF EXISTS createPayedProperty $$
CREATE PROCEDURE createPayedProperty()
BEGIN
    IF ( NOT EXISTS (
            SELECT * FROM information_schema.COLUMNS
            WHERE TABLE_SCHEMA = 'cd' AND TABLE_NAME = 'bookings' AND COLUMN_NAME = 'payed' 
        ) ) THEN
        ALTER TABLE bookings ADD payed TINYINT DEFAULT 0;
    END IF;
END $$

CALL createPayedProperty() $$

-- Событие на запрет удаления оплаченного бронирования.
DROP TRIGGER IF EXISTS onBookingDelete $$

CREATE TRIGGER onBookingDelete BEFORE DELETE ON bookings FOR EACH ROW
BEGIN
    IF (    EXISTS (
                SELECT 1
                FROM payments as pay
                WHERE pay.bookid = OLD.bookid
            )
        ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "You can't delete already paid booking";
    END IF;
END $$

-- Событие при изменении статуса оплаты в bookings.
DROP TRIGGER IF EXISTS onBookingPay $$

CREATE TRIGGER onBookingPay AFTER UPDATE ON bookings FOR EACH ROW
BEGIN
-- Нашел, что MySQL страдает странной болезнью при сравнении OLD и NEW (<> или != вообще не работает, а <=> срабатывает на 2й раз).
-- И судя по всему это еще было в прошлой версии MySQL (5.*), но в 8.* по-прежнему все плохо, хоть и не так сильно как раньше.

-- Если бронь изменила свой статус оплаты, то удаляет\добавляет оплату (в ином случае делает ничего).
    IF NEW.payed <=> OLD.payed THEN
        CASE
            WHEN NEW.payed = 1 THEN
                INSERT INTO payments(bookid, payment)
                SELECT NEW.bookid, getRentCost(memid, facid, slots)
                FROM bookings as book WHERE book.bookid = NEW.bookid LIMIT 1;
            WHEN NEW.payed = 0 THEN
                DELETE FROM payments as pay WHERE pay.bookid = NEW.bookid;
        END CASE;
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