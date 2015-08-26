;;;; cl-newton.asd

(asdf:defsystem #:cl-newton
  :description "Describe cl-newton here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :depends-on (#:cl-autowrap
               #:cl-plus-c)
  :serial t
  :components
  ((:module autowrap-spec
	    :pathname "spec"
	    :components
	    ((:static-file "Newton.h")))
   (:file "package")
   (:file "autowrap")
   (:file "cl-newton")))

