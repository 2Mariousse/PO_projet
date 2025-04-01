(define (problem calendrier_f1)
    (:domain f1)

    (:objects
        melbourne sepang shanghai sakhir yas_marina
        ; barcelone monaco montreal spielberg silverstone budapest
        ; spa monza singapour suzuka sotchi austin mexico sao_paulo yas_marina - circuit
        
        oceanie asie europe amerique_nord amerique_sud - continent
        
        weekend1 weekend2 weekend3 weekend4 weekend5 -weekend
        ; weekend6 weekend7 weekend8
        ; weekend9 weekend10 weekend11 weekend12 weekend13 weekend14 weekend15 weekend16
        ; weekend17 weekend18 weekend19 weekend20 weekend21 weekend22 weekend23 weekend24
        ; weekend25 weekend26 weekend27 weekend28 weekend29 weekend30 weekend31 weekend32
        ; weekend33 weekend34 weekend35 weekend36 weekend37 weekend38 - weekend
    )

    (:init
        ; Définition des continents
        (situe_sur melbourne oceanie)
        (situe_sur sepang asie)
        (situe_sur shanghai asie)
        (situe_sur sakhir asie)
        ; (situe_sur barcelone europe)
        ; (situe_sur monaco europe)
        ; (situe_sur montreal amerique_nord)
        ; (situe_sur spielberg europe)
        ; (situe_sur silverstone europe)
        ; (situe_sur budapest europe)
        ; (situe_sur spa europe)
        ; (situe_sur monza europe)
        ; (situe_sur singapour asie)
        ; (situe_sur suzuka asie)
        ; (situe_sur sotchi europe)
        ; (situe_sur austin amerique_nord)
        ; (situe_sur mexico amerique_nord)
        ; (situe_sur sao_paulo amerique_sud)
        (situe_sur yas_marina asie)

        (not (course_realisee yas_marina))
        (not (course_realisee melbourne))
        (not (course_realisee sakhir))
        (not (course_realisee sepang))
        (not (course_realisee shanghai))
        (not (weekend_occupe weekend1))
        (not (weekend_occupe weekend2))
        (not (weekend_occupe weekend3))

        ; Définition des week-ends successifs
        (precede weekend1 weekend2)
        (precede weekend2 weekend3)
        (precede weekend3 weekend4)
        (precede weekend4 weekend5)
        ; (precede weekend5 weekend6)
        ; (precede weekend6 weekend7)
        ; (precede weekend7 weekend8)
        ; (precede weekend8 weekend9)
        ; (precede weekend9 weekend10)
        ; (precede weekend10 weekend11)
        ; (precede weekend11 weekend12)
        ; (precede weekend12 weekend13)
        ; (precede weekend13 weekend14)
        ; (precede weekend14 weekend15)
        ; (precede weekend15 weekend16)
        ; (precede weekend16 weekend17)
        ; (precede weekend17 weekend18)
        ; (precede weekend18 weekend19)
        ; (precede weekend19 weekend20)
        ; (precede weekend20 weekend21)
        ; (precede weekend21 weekend22)
        ; (precede weekend22 weekend23)
        ; (precede weekend23 weekend24)
        ; (precede weekend24 weekend25)
        ; (precede weekend25 weekend26)
        ; (precede weekend26 weekend27)
        ; (precede weekend27 weekend28)
        ; (precede weekend28 weekend29)
        ; (precede weekend29 weekend30)
        ; (precede weekend30 weekend31)
        ; (precede weekend31 weekend32)
        ; (precede weekend32 weekend33)
        ; (precede weekend33 weekend34)
        ; (precede weekend34 weekend35)
        ; (precede weekend35 weekend36)
        ; (precede weekend36 weekend37)
        ; (precede weekend37 weekend38)

        (course_planifie melbourne weekend1)
        (course_planifie yas_marina weekend3)
        ; (course_planifie yas_marina weekend38)
    )


    (:goal (and
        ; Chaque circuit doit être planifié une et une seule fois
    (forall (?c - circuit)
        (exists (?w - weekend)
            (course_planifie ?c ?w)
        )
    )
    (forall (?c - circuit) 
        (course_realisee ?c)
    )
    ; Contraintes de changement de continent (au moins un week-end de repos)
    (forall (?c1 - circuit ?c2 - circuit ?w1 - weekend ?w2 - weekend)
        (imply (and (changement_continent ?c1 ?c2) (precede ?w1 ?w2))
               (not (and (course_planifie ?c1 ?w1) (course_planifie ?c2 ?w2))))
    )
    ))
)
