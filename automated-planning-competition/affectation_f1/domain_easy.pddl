(define (domain f1)
    (:requirements :strips :typing :negative-preconditions :derived-predicates :disjunctive-preconditions)

    (:types circuit continent weekend)

    (:predicates
        (situe_sur ?c - circuit ?cont - continent)
        (meme_continent ?c1 - circuit ?c2 - circuit)
        (precede ?w1 - weekend ?w2 - weekend)
        (course_planifie ?c - circuit ?w - weekend)
        (changement_continent ?c1 - circuit ?c2 - circuit)
        (course_realisee ?c - circuit)
        (weekend_occupe ?w - weekend)
    )

        ; Définition des continents identiques
    (:derived (meme_continent ?c1 - circuit ?c2 - circuit)
        (exists (?cont - continent)
            (and
                (situe_sur ?c1 ?cont)
                (situe_sur ?c2 ?cont)
            )
        )
    )

    ; Définition du changement de continent
    (:derived (changement_continent ?c1 - circuit ?c2 - circuit)
        (not (meme_continent ?c1 ?c2))
    )


    ; Action pour planifier une course
    (:action planifier-course
        :parameters (?c - circuit ?w - weekend)
        :precondition (and 
        (not (course_realisee ?c))  ; La course n'a pas déjà été réalisée
        (not (weekend_occupe ?w))  ; Le week-end n'est pas déjà pris
        )
        :effect (and
            (course_planifie ?c ?w)
            (course_realisee ?c)  ; Marque la course comme réalisée
            (weekend_occupe ?w)   ; Marque le week-end comme occupé
        )
    )

    (:action prendre-repos
    :parameters (?w - weekend)
    :precondition (not (exists (?c - circuit) (course_planifie ?c ?w)))
    :effect (and)
    )
)