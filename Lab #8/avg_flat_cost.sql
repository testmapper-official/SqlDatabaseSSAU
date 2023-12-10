-- Список средних стоимостей квартир по количеству комнат.
USE estates;
CREATE VIEW avg_flat_cost AS
    SELECT rooms, AVG(cost) as avg_cost
    FROM Apartment
    GROUP BY rooms;
