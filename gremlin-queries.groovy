// Exercice 1: Ajoutez une personne ayant votre prénom et votre nom dans le graphe. Verifiez qui le noeud a bien été crée.
g.addV('Artist').property('id', 'nm-id-eloi').property('primaryName', 'Eloi Dieme').property('birthYear', 2002).property('pk', '1');
// Commentaire: on ajoute un noeud de type Artist avec les propriétés primaryName et birthYear à notre graphe. On utilise un id unique pour éviter les conflits avec d'autres artistes.

// Exercice 2: Ajoutez un film nommé L'histoire de mon 20 au cours Infrastructure de données.
g.addV('Film').property('id', 'tt-film-infra-20').property('primaryTitle', "L'histoire de mon 20 au cours Infrastructure de donnees").property('pk', '1');
// Commentaire: on ajoute un noeud de type Film avec la propriété primaryTitle à notre graphe.

// Exercice 3: Ajoutez la relation ACTED_IN qui modélise votre participation à ce film en tant qu'acteur/actrice.
g.V('nm-id-eloi').addE('acted in').to(g.V('tt-film-infra-20'))
// Commentaire: on crée une relation 'acted in' entre le noeud Artist représentant moi-même et le noeud Film représentant le film que j'ai ajouté.

// Exercice 4: Ajoutez deux de vos professeurs/enseignants comme réalisateurs/réalisatrices de ce film.
g.addV('Artist').property('id', 'nm-luc-vo-van').property('primaryName', 'Luc Vo Van').property('pk', '1');
g.addV('Artist').property('id', 'nm-francesca-bugiotti').property('primaryName', 'Francesca Bugiotti').property('pk', '1');
g.V().has('Artist', 'primaryName', 'Luc Vo Van').addE('directed').to(g.V('tt-film-infra-20'));
g.V().has('Artist', 'primaryName', 'Francesca Bugiotti').addE('directed').to(g.V('tt-film-infra-20'));
// Commentaire: on ajoute deux noeuds Artist représentant les professeurs, puis on crée des relations 'directed' entre ces noeuds et le noeud Film.

// Exercice 5: Affichez le noeud représentant l'actrice nommée Nicole Kidman, et visualisez son année de naissance.
g.V().has('Artist', 'primaryName', 'Nicole Kidman').values('birthYear');
// Commentaire: on utilise une requête pour trouver le noeud Artist dont la propriété primaryName est 'Nicole Kidman', puis on récupère la valeur de la propriété birthYear pour afficher son année de naissance.

// Exercice 6: Visualisez l'ensemble des films.
g.V().hasLabel('Film').values('primaryTitle');
// Commentaire: on utilise une requête pour trouver tous les noeuds de type Film et on récupère la valeur de la propriété primaryTitle pour afficher les titres des films.

// Exercice 7: Trouvez les noms des artistes nés en 1963, affichez ensuite leur nombre.
g.V().has('Artist', 'birthYear', 1963).count();
// Commentaire: on utilise une requête pour trouver tous les noeuds Artist dont la propriété birthYear est 1963, puis on compte le nombre de ces noeuds pour obtenir le résultat.
// Le résultat est 222 artistes nés en 1963.

// Exercice 8: Trouver l'ensemble des acteurs (sans entrées doublons) qui ont joué dans plus d'un film.
g.V().hasLabel('Artist').where(__.outE('acted in').count().is(gt(1))).values('primaryName').dedup();
// Commentaire: on utilise une requête pour trouver tous les noeuds Artist qui ont plus d'une relation 'acted in' vers des noeuds Film. 
// Ensuite, on récupère la valeur de la propriété primaryName pour afficher les noms des acteurs, et on utilise dedup() pour éliminer les doublons.

// Exercice 9: Trouvez les artistes ayant eu plusieurs responsabilités au cours de leur carrière (acteur, directeur, producteur...).
g.V().hasLabel('Artist').where(__.bothE().label().dedup().count().is(gt(1))).project('name', 'roles').by('primaryName').by(__.bothE().label().dedup().fold());
// Commentaire: on utilise une requête pour trouver tous les noeuds Artist qui ont plus d'un type de relation (responsabilité) avec d'autres noeuds. 
// Ensuite, on projette le nom de l'artiste et la liste de ses rôles en utilisant bothE() pour obtenir toutes les relations, label() pour obtenir les types de relations,
// dedup() pour éliminer les doublons, et fold() pour regrouper les rôles dans une liste.

// Exercice 10: Montrez les artistes ayant eu plusieurs responsabilités dans un même film (ex: à la fois acteur et directeur, ou toute autre combinaison) et les titres de ces films.
g.V().hasLabel('Artist').as('a').out().hasLabel('Film').as('f').where(__.select('a').outE().where(__.inV().where(eq('f'))).label().dedup().count().is(gt(1))).dedup().project('artist', 'film', 'roles').by(__.select('a').values('primaryName')).by('primaryTitle').by(__.select('a').outE().where(__.inV().where(eq('f'))).label().dedup().fold());
// Commentaire: on part de chaque artiste, on traverse vers les films connectés, puis on filtre pour garder uniquement les paires (artiste, film)
// où l'artiste a plus d'un type de relation différent vers ce film spécifique. Enfin, on projette le nom de l'artiste, le titre du film et la liste des rôles distincts. 

// Exercice 11: Trouver le nom du ou des film(s) ayant le plus d'acteurs.
g.V().hasLabel('Film').project('film', 'actorCount').by('primaryTitle').by(__.inE('acted in').count()).order().by(select('actorCount'), decr).limit(1);
// Commentaire: on parcourt tous les films, on projette le titre et le nombre d'acteurs (arêtes 'acted in' entrantes),
// on trie par nombre d'acteurs en ordre décroissant, et on limite au premier résultat pour obtenir le film avec le plus d'acteurs.
// On obtient "Myths of the Mother" avec 34 acteurs.