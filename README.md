# cl-newton
cl-autowrap generated bindings for [newton-dynamics](https://github.com/MADEAPPS/newton-dynamics)


### Currently does not work   
The bindings work but the example does not.   
It worked with newton-dynamics 2.36.   
I have tested that the example works in C with newton-dynamics-3 if you change NewtonCreateBody to NewtonCreateDynamicBody.   
I have tried the example in Common Lisp with newton-dynamics-3 with handmade bindings and auto generated but they get stuck, not sure why.




Spec files build with newton-3-X
All the functions are in package :cl-newton-ffi    
[c example](http://newtondynamics.com/wiki/index.php5?title=Super_simple_quick-start_with_48_lines_of_C_example) of example.lisp
