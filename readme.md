# Modélisation du jeu **THE GAME**

Nous avons choisi de modéliser le jeu **THE GAME**, dont les règles originales sont disponibles ici : [Règles officielles](http://jeuxstrategie1.free.fr/jeu_the_game/regle.pdf).

## Règles simplifiées

Le concept est simple : les joueurs disposent de **piles croissantes et décroissantes** et doivent essayer de **placer toutes les cartes** en respectant certaines règles.

Dans notre modélisation, nous avons introduit quelques simplifications :
- **Jeu solo** : Nous nous concentrons sur le cas à **1 joueur**.
- **Pioche connue** : L'ordre des cartes dans la pioche est **entierement determiné à l'avance**.
- **Règle du saut modifiée** : Le saut de **10** est remplacé par un saut de **5**.

## Exemple

**Pioche :** `2 4 3`

Le joueur dispose d'une **seule pile ascendante**.

### Plan optimal :
1. Piocher toutes les cartes.
2. Placer `2` sur la pile.
3. Placer `3` sur la pile.
4. Placer `4` sur la pile.

## Intérêt et complexité

Nous avons choisi cette modélisation car elle conserve **l'esprit du jeu**, même avec un seul joueur et en connaissant l'ordre des cartes.

Cependant, des **extensions** restent possibles pour complexifier la planification.

Lors de notre recherche, nous avons observé que de nombreux problèmes se ramenaient à des **problèmes combinatoires**. De plus, les jeux à plusieurs agents ne s'écrivent pas facilement en PDDL car le plan choisira des actions sous optimales pour l'adversaire afin d'optimiser les choix du joueur principal.

À noter que la version originale du jeu, même avec un seul joueur et en connaissant l'ordre des cartes, présente une **complexité combinatoire gigantesque**. Notre modélisation reste donc plus simple que le jeu original, tout en conservant un défi intéressant.

## Modélisation en **PDDL**

### Domain (domain.pddl)

- **Types :**
  - `pile` : Représente les piles ascendantes et descendantes.
  - `card` : Représente les cartes du jeu.
- **Prédicats :**
  - `(ascending_pile ?p - pile)`, `(descending_pile ?p - pile)`: Indiquent si une pile est croissante ou décroissante.
  - `(card_in_hand ?c - card)`: Indique si une carte est dans la main du joueur.
  - `(top_pile_card ?p - pile ?c - card)`: Indique la carte au sommet d'une pile.
  - `(next_card_in_deck ?c1 - card ?c2 - card)`: Indique l'ordre des cartes dans la pioche.
  - `(top_deck_card ?c - card)`: Indique la carte actuelle au sommet de la pioche.
  - `(is_drawing)`: Indique si le joueur est en train de piocher.
  - `(is_bottom_card ?c - card)`: Indique si une carte est la dernière de la pioche.
  - `(deck_empty)`: Indique si la pioche est vide.
- **Fonctions :**
  - `(value ?c - card)`: Représente la valeur d'une carte.
  - `(n_card_in_hand)`: Indique le nombre de cartes en main.
- **Actions principales :**
  - `play_card` : Joue une carte sur une pile en respectant les règles de placement.
  - `draw_card` : Pioche une carte si le joueur n'a pas trop de cartes en main.
  - `stop_drawing` : Indique que le joueur arrête de piocher.
  - `draw_final_card` : Pioche la dernière carte du deck et signale que la pioche est vide.

### Problem (problem.pddl)

- **Objets :**
  - Une pile (`pile0`).
  - Cartes (`c_min`, `c4`, `c2`, `c3`).
- **Initialisation :**
  - `pile0` est une pile ascendante.
  - `c_min` est la carte initiale sur `pile0`.
  - `c4`, `c2`, `c3` sont dans la pioche dans cet ordre.
  - La main du joueur est vide au début.
- **Objectif :**
  - Toutes les cartes ont été jouées (`deck_empty`).
  - La main du joueur est vide (`n_card_in_hand = 0`).

## Contraintes et limitations

Dans notre modélisation, nous avons dû utiliser des variables numériques pour représenter la valeur des cartes et le nombre de cartes en main.
Cela nous permet de gérer les règles du jeu de manière plus flexible, mais introduit également une contrainte sur les solveurs PDDL.

En effet, tous les solveurs ne supportent pas les fonctions numériques, car ils sont généralement conçus pour des problèmes purement symboliques. Par conséquent, la résolution de ce problème nécessite un solveur prenant en charge les fluents numériques, comme ENHSP ou Metric-FF.

Cette contrainte limite l'ensemble des outils utilisables pour planifier la séquence optimale d'actions.

