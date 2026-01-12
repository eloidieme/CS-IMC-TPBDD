-- Exercice 0: Exploration
SELECT TOP 5 * FROM tArtist;
SELECT TOP 5 * FROM tFilm;
SELECT TOP 5 * FROM tFilmGenre;
SELECT TOP 5 * FROM tGenre;
SELECT TOP 5 * FROM tJob;

/*
Réponse: La BDD est composée de cinq tables (tArtist, tFilm, tFilmGenre, tGenre et tJob). 
Trois d'entre elles (tArtist, tFilm, tGenre) correspondent à des entités et leur caractéristiques (et ont donc des clés primaires) 
tandis que les deux autres (tFilmGenre et tJob) font le lien entre deux entités (film<->genre et film<->artist respectivement) et ont donc des clés étrangères.
Pour les attributs des entités:
 - artistes: noms, dates de naissance
 - films: titres, années de sortie, durées de visionnage
 - genres: noms
*/

-- Exercice 1: Année de naissance de l'artiste Jude Law
SELECT primaryName, birthYear FROM tArtist WHERE primaryName LIKE '%Jude Law%';

-- Commentaire: Jude Law est né en 1972. On le trouve à partir d'une simple requête sur une seule table avec filtre (WHERE .. LIKE).
-- On utilise LIKE pour avoir plus de flexibilité sur le string-matching.

-- Exercice 2: Nombre d'artistes présents dans la BDD
SELECT COUNT(*) FROM tArtist;

-- Commentaire: Il y a 82046 artistes dans la BDD. On utilise une fonction d'agrégation (COUNT) pour compter le nombre de lignes dans la table tArtist.

