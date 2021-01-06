CREATE TABLE `Backup_Towar` (
  `ID` int(11) AUTO-INCREMENT PRIMARY-KEY NOT NULL,
  `Indeks` varchar(50) NOT NULL,
  `Nazwa` varchar(50) NOT NULL,
  `Ilosc` int(11) NOT NULL DEFAULT '0',
  `ID_magazyn` int(11) NOT NULL DEFAULT '0',
  `Cena` float UNSIGNED NOT NULL DEFAULT '0',
  `Jednostka` enum('l','ml','g','kg') NOT NULL,
  `ID_rodzaj` int(11) NOT NULL,
  `Ilosc_min` int(11) NOT NULL DEFAULT '0',
  `Ilosc_max` int(11) NOT NULL DEFAULT '0'
)

CREATE TABLE `Dokumenty` (
  `ID` int(11) AUTO-INCREMENT PRIMARY-KEY NOT NULL,
  `Nazwa` varchar(30) NOT NULL,
  `Nazwa_sk` varchar(10) NOT NULL
)

CREATE TABLE `Magazyn` (
  `ID` int(11) AUTO-INCREMENT PRIMARY-KEY NOT NULL,
  `Nazwa` varchar(30) NOT NULL,
  `ID_rodzaj` int(11) NOT NULL,
  `Ilosc_miejsca` int(11) NOT NULL,
  `ID_miasto` int(11) NOT NULL
)

CREATE TABLE `Miasto` (
  `ID` int(11) AUTO-INCREMENT PRIMARY-KEY NOT NULL,
  `Nazwa` varchar(50) NOT NULL
)

CREATE TABLE `Obsluga_dok` (
  `ID` int(11) AUTO-INCREMENT PRIMARY-KEY NOT NULL,
  `Nr_dok` int(10) UNSIGNED NOT NULL,
  `ID_dok` int(11) NOT NULL,
  `ID_towar` int(11) NOT NULL,
  `Ilosc_tow` int(11) NOT NULL
)

CREATE TABLE `Raport_dok` (
  `ID` int(11) AUTO-INCREMENT PRIMARY-KEY NOT NULL,
  `ID_dok` int(11) NOT NULL,
  `Wartosc` float UNSIGNED NOT NULL,
  `Data_wystawienia` date NOT NULL,
  `Data_potwierdzenia` date DEFAULT NULL
)

CREATE TABLE `Rodzaj_Magazyn` (
  `ID` int(11) AUTO-INCREMENT PRIMARY-KEY NOT NULL,
  `Nazwa` varchar(30) NOT NULL
) 

CREATE TABLE `Rodzaj_Towar` (
  `ID` int(11) AUTO-INCREMENT PRIMARY-KEY NOT NULL,
  `Nazwa` varchar(30) COLLATE utf8_polish_ci NOT NULL
) 

CREATE TABLE `Towar` (
  `ID` int(11) AUTO-INCREMENT PRIMARY-KEY NOT NULL,
  `Indeks` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `Nazwa` varchar(50) COLLATE utf8_polish_ci NOT NULL,
  `Ilosc` int(11) NOT NULL DEFAULT '0',
  `ID_magazyn` int(11) NOT NULL DEFAULT '0',
  `Cena` float UNSIGNED NOT NULL DEFAULT '0',
  `Jednostka` enum('l','ml','g','kg') COLLATE utf8_polish_ci NOT NULL,
  `ID_rodzaj` int(11) NOT NULL,
  `Ilosc_min` int(11) NOT NULL DEFAULT '0',
  `Ilosc_max` int(11) NOT NULL DEFAULT '0'
) 