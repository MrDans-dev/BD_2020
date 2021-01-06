CREATE TRIGGER `Aktualizacja Stanu` AFTER INSERT ON `Obsluga_dok`
 FOR EACH ROW UPDATE Towar SET Ilosc=Ilosc-new.Ilosc_tow WHERE Towar.ID = new.ID_towar AND new.ID_dok=2;

CREATE TRIGGER `Backup Towaru` BEFORE DELETE ON `Towar`
 FOR EACH ROW INSERT INTO `Backup_Towar`(`Indeks`, `Nazwa`, `Ilosc`, `ID_magazyn`, `Cena`, `Jednostka`, `ID_rodzaj`, `Ilosc_min`, `Ilosc_max`) VALUES (OLD.Indeks,old.Nazwa,Old.Ilosc,Old.ID_magazyn,Old.Cena,Old.Jednostka,old.ID_rodzaj, Old.Ilosc_min, Old.Ilosc_max);