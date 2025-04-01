(define (problem pursuit-instance-medium-10)
  (:domain pursuit-evasion)
  (:objects 
    n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 - node
    pursuer1 pursuer2 pursuer3 pursuer4 - pursuer
  )

  (:init
    ;; Graph structure (edges)
    (edge n1 n2) (edge n2 n1)
    (edge n2 n3) (edge n3 n2)
    (edge n3 n4) (edge n4 n3)
    (edge n4 n5) (edge n5 n4)
    (edge n5 n6) (edge n6 n5)
    (edge n6 n7) (edge n7 n6)
    (edge n7 n8) (edge n8 n7)
    (edge n8 n9) (edge n9 n8)
    (edge n9 n10) (edge n10 n9)
    (edge n1 n6) (edge n6 n1)
    (edge n2 n7) (edge n7 n2)
    (edge n3 n8) (edge n8 n3)
    (edge n4 n9) (edge n9 n4)
    (edge n5 n10) (edge n10 n5)
    (edge n2 n4) (edge n4 n2)
    (edge n3 n5) (edge n5 n3)

    ;; Initial pursuers' positions
    (at pursuer1 n3)
    (at pursuer2 n7)
    (at pursuer3 n7)
    (at pursuer4 n3)

    ;; Initial security status
    (visited n3)
    (secure n3)
    (visited n7)
    (secure n7)
    (clear)
  )

  (:goal (and
    (secure n1)
    (secure n2)
    (secure n3)
    (secure n4)
    (secure n5)
    (secure n6)
    (secure n7)
    (secure n8)
    (secure n9)
    (secure n10)
  ))
)
