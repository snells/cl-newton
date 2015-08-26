(cl:in-package :cl-newton-ffi)

(cl:setf autowrap:*c2ffi-program* "/ss/prog/lisp/cl-newton/c2ffi")
(autowrap:c-include
 '(cl-newton autowrap-spec "Newton.h")
 ;"Newton.h"
 :spec-path '(cl-newton autowrap-spec)
					;"/ss/prog/lisp/cl-newton/spec/"
		    :accessor-package :cl-newton-ffi
		    :function-package :cl-newton-ffi
		    :exclude-sources ("/usr/local/lib/clang/([^/]*)/include/(?!stddef.h)"
				      ;"/usr/include/"
				      "/usr/include/arm-linux-gnueabihf")
		    :include-sources ("stdint.h"
				      "bits/types.h"
				      "sys/types.h")
		    :release-p cl:t)
