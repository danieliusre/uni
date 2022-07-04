
DROP TRIGGER IF EXISTS movieOverlap ON Seansas;
DROP FUNCTION movieOverlap();

DROP TRIGGER IF EXISTS SoldOut ON Bilietas;
DROP FUNCTION SoldOut();

DROP VIEW IF EXISTS Filmai_suaugusiems;
DROP VIEW IF EXISTS Multikino_vaikams;
DROP VIEW IF EXISTS vienodu_laiku;
DROP MATERIALIZED VIEW IF EXISTS Populiariausi_seansai;

DROP INDEX Filmo_index;
DROP INDEX Seanso_pradzia_index;

DROP TABLE Bilietas CASCADE;
DROP TABLE Seansas CASCADE;
DROP TABLE Darbuotojas CASCADE;
DROP TABLE Filmas CASCADE;
DROP TABLE Kino_teatras CASCADE;
