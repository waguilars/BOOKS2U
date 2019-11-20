;DEFTEMPLATE
(deftemplate nodo
	(slot nombre)
	(slot tipo)
	(slot pregunta)
	(slot nodo-si)
	(slot nodo-no)
	(slot respuesta)
)
(deftemplate nodo-pregunta-respuesta
  (slot tipo)
  (slot valor)
)
;DEFFACTS   20 
(deffacts hechos-iniciales
;preguntas
(nodo (nombre nodo-0) (tipo decision) (pregunta "Lees con mucha frecuencia(si/no)?: ") (nodo-si nodo-19) (nodo-no nodo-28))
(nodo (nombre nodo-19) (tipo decision) (pregunta "Te gusta la literatura moderna(si/no)?: ") (nodo-si nodo-20) (nodo-no nodo-28))
(nodo (nombre nodo-20) (tipo decision) (pregunta "Te gusta la fantasia(si/no)?: ") (nodo-si nodo-1) (nodo-no nodo-22))
(nodo (nombre nodo-22) (tipo decision) (pregunta "Te gusta la realista(si/no)?: ") (nodo-si nodo-6) (nodo-no nodo-27))
(nodo (nombre nodo-27) (tipo decision) (pregunta "Te gusta el terror(si/no)?: ") (nodo-si nodo-10) (nodo-no nodo-7))
(nodo (nombre nodo-21) (tipo decision) (pregunta "Te gusta el drama (si/no)?: ") (nodo-si nodo-23) (nodo-no nodo-24))
(nodo (nombre nodo-23) (tipo decision) (pregunta "Te gusta la mente humana(si/no)?: ") (nodo-si nodo-2) (nodo-no nodo-25))
(nodo (nombre nodo-25) (tipo decision) (pregunta "Te gusta la sociedad (si/no)?: ") (nodo-si nodo-8) (nodo-no nodo-9))
(nodo (nombre nodo-24) (tipo decision) (pregunta "Te gusta la filosofia(si/no)?: ") (nodo-si nodo-3) (nodo-no nodo-26))
(nodo (nombre nodo-26) (tipo decision) (pregunta "Te gusta el romaticismo(si/no)?: ") (nodo-si nodo-4) (nodo-no nodo-5))

; parte 2 del arbol
(nodo (nombre nodo-28) (tipo decision) (pregunta "Te gustan las lecturas cortas(si/no)?: ") (nodo-si nodo-29) (nodo-no nodo-30))
(nodo (nombre nodo-29) (tipo decision) (pregunta "Te gusta la poesia(si/no)?: ") (nodo-si nodo-11) (nodo-no nodo-31))
(nodo (nombre nodo-30) (tipo decision) (pregunta "Te gustan los comic(si/no)?: ") (nodo-si nodo-14) (nodo-no nodo-32))
(nodo (nombre nodo-31) (tipo decision) (pregunta "Te gustan las leyendas(si/no)?: ") (nodo-si nodo-12) (nodo-no nodo-13))
(nodo (nombre nodo-32) (tipo decision) (pregunta "Te gustan los mangas(si/no)?: ") (nodo-si nodo-15) (nodo-no nodo-16))

; Libros
(nodo (nombre nodo-1) (tipo respuesta) (respuesta "Harry Potter"))
(nodo (nombre nodo-2) (tipo respuesta) (respuesta "Metamorfosis  de franz kafka"))
(nodo (nombre nodo-3) (tipo respuesta) (respuesta "Desayuno con Socrates  de Robet Rowland"))
(nodo (nombre nodo-4) (tipo respuesta) (respuesta "Antes de ti  Jojo Moyes"))
(nodo (nombre nodo-5) (tipo respuesta) (respuesta "El naturalista de  Andrew Mayne"))
(nodo (nombre nodo-6) (tipo respuesta) (respuesta "Pideme lo que quieras de Megan Maxwell"))
(nodo (nombre nodo-7) (tipo respuesta) (respuesta "Mi perfecto sapo azul de  Silvia Ganrcia Ruiz "))
(nodo (nombre nodo-8) (tipo respuesta) (respuesta "ensayo sobre la ceguera  franz kafka "))
(nodo (nombre nodo-9) (tipo respuesta) (respuesta "La cupula de Stephen King "))
(nodo (nombre nodo-10) (tipo respuesta) (respuesta "It   de  Stephen King"))


(nodo (nombre nodo-11) (tipo respuesta) (respuesta "Poemas de amor de Pablo Neruda"))
(nodo (nombre nodo-12) (tipo respuesta) (respuesta "Mitos y  de mundo de Jose Salvador Chavez "))
(nodo (nombre nodo-13) (tipo respuesta) (respuesta "La culpa es de la vaca Jaime Lopez"))
(nodo (nombre nodo-14) (tipo respuesta) (respuesta "Batman  de Frank Miller"))
(nodo (nombre nodo-15) (tipo respuesta) (respuesta "Shingeki No Kyojin de Hajime Isayama"))
(nodo (nombre nodo-16) (tipo respuesta) (respuesta "Pinocho de  Carlo Collodi"))

(nodo-actual nodo-0)
(estado pregunta)
(nodo-pregunta-respuesta)
)


;DEFRULES
(defrule pregunta-en-nodo-decision
?n <- (nodo-actual ?nombre)
	?e <- (estado pregunta)
	(nodo (nombre ?nombre)(tipo ?tipo)(pregunta ?pregunta)(respuesta ?respuesta))
	?p <- (nodo-pregunta-respuesta )
=>
	(retract ?e)
	(retract ?p)
	(if(eq ?tipo decision)then
       (assert (nodo-pregunta-respuesta (tipo ?tipo)(valor ?pregunta)))
	else
	(assert (nodo-pregunta-respuesta (tipo ?tipo)(valor ?respuesta)))
	)
)


(defrule procesa-si-en-nodo-decision
	?n <- (nodo-actual ?nombre)
	?o <- (opcion si)
	(nodo (nombre ?nombre)(tipo decision)(nodo-si ?n-si))
         =>
	(retract ?n)
	(retract ?o)
	(assert (nodo-actual ?n-si))
	(assert (estado pregunta))
)

(defrule procesa-no-en-nodo-decision
  	?n <- (nodo-actual ?nombre)
	?o <- (opcion no)
	(nodo (nombre ?nombre)(tipo decision)(nodo-no ?n-no))
        =>
	(retract ?n)
	(retract ?o)
	(assert (nodo-actual ?n-no)) 
	(assert (estado pregunta))
)
  

(defrule pregunta-de-nuevo
	?n <- (nodo-actual ?nombre)
	?o <- (opcion ?opcion)
	(nodo (nombre ?nombre)(tipo respuesta))
	?p <- (nodo-pregunta-respuesta )
=>
	(retract ?n)
	(retract ?p)
	(if(eq ?opcion si)then
		(assert (nodo-actual nodo-0))
		(assert (estado pregunta))
		(assert (nodo-pregunta-respuesta))
	else
		(assert (nodo-pregunta-respuesta (tipo salir)))
	)
	(retract ?o)
)