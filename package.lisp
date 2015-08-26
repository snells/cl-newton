;;;; package.lisp

(push :cl-newton *features*)

(defpackage #:cl-newton
  (:use #:cl #:autowrap #:plus-c))

(defpackage #:cl-newton-ffi)

(defpackage #:cl-newton-ffi-acc)
(defpackage #:cl-newton-ffi-fn)


(in-package :cl-newton)
(cffi:define-foreign-library newton-lib
  (:unix "libNewton.so"))
(cffi:use-foreign-library newton-lib)
