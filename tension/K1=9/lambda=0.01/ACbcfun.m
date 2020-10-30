    %This file contains the bpundary condition corresponding to the shape
    %equation for the initial protein density (Gaussian function)

    function res = ACbcfun(ya,yb,par) 
    global   epsilon C_0_ sigma2 a_0 lambda_
    c1=par(1); %Fitting parameter in boundary conditions
    
   A_init=a_0*exp(-1.0/(2*sigma2^2)*(epsilon).^2); %Initial protein density (Gaussian) as s=epsilon
   T_f=lambda_; %far field tension
   
   
   C=C_0_*A_init; %spontaneous curvature
   
    BC1=ya(1)-c1*epsilon; %BC fot the angle phi, phi(s=epsilon)
    BC2=ya(2)-epsilon; %BC for the radial distance r(s=epsilon)
    BC3=ya(3)-pi*epsilon^2; %BC for the membrane area A(s=epsilon)
    BC4=ya(4)-(1/2)*c1*epsilon^2; %BC for the height z(s=epsilon)
    BC5=ya(5)-(c1-C); %BC for the bending moment M(s=epsilon)
    BC6= yb(6)-T_f; %BC for the function U, U(s=smax)
    BC7=yb(1); %BC for the angle phi, phi(s=smax)
    
    BC=[BC1
         BC2
         BC3
         BC4
         BC5    
         BC6
         BC7];
   res = BC; 
     
%     