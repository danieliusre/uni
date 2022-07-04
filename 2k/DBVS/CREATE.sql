CREATE TABLE Kino_teatras
( 
    teatro_id    INT PRIMARY KEY,
    pavadinimas  VARCHAR(30)   NOT NULL,
    adresas      VARCHAR(40)   UNIQUE NOT NULL
	
);

CREATE TABLE Filmas
(
    filmo_id       		INT   PRIMARY KEY,
    pavadinimas    		VARCHAR(40)   NOT NULL, 
	metai		   		INT NOT NULL,
	zanras		   		VARCHAR(30)	 NOT NULL DEFAULT 'Zanras nezinomas',
    trukme 	  	   		TIME   NOT NULL,
	biudzetas   	INT NOT NULL,
	ivertinimas    		VARCHAR(12) DEFAULT 'Neivertintas',
	salis		   		VARCHAR(15) DEFAULT 'Salis nezinoma'
  
);



CREATE TABLE Darbuotojas
( 
	darbuotojo_id 	SERIAL PRIMARY KEY,
    teatro_id    	INT NOT NULL,
    vardas  		VARCHAR(20)   NOT NULL,
    pavarde      	VARCHAR(20)   NOT NULL,   
    pareigos     	VARCHAR(30)	  NOT NULL,
	atlyginimas		INT  NOT NULL CONSTRAINT Atlyginimas_negali_buti_zemiau_minimumo CHECK (atlyginimas > 730),
	CONSTRAINT teatro_id FOREIGN KEY (teatro_id) REFERENCES Kino_teatras(teatro_id)
	
); 



CREATE TABLE Seansas
(
    seanso_id    	SERIAL   PRIMARY KEY, 
    kino_teatras  	INT   	 NOT NULL,
    filmo_id       	INT   	 NOT NULL,
    sales_nr     	VARCHAR(30)  NOT NULL DEFAULT 'Sale dar nepaskelbta',
    seanso_pradzia  TIME     NOT NULL CONSTRAINT Seansas_negali_prasideti_po_vidurnakcio CHECK (seanso_pradzia > '04:00'),  
	seanso_pabaiga	TIME 	 NOT NULL,
	seanso_data		DATE NOT NULL,
	kaina			INT		 NOT NULL CONSTRAINT Kaina_negali_buti_0 CHECK (kaina > 0),
	laisvos_vietos  INT 	 NOT NULL CONSTRAINT Sale_negali_buti_perpildyta CHECK (laisvos_vietos >= 0),
    CONSTRAINT kino_teatras	 FOREIGN KEY  (kino_teatras) REFERENCES Kino_teatras(teatro_id) ON DELETE CASCADE,
    CONSTRAINT filmo_id		 FOREIGN KEY  (filmo_id) REFERENCES Filmas(filmo_id) ON DELETE CASCADE
);
   rs = stmt.executeQuery("INSERT INTO " + _tableName + " VALUES(" + Integer.parseInt(values[0]) +","+ Integer.parseInt(values[1])+","+ Integer.parseInt(values[2]) +",'"+ values[3] +"','"+ startTime +"','"+ endTime +"','"+ movieDate +"',"+ Integer.parseInt(values[7]) +"',"+ Integer.parseInt(values[8]) +"');");


CREATE TABLE Bilietas
(
	vieta		   VARCHAR(4) NOT NULL,
	seanso_id		INT NOT NULL,
	PRIMARY KEY(seanso_id, vieta),
    pirkimo_data   DATE NOT NULL,
    CONSTRAINT FK_seanso_id FOREIGN KEY (seanso_id) REFERENCES Seansas(seanso_id)
);


--VIEW
--Seansai suaugusiems t.y. seansai, kurie baigiasi po 00:00
CREATE VIEW Filmai_suaugusiems (kino_teatras, adresas, filmas, sales_nr, seanso_pradzia, data)
AS SELECT K.pavadinimas, K.adresas, F.pavadinimas, S.sales_nr, S.seanso_pradzia, S.seanso_data
FROM Kino_teatras AS K, Filmas AS F, Seansas AS S
WHERE S.seanso_pradzia > '21:00'
AND K.teatro_id = S.kino_teatras
AND S.filmo_id = F.filmo_id;

--Seansai vaikams: seansai, vykstantys tik MULTIKINO kino teatre, nuo 10:00 iki 16:00 (turi pasibaigti iki 16:00)
CREATE VIEW Multikino_vaikams (filmas, seanso_pradzia, adresas, kaina)
AS SELECT F.pavadinimas, S.seanso_pradzia, K.adresas, S.kaina
FROM filmas AS F, kino_teatras AS K, seansas AS S
WHERE K.pavadinimas = 'Multikino'
AND K.teatro_id = S.kino_teatras
AND S.filmo_id = F.filmo_id
AND S.seanso_pradzia BETWEEN '10:00' AND '16:00'-F.trukme;

--Tikrina ar nesikerta filmu laikai
CREATE VIEW vienodu_laiku AS 
WITH timechange (seanso_id, kino_teatras, sales_nr, seanso_data, seanso_pradzia, seanso_pabaiga) AS 
(SELECT seanso_id, kino_teatras, sales_nr, seanso_data, seanso_pradzia, CASE 
	WHEN seanso_pabaiga > '00:01' AND seanso_pabaiga < '04:00' THEN '23:59' 
	WHEN seanso_pabaiga > '04:00' THEN seanso_pabaiga END seanso_pabaiga
FROM Seansas)
SELECT COUNT(*)
FROM timechange AS S, timechange AS S1
WHERE S.seanso_id <> S1.seanso_id 
AND S.kino_teatras = S1.kino_teatras
AND S.sales_nr = S1.sales_nr
AND S.seanso_data = S1.seanso_data
AND S.seanso_pradzia BETWEEN S1.seanso_pradzia AND S1.seanso_pabaiga;

--METERIALIZUOTA
--Populiariausi seansai: seansai, kuriuose ispirkta daug vietu(like maziau nei 40), bei ivertinti >7.5 (tikslas: kartoti seansus)
CREATE MATERIALIZED VIEW Populiariausi_seansai (kino_teatras, adresas, filmas, seanso_pradzia, ivertinimas, likusios_laisvos_vietos)
AS SELECT K.pavadinimas, K.adresas, F.pavadinimas, S.seanso_pradzia, F.Ivertinimas, S.laisvos_vietos
FROM Kino_teatras AS K, Filmas AS F, Seansas AS S
WHERE CAST(F.ivertinimas AS FLOAT) > 7.5
AND K.teatro_id IN (1,2,3)
AND K.teatro_id = S.kino_teatras
AND S.filmo_id = F.filmo_id
AND S.laisvos_vietos < 40;


--INDEXAI
CREATE UNIQUE INDEX Filmo_index
ON Filmas(pavadinimas, metai);

CREATE INDEX Seanso_pradzia_index
ON Seansas(seanso_pradzia);


--TRIGGER
--Tikrina ar naujas filmas neprasideda anksciau, nei baigesi praeitas
CREATE FUNCTION MovieOverlap()
RETURNS TRIGGER AS
$$BEGIN
	IF (SELECT * FROM vienodu_laiku) > 0
	THEN
		RAISE EXCEPTION 'Sale dar neisvalyta arba joje vyksta kitas filmas';
	END IF;
	RETURN NEW;
	END;$$
	LANGUAGE plpgsql;
	
CREATE  TRIGGER MovieOverlap 
AFTER INSERT OR UPDATE
ON Seansas
FOR EACH ROW
EXECUTE PROCEDURE MovieOverlap();

--Tikrina, ar perkant bilieta, yra like laisvu vietu, o nusipirkus jas sumazina.
CREATE FUNCTION SoldOut()
RETURNS TRIGGER AS
$$BEGIN
	IF (SELECT Seansas.laisvos_vietos FROM Bilietas JOIN Seansas ON Seansas.seanso_id = new.seanso_id GROUP BY new.seanso_id, 1) = 0
	THEN
		RAISE EXCEPTION 'Bilietu i si filma nebera';
	ELSE
		UPDATE Seansas
		SET laisvos_vietos = laisvos_vietos - 1
		WHERE Seansas.seanso_id = new.seanso_id;
	END IF;
	RETURN NEW;
	END;$$
	LANGUAGE plpgsql;
	
CREATE  TRIGGER SoldOut 
BEFORE INSERT OR UPDATE
ON Bilietas
FOR EACH ROW
EXECUTE PROCEDURE SoldOut();

