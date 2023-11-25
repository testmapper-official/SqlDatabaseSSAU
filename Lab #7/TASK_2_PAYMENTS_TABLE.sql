-- Создание таблицы payments.
USE cd;
DROP TABLE IF EXISTS payments;
CREATE TABLE IF NOT EXISTS payments (
    payid INT PRIMARY KEY AUTO_INCREMENT,
    payment DECIMAL DEFAULT 0,
    bookid INT,
    FOREIGN KEY (bookid) REFERENCES bookings (bookid)
);

-- Редактирование таблицы bookings если она еще не имеет этих изменений.
DROP PROCEDURE IF EXISTS createPayedProperty;
CREATE PROCEDURE createPayedProperty()
BEGIN
    IF ( EXISTS ( SELECT 1 FROM bookings WHERE payed IS NULL ) ) THEN
        ALTER TABLE bookings ADD payed BIT DEFAULT 0;
    END IF;
END;

CALL createPayedProperty();

-- Событие на запрет удаления оплаченного бронирования.
DROP TRIGGER IF EXISTS onBookingDelete;

CREATE TRIGGER onBookingDelete BEFORE DELETE ON bookings FOR EACH ROW
BEGIN 
    IF (    NOT EXISTS (
                SELECT 1
                FROM payments as pay
                WHERE pay.bookid = old.bookid
            )
        ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "You can't delete already paid booking";
    END IF;
END;

-- Событие при изменении статуса оплаты в bookings.
DROP TRIGGER IF EXISTS onBookingPay;

CREATE TRIGGER onBookingPay AFTER CHANGE ON bookings FOR EACH ROW
BEGIN
    -- TODO: оплата бронирования - добавление записи payments и отмена оплаты бронирования - удаление записи payments.
END;