CREATE TABLE Korisnik(
  k_ime VARCHAR(20) PRIMARY KEY, 
  ime VARCHAR(20), 
  prezime VARCHAR(20), 
  tip VARCHAR(20), ---?
  pretplata INT,
  datum_reg DATE, 
  tel_broj VARCHAR(12), 
  email VARCHAR(30),
  CONSTRAINT CH_datum_reg CHECK ( datum_reg BETWEEN '2023-01-01' AND '2024-12-31')
);

CREATE TABLE Premium_korisnik(
  k_ime VARCHAR(20) PRIMARY KEY REFERENCES Korisnik(k_ime) ON DELETE CASCADE ON UPDATE CASCADE, 
  datum DATE, 
  procent_popust FLOAT DEFAULT 20.0
);

CREATE TABLE Profil(
  k_ime VARCHAR(20) REFERENCES Korisnik(k_ime) ON DELETE CASCADE ON UPDATE CASCADE, 
  ime VARCHAR(20), 
  datum DATE,
  CONSTRAINT PK PRIMARY KEY (k_ime,ime)
);

CREATE TABLE Video_zapis(
  naslov VARCHAR(50) PRIMARY KEY, 
  jazik VARCHAR(20) DEFAULT 'English', 
  vremetraenje INT, 
  datum_d DATE, 
  datum_p DATE,
  CONSTRAINT CH_datum CHECK (datum_d > datum_p)
);

CREATE TABLE Video_zapis_zanr(
  naslov VARCHAR(50) REFERENCES Video_zapis(naslov) ON DELETE CASCADE ON UPDATE CASCADE, 
  zanr VARCHAR(20),
  CONSTRAINT PK PRIMARY KEY (naslov, zanr)
);

CREATE TABLE Lista_zelbi(
  naslov VARCHAR(50) REFERENCES Video_zapis_zanr(naslov) ON DELETE CASCADE ON UPDATE CASCADE, 
  k_ime VARCHAR(20),
  ime VARCHAR(20),
  CONSTRAINT PK PRIMARY KEY (naslov, k_ime, ime),
  CONSTRAINT FK_lz_k FOREIGN KEY (k_ime,ime) REFERENCES Profil(k_ime,ime) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE Preporaka(
  ID INT PRIMARY KEY, 
  k_ime_od VARCHAR(20) REFERENCES Korisnik(k_ime) ON DELETE CASCADE ON UPDATE CASCADE, 
  k_ime_na VARCHAR(20) REFERENCES Korisnik(k_ime) ON DELETE CASCADE ON UPDATE CASCADE, 
  naslov VARCHAR(50) DEFAULT 'Deleted' REFERENCES Video_zapis(naslov) ON DELETE SET DEFAULT ON UPDATE CASCADE, 
  datum DATE, 
  komentar VARCHAR(250) NOT NULL, 
  ocena INT,
  CONSTRAINT CH_ocena CHECK (ocena BETWEEN 1 AND 5),
  CONSTRAINT CH_datum CHECK (datum > '2022-12-7')
);