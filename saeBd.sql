------------------------------------------------------------
--        Script Postgre 
------------------------------------------------------------

DROP SCHEMA IF EXISTS gaumont cascade;
CREATE SCHEMA gaumont

------------------------------------------------------------
-- Table: ville
------------------------------------------------------------
CREATE TABLE gaumont.ville(
	codepostal   INT  NOT NULL ,
	nom          VARCHAR  NOT NULL ,
	region       VARCHAR  NOT NULL  ,
	CONSTRAINT ville_PK PRIMARY KEY (codepostal)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: CINEMAS
------------------------------------------------------------
CREATE TABLE gaumont.CINEMAS(
	idCinemas    INT  NOT NULL ,
	nom          VARCHAR  NOT NULL ,
	codepostal   INT  NOT NULL  ,
	CONSTRAINT CINEMAS_PK PRIMARY KEY (idCinemas)

	,CONSTRAINT CINEMAS_ville_FK FOREIGN KEY (codepostal) REFERENCES gaumont.ville(codepostal)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: salles
------------------------------------------------------------
CREATE TABLE gaumont.salles(
	idSalles    INT  NOT NULL ,
	capacite    INT  NOT NULL ,
	idCinemas   INT  NOT NULL  ,
	CONSTRAINT salles_PK PRIMARY KEY (idSalles)

	,CONSTRAINT salles_CINEMAS_FK FOREIGN KEY (idCinemas) REFERENCES gaumont.CINEMAS(idCinemas)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: personne
------------------------------------------------------------
CREATE TABLE gaumont.personne(
	idPersonne      INT  NOT NULL ,
	nom             VARCHAR  NOT NULL ,
	prenom          VARCHAR  NOT NULL ,
	datenaissance   DATE  NOT NULL  ,
	CONSTRAINT personne_PK PRIMARY KEY (idPersonne)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: employe
------------------------------------------------------------
CREATE TABLE gaumont.employe(
	idPersonne      INT  NOT NULL ,
	numerotel       INT  NOT NULL ,
	nom             VARCHAR  NOT NULL ,
	prenom          VARCHAR  NOT NULL ,
	datenaissance   DATE  NOT NULL ,
	idCinemas       INT  NOT NULL  ,
	CONSTRAINT employe_PK PRIMARY KEY (idPersonne)

	,CONSTRAINT employe_personne_FK FOREIGN KEY (idPersonne) REFERENCES gaumont.personne(idPersonne)
	,CONSTRAINT employe_CINEMAS0_FK FOREIGN KEY (idCinemas) REFERENCES gaumont.CINEMAS(idCinemas)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: client
------------------------------------------------------------
CREATE TABLE gaumont.client(
	idPersonne      INT  NOT NULL ,
	nom             VARCHAR  NOT NULL ,
	prenom          VARCHAR  NOT NULL ,
	datenaissance   DATE  NOT NULL  ,
	CONSTRAINT client_PK PRIMARY KEY (idPersonne)

	,CONSTRAINT client_personne_FK FOREIGN KEY (idPersonne) REFERENCES gaumont.personne(idPersonne)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: societeProduction
------------------------------------------------------------
CREATE TABLE gaumont.societeProduction(
	societeProductionid   INT  NOT NULL ,
	nom                   VARCHAR  NOT NULL  ,
	CONSTRAINT societeProduction_PK PRIMARY KEY (societeProductionid)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: films
------------------------------------------------------------
CREATE TABLE gaumont.films(
	idfilm                SERIAL NOT NULL ,
	nom                   VARCHAR  NOT NULL ,
	dateDebutDiff         DATE NOT NULL  ,
	dateFinDiff           DATE NOT NULL  ,
	societeProductionid   INT  NOT NULL  ,
	CONSTRAINT films_PK PRIMARY KEY (idfilm)

	,CONSTRAINT films_societeProduction_FK FOREIGN KEY (societeProductionid) REFERENCES gaumont.societeProduction(societeProductionid)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: seance
------------------------------------------------------------
CREATE TABLE gaumont.seance(
	idfilm       INT  NOT NULL ,
	idSalles     INT  NOT NULL ,
	idPersonne   INT  NOT NULL  ,
	dateSeance 	 DATE NOT NULL	,
	CONSTRAINT seance_PK PRIMARY KEY (idSalles,dateSeance)

	,CONSTRAINT seance_films_FK FOREIGN KEY (idfilm) REFERENCES gaumont.films(idfilm)
	,CONSTRAINT seance_salles0_FK FOREIGN KEY (idSalles) REFERENCES gaumont.salles(idSalles)
	,CONSTRAINT seance_client1_FK FOREIGN KEY (idPersonne) REFERENCES gaumont.client(idPersonne)
)WITHOUT OIDS;


INSERT INTO gaumont.ville (codepostal, nom, region) VALUES
(75001, 'Paris', 'Île-de-France'),
(13001, 'Marseille', 'Provence-Alpes-Côte d''Azur'),
(69001, 'Lyon', 'Auvergne-Rhône-Alpes'),
(31000, 'Toulouse', 'Occitanie'),
(33000, 'Bordeaux', 'Nouvelle-Aquitaine'),
(54000, 'Nancy', 'Grand Est'),
(35000, 'Rennes', 'Bretagne'),
(59000, 'Lille', 'Hauts-de-France'),
(67000, 'Strasbourg', 'Grand Est'),
(44000, 'Nantes', 'Pays de la Loire'),
(69002, 'Villeurbanne', 'Auvergne-Rhône-Alpes'),
(13008, 'Nice', 'Provence-Alpes-Côte d''Azur'),
(21000, 'Dijon', 'Bourgogne-Franche-Comté'),
(37000, 'Tours', 'Centre-Val de Loire'),
(80000, 'Amiens', 'Hauts-de-France');


INSERT INTO gaumont.CINEMAS (idCinemas, nom, codepostal) VALUES
(1, 'Cinema Paris 1', 75001),
(2, 'Cinema Marseille 1', 13001),
(3, 'Cinema Lyon 1', 69001),
(4, 'Cinema Toulouse 1', 31000),
(5, 'Cinema Bordeaux 1', 33000),
(6, 'Cinema Nancy 1', 54000),
(7, 'Cinema Rennes 1', 35000),
(8, 'Cinema Lille 1', 59000),
(9, 'Cinema Strasbourg 1', 67000),
(10, 'Cinema Nantes 1', 44000),
(11, 'Cinema Villeurbanne 1', 69002),
(12, 'Cinema Nice 1', 13008),
(13, 'Cinema Dijon 1', 21000),
(14, 'Cinema Tours 1', 37000),
(15, 'Cinema Amiens 1', 80000);


INSERT INTO gaumont.salles (idSalles, capacite, idCinemas) VALUES
(101, 150, 1),
(102, 120, 1),
(103, 110, 1),
(201, 100, 2),
(202, 80, 2),
(203, 120, 2),
(301, 120, 3),
(302, 90, 3),
(303, 110, 3),
(401, 80, 4),
(402, 100, 4),
(501, 110, 5),
(502, 90, 5),
(601, 100, 6),
(602, 120, 6);



INSERT INTO gaumont.personne (idPersonne, nom, prenom, datenaissance) VALUES
(1, 'Dupont', 'Jean', '1990-05-15'),
(2, 'Martin', 'Marie', '1985-08-22'),
(3, 'Dubois', 'Pierre', '1995-02-10'),
(4, 'Lefevre', 'Sophie', '1992-11-30'),
(5, 'Leroy', 'Thomas', '1988-04-18'),
(6, 'Girard', 'Emilie', '1998-07-25'),
(7, 'Moreau', 'Lucie', '1993-03-05'),
(8, 'Roux', 'Antoine', '1987-09-12'),
(9, 'Leclerc', 'Camille', '1996-06-20'),
(10, 'Fournier', 'Nicolas', '1991-12-25'),
(11, 'Bertrand', 'Isabelle', '1986-10-15'),
(12, 'Lemoine', 'Martin', '1994-08-08'),
(13, 'Garnier', 'Julie', '1989-04-01'),
(14, 'Dufour', 'Alexandre', '1997-02-28'),
(15, 'Caron', 'Charlotte', '1990-06-10'),
(16, 'Dupuis', 'Alice', '1993-09-18');


INSERT INTO gaumont.employe (idPersonne, numerotel, nom, prenom, datenaissance, idCinemas) VALUES
(1, 123456789, 'Dupont', 'Jean', '1990-05-15', 1),
(2, 987654321, 'Martin', 'Marie', '1985-08-22', 2),
(3, 555555555, 'Dubois', 'Pierre', '1995-02-10', 3),
(4, 111222333, 'Lefevre', 'Sophie', '1992-11-30', 4),
(5, 444555666, 'Leroy', 'Thomas', '1988-04-18', 5),
(6, 777888999, 'Girard', 'Emilie', '1998-07-25', 6),
(7, 999888777, 'Moreau', 'Lucie', '1993-03-05', 7),
(8, 333222111, 'Roux', 'Antoine', '1987-09-12', 8),
(9, 666555444, 'Leclerc', 'Camille', '1996-06-20', 9),
(10, 111000222, 'Fournier', 'Nicolas', '1991-12-25', 10),
(11, 444000555, 'Bertrand', 'Isabelle', '1986-10-15', 11),
(12, 777000888, 'Lemoine', 'Martin', '1994-08-08', 12),
(13, 999000111, 'Garnier', 'Julie', '1989-04-01', 13),
(14, 333000444, 'Dufour', 'Alexandre', '1997-02-28', 14),
(15, 666000777, 'Caron', 'Charlotte', '1990-06-10', 15);


INSERT INTO gaumont.client (idPersonne, nom, prenom, datenaissance) VALUES
(1, 'Petit', 'Philippe', '1992-04-17'),
(2, 'Lopez', 'Marina', '1986-09-28'),
(3, 'Gauthier', 'Théo', '1995-03-15'),
(4, 'Perrin', 'Hélène', '1998-01-20'),
(5, 'Renard', 'Sarah', '1991-07-08'),
(6, 'Bouchard', 'Luc', '1987-11-12'),
(7, 'Lacombe', 'Océane', '1994-06-05'),
(8, 'Riviere', 'Benjamin', '1989-02-03'),
(9, 'Deschamps', 'Laura', '1996-10-22'),
(10, 'Lamy', 'Alexis', '1990-12-01'),
(11, 'Rolland', 'Léa', '1985-08-18'),
(12, 'Henry', 'Guillaume', '1993-04-14'),
(13, 'Brunet', 'Manon', '1988-11-27'),
(14, 'Arnaud', 'Lucas', '1997-05-09'),
(15, 'Vasseur', 'Céline', '1990-09-30');


INSERT INTO gaumont.societeProduction (societeProductionid, nom) VALUES
(1, 'Warner Bros.'),
(2, 'Universal Pictures'),
(3, 'Paramount Pictures'),
(4, '20th Century Studios'),
(5, 'Walt Disney Pictures'),
(6, 'Sony Pictures Entertainment'),
(7, 'Metro-Goldwyn-Mayer (MGM)'),
(8, 'DreamWorks Pictures'),
(9, 'Lionsgate'),
(10, 'Columbia Pictures'),
(11, 'Miramax Films'),
(12, 'New Line Cinema'),
(13, 'Focus Features'),
(14, 'Studio Ghibli'),
(15, 'Legendary Entertainment');


INSERT INTO gaumont.films (idfilm, nom, dateDebutDiff, dateFinDiff, societeProductionid) VALUES
(1, 'Inception', '2023-01-01', '2028-01-01', 1),--
(2, 'Jurassic Park', '2024-02-05', '2024-02-19', 2),--
(3, 'Forrest Gump', '2024-02-10', '2024-02-24', 3),--
(4, 'Titanic', '2024-02-15', '2024-02-29', 4),--
(5, 'The Lion King', '2024-02-20', '2024-03-05', 5),--
(6, 'Spider-Man: Into the Spider-Verse', '2024-02-25', '2024-03-26', 6), --
(7, 'The Wizard of Oz', '2024-03-01', '2024-03-16', 7),--
(8, 'Saving Private Ryan', '2024-03-05', '2024-03-20', 8),--
(9, 'The Hunger Games', '2024-03-10', '2024-03-25', 9),--
(10, 'Men in Black', '2024-03-15', '2024-04-17', 10),--
(11, 'Pulp Fiction', '2024-03-20', '2024-04-12', 11),--
(12, 'The Lord of the Rings: The Fellowship of the Ring', '2024-03-25', '2024-04-10', 12),--
(13, 'La La Land', '2024-03-30', '2024-04-22', 13),--
(14, 'Spirited Away', '2024-04-04', '2024-05-23', 14),
(15, 'The Dark Knight', '2024-04-09', '2024-04-27', 1);


INSERT INTO gaumont.seance (idfilm, idSalles, idPersonne, dateSeance) VALUES
(1, 101, 1, '2024-02-01'),--
(2, 201, 1, '2024-02-05'),--
(3, 301, 3, '2024-02-10'),--
(4, 401, 8, '2024-02-15'),--
(5, 501, 14, '2024-02-20'),--
(6, 601, 2, '2024-02-25'),--
(7, 401, 9, '2024-03-01'),--
(8, 602, 4, '2024-03-05'),--
(9, 601, 7, '2024-03-10'),--
(10, 101, 7, '2024-03-15'),--
(11, 201, 5, '2024-03-20'),--
(12, 301, 6, '2024-03-25'),--
(13, 401, 6, '2024-03-30'),--
(14, 501, 12, '2024-04-04'),--
(15, 601, 13, '2024-04-09');


-- 1. Retrouver les noms des films, le nom du studio de production, et la date de séance pour toutes les séances.
/*SELECT client.nom AS "Nom du Client", client.prenom AS "Prénom du Client", films.nom AS "Nom du Film", seance.dateSeance AS "Date de la scéance"
FROM gaumont.seance
JOIN gaumont.client ON seance.idPersonne = client.idPersonne
JOIN gaumont.films ON seance.idfilm = films.idfilm;

-- 2. Retrouver les noms des clients, le nom de la salle, et la date de séance pour toutes les réservations.
SELECT films.nom AS "Nom du Film", societeProduction.nom AS "Studio de Production", seance.dateSeance AS "Date de la scéance"
FROM gaumont.seance
INNER JOIN gaumont.films ON seance.idfilm = films.idfilm
INNER JOIN gaumont.societeProduction ON films.societeProductionid = societeProduction.societeProductionid;

-- 3. Retrouver le nombre de séances par salle.
SELECT salles.idsalles AS "Nom de la Salle", COUNT(*) AS "Nombre de Séances"
FROM gaumont.seance
INNER JOIN gaumont.salles ON seance.idSalles = salles.idSalles
GROUP BY salles.idsalles;

-- 4. Retrouver le nombre de films produits par chaque studio de production.
SELECT societeProduction.nom AS "Studio de Production", COUNT(*) AS "Nombre de Films"
FROM gaumont.films
INNER JOIN gaumont.societeProduction ON films.societeProductionid = societeProduction.societeProductionid
GROUP BY societeProduction.nom;

-- 5. Retrouver les noms des personnes qui sont à la fois employées et clientes.
SELECT personne.nom AS "Nom", personne.prenom AS "Prénom"
FROM gaumont.personne
INNER JOIN gaumont.employe ON personne.idPersonne = employe.idPersonne
INTERSECT
SELECT personne.nom, personne.prenom
FROM gaumont.personne
INNER JOIN gaumont.client ON personne.idPersonne = client.idPersonne;
*/
