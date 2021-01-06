CREATE DEFINER=`kucharskid`@`%` FUNCTION `Analiza Stanów Magazynowych` () RETURNS TEXT CHARSET utf8 COLLATE utf8_polish_ci NO SQL
IF (SELECT COUNT(*) FROM Towar WHERE Ilosc=0) > 0
THEN RETURN 'Braki na stanach magazynowych!!!';
ELSE
RETURN 'OK';
END IF$$

DELIMITER ;