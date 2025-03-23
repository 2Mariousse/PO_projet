(define (domain the_game)
    (:requirements :strips :typing :fluents :negative-preconditions :disjunctive-preconditions :conditional-effects)

    (:types 
        pile card - object
    )

    (:predicates
        (ascending_pile ?p - pile)
        (descending_pile ?p - pile)
        (card_in_hand ?c - card)
        (top_pile_card ?p - pile ?c - card)
        (next_card_in_deck ?c1 - card ?c2 - card)  ; Simulates list order in drawing pile
        (top_deck_card ?c - card)
        (is_drawing)
        (is_bottom_card ?c - card)
        (deck_empty)
    )

    (:functions
        (value ?c - card)
        (n_card_in_hand) 
    )

    (:action play_card
        :parameters (?c - card ?p - pile ?c_top - card)
        :precondition (and
            (card_in_hand ?c) 
            (top_pile_card ?p ?c_top) 
            (not (is_drawing))
            (or 
                (and (ascending_pile ?p) (> (value ?c) (value ?c_top)))
                (and (descending_pile ?p) (< (value ?c) (value ?c_top)))
                (and (ascending_pile ?p) (= (value ?c) (- (value ?c_top) 5)))
                (and (descending_pile ?p) (= (value ?c) (+ (value ?c_top) 5)))
            )
        )
        :effect (and
            (not (card_in_hand ?c))
            (top_pile_card ?p ?c)
            (not (top_pile_card ?p ?c_top))
            (decrease (n_card_in_hand) 1)

        )
    )

    (:action draw_card
        :parameters (?c1 - card ?c2 - card)
        :precondition (and
            (top_deck_card ?c1)
            (next_card_in_deck ?c1 ?c2)
            (<= (n_card_in_hand) 6)
            (or 
                (is_drawing)
                (<= (n_card_in_hand) 5)
            )
        )
        :effect (and
            (not (top_deck_card ?c1))
            (top_deck_card ?c2)
            (card_in_hand ?c1)
            (increase (n_card_in_hand) 1)
            (is_drawing)
        )
    )
    
    (:action stop_drawing
        :parameters ()
        :precondition (and 
            (= (n_card_in_hand) 7)
            (is_drawing)
        )
        :effect (not (is_drawing))
    )

    (:action draw_final_card
        :parameters (?c1 - card)
        :precondition (and
            (top_deck_card ?c1)
            (is_bottom_card ?c1)
        )
        :effect (and
            (not (top_deck_card ?c1))
            (card_in_hand ?c1)
            (increase (n_card_in_hand) 1)
            (not (is_drawing))
            (deck_empty)
        )
    )

)
