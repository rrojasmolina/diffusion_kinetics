%This file computes the protein density and membrane shape associated to a
%diffuso-kinetic protein dynamics on the membrane.

clear all
 close all
global a epsilon  x1 alphat sigma2 a_0 area C_0_ lambda_ 


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
            lambda_=0.0; %adimensional surface tension
            
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
           
            %%%%%Solving the shape equations with the initial protein
            %%%%%density using bvp4c
            
            solinit = bvpinit(x1,@mat6init,c1); 
            options = bvpset('RelTol',1e-5,'AbsTol',1e-5,'Nmax',5000);
            sol = bvp4c(@ACodefun,@ACbcfun,solinit,options);
            
            
            %Initial Gaussian distribution %%%%%%%%%%%%%%
            alpha1=a_0*exp(-1.0/(2*sigma2^2)*(x1).^2);
            
            %%%%%%Initialize the variables%%%%%%%%%%
            C=zeros(size(x1)); %spontaneous curvature
            H=zeros(size(x1)); %Mean curvature
            H2=zeros(size(x1)); %Mean curvature at the next time step
            alpha=zeros(size(x1)); %protein density at the next time step
            
            %Structures to solve the linear system for the evolution equation of the protein density
  
            A = zeros(size(x1,2), size(x1,2)); 
            b = zeros(size(x1));
  
          
            for l=1:t_steps
        
                solf = deval(sol,x1); %evaluate the solution in the unifom mesh x1
                
                phi=solf(1,:); %tangent angle
                r=solf(2,:); %radial distance
                area=solf(3,:); %membrane area
                z=solf(4,:); %membrane height
                M=solf(5,:); %bending moment
                U=solf(6,:); %function associated to the tension
                T=U.*cos(phi); %tension
                Q=-U.*sin(phi); %transverse shear
                
                
                
                H=M+C_0_*alpha1;   %mean curvature       
                K1=K1_.*heaviside(H-H_0); %curvature-dependent protein recruitment with a heaviside model. It can be changed.
                K2=K2_*ones(size(x1)); %uniform protein turnover
                
                %compute the matrix A, with zero flux condition at the
                %spatial boundaries and centered-scheme spatial
                %discretization, backward in time
                for m=1:size(x1,2) 
          
                    if m==1
                        A(m,m)=  1 + 2*F1 - 2*F2*mu*Q(m+1)+K2(m)*dt;
                        A(m,m+1)= -2*F1 - 2*F2*mu*Q(m);
            
                    elseif m==size(x1,2)
          
                        A(m,m)= 1 + 2*F1 + 2*F2*mu*Q(m-1)+ K2(m)*dt;
                        A(m,m-1)= -2*F1 +2*F2*mu*Q(m) ;
                    else
                        A(m,m)=1 + 0.5*F1*(r(m+1)+r(m))./(r(m)) + 0.5*F1*(r(m)+r(m-1))./(r(m))...
                            -(F2/4)*mu*(r(m+1)+r(m))*(Q(m+1)+Q(m))/r(m) + (F2/4)*mu*(r(m)+r(m-1))*(Q(m)+Q(m-1))/r(m)...
                             +dt*K2(m);
                        A(m,m+1)=-0.5*F1*(r(m+1)+r(m))./(r(m))   - (F2/4)*mu*(r(m+1)+r(m))*(Q(m+1)+Q(m))/r(m) ;
                        A(m,m-1)=-0.5*F1*(r(m)+r(m-1))./(r(m))   + (F2/4)*mu*(r(m)+r(m-1))*(Q(m)+Q(m-1))/r(m) ;
                    end    
                end   
       
                %compute the entries of the vector b in A * alpha=b
                for m=1:size(x1,2) 
                
                        b(m)=  alpha1(m) + K1(m)*dt;
                end
                
                bt=transpose(b);
                
                %Condition to stop if the matrix A becomes singular (very narrow membrane neck)
                if 1.0/cond(A)< 1.e-6
                    break
                end
                alpha = linsolve(A,bt);
         
                alphat=transpose(alpha);
         
                %Solve the shape equations with the new protein density
                sol2 = bvp4c(@odefun7_ev,@bcfun7_ev,sol,options);
                
                %Evaluate the new solution a the uniform mesh x1
                sol2f=deval(sol2,x1);
                phi2=sol2f(1,:);
                r2=sol2f(2,:);
                A2=sol2f(3,:);
                z2=sol2f(4,:);
                M2=sol2f(5,:);
                U2=sol2f(6,:);
                Q2=-U2.*sin(phi2);
                T2=U2.*cos(phi2);
         
          
                C(m)=C_0_*alphat(m); %spontaneous curvature  
                H2=M2+C; %mean curvature
                
                %Evolve in time
                t=t+dt;
                %Save the solutions in a folder called according to the
                %value of K2
                save(sprintf('./K1=9/min7_%d.txt',l)','x1', 'alphat', 'phi2','r2','A2','z2','M2', 'U2','T2', 'Q2','t','-ascii')
                
                %Update the initial protein density
                alpha1=alphat;
                
                %Update the initial solution
                sol=sol2; 
          
            end

