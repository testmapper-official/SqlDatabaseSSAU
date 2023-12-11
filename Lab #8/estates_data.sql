/**
 * База данных о недвижимости, их владельцев и риелторов.
 * База данных включает в себя квартиры, стоимость, кто ими владеет, дату регистрации и позднюю дату об изменении информации,
 * адрес квартиры, количество этажей в здании, где находится квартира; на каком этаже находится квартира,
 * жилая, кухонная и общая площади.
 * Также сюда включены контакты владельцев и риелторов.
 */

CREATE DATABASE IF NOT EXISTS `estates`;

USE estates;

CREATE TABLE IF NOT EXISTS Holder (
    ID INT PRIMARY KEY,
    firstname VARCHAR(128),
    surname VARCHAR(128),
    email VARCHAR(200),
    telegram VARCHAR(200),
    vk VARCHAR(200),

    change_date TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Realtor (
    ID INT PRIMARY KEY,
    firstname VARCHAR(128),
    surname VARCHAR(128),
    email VARCHAR(200),
    telegram VARCHAR(200),
    vk VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS Apartment (
    ID INT PRIMARY KEY,
    holderID INT,
    realtorID INT,
    FOREIGN KEY (holderID) REFERENCES Holder(ID),
    FOREIGN KEY (realtorID) REFERENCES Realtor(ID),

    total_size DECIMAL,
    live_size DECIMAL,
    kitchen_size DECIMAL,
    rooms INT,

    address VARCHAR(200),
    total_floors INT,
    floor INT,

    cost DECIMAL,
    register_date TIMESTAMP,
    change_date TIMESTAMP
);
