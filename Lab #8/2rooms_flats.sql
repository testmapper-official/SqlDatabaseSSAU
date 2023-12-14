-- Список двухкомнатных квартир
USE estates;
CREATE VIEW flats_2 AS
    SELECT holderID, live_size, address, cost
    FROM Apartment
    WHERE rooms = 2;