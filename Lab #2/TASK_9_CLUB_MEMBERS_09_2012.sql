-- ВЫБИРАЕТ ЧЛЕНОВ КЛУБА ЗАРЕГИСТРИРОВАВШИХСЯ C СЕНТЯБРЯ 2012 ГОДА В ТАБЛИЦЕ facilities БД cd
SELECT * FROM cd.members WHERE MONTH(joindate) >= 9 AND YEAR(joindate) = 2012 OR YEAR(joindate) > 2012; 