clear all
close all

%This file computes the bud radius and the membrane neck as function of
%time

t_max=1; %time step after which the membrane shapes becomes unphysical (check the shape plotting it with the plot_shape.m file)
dt=6.3e-4*2; %time step
r_neck=zeros(t_max); %neck radius
r_max=zeros(t_max); %maximal vesicle radius
t=zeros(t_max); %time at which the membrane starts to have a neck
s_neck=zeros(t_max); %position along the arc-length of the membrane neck
s_max=zeros(t_max); %position along the arc-length of the maximal vesicle radius


    for n=1
        
        filename = sprintf('./K1=9/min7_%d.txt',n);
        delimiterIn = ' ';

        A = importdata(filename,delimiterIn);
    
        r=A(4,:); %radial distance
        s=A(1,:); %arc-length
        
       fmax=islocalmax(r); %find the local maximum of radial distance (vesicle radius)
       fmin=islocalmin(r); %find the local minimum of radial distance (neck)
       
       rmax=r(fmax); %vesicle radius
       rneck=r(fmin); %membrane neck
          
       c=isempty(rneck);  %check if there neck is not formed (no local minimum of r)
        if c==1 %no neck is formed
            t(n)=0;
            r_max(n)=0;
            r_neck(n)=0;
            s_max(n)=0;
            s_neck(n)=0;
            
        elseif c==0  %the neck is formed (there is a local minimum of r)
             
             
             smax=s(fmax); %positions of all the maximum radii
             r_max(n)=rmax(1); %radius of the upper bud
             s_max(n)=smax(1); %position along s of the radius of the upper bud 
             
             sneck=s(fmin); % positions of all the necks
             r_neck(n)=rneck(1); %neck of the upper bud
             s_neck(n)=sneck(1); %position along s of the neck of the upper bud 
             
             t(n)=n*dt; %time
          
          
        end
    
    end

 %Eliminate all the values of neck radius and bud radius that are zero
 r_neck=r_neck(r_neck~=0); 
 r_max=r_max(r_max~=0); 
 t=t(t~=0);
 s_neck=s_neck(s_neck~=0); 
 s_max=s_max(s_max~=0); 
 
 %convert the data into columns
 neck_=r_neck(:,1);
 rmax_=r_max(:,1);
 t_=t(:,1);
 sneck=s_neck(:,1);
 smax=s_max(:,1);

 %Save the data      
 T = table(t_, neck_, rmax_, sneck, smax,'VariableNames', { 't', 'neck', 'rmax','s_neck','s_max'} );
 writetable(T, './r_and_neck_vs_t.txt')
