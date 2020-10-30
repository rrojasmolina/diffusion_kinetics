   %This file contains the boundary condition corresponding to the shape
    %equations for the time-evolved protein density

   function res = bcfun7_ev(ya,yb,par) 
    global  epsilon C_0_ alphat lambda_
    c1=par(1);
    
   alpha_0=alphat(1); %protein density at s=epsilon
   T_f=lambda_; %far field tension
   C=C_0_*alpha_0; %spontaneous curvature
   
    BC1=ya(1)-c1*epsilon; %BC for the angle phi, phi(s=epsilon)
    BC2=ya(2)-epsilon; %BC for the radial distance, r(s=epsilon)
    BC3=ya(3)-pi*epsilon^2; %BC for the area, A(s=epsilon)
    BC4=ya(4)-(1/2)*c1*epsilon^2; %BC for the height, z(s=epsilon)
    BC5=ya(5)-(c1-C); %BC for the bending moment, M(s=epsilon)
    BC6= yb(6)-T_f; %BC for the function U, U(s=smax)
    BC7=yb(1); %BC for the angle phi, phi(s=smax)
    
    Tak=[BC1
         BC2
         BC3
         BC4
         BC5    
         BC6
         BC7];
   res = Tak; 
     