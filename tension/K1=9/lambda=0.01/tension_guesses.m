%This files computes the solution of the shape equations for a
%non-vanishing surface tension.
clear all
close all
global a epsilon  x1 sigma2 a_0 C_0_ lambda_

            %%%%%% Parameters of the model %%%%%%%%%%%%%%%%%%
            
            K2_=45.0; %constant protein detachment
            K1_=9.0; %constant protein recruitment, K1=K2/5
            H_0=0.15; %threshold of the membrane curvature that triggers protein recruitment
            sigma_eq=0.2; %equilibrium protein density, defined as sigma_eq = K1/K2
            C_0=0.1; %spontaneous curvature of the protein in nanometers
            L=1/(sigma_eq*C_0); %length scale of the system
            B=20; %bending moment in units of kbT
            ap=27; %area of one protein in nm^2
            C_0_=C_0*L; % adimensional spontaneous curvature
            Lambda_ =(ap*B)/L^2; %adimensional protein mobility
            mu=C_0_*Lambda_;
            lambda_=0.01; %adimensional surface tension
            
            %%%%%%%%%%% Numerical parameters to solve the shape equations
            %%%%%%%%%%% and the diffuso-kinetic equation
            
            a=50.0; %lenght of the spatial dimension (arclength)
            c1=1.0; %initial guess of the free parameter in the system of differential equations
            dt=6.3e-4*2; %time interval
            t=0;
            t_steps=2000; %number of time steps
            n_space=4000; %number of points in the spatial dimension
            epsilon=1E-3; %small parameter used to regularize the boundary conditions of the shape equations
            x1=linspace(epsilon,a,n_space); %uniform spatial mesh
            ds=x1(2)-x1(1); 
            F1=dt/ds^2; %numerical parameter of the evolution equation for the protein density
            F2=dt/ds; %numerical parameter of the evolution equation for the protein density
            
            %%%%%%%%% Parameters of the initial protein density %%%%%%%%
       
            a_0=0.1; %amplitude of the initial gaussian density
            sigma2=0.3; %widht of the gaussian function
            
            %Find the solution of the shape equations for the initual
            %protein density 
            solinit = bvpinit(x1,@mat6init,c1);
            options = bvpset('RelTol',1e-5,'AbsTol',1e-5,'Nmax',5000);
            sol = bvp4c(@ACodefun,@ACbcfun,solinit,options);
            
           
            for j=1:100  %Increase the surface tension
                lambda_=0.01*j;
                sol1 = bvp4c(@ACodefun,@ACbcfun,sol,options); %find the solution for a given surface tension
                solf = deval(sol1,x1);
                
                phi=solf(1,:); %tangent angle
                r=solf(2,:); %radial distance
                A=solf(3,:); %membrane area
                z=solf(4,:); %membrane height
                M=solf(5,:); %bending moment
                U=solf(6,:); %function associated to the tension
                T=U.*cos(phi); %tension
                Q=-U.*sin(phi); %transverse shear
              
                %Save the solutions 
                save(sprintf('./tension_guesses/guess_%d.txt',j)','x1', 'phi','r','A','z','M', 'Q','T', 'U','-ascii')
                %Upadate the initial solution
                sol=sol1;
                
            end 
        

