from random import shuffle


def generate(
    file_name: str,
    draw_pile: list[int],
    n_ascendants: int,
    n_descendants: int,
    c_min: int | None = 1,
    c_max: int | None = 100,
):
    assert len(set(draw_pile)) == len(draw_pile), "Draw pile contains duplicate cards"
    assert c_min is None or min(draw_pile) > c_min, (
        "Draw pile contains card with value lower or equal to c_min"
    )
    assert c_max is None or max(draw_pile) < c_max, (
        "Draw pile contains card with value greater or equal to c_max"
    )

    shuffle(draw_pile)

    with open(f"{file_name}.pddl", "w") as f:
        f.write(f"(define (problem {file_name})\n")
        f.write("    (:domain the_game)\n")

        f.write("    (:objects\n")
        f.write(
            f"        {' '.join(f'pile{i}' for i in range(n_ascendants + n_descendants))} - pile\n"
        )
        f.write(
            f"        {'c_min ' if c_min is not None else ''}{'c_max ' if c_max is not None else ''}{' '.join(f'c{value}' for value in draw_pile)} - card\n"
        )
        f.write("    )\n")

        f.write("    (:init\n")

        for i in range(n_ascendants):
            f.write(f"        (ascending_pile pile{i})\n")
        for i in range(n_ascendants, n_ascendants + n_descendants):
            f.write(f"        (descending_pile pile{i})\n")

        for i in range(n_ascendants):
            f.write(f"        (top_pile_card pile{i} c_min)\n")
        for i in range(n_ascendants, n_ascendants + n_descendants):
            f.write(f"        (top_pile_card pile{i} c_max)\n")

        f.write(f"        (top_deck_card c{draw_pile[0]})\n")
        for i in range(1, len(draw_pile)):
            f.write(
                f"        (next_card_in_deck c{draw_pile[i - 1]} c{draw_pile[i]})\n"
            )
        f.write(f"        (is_bottom_card c{draw_pile[-1]})\n")

        f.write("        (= (n_card_in_hand) 0)\n")

        if c_min is not None:
            f.write(f"        (= (value c_min) {c_min})\n")
        if c_max is not None:
            f.write(f"        (= (value c_max) {c_max})\n")

        for value in draw_pile:
            f.write(f"        (= (value c{value}) {value})\n")

        f.write("    )\n")

        f.write("    (:goal\n")
        f.write("        (and\n")
        f.write("            (deck_empty)\n")
        f.write("            (= (n_card_in_hand) 0)\n")
        f.write("        )\n")
        f.write("    )\n")
        f.write(")\n")


generate("hard", list(range(2, 30)), 2, 2, c_min=1, c_max=30)
generate("medium", list(range(2, 20)), 1, 1, c_min=1, c_max=20)
generate("easy", list(range(2, 5)), 1, 0, c_min=1, c_max=None)
generate("very_hard", list(range(2, 50)), 2, 2, c_min=1, c_max=50)
