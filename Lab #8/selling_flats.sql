-- Показывает владельцев квартир и количество их недвижимости.
USE estates;
CREATE VIEW selling_flats AS
    SELECT Holder.ID, surname, firstname, Count(*) as flats
    FROM Holder
    LEFT JOIN Apartment as apart ON apart.holderID = Holder.ID
    GROUP BY Holder.ID;