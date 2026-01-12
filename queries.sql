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
