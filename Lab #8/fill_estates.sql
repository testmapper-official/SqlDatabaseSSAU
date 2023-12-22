USE estates;

INSERT INTO Holder
    (ID, firstname, surname, email, telegram, vk)
VALUES
    (0, 'Pavel', 'Rochev', 'pavelrussia@gmail.com', '@pavel332', 'vk.com/pavelch'),
    (1, 'Marina', 'Vyazova', 'vyamarine@yandex.ru', '@marinv', 'vk.com/marinv'),
    (2, 'Sergey', 'Malov', 'serjant@gmail.com', '@serj', 'vk.com/serj'),
    (3, 'Elaine', 'Nerestova', 'nelya1991@mail.ru', '@nelyash', 'vk.com/nelyash');

INSERT INTO Realtor
    (ID, firstname, surname, email, telegram, vk)
VALUES
    (0, 'Valentin', 'Dobry', 'dobryval@mail.ru', '@dobryval', 'vk.com/dobryval'),
    (1, 'Ilya', 'Naumov', 'militaryilya2001@yandex.ru', '@naumov1987', 'vk.com/naumov1987'),
    (2, 'Sergey', 'Malov', 'serjant@gmail.com', '@serj', 'vk.com/serj');

INSERT INTO Apartment
    (ID, holderID, total_size, live_size, kitchen_size, rooms, address, total_floors, floor, cost, register_date, change_date)
VALUES
    (0, 0, 24, 16, 4, 1, 'Samara, October prospect, h. 72, ent. 3, 4 floor, 407 room', 7, 4, 18000000, '2007-03-11', '2012-03-01'),
    (1, 2, 18, 11, 3, 1, 'Samara, October prospect, h. 32, ent. 2, 2 floor, 501 room', 9, 2, 16000000, '2010-01-05', '2011-05-10'),
    (2, 3, 40, 28, 6, 2, 'Samara, Revoluchionnaya street, h. 17, ent. 1, 5 floor, 501 room', 5, 4, 68000000, '2011-01-05', '2010-11-30'),
    (3, 3, 24, 16, 4, 2, 'Samara, Revoluchionnya street, h. 18, ent. 1, 5 floor, 503 room', 5, 4, 32000000, '2009-05-11', '2010-07-02'),
    (4, 1, 24, 16, 4, 2, 'Samara, Revoluchionnya street, h. 18, ent. 1, 5 floor, 504 room', 5, 4, 32000000, '2009-05-11', '2009-05-11');

INSERT INTO Apartment_Realtors
    (apartmentID, realtorID)
VALUES
    (0, 2),
    (1, 0),
    (2, 2),
    (3, 1),
    (4, 0),
    (4, 1);