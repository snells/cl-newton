(in-package :cl-newton)

(use-package :cl-newton-ffi)


(defcallback apply-force :void
    ((body :pointer)
     (step :float)
     (index :int))
  (declare (ignore step index))
  (with-many-alloc ((force :float 4)
		    (mass :float)
		    (x :float)
		    (y :float)
		    (z :float))
    (newton-body-get-mass-matrix body mass x y z)
    (setf (c-aref force 0 :float) 0.0)
    (setf (c-aref force 1 :float) (* -9.8 (c-aref mass 0 :float)))
    (setf (c-aref force 2 :float) 0.0)
    (setf (c-aref force 3 :float) 1.0)
    (newton-body-set-force body force)))

(defun main ()
  (let* ((world (newton-create))
; newton functions take float parameters 
	 (collision (newton-create-box world 10.0 10.0 10.0 0 (cffi:make-pointer 0)))
	 (initial-tm (alloc :float 16))
	 (body))

; cffi foreign-alloc should set memory values to 0 but for some I got non-zero value
; when referencing freshly allocated array
; so I set the array values to 0 just in case
    (dotimes (x 16)
      (setf (c-aref initial-tm x :float) 0.0))
    
    (setf (c-aref initial-tm 0 :float) 1.0)
    (setf (c-aref initial-tm 5 :float) 1.0)
    (setf (c-aref initial-tm 10 :float) 1.0)
    (setf (c-aref initial-tm 15 :float) 1.0)
    
    (setf body (newton-create-dynamic-body world collision initial-tm))

    (newton-body-set-force-and-torque-callback body (callback 'apply-force))
    (newton-body-set-mass-matrix body 10.0 1.0 1.0 1.0)

    (dotimes (x 100)
      (newton-update world (coerce (/ 1 60) 'single-float))
      (with-alloc (tm :float 16)
	(newton-body-get-matrix body tm)
	(format t "~a, position = ~a, ~a, ~a~%" x
		(c-aref tm 12 :float)
		(c-aref tm 13 :float)
		(c-aref tm 14 :float))))

    (newton-destroy-all-bodies world)
    (newton-destroy world)))
