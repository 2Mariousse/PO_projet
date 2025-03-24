Nous avons choisi de modéliser le jeu THE GAME dont les règles sont disponibles ici : http://jeuxstrategie1.free.fr/jeu_the_game/regle.pdf


Le concept est simple : possédant des piles croissantes et décroissantes, les joueurs doivent essayer de placer toutes les cartes respectant certaines règles.

Dans notre modélisation, nous simplifions certaines règles:
-Nous nous concentrons sur le cas à 1 joueur
-On suppose connue l'intégralité de l'ordre des cartes (la pioche).
-la règle du saut de 10 et simplifiée en saut de 5.

Voici un exemple très simple.

2
4
3
----

et une seule pile ascendante, le joueur pioche toutes les cartes, puis place sur la pile la carte 2, puis 3 puis 4.

Nous avons choisi ce problème car il garde l'esprit du jeu, même avec un  seul joueur et en connaissant l'ordre des cartes. Des extensions de ce problème de planification restent possible également.
Lors de notre recherche, souvent les problèmes se résumaient à des problèmes combinatoires, ou alors retirer un des deux agents rendait la solution systématiquement triviale.

On note que la version originale du jeu, même avec un seul joueur et en connaissant l'ordre des cartes, le problème possède une complexité combinatoire gigantesque, notre instance la plus difficile reste bien plus simple que le jeu original.

