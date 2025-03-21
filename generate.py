from random import shuffle


def generate(file_name: str, draw_pile: list[int], n_ascendants: int, n_descendants: int):
    assert len(set(draw_pile)) == len(draw_pile), "Draw pile contains duplicate cards"
    assert min(draw_pile) > 1, "Draw pile contains card with value lower or equal to 1"
    assert max(draw_pile) < 100, "Draw pile contains card with value greater or equal to 100"
    
    shuffle(draw_pile)
    
    with open(f"{file_name}.pddl", "w") as f:
        f.write(f"(define (problem problem1)\n")
        f.write(f"    (:domain the_game)\n")
        
        f.write(f"    (:objects\n")
        f.write(f"        {" ".join(f"pile{i}" for i in range(n_ascendants + n_descendants))} - pile\n")
        f.write(f"        {" ".join(f"c1 c100 c{value}" for value in draw_pile)} - card\n")
        f.write(f"    )\n")
        
        f.write(f"    (:init\n")
        f.write(f"        (ascending_pile {" ".join(f"pile{i}" for i in range(n_ascendants))})\n")
        f.write(f"        (descending_pile {" ".join(f"pile{i}" for i in range(n_ascendants, n_ascendants + n_descendants))})\n")
        
        for i in range(n_ascendants):
            f.write(f"        (top_pile_card pile{i} c1)\n")
        for i in range(n_ascendants, n_ascendants + n_descendants):
            f.write(f"        (top_pile_card pile{i} c100)\n")
        
        f.write(f"        (top_deck_card c{draw_pile[0]})\n")
        for i in range(1, len(draw_pile)):
            f.write(f"        (next_card_in_deck c{draw_pile[i-1]} c{draw_pile[i]})\n")
        f.write(f"        (is_bottom_card c{draw_pile[-1]})\n")
        
        f.write(f"        (= (n_card_in_hand) 0)\n")
        
        f.write(f"        (= (value c1) 1)\n")
        f.write(f"        (= (value c100) 100)\n")
        
        for value in draw_pile:
            f.write(f"        (= (value c{value}) {value})\n")
        
        f.write(f"    )\n")
        
        f.write(f"    (:goal\n")
        f.write(f"        (and\n")
        f.write(f"            (deck_empty)\n")
        f.write(f"            (= (n_card_in_hand) 0)\n")
        f.write(f"        )\n")
        f.write(f"    )\n")
        f.write(f")\n")


generate("test", [3, 4, 5, 10, 20, 30, 50, 70, 19, 27, 17, 52, 28, 89, 74], 1, 1)