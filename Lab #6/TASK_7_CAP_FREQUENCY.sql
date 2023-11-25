-- Выводит встречаемости первых букв фамилий среди всех членов клуба

SELECT
    LEFT(surname, 1) as capital,
    COUNT(*) as count
FROM cd.members
GROUP BY capital
ORDER BY capital DESC;