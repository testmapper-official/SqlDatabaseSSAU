-- Список двухкомнатных квартир
USE estates;
CREATE VIEW flats_2 AS
    SELECT *
    FROM Apartment
    WHERE rooms = 2;