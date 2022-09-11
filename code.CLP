(deftemplate space
	(slot name)
	(slot state)
	
)

(deftemplate platform
	(slot name)
	(slot space)
	(slot state)
)

(deftemplate car
	(slot id)
	(slot state)
)
(deffacts spaces
	(space (name S1) (state P))
	(space (name S2) (state EMPTY))
	(space (name S3) (state P))
	(space (name S4) (state P))
	(space (name S5) (state P))
	(space (name S6) (state P))
)

(deffacts platforms
	(platform (name P1) (space S1) (state EMPTY))
	(platform (name P2) (space S3) (state EMPTY))
	(platform (name P3) (space S4) (state EMPTY))
	(platform (name P4) (space S5) (state EMPTY))
	(platform (name P5) (space S6) (state EMPTY))
)

(deffacts cars
	(car (id ZXN1533) (state WAITING))
	(car (id ZXN1523) (state WAITING))
	(car (id ZXN1543) (state WAITING))
	(car (id ZXN1553) (state WAITING))
	(car (id ZXN1583) (state WAITING))
)
)
(deffacts east_spaces
	(east S1 S2)
	(east S2 S3)
	(east S4 S5)
	(east S5 S6)
)

(deffacts north_spaces

	(north S1 S4)
	(north S2 S5)
	(north S3 S6)
)

(defrule enter_car
	(declare(salience 20))
	?s <- (platform (name ?plat) (space S2) (state EMPTY))
	?cn <- (car (id ?t) (state WAITING))
=>
	(printout t crlf "CAR ENTERING")
	(modify ?s (state NOT_EMPTY))
	(modify ?cn (state PARKED))

)

(defrule is_goal
	(declare(salience 0))
	(not (car (state WAITING)))
=>
	(printout t crlf "GOAL REACHED")
	(halt)
)
	

(defrule move_east
	(declare(salience 0))
	?s1 <- (space (name ?sx) (state ?sy))
	(east ?sx ?s2x)	
	?s2<-  (space (name ?s2x) (state EMPTY))
	?p1<-  (platform (name ?sd) (space ?sx) (state ?st))
			
=>
	(modify ?s1 (state EMPTY))
	(modify ?s2 (state ?sy))
	(modify ?p1 (space ?s2x))
)

(defrule move_west
	(declare(salience 0))
	?s1 <- (space (name ?sx) (state ?sy))
	(east ?s2x ?sx)	
	?s2<-  (space (name ?s2x) (state EMPTY))
	?p1<-  (platform (name ?sd) (space ?sx) (state ?st))

	
=>
	(modify ?s1 (state EMPTY))
	(modify ?s2 (state ?sy))
	(modify ?p1 (space ?s2x))
)



(defrule move_north
	(declare(salience 0))
	
	?s1 <- (space (name ?sx) (state ?sy))
	(north ?sx ?s2x)	
	?s2<-  (space (name ?s2x) (state EMPTY))
	?p1<-  (platform (name ?sd) (space ?sx) (state ?st))

=>
	(modify ?s1 (state EMPTY))
	(modify ?s2 (state ?sy))
	(modify ?p1 (space ?s2x))
)


(defrule move_south
	(declare(salience 0))
	
	?s1 <- (space (name ?sx) (state ?sy))
	(north ?s2x ?sx)	
	?s2<-  (space (name ?s2x) (state EMPTY))
	?p1<-  (platform (name ?sd) (space ?sx) (state ?st))
	
=>
	(modify ?s1 (state EMPTY))
	(modify ?s2 (state ?sy))
	(modify ?p1 (space ?s2x))
)
