(define (domain pursuit-evasion)
  (:requirements :typing :strips :conditional-effects :universal-preconditions :existential-preconditions
                 :negative-preconditions :disjunctive-preconditions :equality :negative-preconditions)
  (:types node pursuer - object)
  
  (:predicates
    (at ?p - pursuer ?n - node)
    (edge ?n1 - node ?n2 - node)
    (visited ?n - node)
    (secure ?n - node)
    (pending-propagation ?origin - node ?target - node )
    (clear) ; Indicates that there are no pending propagations.
)
  
  ;; The move action allows a pursuer to move from one node to a connected node.
  (:action move
    :parameters (?p - pursuer ?from - node ?to - node)
    :precondition (and (at ?p ?from) (edge ?from ?to) (clear))
    :effect (and 
             (not (at ?p ?from))
             (at ?p ?to)
             (visited ?to)
             (secure ?to)
            ;; For every neighbor ?n of the original node ?from (except the node ?to),
            ;; if ?n is secure and there exists at least one neighbor that is not secure (where an invader could be),
            ;; then add a pending-propagation effect for ?n (that node will become unsecure except if there if a pursuer on it).

            
            (forall (?n - node)
                       (when (and (edge ?from ?n) (not (= ?n ?to)) (secure ?n) (exists (?m - node) (and (edge ?from ?m)  (not (= ?m ?to)) (not (secure ?m)))) (not (exists (?q - pursuer)(and (not (= ?p ?q))(at ?q ?from)))
             ))
                             (pending-propagation ?from ?n))
                   )

            (when  (and (exists (?n - node) (and (edge ?from ?n) (not (secure ?n))(not (= ?n ?to)))) (not (exists (?q - pursuer)(and (not (= ?p ?q))(at ?q ?from))
             )))
             (not (secure ?from)))
          
        ;; If there exists any neighbor of ?from (other than ?to) that is secure
        ;; and also exists one that is not secure, then remove the (clear) flag,
        ;; indicating that pending propagations now exist.
           (when (and (exists (?m - node) (and (edge ?from ?m) (secure ?m)(not (= ?m ?to)))) (exists (?n - node) (and (edge ?from ?n) (not (secure ?n))(not (= ?n ?to)))) (not (exists (?q - pursuer)(and (not (= ?p ?q))(at ?q ?from)))
             ))
             (not (clear)))
    ))
  
             
  
  ;; Propagate-insecurity action now is the only action that can be applied when a pending-propagation exists.
  ;; It handles the pending propagation effects.
  (:action propagate-insecurity
    :parameters (?origin - node ?current - node)
    :precondition (and (pending-propagation ?origin ?current))
    :effect (and 
             (not (pending-propagation ?origin ?current))
             ;; For every neighbor ?n of the current node ?current, if:
            ;; - ?n is not the origin,
            ;; - ?n is secure, and
            ;; - there is no pursuer at ?current,
            ;; then add a new pending-propagation from ?current to ?n.
            (forall (?n - node)
                        (when (and (edge ?current ?n) (not (= ?n ?origin)) (secure ?n) (not (exists (?p - pursuer)(at ?p ?current))
             ))
                            (pending-propagation ?current ?n)))

            ;; If there is no pursuer at the current node, then mark the current node as not secure.
            (when (not (exists (?p - pursuer)(at ?p ?current))
             ) (not (secure ?current)) )

             ;; If no pending propagation exists anywhere in the system after processing,
            ;; then set the (clear) flag, indicating that the system is free of pending propagations.
             (when (not (exists (?o - node ?t - node) (pending-propagation ?o ?t)))
      (clear))

            )
  )
)
