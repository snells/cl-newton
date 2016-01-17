# cl-newton
cl-autowrap generated bindings for [newton-dynamics](https://github.com/MADEAPPS/newton-dynamics)


### Currently does not work   
The bindings work but the example does not.   
It worked with newton-dynamics 2.36.   
I have tried the example in Common Lisp with newton-dynamics-3 with handmade bindings and auto generated but they get stuck on second call to newton-update, not sure why.   





Spec files build with newton-dynamics-3-x
All the functions are in package :cl-newton-ffi    
[c example](http://newtondynamics.com/wiki/index.php5?title=Super_simple_quick-start_with_48_lines_of_C_example) of example.lisp





I modified the C example to work with newton-dynamics 3.   
You can compile it with   
gcc c-example.cpp -lNewton -lpthread
