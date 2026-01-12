// Exercice 1: Ajoutez une personne ayant votre prénom et votre nom dans le graphe. Verifiez qui le noeud a bien éte crée.
CREATE (eloi:Artist {primaryName: "Eloi Dieme", birthYear: 2002}) RETURN eloi;
// Commentaire: on ajoute un noeud de type Artist avec les propriétés primaryName et birthYear à notre graphe. On retourne ensuite le noeud créé pour vérifier son existence.

// Exercice 2: Ajoutez un film nommé L'histoire de mon 20 au cours Infrastructure de données.
CREATE (f:Film {primaryTitle: "L'histoire de mon 20 au cours Infrastructure de données", startYear: 2026}) RETURN f;
// Commentaire: on ajoute un noeud de type Film avec les propriétés primaryTitle et startYear à notre graphe. On retourne ensuite le noeud créé pour vérifier son existence.

// Exercice 3: Ajoutez la relation ACTED_IN qui modélise votre participation à ce film en tant qu'acteur/actrice.
MATCH (a:Artist), (b:Film) WHERE a.primaryName = "Eloi Dieme" AND b.primaryTitle = "L'histoire de mon 20 au cours Infrastructure de données" CREATE (a)-[r:acted_in]->(b) RETURN type(r);
// Commentaire: on utilise une requête MATCH pour trouver les noeuds Artist et Film correspondant à notre nom et au titre du film. Ensuite, on crée une relation ACTED_IN entre ces deux noeuds et on retourne le type de la relation créée pour vérifier son existence.
// On obtient bien le type de la relation "acted_in".

// Exercice 4: Ajoutez deux de vos professeurs/enseignants comme réalisateurs/réalisatrices de ce film.

// Exercice 5: Affichez le noeud représentant l'actrice nommée Nicole Kidman, et visualisez son année de naissance.

// Exercice 6: Visualisez l'ensemble des films.

// Exercice 7: Trouvez les noms des artistes nés en 1963, affichez ensuite leur nombre.

// Exercice 8: Trouver l'ensemble des acteurs (sans entrées doublons) qui ont joué dans plus d'un film.

// Exercice 9: Trouvez les artistes ayant eu plusieurs responsabilités au cours de leur carrière (acteur, directeur, producteur...).

// Exercice 10: Montrez les artistes ayant eu plusieurs responsabilités dans un même film (ex: à la fois acteur et directeur, ou toute autre combinaison) et les titres de ces films.

// Exercice 11: Trouver le nom du ou des film(s) ayant le plus d'acteurs.