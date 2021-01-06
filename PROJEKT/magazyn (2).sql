-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Czas generowania: 06 Sty 2021, 20:35
-- Wersja serwera: 10.0.28-MariaDB-2+b1
-- Wersja PHP: 7.3.11-1~deb10u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `magazyn`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`kucharskid`@`%` PROCEDURE `Dodawanie do Wydania` (IN `Nr_dok` INT, IN `ID_towar` INT, IN `Ilosc` INT)  NO SQL
INSERT INTO Obsluga_dok VALUES (DEFAULT , @P0 , 2 , @P1 , @P2)$$

CREATE DEFINER=`kucharskid`@`%` PROCEDURE `Utwórz Raport Wartosci` ()  NO SQL
INSERT INTO `Raport_dok`(`ID_dok`, `Wartosc`, `Data_wystawienia`, `Data_potwierdzenia`) (SELECT * FROM `Raport Wartosci Dokumentow`)$$

CREATE DEFINER=`kucharskid`@`%` PROCEDURE `Zamów brakujące towary` ()  NO SQL
    SQL SECURITY INVOKER
INSERT INTO Obsluga_dok SELECT * FROM TDZ_P2$$

--
-- Funkcje
--
CREATE DEFINER=`kucharskid`@`%` FUNCTION `Analiza Stanów Magazynowych` () RETURNS TEXT CHARSET utf8 COLLATE utf8_polish_ci NO SQL
IF (SELECT COUNT(*) FROM Towar WHERE Ilosc=0) > 0
THEN RETURN 'Braki na stanach magazynowych!!!';
ELSE
RETURN 'OK';
END IF$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `Akumulatory`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `Akumulatory` (
`ID` int(11)
,`Indeks` varchar(50)
,`Nazwa` varchar(50)
,`Ilosc` int(11)
,`ID_magazyn` int(11)
,`Cena` float unsigned
,`Jednostka` enum('l','ml','g','kg')
,`ID_rodzaj` int(11)
,`Ilosc_min` int(11)
,`Ilosc_max` int(11)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Backup_Towar`
--

CREATE TABLE `Backup_Towar` (
  `ID` int(11) NOT NULL,
  `Indeks` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `Nazwa` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `Ilosc` int(11) NOT NULL DEFAULT '0',
  `ID_magazyn` int(11) NOT NULL DEFAULT '0',
  `Cena` float UNSIGNED NOT NULL DEFAULT '0',
  `Jednostka` enum('l','ml','g','kg') COLLATE utf8_polish_ci NOT NULL,
  `ID_rodzaj` int(11) NOT NULL,
  `Ilosc_min` int(11) NOT NULL DEFAULT '0',
  `Ilosc_max` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci COMMENT='Tabela przechowująca informacje o magazynowanych towarach';

--
-- Zrzut danych tabeli `Backup_Towar`
--

INSERT INTO `Backup_Towar` (`ID`, `Indeks`, `Nazwa`, `Ilosc`, `ID_magazyn`, `Cena`, `Jednostka`, `ID_rodzaj`, `Ilosc_min`, `Ilosc_max`) VALUES
(1, 'S1', 'Smar 1kg', 15, 5, 24.09, 'kg', 5, 10, 15);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Dokumenty`
--

CREATE TABLE `Dokumenty` (
  `ID` int(11) NOT NULL,
  `Nazwa` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  `Nazwa_sk` varchar(10) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `Dokumenty`
--

INSERT INTO `Dokumenty` (`ID`, `Nazwa`, `Nazwa_sk`) VALUES
(1, 'Przyjęcie Towaru', 'P'),
(2, 'Wydanie Towaru', 'W'),
(3, 'Zamówienie', 'Z');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `Ilosc magazynowanego Towaru`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `Ilosc magazynowanego Towaru` (
`Nazwa` varchar(30)
,`Rodzaj Magazynu` varchar(30)
,`Ilosc Towaru` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Magazyn`
--

CREATE TABLE `Magazyn` (
  `ID` int(11) NOT NULL,
  `Nazwa` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  `ID_rodzaj` int(11) NOT NULL,
  `Ilosc_miejsca` int(11) NOT NULL,
  `ID_miasto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci COMMENT='Lista magazynów';

--
-- Zrzut danych tabeli `Magazyn`
--

INSERT INTO `Magazyn` (`ID`, `Nazwa`, `ID_rodzaj`, `Ilosc_miejsca`, `ID_miasto`) VALUES
(1, 'MAG1', 1, 50, 1),
(2, 'MAG2', 2, 50, 1),
(3, 'MAG3', 4, 20, 1),
(4, 'MAG4', 3, 30, 1),
(5, 'MAG5', 1, 20, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Miasto`
--

CREATE TABLE `Miasto` (
  `ID` int(11) NOT NULL,
  `Nazwa` varchar(50) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `Miasto`
--

INSERT INTO `Miasto` (`ID`, `Nazwa`) VALUES
(1, 'Olsztyn');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Obsluga_dok`
--

CREATE TABLE `Obsluga_dok` (
  `ID` int(11) NOT NULL,
  `Nr_dok` int(10) UNSIGNED NOT NULL,
  `ID_dok` int(11) NOT NULL,
  `ID_towar` int(11) NOT NULL,
  `Ilosc_tow` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `Obsluga_dok`
--

INSERT INTO `Obsluga_dok` (`ID`, `Nr_dok`, `ID_dok`, `ID_towar`, `Ilosc_tow`) VALUES
(1, 1, 2, 2, 2),
(2, 1, 2, 3, 4),
(3, 2, 2, 3, 5),
(4, 2, 2, 3, 5),
(5, 3, 2, 2, 14),
(6, 3, 2, 5, 15),
(7, 4, 2, 9, 1),
(10, 5, 2, 3, 100),
(11, 3, 2, 5, 4),
(12, 5, 2, 9, 14);

--
-- Wyzwalacze `Obsluga_dok`
--
DELIMITER $$
CREATE TRIGGER `Aktualizacja Stanu` AFTER INSERT ON `Obsluga_dok` FOR EACH ROW UPDATE Towar SET Ilosc=Ilosc-new.Ilosc_tow WHERE Towar.ID = new.ID_towar AND new.ID_dok=2
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `Produkty poniżej średniej Cenowej`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `Produkty poniżej średniej Cenowej` (
`ID` int(11)
,`Indeks` varchar(50)
,`Nazwa` varchar(50)
,`Ilosc` int(11)
,`ID_magazyn` int(11)
,`Cena` float unsigned
,`Jednostka` enum('l','ml','g','kg')
,`ID_rodzaj` int(11)
,`Ilosc_min` int(11)
,`Ilosc_max` int(11)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `Ranking Sprzedazy Towarow`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `Ranking Sprzedazy Towarow` (
`Nazwa` varchar(50)
,`SUMA` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `Raport Wartosci Dokumentow`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `Raport Wartosci Dokumentow` (
`Nr_dok` int(10) unsigned
,`Wartosc` double
,`DATE(NOW())` date
,`NULL` binary(0)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Raport_dok`
--

CREATE TABLE `Raport_dok` (
  `ID` int(11) NOT NULL,
  `ID_dok` int(11) NOT NULL,
  `Wartosc` float UNSIGNED NOT NULL,
  `Data_wystawienia` date NOT NULL,
  `Data_potwierdzenia` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `Raport_dok`
--

INSERT INTO `Raport_dok` (`ID`, `ID_dok`, `Wartosc`, `Data_wystawienia`, `Data_potwierdzenia`) VALUES
(1, 1, 2540, '2021-01-06', NULL),
(2, 2, 5100, '2021-01-06', NULL),
(3, 3, 5600, '2021-01-06', NULL),
(4, 4, 15.23, '2021-01-06', NULL),
(5, 5, 51000, '2021-01-06', NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Rodzaj_Magazyn`
--

CREATE TABLE `Rodzaj_Magazyn` (
  `ID` int(11) NOT NULL,
  `Nazwa` varchar(30) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `Rodzaj_Magazyn`
--

INSERT INTO `Rodzaj_Magazyn` (`ID`, `Nazwa`) VALUES
(2, 'Akumulatorów Chemicznych'),
(3, 'Akumulatorów Litowo-jonowych'),
(1, 'Cieczy'),
(4, 'Materiałów niebezpiecznych');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Rodzaj_Towar`
--

CREATE TABLE `Rodzaj_Towar` (
  `ID` int(11) NOT NULL,
  `Nazwa` varchar(30) COLLATE utf8_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `Rodzaj_Towar`
--

INSERT INTO `Rodzaj_Towar` (`ID`, `Nazwa`) VALUES
(2, 'Akumulator'),
(4, 'Część do samochodów ciężarowyc'),
(3, 'Część do samochodów os.'),
(1, 'Płyn'),
(5, 'Smar');

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `Suma Wartości Na Rodzaj Towaru`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `Suma Wartości Na Rodzaj Towaru` (
`Nazwa` varchar(30)
,`Wartość` double
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `TDZ_P2`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `TDZ_P2` (
`NULL` binary(0)
,`3` int(1)
,`(SELECT MAX(ID_dok) FROM Obsluga_dok)` bigint(12)
,`ID` int(11)
,`Ilosc_max-Ilosc` bigint(12)
);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `Towar`
--

CREATE TABLE `Towar` (
  `ID` int(11) NOT NULL,
  `Indeks` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `Nazwa` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `Ilosc` int(11) NOT NULL DEFAULT '0',
  `ID_magazyn` int(11) NOT NULL DEFAULT '0',
  `Cena` float UNSIGNED NOT NULL DEFAULT '0',
  `Jednostka` enum('l','ml','g','kg') COLLATE utf8_polish_ci NOT NULL,
  `ID_rodzaj` int(11) NOT NULL,
  `Ilosc_min` int(11) NOT NULL DEFAULT '0',
  `Ilosc_max` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci COMMENT='Tabela przechowująca informacje o magazynowanych towarach';

--
-- Zrzut danych tabeli `Towar`
--

INSERT INTO `Towar` (`ID`, `Indeks`, `Nazwa`, `Ilosc`, `ID_magazyn`, `Cena`, `Jednostka`, `ID_rodzaj`, `Ilosc_min`, `Ilosc_max`) VALUES
(1, 'OSK', 'Olej silnikowy do kosiarek', 30, 1, 15.55, 'ml', 1, 0, 0),
(2, 'AKUM12_180', 'Akumulator 12v-180Ah', 1, 2, 250, 'kg', 2, 0, 0),
(3, 'AKUM12_225', 'Akumulator 12v-225Ah', 0, 2, 510, 'kg', 2, 20, 100),
(4, 'O5W_40', 'Olej 5W-40', 10, 1, 16.99, 'l', 1, 5, 10),
(5, 'AKUM12_55', 'Akumulator 12v-55Ah', 96, 1, 140, 'kg', 2, 55, 100),
(6, 'AKUM12_70', 'Akumulator 12v-70Ah', 166, 1, 135, 'kg', 2, 15, 166),
(7, 'AKUM12_25', 'Akumulator 12v-25Ah', 60, 1, 160, 'kg', 2, 44, 60),
(8, 'O5W_30', 'Olej 5W-30', 150, 2, 55, 'l', 1, 40, 150),
(9, 'S0.80', 'Smar 0.80kg', 31, 1, 15.23, 'kg', 5, 30, 45);

--
-- Wyzwalacze `Towar`
--
DELIMITER $$
CREATE TRIGGER `Backup Towaru` BEFORE DELETE ON `Towar` FOR EACH ROW INSERT INTO `Backup_Towar`(`Indeks`, `Nazwa`, `Ilosc`, `ID_magazyn`, `Cena`, `Jednostka`, `ID_rodzaj`, `Ilosc_min`, `Ilosc_max`) VALUES (OLD.Indeks,old.Nazwa,Old.Ilosc,Old.ID_magazyn,Old.Cena,Old.Jednostka,old.ID_rodzaj, Old.Ilosc_min, Old.Ilosc_max)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `Towar do zamowienia`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `Towar do zamowienia` (
`Nazwa` varchar(50)
,`Ilosc` int(11)
,`Ilosc_min` int(11)
,`Nalezy zamowic` bigint(12)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `Zamówiony Towar`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `Zamówiony Towar` (
`Nr_dok` int(10) unsigned
,`Dokument` varchar(30)
,`Towar` varchar(50)
,`Ilosc_tow` int(11)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `Średnia Wartość Dokumentów`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `Średnia Wartość Dokumentów` (
`Średania Wartość` double
,`Miesiąc` int(2)
,`Rok` int(4)
);

-- --------------------------------------------------------

--
-- Zastąpiona struktura widoku `Średnia Zamowien Towarow`
-- (Zobacz poniżej rzeczywisty widok)
--
CREATE TABLE `Średnia Zamowien Towarow` (
`Towar` varchar(50)
,`AVG(Ilosc_tow)` decimal(14,4)
);

-- --------------------------------------------------------

--
-- Struktura widoku `Akumulatory`
--
DROP TABLE IF EXISTS `Akumulatory`;

CREATE ALGORITHM=UNDEFINED DEFINER=`kucharskid`@`%` SQL SECURITY DEFINER VIEW `Akumulatory`  AS  select `Towar`.`ID` AS `ID`,`Towar`.`Indeks` AS `Indeks`,`Towar`.`Nazwa` AS `Nazwa`,`Towar`.`Ilosc` AS `Ilosc`,`Towar`.`ID_magazyn` AS `ID_magazyn`,`Towar`.`Cena` AS `Cena`,`Towar`.`Jednostka` AS `Jednostka`,`Towar`.`ID_rodzaj` AS `ID_rodzaj`,`Towar`.`Ilosc_min` AS `Ilosc_min`,`Towar`.`Ilosc_max` AS `Ilosc_max` from `Towar` where ((`Towar`.`Indeks` like 'A%') and (`Towar`.`Cena` between 100 and 500) and (`Towar`.`Ilosc` <> 0)) ;

-- --------------------------------------------------------

--
-- Struktura widoku `Ilosc magazynowanego Towaru`
--
DROP TABLE IF EXISTS `Ilosc magazynowanego Towaru`;

CREATE ALGORITHM=UNDEFINED DEFINER=`kucharskid`@`%` SQL SECURITY DEFINER VIEW `Ilosc magazynowanego Towaru`  AS  select `Magazyn`.`Nazwa` AS `Nazwa`,`Rodzaj_Magazyn`.`Nazwa` AS `Rodzaj Magazynu`,sum(`Towar`.`Ilosc`) AS `Ilosc Towaru` from ((`Magazyn` join `Towar` on((`Magazyn`.`ID` = `Towar`.`ID_magazyn`))) join `Rodzaj_Magazyn` on((`Magazyn`.`ID_rodzaj` = `Rodzaj_Magazyn`.`ID`))) group by `Towar`.`ID_magazyn` ;

-- --------------------------------------------------------

--
-- Struktura widoku `Produkty poniżej średniej Cenowej`
--
DROP TABLE IF EXISTS `Produkty poniżej średniej Cenowej`;

CREATE ALGORITHM=UNDEFINED DEFINER=`kucharskid`@`%` SQL SECURITY DEFINER VIEW `Produkty poniżej średniej Cenowej`  AS  select `Towar`.`ID` AS `ID`,`Towar`.`Indeks` AS `Indeks`,`Towar`.`Nazwa` AS `Nazwa`,`Towar`.`Ilosc` AS `Ilosc`,`Towar`.`ID_magazyn` AS `ID_magazyn`,`Towar`.`Cena` AS `Cena`,`Towar`.`Jednostka` AS `Jednostka`,`Towar`.`ID_rodzaj` AS `ID_rodzaj`,`Towar`.`Ilosc_min` AS `Ilosc_min`,`Towar`.`Ilosc_max` AS `Ilosc_max` from `Towar` having (`Towar`.`Cena` < avg(`Towar`.`Cena`)) ;

-- --------------------------------------------------------

--
-- Struktura widoku `Ranking Sprzedazy Towarow`
--
DROP TABLE IF EXISTS `Ranking Sprzedazy Towarow`;

CREATE ALGORITHM=UNDEFINED DEFINER=`kucharskid`@`%` SQL SECURITY DEFINER VIEW `Ranking Sprzedazy Towarow`  AS  select `Towar`.`Nazwa` AS `Nazwa`,sum(`Obsluga_dok`.`Ilosc_tow`) AS `SUMA` from (`Obsluga_dok` join `Towar` on((`Obsluga_dok`.`ID_towar` = `Towar`.`ID`))) group by `Obsluga_dok`.`ID_towar` order by sum(`Obsluga_dok`.`Ilosc_tow`) desc limit 10 ;

-- --------------------------------------------------------

--
-- Struktura widoku `Raport Wartosci Dokumentow`
--
DROP TABLE IF EXISTS `Raport Wartosci Dokumentow`;

CREATE ALGORITHM=UNDEFINED DEFINER=`kucharskid`@`%` SQL SECURITY DEFINER VIEW `Raport Wartosci Dokumentow`  AS  select `Obsluga_dok`.`Nr_dok` AS `Nr_dok`,sum((`Towar`.`Cena` * `Obsluga_dok`.`Ilosc_tow`)) AS `Wartosc`,cast(now() as date) AS `DATE(NOW())`,NULL AS `NULL` from (`Obsluga_dok` join `Towar` on((`Obsluga_dok`.`ID_towar` = `Towar`.`ID`))) group by `Obsluga_dok`.`Nr_dok` ;

-- --------------------------------------------------------

--
-- Struktura widoku `Suma Wartości Na Rodzaj Towaru`
--
DROP TABLE IF EXISTS `Suma Wartości Na Rodzaj Towaru`;

CREATE ALGORITHM=UNDEFINED DEFINER=`kucharskid`@`%` SQL SECURITY DEFINER VIEW `Suma Wartości Na Rodzaj Towaru`  AS  select `Rodzaj_Towar`.`Nazwa` AS `Nazwa`,sum(`Towar`.`Cena`) AS `Wartość` from (`Towar` join `Rodzaj_Towar` on((`Towar`.`ID_rodzaj` = `Rodzaj_Towar`.`ID`))) group by `Towar`.`ID_rodzaj` ;

-- --------------------------------------------------------

--
-- Struktura widoku `TDZ_P2`
--
DROP TABLE IF EXISTS `TDZ_P2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`kucharskid`@`%` SQL SECURITY DEFINER VIEW `TDZ_P2`  AS  select NULL AS `NULL`,3 AS `3`,(select (max(`Obsluga_dok`.`ID_dok`) + 1) from `Obsluga_dok`) AS `(SELECT MAX(ID_dok) FROM Obsluga_dok)`,`Towar`.`ID` AS `ID`,(`Towar`.`Ilosc_max` - `Towar`.`Ilosc`) AS `Ilosc_max-Ilosc` from `Towar` where (`Towar`.`Ilosc` < `Towar`.`Ilosc_min`) ;

-- --------------------------------------------------------

--
-- Struktura widoku `Towar do zamowienia`
--
DROP TABLE IF EXISTS `Towar do zamowienia`;

CREATE ALGORITHM=UNDEFINED DEFINER=`kucharskid`@`%` SQL SECURITY DEFINER VIEW `Towar do zamowienia`  AS  select `Towar`.`Nazwa` AS `Nazwa`,`Towar`.`Ilosc` AS `Ilosc`,`Towar`.`Ilosc_min` AS `Ilosc_min`,(`Towar`.`Ilosc_max` - `Towar`.`Ilosc`) AS `Nalezy zamowic` from `Towar` where (`Towar`.`Ilosc` < `Towar`.`Ilosc_min`) ;

-- --------------------------------------------------------

--
-- Struktura widoku `Zamówiony Towar`
--
DROP TABLE IF EXISTS `Zamówiony Towar`;

CREATE ALGORITHM=UNDEFINED DEFINER=`kucharskid`@`%` SQL SECURITY DEFINER VIEW `Zamówiony Towar`  AS  select `Obsluga_dok`.`Nr_dok` AS `Nr_dok`,`Dokumenty`.`Nazwa` AS `Dokument`,`Towar`.`Nazwa` AS `Towar`,`Obsluga_dok`.`Ilosc_tow` AS `Ilosc_tow` from ((`Obsluga_dok` join `Dokumenty` on((`Obsluga_dok`.`ID_dok` = `Dokumenty`.`ID`))) join `Towar` on((`Obsluga_dok`.`ID_towar` = `Towar`.`ID`))) where (`Obsluga_dok`.`ID_dok` = 2) ;

-- --------------------------------------------------------

--
-- Struktura widoku `Średnia Wartość Dokumentów`
--
DROP TABLE IF EXISTS `Średnia Wartość Dokumentów`;

CREATE ALGORITHM=UNDEFINED DEFINER=`kucharskid`@`%` SQL SECURITY DEFINER VIEW `Średnia Wartość Dokumentów`  AS  select avg(`Raport_dok`.`Wartosc`) AS `Średania Wartość`,month(`Raport_dok`.`Data_wystawienia`) AS `Miesiąc`,year(`Raport_dok`.`Data_wystawienia`) AS `Rok` from `Raport_dok` group by month(`Raport_dok`.`Data_wystawienia`) ;

-- --------------------------------------------------------

--
-- Struktura widoku `Średnia Zamowien Towarow`
--
DROP TABLE IF EXISTS `Średnia Zamowien Towarow`;

CREATE ALGORITHM=UNDEFINED DEFINER=`kucharskid`@`%` SQL SECURITY DEFINER VIEW `Średnia Zamowien Towarow`  AS  select `Zamówiony Towar`.`Towar` AS `Towar`,avg(`Zamówiony Towar`.`Ilosc_tow`) AS `AVG(Ilosc_tow)` from `Zamówiony Towar` group by `Zamówiony Towar`.`Towar` ;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `Backup_Towar`
--
ALTER TABLE `Backup_Towar`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Indeks` (`Indeks`),
  ADD KEY `Towar` (`ID_magazyn`),
  ADD KEY `ID_rodzaj` (`ID_rodzaj`);

--
-- Indeksy dla tabeli `Dokumenty`
--
ALTER TABLE `Dokumenty`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nazwa` (`Nazwa`);

--
-- Indeksy dla tabeli `Magazyn`
--
ALTER TABLE `Magazyn`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nazwa` (`Nazwa`),
  ADD KEY `ID_rodzaj` (`ID_rodzaj`),
  ADD KEY `ID_miasto` (`ID_miasto`);

--
-- Indeksy dla tabeli `Miasto`
--
ALTER TABLE `Miasto`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nazwa` (`Nazwa`);

--
-- Indeksy dla tabeli `Obsluga_dok`
--
ALTER TABLE `Obsluga_dok`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID_dok` (`ID_dok`),
  ADD KEY `ID_towar` (`ID_towar`);

--
-- Indeksy dla tabeli `Raport_dok`
--
ALTER TABLE `Raport_dok`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID_dok` (`ID_dok`);

--
-- Indeksy dla tabeli `Rodzaj_Magazyn`
--
ALTER TABLE `Rodzaj_Magazyn`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nazwa` (`Nazwa`);

--
-- Indeksy dla tabeli `Rodzaj_Towar`
--
ALTER TABLE `Rodzaj_Towar`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nazwa` (`Nazwa`);

--
-- Indeksy dla tabeli `Towar`
--
ALTER TABLE `Towar`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Indeks` (`Indeks`),
  ADD KEY `Towar` (`ID_magazyn`),
  ADD KEY `ID_rodzaj` (`ID_rodzaj`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `Backup_Towar`
--
ALTER TABLE `Backup_Towar`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `Dokumenty`
--
ALTER TABLE `Dokumenty`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `Magazyn`
--
ALTER TABLE `Magazyn`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT dla tabeli `Miasto`
--
ALTER TABLE `Miasto`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT dla tabeli `Obsluga_dok`
--
ALTER TABLE `Obsluga_dok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT dla tabeli `Raport_dok`
--
ALTER TABLE `Raport_dok`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT dla tabeli `Rodzaj_Magazyn`
--
ALTER TABLE `Rodzaj_Magazyn`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `Rodzaj_Towar`
--
ALTER TABLE `Rodzaj_Towar`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT dla tabeli `Towar`
--
ALTER TABLE `Towar`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `Magazyn`
--
ALTER TABLE `Magazyn`
  ADD CONSTRAINT `Magazyn_ibfk_1` FOREIGN KEY (`ID_rodzaj`) REFERENCES `Rodzaj_Magazyn` (`ID`),
  ADD CONSTRAINT `Magazyn_ibfk_2` FOREIGN KEY (`ID_miasto`) REFERENCES `Miasto` (`ID`);

--
-- Ograniczenia dla tabeli `Obsluga_dok`
--
ALTER TABLE `Obsluga_dok`
  ADD CONSTRAINT `Obsluga_dok_ibfk_1` FOREIGN KEY (`ID_dok`) REFERENCES `Dokumenty` (`ID`),
  ADD CONSTRAINT `Obsluga_dok_ibfk_2` FOREIGN KEY (`ID_towar`) REFERENCES `Towar` (`ID`);

--
-- Ograniczenia dla tabeli `Raport_dok`
--
ALTER TABLE `Raport_dok`
  ADD CONSTRAINT `Raport_dok_ibfk_1` FOREIGN KEY (`ID_dok`) REFERENCES `Obsluga_dok` (`ID`);

--
-- Ograniczenia dla tabeli `Towar`
--
ALTER TABLE `Towar`
  ADD CONSTRAINT `Towar` FOREIGN KEY (`ID_magazyn`) REFERENCES `Magazyn` (`ID`),
  ADD CONSTRAINT `Towar_ibfk_1` FOREIGN KEY (`ID_rodzaj`) REFERENCES `Rodzaj_Towar` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
