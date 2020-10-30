   function rhs = odefun7_ev(x,y, par)
   global  C_0_  alphat area
   
   %This file contains the differential equations satisfied by the angle
   %phi, the radial distance, the area, the height, the bending moment and
   %the function U associated to the membrane tension.

    [dummy index] = min(abs(y(3)-area)); 
  
     alpha_init=alphat(index); %protein density at the points specified by the membrane area

   C=C_0_*alpha_init; %spontaneous curvature
   
   phi=y(1); 
   r=y(2); 
   %A=y(3); 
   %z=y(4); 
   M=y(5); 
   U=y(6);
  
   eq1=2*M-sin(phi)/r+2*C; %Eq. for the angle phi
   eq2=cos(phi); %Eq. for the radial distance
   eq3=2*pi*r; %Eq, for the membrane area
   eq4=sin(phi); %Eq. for the height
   eq5=U*sin(phi); %Eq. for the bending moment
   eq6=M/r*(2*M-2*sin(phi)/r+2*C); %Eq. for the function U
   
   rhs=[eq1
        eq2
        eq3
        eq4
        eq5
        eq6];

       