(define (problem the_game_instance)
    (:domain the_game)

    (:objects
        pile1 pile2 - pile
        c1 c3 c4 c5 c10 c20 c30 c50 c70 c100 c19 c27 c17 c52 c28 c89 c74 - card
    )

    (:init
        (ascending_pile pile1)
        (descending_pile pile2)

        (top_pile_card pile1 c1)
        (top_pile_card pile2 c100)


        (next_card_in_deck c3 c4)
        (next_card_in_deck c4 c5)
        (next_card_in_deck c5 c10)
        (next_card_in_deck c10 c20)
        (next_card_in_deck c20 c30)
        (next_card_in_deck c30 c50)
        (next_card_in_deck c50 c70)

        (top_deck_card c3)
        (is_bottom_card c70)
        (card_in_hand c19)
        (card_in_hand c27)
        (card_in_hand c17)
        (card_in_hand c52)
        (card_in_hand c28)
        (card_in_hand c89)
        (card_in_hand c74)
        
        (= (n_card_in_hand) 7)

        (= (value c1) 1)
        (= (value c3) 3)
        (= (value c4) 4)
        (= (value c5) 5)
        (= (value c10) 10)
        (= (value c20) 20)
        (= (value c30) 30)
        (= (value c50) 50)
        (= (value c70) 70)
        (= (value c100) 100)
        (= (value c19) 19)
        (= (value c27) 27)
        (= (value c17) 17)
        (= (value c52) 52)
        (= (value c28) 28)
        (= (value c89) 89)
        (= (value c74) 74)


    )

    (:goal
        (and
            (deck_empty)
            (= (n_card_in_hand) 0)
        )
    )
)
