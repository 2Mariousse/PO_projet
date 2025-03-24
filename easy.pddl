(define (problem easy)
    (:domain the_game)
    (:objects
        pile0 - pile
        c_min c3 c2 c4 - card
    )
    (:init
        (ascending_pile pile0)
        (top_pile_card pile0 c_min)
        (top_deck_card c3)
        (next_card_in_deck c3 c2)
        (next_card_in_deck c2 c4)
        (is_bottom_card c4)
        (= (n_card_in_hand) 0)
        (= (value c_min) 1)
        (= (value c3) 3)
        (= (value c2) 2)
        (= (value c4) 4)
    )
    (:goal
        (and
            (deck_empty)
            (= (n_card_in_hand) 0)
        )
    )
)
