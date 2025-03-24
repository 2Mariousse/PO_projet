(define (problem easy)
    (:domain the_game)
    (:objects
        pile0 - pile
        c_min c4 c2 c3 - card
    )
    (:init
        (ascending_pile pile0)
        (top_pile_card pile0 c_min)
        (top_deck_card c4)
        (next_card_in_deck c4 c2)
        (next_card_in_deck c2 c3)
        (is_bottom_card c3)
        (= (n_card_in_hand) 0)
        (= (value c_min) 1)
        (= (value c4) 4)
        (= (value c2) 2)
        (= (value c3) 3)
    )
    (:goal
        (and
            (deck_empty)
            (= (n_card_in_hand) 0)
        )
    )
)
