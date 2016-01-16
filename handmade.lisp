(defcfun "NewtonWorldGetVersion" :int)

(defcfun "NewtonBodyGetMassMatrix" :void
  (body :pointer)
  (mass :pointer)
  (ixx  :pointer)
  (iyy  :pointer)
  (izz  :pointer))

(defcfun "NewtonBodySetForce" :void
  (body :pointer)
  (force :pointer))

(defcfun "NewtonCreate" :pointer)

(defcfun "NewtonCreateBox" :pointer
  (w :pointer)
  (x :float)
  (y :float)
  (z :float)
  (id :int)
  (offset :pointer))

(defcfun "NewtonCreateDynamicBody" :pointer
  (world :pointer)
  (collision :pointer)
  (initial-tm :pointer))

(defcfun "NewtonBodySetForceAndTorqueCallback" :void
  (body :pointer)
  (cb :pointer))

(defcfun "NewtonBodySetMassMatrix" :void
  (body :pointer)
  (mass :float)
  (x :float)
  (y :float)
  (z :float))

(defcfun "NewtonUpdate" :void
  (world :pointer)
  (delta :float))

(defcfun "NewtonBodyGetMatrix" :pointer
  (body :pointer)
  (tm :pointer))

(defcfun "NewtonDestroy" :void
  (world :pointer))




(defun alloc (type &optional c)
  (cffi:foreign-alloc type :count (if c c 1)))

(defcallback apply-force :void
    ((body :pointer)
     (step :float)
     (index :int))
  (declare (ignore step index))
  (let ((force (alloc :float 4))
	(mass (alloc :float))
	(x (alloc :float))
	(y (alloc :float))
	(z (alloc :float)))
    (newtonbodygetmassmatrix body mass x y z)
    (setf (mem-aref force :float 0) 0.0)
    (setf (mem-aref force :float 1) (* -9.8 (mem-aref mass :float)))
    (setf (mem-aref force :float 2) 0.0)
    (setf (mem-aref force :float 3) 1.0)
    (newtonbodysetforce body force)))

(defun main ()
  (let* ((world (newtoncreate))
; newton functions take float parameters 
	 (collision (newtoncreatebox world 10.0 10.0 10.0 0 (cffi:make-pointer 0)))
	 (initial-tm (alloc :float 16))
	 (body))

; cffi foreign-alloc should set memory values to 0 but for some I got non-zero value
; when referencing freshly allocated array
; so I set the array values to 0 just in case
    (dotimes (x 16)
    (setf (mem-aref initial-tm :float x  ) 0.0))
    (setf (mem-aref initial-tm :float 0  ) 1.0)
    (setf (mem-aref initial-tm :float 5  ) 1.0)
    (setf (mem-aref initial-tm :float 10 ) 1.0)
    (setf (mem-aref initial-tm :float 15 ) 1.0)
    
    (setf body (newtoncreatedynamicbody world collision initial-tm))

    (newtonbodysetforceandtorquecallback body (callback apply-force))
    (newtonbodysetmassmatrix body 10.0 1.0 1.0 1.0)

    (dotimes (x 100)
      (newtonupdate world (coerce (/ 1 60) 'single-float))
      (let ((tm (alloc :float 16)))
	(newtonbodygetmatrix body tm)
	(format t "~a, position = ~a, ~a, ~a~%" x
		(mem-aref tm :float 12)
		(mem-aref tm :float 13)
		(mem-aref tm :float 14))
	(foreign-free tm)))

    ;(newton-destroy-all-bodies world)
      (newtondestroy world)))
  
