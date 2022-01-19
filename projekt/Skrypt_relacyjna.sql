---- Projekt SQL --- BAZA danych policji ---

--- DROP TABLES --- 
DROP TABLE DOWOD_SPRAWA;
DROP TABLE DOWOD_ZDJECIE;
DROP TABLE ODZNAKA_POLICJANT;
DROP TABLE OSOBA_ZDJECIE;
DROP TABLE OSPRZET;
DROP TABLE POLISA;
DROP TABLE SAMOCHOD;
DROP TABLE SPRZET;
DROP TABLE ODZNAKI;
DROP TABLE POLICJANT;
DROP TABLE ODCISKI;
DROP TABLE SPRAWA;
DROP TABLE KOMISARIAT;
DROP TABLE OSOBA;
DROP TABLE ZDJECIE;
DROP TABLE DOWOD;


--- CREATE TABLES ----
CREATE TABLE dowod (
	id number(5) NOT NULL PRIMARY KEY,
	opis varchar(30),
	data_zebrania date
);

CREATE TABLE zdjecie (
	id number(5) NOT NULL PRIMARY KEY,
	opis varchar(30),
	data_zebrania date,
	obrazek blob
);

CREATE TABLE osoba (
	id number(5) NOT NULL PRIMARY KEY,
	imie varchar(30),
	nazwisko varchar(30),
	pesel varchar(11),
	data_urodzenia date,
	ulica VARCHAR2(10),
	nr_domu VARCHAR2(4),
	nr_mieszkania VARCHAR2(4),
	miasto VARCHAR2(10),
	kod VARCHAR2(6),
	numer_telefonu varchar(30),
	email varchar(30)
);



CREATE TABLE dowod_zdjecie(
	id number(5) NOT NULL PRIMARY KEY,
	dowod_id number(5),
	zdjecie_id number(5),
	CONSTRAINT fk_dowod FOREIGN KEY (dowod_id) REFERENCES dowod(id),
	CONSTRAINT fk_zdjecie FOREIGN KEY (zdjecie_id) REFERENCES zdjecie(id)
);

CREATE TABLE osoba_zdjecie(
	id number(5) NOT NULL PRIMARY KEY,
	osoba_id number(5),
	zdjecie_id number(5),
	CONSTRAINT fk_osoba_zdjecie FOREIGN KEY (osoba_id) REFERENCES osoba(id),
	CONSTRAINT fk_zdjecie_osoba FOREIGN KEY (zdjecie_id) REFERENCES zdjecie(id)
);





CREATE TABLE komisariat (
	id number(5) NOT NULL PRIMARY KEY,
	opis varchar(30),
	ulica varchar(30),
	numer_domu varchar(10),
	kod_pocztowy varchar(6),
	miejscowosc varchar(30),
	numer_telefonu varchar(30),
	email varchar(30),
	powiat varchar(30),
	wojewodztwo varchar(30)
);

CREATE TABLE sprawa (
	id number(5) NOT NULL PRIMARY KEY,
	opis varchar(30),
	typ varchar(30),
	komisariat_id number(5),
	CONSTRAINT fk_komisariat_spr FOREIGN KEY (komisariat_id) REFERENCES komisariat(id)
);

CREATE TABLE dowod_sprawa(
	id number(5) NOT NULL PRIMARY KEY,
	dowod_id number(5),
	sprawa_id number(5),
	CONSTRAINT fk_dowod_s FOREIGN KEY (dowod_id) REFERENCES dowod(id),
	CONSTRAINT fk_sprawa_d FOREIGN KEY (sprawa_id) REFERENCES sprawa(id)
);


CREATE TABLE odciski (
	id number(5) NOT NULL PRIMARY KEY,
	opis varchar(30),
	data_zebrania date,
	osoba_id number(5),
	CONSTRAINT fk_osoba_o FOREIGN KEY (osoba_id) REFERENCES osoba(id),
	grafika blob
);



CREATE TABLE policjant (
	id number(5) NOT NULL PRIMARY KEY,
	osoba_id number(5),
	komisariat_id number(5),
	CONSTRAINT fk_osoba_p FOREIGN KEY (osoba_id) REFERENCES osoba(id),
	CONSTRAINT fk_komisariat_p FOREIGN KEY (komisariat_id) REFERENCES komisariat(id),
	stopien varchar(30)
);

CREATE TABLE odznaki(
	id number(5) NOT NULL PRIMARY KEY,
	nazwa_odznaki varchar(30),
	cel varchar(30)
);

CREATE TABLE odznaka_policjant(
	id number(5) NOT NULL PRIMARY KEY,
	odznaka_id number(5),
	policjant_id number(5),
	CONSTRAINT fk_odznaka_p FOREIGN KEY (odznaka_id) REFERENCES odznaki(id),
	CONSTRAINT fk_policjant_o FOREIGN KEY (policjant_id) REFERENCES policjant(id),
	data_uzyskania date
);

CREATE TABLE sprzet(
	id number(5) NOT NULL PRIMARY KEY,
	nazwa varchar(30),
	data_zakupu date,
	gwarancja NUMBER(1),
	komisariat_id number(5),
	CONSTRAINT fk_komiariat_s FOREIGN KEY (komisariat_id) REFERENCES komisariat(id)
);

CREATE TABLE samochod(
	id number(5) NOT NULL PRIMARY KEY,
	marka varchar(30),
	model varchar(30),
	silnik varchar(30),
	spalanie varchar(30),
	kolor varchar(30),
	nr_rejestracyjny varchar(30),
	komisariat_id number(5),
	CONSTRAINT fk_komiariat_sa FOREIGN KEY (komisariat_id) REFERENCES komisariat(id)
);

CREATE TABLE polisa(
	id number(5) NOT NULL PRIMARY KEY,
	typ_polisy varchar(30),
	data_waznosci date,
	samochod_id number(5),
	CONSTRAINT fk_samochod_po FOREIGN KEY (samochod_id) REFERENCES samochod(id)
);

CREATE TABLE osprzet(
	id number(5) NOT NULL PRIMARY KEY,
	nazwa varchar(30),
	wymagany_przeglad date,
	policjant_id number(5),
	CONSTRAINT fk_policjant_os FOREIGN KEY (policjant_id) REFERENCES policjant(id)
);


-------- INSERTS -------------------
INSERT INTO dowod VALUES(1,'Luski po pocisakch', TO_DATE('24-03-2021','DD-MM-YYYY'));
INSERT INTO dowod VALUES(2,'Chusta', TO_DATE('14-08-2021','DD-MM-YYYY'));
INSERT INTO dowod VALUES(3,'Wykalaczki', TO_DATE('13-02-2021','DD-MM-YYYY'));
INSERT INTO dowod VALUES(4,'Probka krwi', TO_DATE('11-09-2021','DD-MM-YYYY'));
INSERT INTO dowod VALUES(5,'Sztuczna szczeka', TO_DATE('11-11-2021','DD-MM-YYYY'));

INSERT INTO zdjecie VALUES(1,'Zdjęcie psa', TO_DATE('11-11-2021','DD-MM-YYYY'), '2211174522912251234');
INSERT INTO zdjecie VALUES(2,'Zdjęcie kota', TO_DATE('12-11-2021','DD-MM-YYYY'), '231241253532532543525432432432');
INSERT INTO zdjecie VALUES(3,'Zdjęcie lyzeczki', TO_DATE('31-10-2021','DD-MM-YYYY'), '543543543264576456456436456456345645643');
INSERT INTO zdjecie VALUES(4,'Zdjęcie ugryzienia', TO_DATE('12-12-2021','DD-MM-YYYY'), '654653645645645645733465765387653765367456');
INSERT INTO zdjecie VALUES(5,'Zdjęcie telefonu', TO_DATE('03-01-2021','DD-MM-YYYY'), '35753753654643645');

INSERT INTO osoba VALUES(1,'Jan','Kowalski', '99120312345', TO_DATE('03-12-1999','DD-MM-YYYY'), 'Lewa', '1a','1','Notki', '12342',  '123421312', 'asdas@dsa.pl');
INSERT INTO osoba VALUES(2,'Jan','Nowak', '92120312345', TO_DATE('03-12-1992','DD-MM-YYYY'), 'Biala', '31','1','Pionki', '12342',  '123123123123421312', 'dasddas@dsas@dsdasa.pl');
INSERT INTO osoba VALUES(3,'Tomasz','Wolski', '54110512345', TO_DATE('05-11-1954','DD-MM-YYYY'), 'Mewa', '62','1', 'Nysa','12342',  '321312', 'dasdasdas@dsadas.pl');
INSERT INTO osoba VALUES(4,'Andrzej','Polski', '33120512345', TO_DATE('05-12-1933','DD-MM-YYYY'), 'Rakiet', '11','1','Wurek', '12342',  '3213123321', 'fasd@dsdsaa.pl');
INSERT INTO osoba VALUES(5,'Hanna','Miara', '67090312345', TO_DATE('03-09-1967','DD-MM-YYYY'), 'Pomostowa', '34','1','Mopsik', '12342',  '312312312', 'sds@dsdasa.com');


INSERT INTO komisariat VALUES(1,'Komisariat Powiatowy','Pomostowa', '22', '12342', 'Mopsik', '3213123123', 'dasdsada@dasdas.com', 'Hubski', 'Lubuskie');
INSERT INTO komisariat VALUES(2,'Komisariat miejski','Miastowa', '13', '32133', 'Klawiur', '2312312312', 'dadsaada@dasdas.com', 'Klawiurski', 'Lubuskie');
INSERT INTO komisariat VALUES(3,'Komisariat wiejski','Wiejska', '232', '12342', 'Masun', '312321312', 'ddasdasdsada@dasdas.com', 'Masunski', 'Lubuskie');
INSERT INTO komisariat VALUES(4,'Komisariat Wojewodzki','Grudziadzka', '21', '12313', 'Szczecin', '6546445324', 'dasdddsada@dasdas.com', 'Szczecinski', 'Zachodniopomorskie');
INSERT INTO komisariat VALUES(5,'Komisariat pomocniczy','Gdanska', '1', '12342', 'Torun', '7657656756', 'dasdsddada@dasdas.com', 'Torunski', 'Lubuskie');


INSERT INTO sprawa VALUES(1,'Porwanie Jana K','Cywilna',1);
INSERT INTO sprawa VALUES(2,'Kradziez zegarka','Cywilna',2);
INSERT INTO sprawa VALUES(3,'Kradziez roweru','Cywilna',3);
INSERT INTO sprawa VALUES(4,'Grozby karalne','Cywilna',4);
INSERT INTO sprawa VALUES(5,'Oszustwa podatkowe','Cywilna',5);

INSERT INTO dowod_zdjecie VALUES(1,1,1);
INSERT INTO dowod_zdjecie VALUES(2,1,2);
INSERT INTO dowod_zdjecie VALUES(3,1,5);
INSERT INTO dowod_zdjecie VALUES(4,3,2);
INSERT INTO dowod_zdjecie VALUES(5,3,3);

INSERT INTO osoba_zdjecie VALUES(1,1,1);
INSERT INTO osoba_zdjecie VALUES(2,2,2);
INSERT INTO osoba_zdjecie VALUES(3,3,3);
INSERT INTO osoba_zdjecie VALUES(4,4,4);
INSERT INTO osoba_zdjecie VALUES(5,5,5);

INSERT INTO dowod_sprawa VALUES(1,1,1);
INSERT INTO dowod_sprawa VALUES(2,2,2);
INSERT INTO dowod_sprawa VALUES(3,3,3);
INSERT INTO dowod_sprawa VALUES(4,4,4);
INSERT INTO dowod_sprawa VALUES(5,5,5);

INSERT INTO odciski VALUES(1,'Kciuk', TO_DATE('11-12-2021','DD-MM-YYYY'),1, '2211174522912251234');
INSERT INTO odciski VALUES(2,'Wskazujacy lewy', TO_DATE('11-12-2021','DD-MM-YYYY'),2, '2211172224522912251234');
INSERT INTO odciski VALUES(3,'Kciuk', TO_DATE('12-03-2021','DD-MM-YYYY'),3, '22111745224213123912251234');
INSERT INTO odciski VALUES(4,'Kciuk', TO_DATE('22-02-2021','DD-MM-YYYY'),5, '2211122227452222912251234');
INSERT INTO odciski VALUES(5,'Kciuk', TO_DATE('31-08-2021','DD-MM-YYYY'),5, '22221312412412412');


INSERT INTO policjant VALUES(1,1,1,'NADINSPEKTOR');
INSERT INTO policjant VALUES(2,2,2,'POSTERUNKOWY');
INSERT INTO policjant VALUES(3,3,2,'STARSZY POSTERUNKOWY');
INSERT INTO policjant VALUES(4,4,2,'SIERŻANT');
INSERT INTO policjant VALUES(5,5,5,'SIERŻANT');

INSERT INTO odznaki VALUES(1,'Policyjna','Potwierdzenie uprawnien');
INSERT INTO odznaki VALUES(2,'Dzielny policjant','Nagroda');
INSERT INTO odznaki VALUES(3,'Piatki policyjne','Specjalna');
INSERT INTO odznaki VALUES(4,'Operacja znicz','Specjalna');
INSERT INTO odznaki VALUES(5,'Swiateczny Policjant','Specjalna');

INSERT INTO odznaka_policjant VALUES(1,1,1,TO_DATE('12-03-2021','DD-MM-YYYY'));
INSERT INTO odznaka_policjant VALUES(2,2,2,TO_DATE('12-03-2021','DD-MM-YYYY'));
INSERT INTO odznaka_policjant VALUES(3,3,3,TO_DATE('12-03-2021','DD-MM-YYYY'));
INSERT INTO odznaka_policjant VALUES(4,4,4,TO_DATE('12-03-2021','DD-MM-YYYY'));
INSERT INTO odznaka_policjant VALUES(5,5,5,TO_DATE('12-03-2021','DD-MM-YYYY'));

INSERT INTO sprzet VALUES(1,'Karabin maszynowy AF-123',TO_DATE('05-05-2021','DD-MM-YYYY'),1,1);
INSERT INTO sprzet VALUES(2,'Karabin maszynowy AF-125',TO_DATE('22-05-2021','DD-MM-YYYY'),1,1);
INSERT INTO sprzet VALUES(3,'Gasnica specjalna',TO_DATE('05-05-2021','DD-MM-YYYY'),1,2);
INSERT INTO sprzet VALUES(4,'Granat błyskowy',TO_DATE('13-05-2021','DD-MM-YYYY'),0,3);
INSERT INTO sprzet VALUES(5,'Armatka wodna',TO_DATE('11-05-2021','DD-MM-YYYY'),1,3);


INSERT INTO samochod VALUES(1,'Dacia', 'Duster', '2.4 JTD', '11.2', 'Morelowy', 'CTF1233', 1);
INSERT INTO samochod VALUES(2,'Skoda', 'Fabia', '2.4 TDI', '5.5', 'Biały', 'CTF1321', 1);
INSERT INTO samochod VALUES(3,'Peugeot', '508', '5.4 HDI', '8.8', 'Szary', 'CDG1233', 2);
INSERT INTO samochod VALUES(4,'Mercedes', 'A320', '1.9 benzyna', '13.2', 'Czarny', 'DWR1233', 3);
INSERT INTO samochod VALUES(5,'Bmw', 'i320', '3.2', '11.2', 'Zielony', 'BRO1233', 4);


INSERT INTO polisa VALUES(1,'OC', TO_DATE('12-03-2022','DD-MM-YYYY'),1);
INSERT INTO polisa VALUES(2,'OC', TO_DATE('12-03-2022','DD-MM-YYYY'),2);
INSERT INTO polisa VALUES(3,'OC', TO_DATE('12-03-2022','DD-MM-YYYY'),3);
INSERT INTO polisa VALUES(4,'OC', TO_DATE('12-03-2022','DD-MM-YYYY'),4);
INSERT INTO polisa VALUES(5,'OC', TO_DATE('12-03-2022','DD-MM-YYYY'),5);

INSERT INTO osprzet VALUES(1,'Gaz łzawiacy', TO_DATE('03-01-2022','DD-MM-YYYY'),1);
INSERT INTO osprzet VALUES(2,'Pałka teleskopowa', TO_DATE('03-01-2022','DD-MM-YYYY'),2);
INSERT INTO osprzet VALUES(3,'Pistolet hukowy', TO_DATE('03-01-2022','DD-MM-YYYY'),3);
INSERT INTO osprzet VALUES(4,'Kajdanki', TO_DATE('03-01-2022','DD-MM-YYYY'),4);
INSERT INTO osprzet VALUES(5,'Magazynek', TO_DATE('03-01-2022','DD-MM-YYYY'),5);

UPDATE  SAMOCHOD SET MODEL = '805' WHERE MODEL ='508';
UPDATE  osprzet SET WYMAGANY_PRZEGLAD =  TO_DATE('22-01-2022','DD-MM-YYYY') WHERE ID = 1;
UPDATE  dowod_sprawa SET DOWOD_ID =  2 WHERE ID = 1;
UPDATE  POLISA SET DATA_WAZNOSCI =  TO_DATE('22-11-2022','DD-MM-YYYY');
UPDATE  ZDJECIE SET OBRAZEK = '312312312312312312312312' WHERE ID = 1;

DELETE FROM dowod_sprawa WHERE ID = 1;
DELETE FROM dowod_zdjecie WHERE ID = 1;
DELETE FROM osoba_zdjecie WHERE ID = 1;
DELETE FROM polisa WHERE ID = 1;
DELETE FROM osprzet WHERE ID = 1;
commit;
