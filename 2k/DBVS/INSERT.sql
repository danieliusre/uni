INSERT INTO Kino_teatras(pavadinimas,adresas) VALUES('Multikino','Ozo g. 18');
INSERT INTO Kino_teatras(pavadinimas,adresas) VALUES('ForumCinemas Akropolis','Ozo g. 25');
INSERT INTO Kino_teatras(pavadinimas,adresas) VALUES('ForumCinemas Vingis','Savanorių pr. 7');
INSERT INTO Kino_teatras(pavadinimas,adresas) VALUES('Skalvija','A. Goštauto g. 2');
INSERT INTO Kino_teatras(pavadinimas,adresas) VALUES('Pasaka','Paupio g. 26');

INSERT INTO Filmas VALUES(101,'Once Upon a Time in Hollywood','Comedy','02:41:00',90,7.6,'JAV');
INSERT INTO Filmas VALUES(102,'Parasite','Drama','02:12:00', 11.4, 8.6,'South Korea');
INSERT INTO Filmas VALUES(103,'Knives Out','Drama','02:10:00',4,7.9,'JAV');
INSERT INTO Filmas VALUES(104,'1917','Action','01:59:00',95,8.3,'JAV');
INSERT INTO Filmas VALUES(105,'Dunkirk','Action','01:53:00',100,7.8,'UK');
INSERT INTO Filmas VALUES(106,'The Shawshank Redemption','Drama','02:22:00',25,9.3,'JAV');
INSERT INTO Filmas VALUES(107,'Encanto','Animation','01:42:00',50,7.7,'JAV');
INSERT INTO Filmas VALUES(108,'Shutter Island','Thriller','02:18:00',80,8.2,'JAV');
INSERT INTO Filmas VALUES(109,'Ford v Ferrari','Action','02:32:00',97.6,8.1,'JAV');
INSERT INTO Filmas VALUES(110,'Apollo 11','Documentary','01:33:00',9,8.2,'JAV');
INSERT INTO Filmas VALUES(111,'Avengers: Endgame','Fantasy','03:01:00',365,8.4,'JAV');
INSERT INTO Filmas VALUES(112,'Shrek','Animation','01:30:00',60,7.9,'JAV');
INSERT INTO Filmas VALUES(113,'Frozen','Animation','01:42:00',150,7.4,'JAV');
INSERT INTO Filmas VALUES(114,'Frozen 2','Animation','01:43:00',150,6.8,'JAV');

INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(101,1,1,'14:30','2021-12-07', 4, 100);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(103,1,1,'19:30','2021-12-07', 4, 95);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(104,1,2,'15:30','2021-12-07', 4, 30);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(110,1,2,'19:30','2021-12-07', 4, 50);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(111,1,2,'23:00','2021-12-07', 4, 60);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(107,1,3,'10:30','2021-12-08', 3, 80);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(113,1,3,'13:20','2021-12-08', 3, 74);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(114,1,3,'12:00','2021-12-09', 3, 95);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(102,1,4,'22:00','2021-12-07', 4, 66);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(104,1,4,'18:45','2021-12-08', 4, 95);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(105,1,4,'23:30','2021-12-09', 4, 0);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(105,1,4,'22:55','2021-12-10', 4, 18);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(113,1,4,'11:30','2021-12-10', 3, 70);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(111,1,5,'19:30','2021-12-07', 4, 20);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(112,1,5,'10:20','2021-12-08', 3, 66);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(113,1,5,'14:40','2021-12-08', 3, 55);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(114,1,6,'13:30','2021-12-07', 3, 76);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(107,1,6,'10:30','2021-12-08', 3, 44);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(107,1,6,'10:30','2021-12-09', 3, 39);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(112,1,8,'11:20','2021-12-07', 3, 70);

INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(103,2,1,'14:30','2021-12-07', 5, 95);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(103,2,1,'15:10','2021-12-08', 5, 34);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(105,2,1,'19:30','2021-12-07', 5, 75);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(109,2,1,'19:00','2021-12-08', 5, 31);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(109,2,1,'19:30','2021-12-09', 5, 11);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(108,2,1,'23:10','2021-12-10', 5, 86);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(110,2,2,'14:30','2021-12-07', 5, 44);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(101,2,2,'18:55','2021-12-07', 5, 75);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(102,2,2,'19:30','2021-12-08', 5, 10);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(106,2,2,'14:20','2021-12-09', 5, 54);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(109,2,2,'20:00','2021-12-09', 5, 13);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(111,2,3,'15:50','2021-12-07', 5, 53);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(110,2,3,'19:30','2021-12-07', 5, 86);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(102,2,3,'21:20','2021-12-08', 5, 25);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(102,2,3,'19:30','2021-12-09', 5, 74);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(102,2,4,'23:30','2021-12-10', 5, 2);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(104,2,5,'11:30','2021-12-07', 5, 54);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(105,2,5,'16:50','2021-12-07', 5, 44);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(106,2,5,'19:30','2021-12-08', 5, 84);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(107,2,5,'16:30','2021-12-09', 5, 34);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(108,2,5,'21:40','2021-12-09', 5, 63);

INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(103,3,1,'13:30','2021-12-07', 5, 82);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(105,3,1,'17:50','2021-12-09', 5, 33);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(106,3,1,'22:45','2021-12-08', 5, 55);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(103,3,2,'14:20','2021-12-07', 5, 35);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(104,3,2,'18:30','2021-12-07', 5, 51);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(105,3,2,'20:20','2021-12-08', 5, 25);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(105,3,2,'15:30','2021-12-09', 5, 35);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(105,3,2,'19:45','2021-12-09', 5, 75);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(107,3,2,'17:00','2021-12-10', 5, 99);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(108,3,3,'14:30','2021-12-07', 5, 45);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(110,3,3,'19:10','2021-12-07', 5, 72);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(111,3,3,'23:30','2021-12-07', 5, 51);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(104,3,3,'16:20','2021-12-08', 5, 42);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(103,3,3,'19:30','2021-12-07', 4, 95);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(105,3,4,'14:30','2021-12-07', 5, 45);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(106,3,4,'18:50','2021-12-07', 5, 58);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(107,3,4,'16:05','2021-12-08', 5, 25);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(106,3,4,'23:30','2021-12-08', 5, 49);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(113,3,4,'12:30','2021-12-09', 5, 36);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(104,3,4,'17:00','2021-12-09', 5, 73);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(102,3,4,'23:30','2021-12-09', 5, 63);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(102,3,5,'23:30','2021-12-09', 5, 35);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(109,3,5,'17:45','2021-12-10', 5, 25);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(110,3,5,'21:00','2021-12-10', 5, 14);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(102,3,5,'15:30','2021-12-11', 5, 34);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(104,3,5,'20:00','2021-12-11', 5, 99);

INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(109,4,1,'19:30','2021-12-07', 5, 20);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(103,4,1,'19:30','2021-12-08', 5, 25);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(102,4,1,'19:30','2021-12-09', 5, 18);

INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(111,5,1,'18:20','2021-12-07', 5, 15);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(105,5,1,'19:30','2021-12-08', 5, 25);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(107,5,1,'16:50','2021-12-09', 5, 17);
INSERT INTO Seansas(filmo_id,kino_teatras,sales_nr,seanso_pradzia,seanso_data,kaina,laisvos_vietos) VALUES(101,5,1,'21:50','2021-12-09', 5, 6);

INSERT INTO Darbuotojas VALUES(teatro_id, 'Akvile', 'Kazlauskiene', 'Vadovas', 2500);--1
INSERT INTO Darbuotojas VALUES(teatro_id, 'Petras', 'Jankauskas', 'Vadovas', 2500);--2
INSERT INTO Darbuotojas VALUES(teatro_id, 'Jonas', 'Jonaitis', 'Vadovas', 2500);--3
INSERT INTO Darbuotojas VALUES(teatro_id, 'Lukas', 'Petraitis', 'Vadovas', 2000);--4
INSERT INTO Darbuotojas VALUES(teatro_id, 'Karolina', 'Jankauskiene', 'Vadovas', 2000);--5

INSERT INTO Darbuotojas VALUES(teatro_id, 'Tomas', 'Petraitis', 'Kasininkas', 1000);
INSERT INTO Darbuotojas VALUES(teatro_id, 'Tomas', 'Jonaitis', 'Kasininkas', 1000);
INSERT INTO Darbuotojas VALUES(teatro_id, 'Vilius', 'Stankevicius', 'Valytojas', 800);
INSERT INTO Darbuotojas VALUES(teatro_id, 'Akvile', 'Kazlauskaite', 'Valytojas', 800);--1
INSERT INTO Darbuotojas VALUES(teatro_id, 'Jonas', 'Urbonas', 'Kasininkas', 1000);
INSERT INTO Darbuotojas VALUES(teatro_id, 'Rokas', 'Vasiliauskas', 'Valytojas', 800);
INSERT INTO Darbuotojas VALUES(teatro_id, 'Monika', 'Paulauskiene', 'Kasininkas', 100);
INSERT INTO Darbuotojas VALUES(teatro_id, 'Kristina', 'Zukausniene', 'Valytojas', 800);--2
INSERT INTO Darbuotojas VALUES(teatro_id, 'Lukas', 'Butkus', 'Kasininkas', 1000);
INSERT INTO Darbuotojas VALUES(teatro_id, 'Tomas', 'Stankevicius', 'Valytojas', 800);
INSERT INTO Darbuotojas VALUES(teatro_id, 'Jonas', 'Vasiliauskas', 'Kasininkas', 1000);
INSERT INTO Darbuotojas VALUES(teatro_id, 'Evelina', 'Butkute', 'Valytojas', 800);--3
INSERT INTO Darbuotojas VALUES(teatro_id, 'Migle', 'Pociute', 'Kasininkas', 800);
INSERT INTO Darbuotojas VALUES(teatro_id, 'Ieva', 'Kavaliauskiene', 'Valytojas', 800);--4
INSERT INTO Darbuotojas VALUES(teatro_id, 'Arnas', 'Jankauskas', 'Kasininkas', 800);
INSERT INTO Darbuotojas VALUES(teatro_id, 'Dovydas', 'Petrauskas', 'Valytojas', 800);--5


-- CREATE TABLE Bilietas
-- (
-- 	vieta		   SERIAL PRIMARY KEY,
--     seanso_id      SERIAL PRIMARY KEY + FK??
--     pirkimo_data   DATETIME NOT NULL,
-- );



