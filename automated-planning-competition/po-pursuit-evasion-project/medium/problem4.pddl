(define (problem pursuit-instance)
  (:domain pursuit-evasion)
  (:objects 
    n1 n2 n3 n4 n5 n6 n7 n8 n9 - node
    pursuer1 pursuer2 pursuer3 - pursuer
  )
  
  (:init
    ;; Graph structure (edges)
    (edge n1 n2) (edge n2 n1)
    (edge n2 n3) (edge n3 n2)
    (edge n1 n3) (edge n3 n1)
    (edge n1 n4) (edge n4 n1)
    (edge n5 n4) (edge n4 n5)
    (edge n6 n5) (edge n5 n6)
    (edge n6 n4) (edge n4 n6)
    (edge n4 n7) (edge n7 n4)
    (edge n7 n9) (edge n9 n7)
    (edge n7 n8) (edge n8 n7)
    (edge n8 n9) (edge n9 n8)

    ;; Initial pursuers' positions
    (at pursuer1 n3)
    (at pursuer2 n5)
    (at pursuer3 n9)

    ;; Initial security status
    (visited n3)
    (secure n3)
    (visited n5)
    (secure n5)
    (visited n9)
    (secure n9)
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
  ))
)
