(define (problem pursuit-instance)
  (:domain pursuit-evasion)
  (:objects 
    n1 n2 n3 n4 n5 n6 - node
    pursuer1 pursuer2 - pursuer
  )
  
  (:init
    ;; Graph structure (edges)
    (edge n1 n2) (edge n2 n1)
    (edge n1 n3) (edge n3 n1)
    (edge n1 n4) (edge n4 n1)
    (edge n1 n6) (edge n6 n1)
    (edge n4 n5) (edge n5 n4)
    (edge n5 n6) (edge n6 n5)

    ;; Initial pursuers' positions
    (at pursuer1 n1)
    (at pursuer2 n1)

    ;; Initial security status
    (visited n1)
    (secure n1)
    (clear)
  )

  (:goal (and
    (secure n1)
    (secure n2)
    (secure n3)
    (secure n4)
    (secure n5)
    (secure n6)
  ))
)
