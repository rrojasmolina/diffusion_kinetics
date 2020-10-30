%This file creates an initial guess for the solver bvp4c based on the
%solution of the shape equations for a small but finite surface tension
function yinit = mat6init_tension(x)
global x1 A1

   [dummy index] = min(abs(x-x1));
   
  
    phi=A1(2,index);
    r=A1(3,index);
    A=A1(4,index);
    z=A1(5,index);
    M=A1(6,index);
    U=A1(9,index);
    
yinit = [phi  
        r
        A
        z
        M
        U];