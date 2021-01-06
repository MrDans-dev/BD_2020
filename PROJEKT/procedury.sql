CREATE DEFINER=`kucharskid`@`%` PROCEDURE `Dodawanie do Wydania` (IN `Nr_dok` INT, IN `ID_towar` INT, IN `Ilosc` INT)  NO SQL
INSERT INTO Obsluga_dok VALUES (DEFAULT , @P0 , 2 , @P1 , @P2)$$

CREATE DEFINER=`kucharskid`@`%` PROCEDURE `Utwórz Raport Wartosci` ()  NO SQL
INSERT INTO `Raport_dok`(`ID_dok`, `Wartosc`, `Data_wystawienia`, `Data_potwierdzenia`) (SELECT * FROM `Raport Wartosci Dokumentow`)$$

CREATE DEFINER=`kucharskid`@`%` PROCEDURE `Zamów brakujące towary` ()  NO SQL
    SQL SECURITY INVOKER
INSERT INTO Obsluga_dok SELECT * FROM TDZ_P2$$