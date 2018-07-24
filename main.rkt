#lang racket

(require web-server/servlet
	 web-server/servlet-env)

(define (my-app req)
  (app-router req))

(define-values (app-router app-url)
  (dispatch-rules
   [("") #:method "get" app-get]
   [("") #:method "post" app-post]
   [("cat" (string-arg)) app-cat]
   [("cat" (string-arg) (string-arg)) app-cat2]
   [else app-get]
   ))

(define (app-cat req s )
  (let ([cur-str (string-append "You " s " the cat!")])
    (println cur-str)
    (response/xexpr
     `(html (body ,cur-str))
     )
  )
  )
  

(define (app-cat2 req s s2)
  (let ([cur-str (string-append "You " s " the cat a " s2 "!")])
    (println cur-str)
    (response/xexpr
     `(html (body ,cur-str))
     )
  )
  )

		      
(define (app-get req)
  (response/xexpr
   `(html (body "you got a cat thing"))
   )
   )

(define (form-parser want-binding binding-list)
  (match
   (bindings-assq want-binding binding-list)
   [(? binding:form? b) (cons (binding-id b) (binding:form-value b))]
   )
  )

(define (app-post req)
  (println "RAW DATA")
  (println (request-post-data/raw req))
  (println "FORM DATA")
  (let ([cur-bind (request-bindings/raw req)])
    (println (map (lambda (n) (form-parser n cur-bind)) '(#"name" #"color")))
    )
  
  (response/xexpr
   `(html (body "you posted to a cat thing"))
   )
  )

(serve/servlet my-app ; answers requests
	       #:servlet-path "" ;default url
	       #:port 8000
	       #:servlet-regexp #px"") ;decides what gets handled
