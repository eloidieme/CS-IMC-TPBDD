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

-- Exercice 1: Visualisez l'année de naissance de l'artiste *Jude Law (Brad Pitt n'étant pas dans la BDD).
SELECT primaryName, birthYear FROM tArtist WHERE primaryName LIKE '%Jude Law%';
-- Commentaire: Jude Law est né en 1972. On le trouve à partir d'une simple requête sur une seule table avec filtre (WHERE .. LIKE).
-- On utilise LIKE pour avoir plus de flexibilité sur le string-matching.

-- Exercice 2: Comptez le nombre d'artistes présents dans la base de données.
SELECT COUNT(*) FROM tArtist;
-- Commentaire: Il y a 82046 artistes dans la BDD. On utilise une fonction d'agrégation (COUNT) pour compter le nombre de lignes dans la table tArtist.

-- Exercice 3: Trouvez les noms des artistes nés en 1960, affichez ensuite leur nombre.
SELECT primaryName FROM tArtist WHERE birthYear = 1960;
SELECT COUNT(*) FROM tArtist WHERE birthYear = 1960;
-- Commentaire: Il y a 203 artistes nés en 1960 dans la BDD. On utilise ici aussi du filtrage et une fonction d'aggrégation.

-- Exercice 4: Trouvez l'année de naissance la plus représentée parmi les acteurs (sauf 0!), et combien d'acteurs sont nés cette année là.
SELECT birthYear, COUNT(*) FROM tArtist WHERE birthYear <> 0 GROUP BY birthYear ORDER BY COUNT(*) DESC;
-- Commentaire: L'année de naissance la plus représentée parmi les acteurs est 1980 (avec 477 occurences). 
-- Cette fois on combine une fonction d'aggrégation avec un GROUP BY pour grouper les artistes par année de naissance. 
-- Enfin on ordonne pour obtenir le classement.

-- Exercice 5: Trouvez les artistes ayant joué dans plus d'un film.
SELECT a.primaryName, COUNT(j.idFilm) AS NumberOfFilms FROM tArtist AS a INNER JOIN tJob AS j ON a.idArtist = j.idArtist WHERE j.category = 'acted in' GROUP BY a.primaryName HAVING COUNT(j.idFilm) > 1;
-- Commentaire: On utilise une jointure entre tArtist et tJob pour relier les artistes à leurs films. 
-- Ensuite on groupe par artiste et on utilise HAVING pour filtrer ceux ayant plus d'un film.
-- On filtre aussi sur la catégorie 'acted in' pour ne considérer que les rôles d'acteur.

-- Exercice 6: Trouvez les artistes ayant eu plusieurs responsabilités au cours de leur carrière (acteur, directeur, producteur...).
SELECT a.primaryName, COUNT(DISTINCT j.category) AS NumberOfRoles 
FROM tArtist AS a 
INNER JOIN tJob AS j ON a.idArtist = j.idArtist 
GROUP BY a.primaryName 
HAVING COUNT(DISTINCT j.category) > 1;
-- Commentaire: Similaire à l'exercice précédent, mais cette fois on compte le nombre distinct de catégories (rôles) pour chaque artiste.

-- Exercice 7: Trouver le nom du ou des film(s) ayant le plus d'acteurs (i.e. uniquement acted in).
SELECT f.primaryTitle, COUNT(j.idArtist) AS NumberOfActors 
FROM tFilm AS f INNER JOIN tJob AS j ON f.idFilm = j.idFilm 
WHERE j.category = 'acted in' 
GROUP BY f.primaryTitle 
ORDER BY NumberOfActors DESC;
-- Commentaire: On utilise une jointure entre tFilm et tJob pour relier les films à leurs acteurs. 
-- Ensuite on groupe par film et on compte le nombre d'acteurs, puis on ordonne pour obtenir le classement.
-- On trouve que le gagnant est "Heidi - Rescue of the Lynx", avec 36 acteurs.

-- Exercice 8: Montrez les artistes ayant eu plusieurs responsabilités dans un même film (ex: à la fois acteur et directeur, ou toute autre combinaison) et les titres de ces films.
SELECT f.idFilm, f.primaryTitle, COUNT(j.idArtist) AS NumberOfActors 
FROM tFilm AS f 
INNER JOIN tJob AS j ON f.idFilm = j.idFilm 
WHERE j.category = 'acted in' 
GROUP BY f.idFilm, f.primaryTitle 
ORDER BY NumberOfActors DESC;
-- Commentaire: On utilise des jointures entre tArtist, tJob et tFilm pour relier les artistes à leurs films et rôles. 
-- Ensuite on groupe par artiste et film, et on compte le nombre distinct de catégories (rôles) pour chaque combinaison.
-- Enfin, on filtre avec HAVING pour ne garder que ceux ayant plusieurs rôles dans le même film
