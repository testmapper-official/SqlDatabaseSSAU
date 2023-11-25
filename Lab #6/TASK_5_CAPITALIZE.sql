-- Выводит список объектов, если содержится слово теннис с капитализацией каждого слова в названии объекта.
DROP FUNCTION IF EXISTS capitalize_words;

CREATE FUNCTION capitalize_words (input VARCHAR(255))
    RETURNS VARCHAR(255)
    DETERMINISTIC
BEGIN
	DECLARE len INT;
	DECLARE i INT;

	SET len   = CHAR_LENGTH(input);
	SET input = LOWER(input);
	SET i = 0;

	WHILE (i < len) DO
		IF (MID(input,i,1) = ' ' OR i = 0) THEN
			IF (i < len) THEN
				SET input = CONCAT(
					LEFT(input, i),
					UPPER(MID(input,i + 1, 1)),
					RIGHT(input, len - i - 1)
				);
			END IF;
		END IF;
		SET i = i + 1;
	END WHILE;

	RETURN input;
END;

SELECT
    facility as facility
FROM cd.facilities;
SELECT
    IF(facility LIKE '%Tennis%', capitalize_words(facility), facility) as facility
FROM cd.facilities;