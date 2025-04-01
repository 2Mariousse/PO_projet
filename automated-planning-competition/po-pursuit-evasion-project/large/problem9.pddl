(define (problem pursuit-instance-large-25)
  (:domain pursuit-evasion)
  (:objects 
    n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 n11 n12 n13 n14 n15 n16 n17 n18 n19 n20 n21 n22 n23 n24 n25 - node
    pursuer1 pursuer2 pursuer3 pursuer4 pursuer5 pursuer6 - pursuer
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
    (edge n10 n11) (edge n11 n10)
    (edge n11 n12) (edge n12 n11)
    (edge n12 n13) (edge n13 n12)
    (edge n13 n14) (edge n14 n13)
    (edge n14 n15) (edge n15 n14)
    (edge n15 n16) (edge n16 n15)
    (edge n16 n17) (edge n17 n16)
    (edge n17 n18) (edge n18 n17)
    (edge n18 n19) (edge n19 n18)
    (edge n19 n20) (edge n20 n19)
    (edge n20 n21) (edge n21 n20)
    (edge n21 n22) (edge n22 n21)
    (edge n22 n23) (edge n23 n22)
    (edge n23 n24) (edge n24 n23)
    (edge n24 n25) (edge n25 n24)
    (edge n10 n15) (edge n15 n10)
    (edge n12 n20) (edge n20 n12)
    (edge n5 n25) (edge n25 n5)
    (edge n9 n17) (edge n17 n9)
    (edge n6 n19) (edge n19 n6)
    (edge n14 n21) (edge n21 n14)
    (edge n13 n18) (edge n18 n13)
    (edge n3 n22) (edge n22 n3)
    (edge n4 n11) (edge n11 n4)
    (edge n2 n8) (edge n8 n2)
    (edge n7 n23) (edge n23 n7)
    (edge n16 n24) (edge n24 n16)
    
    ;; Initial pursuers' positions
    (at pursuer1 n5)
    (at pursuer2 n5)
    (at pursuer3 n5)
    (at pursuer4 n5)
    (at pursuer5 n5)
    (at pursuer6 n5)

    ;; Initial security status
    (visited n5)
    (secure n5)
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
    (secure n11)
    (secure n12)
    (secure n13)
    (secure n14)
    (secure n15)
    (secure n16)
    (secure n17)
    (secure n18)
    (secure n19)
    (secure n20)
    (secure n21)
    (secure n22)
    (secure n23)
    (secure n24)
    (secure n25)
  ))
)