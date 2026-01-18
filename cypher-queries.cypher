// Exercice 1: Ajoutez une personne ayant votre prénom et votre nom dans le graphe. Verifiez qui le noeud a bien éte crée.
CREATE (eloi:Artist {primaryName: "Eloi Dieme", birthYear: 2002}) RETURN eloi;
// Commentaire: on ajoute un noeud de type Artist avec les propriétés primaryName et birthYear à notre graphe. On retourne ensuite le noeud créé pour vérifier son existence.

// Exercice 2: Ajoutez un film nommé L'histoire de mon 20 au cours Infrastructure de données.
CREATE (f:Film {primaryTitle: "L'histoire de mon 20 au cours Infrastructure de données", startYear: 2026}) RETURN f;
// Commentaire: on ajoute un noeud de type Film avec les propriétés primaryTitle et startYear à notre graphe. On retourne ensuite le noeud créé pour vérifier son existence.

// Exercice 3: Ajoutez la relation ACTED_IN qui modélise votre participation à ce film en tant qu'acteur/actrice.
MATCH (a:Artist), (b:Film) WHERE a.primaryName = "Eloi Dieme" AND b.primaryTitle = "L'histoire de mon 20 au cours Infrastructure de données" CREATE (a)-[r:acted_in]->(b) RETURN type(r);
// Commentaire: on utilise une requête MATCH pour trouver les noeuds Artist et Film correspondant à notre nom et au titre du film. 
// Ensuite, on crée une relation ACTED_IN entre ces deux noeuds et on retourne le type de la relation créée pour vérifier son existence.
// On obtient bien le type de la relation "acted_in".

// Exercice 4: Ajoutez deux de vos professeurs/enseignants comme réalisateurs/réalisatrices de ce film.
MATCH (a:Artist), (b:Film) WHERE a.primaryName IN ["Luc Vo Van", "Francesca Bugiotti"] AND b.primaryTitle = "L'histoire de mon 20 au cours Infrastructure de données" CREATE (a)-[r:directed]->(b) RETURN type(r);
// Commentaire: on utilise une requête MATCH pour trouver les noeuds Artist correspondant aux noms de nos professeurs et le noeud Film correspondant au titre du film. 
// Ensuite, on crée une relation DIRECTED entre chaque professeur et le film, et on retourne le type de la relation créée pour vérifier son existence.
// On obtient bien le type de la relation "directed".

// Exercice 5: Affichez le noeud représentant l'actrice nommée Nicole Kidman, et visualisez son année de naissance.
MATCH (a:Artist) WHERE a.primaryName = "Nicole Kidman" RETURN a.birthYear;
// Commentaire: on utilise une requête MATCH pour trouver le noeud Artist correspondant à Nicole Kidman, puis on retourne la propriété birthYear de ce noeud pour visualiser son année de naissance.

// Exercice 6: Visualisez l'ensemble des films.
MATCH (f:Film) RETURN f.primaryTitle;
// Commentaire: on utilise une requête MATCH pour trouver tous les noeuds de type Film, puis on retourne la propriété primaryTitle de chaque film pour visualiser l'ensemble des titres de films

// Exercice 7: Trouvez les noms des artistes nés en 1963, affichez ensuite leur nombre.
MATCH (a:Artist) WHERE a.birthYear = 1963 RETURN count(a) AS nombre_artistes;
// Commentaire: on utilise une requête MATCH pour trouver tous les noeuds Artist dont la propriété birthYear est égale à 1963. 
// Ensuite, on retourne le nombre total d'artistes nés en 1963 en utilisant la fonction count(). Le résultat est 222.

// Exercice 8: Trouver l'ensemble des acteurs (sans entrées doublons) qui ont joué dans plus d'un film.
MATCH (a:Artist)-[:acted_in]->(f:Film) WITH a, count(f) AS nombre_films WHERE nombre_films > 1 RETURN DISTINCT a.primaryName;
// Commentaire: on utilise une requête MATCH pour trouver tous les noeuds Artist qui ont une relation ACTED_IN avec des noeuds Film. 
// Ensuite, on compte le nombre de films pour chaque artiste et on filtre ceux qui ont joué dans plus d'un film. 
// Enfin, on retourne les noms distincts des artistes correspondants.

// Exercice 9: Trouvez les artistes ayant eu plusieurs responsabilités au cours de leur carrière (acteur, directeur, producteur...).
MATCH (a:Artist)-[r]->(f:Film) WITH a, collect(DISTINCT type(r)) AS roles WHERE size(roles) > 1 RETURN a.primaryName, roles;
// Commentaire: on utilise une requête MATCH pour trouver tous les noeuds Artist qui ont des relations avec des noeuds Film. 
// Ensuite, on collecte les types de relations distincts pour chaque artiste et on filtre ceux qui ont eu plus d'un rôle. 
// Enfin, on retourne les noms des artistes et leurs rôles correspondants.

// Exercice 10: Montrez les artistes ayant eu plusieurs responsabilités dans un même film (ex: à la fois acteur et directeur, ou toute autre combinaison) et les titres de ces films.
MATCH (a:Artist)-[r1]->(f:Film)<-[r2]-(a) WHERE type(r1) <> type(r2) RETURN a.primaryName, f.primaryTitle, collect(DISTINCT type(r1)) + collect(DISTINCT type(r2)) AS roles;
// Commentaire: on utilise une requête MATCH pour trouver tous les noeuds Artist qui ont des relations avec des noeuds Film. 
// On s'assure que les types de relations sont différents pour capturer les artistes ayant eu plusieurs responsabilités dans le même film. 
// Enfin, on retourne les noms des artistes, les titres des films et les rôles correspondants.

// Exercice 11: Trouver le nom du ou des film(s) ayant le plus d'acteurs.
MATCH (a:Artist)-[:acted_in]->(f:Film) WITH f, count(a) AS nombre_acteurs ORDER BY nombre_acteurs DESC LIMIT 1 RETURN f.primaryTitle, nombre_acteurs;
// Commentaire: on utilise une requête MATCH pour trouver tous les noeuds Artist qui ont une relation ACTED_IN avec des noeuds Film. 
// Ensuite, on compte le nombre d'acteurs pour chaque film, on trie les films par nombre d'acteurs en ordre décroissant,
// on limite le résultat au film ayant le plus d'acteurs, et on retourne le titre du film et le nombre d'acteurs correspondants.
// On obtient "Myths of the Mother" avec 34 acteurs, ce qui diffère du résultat SQL (10 acteurs max) pour deux raisons:
// 1) La table tJob contient des doublons (même artiste/film/catégorie plusieurs fois), exportés tels quels vers Neo4j
// 2) La requête SQL utilise COUNT(DISTINCT) et INNER JOIN tArtist pour éliminer les doublons et les artistes orphelins
// Pour corriger cela, il faudrait modifier l'export avec SELECT DISTINCT dans la requête SQL de export-neo4j.py