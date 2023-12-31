-- Откройте транзакцию, удалите пользователя с memid = 37, 
-- выведите список всех членов клуба, завершите транзакцию
-- с отказом о всех изменениях.  Повторно выведите список
-- всех членов клуба. Сохраните скриgт на GitHub.
-- Повторно выполните вышеуказанные действия завершив 
-- транзакцию с сохранением всех изменений. 
-- Сравните полученные результаты.
USE cd;

START TRANSACTION;
  DELETE FROM members
  WHERE memid = 37;
  SELECT * FROM members;
ROLLBACK;

SELECT * FROM members;
-- Сравнивая результаты, мы удалили пользователя с memid = 37 но вернули назад.

START TRANSACTION;
  DELETE FROM members
  WHERE memid = 37;
  SELECT * FROM members;
COMMIT;

SELECT * FROM members;
-- Таким образом, с помощью транзакции мы проверили, что удаляем ТОЧНО ТЕ данные, которые нам необходимы.
-- И после пробной проверки, мы удаляем пользователя с подтверждением.

