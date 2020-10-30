
%This file find the maximal membrane height as a function of time
clear all
close all

t_max=1;
dt=6.3e-4*2; %time interval

t=zeros(t_max);
zmax=zeros(t_max);

        
for n=1:t_max
     filename = sprintf('./lambda=0.01/min7_%d.txt',n) ;
    
      delimiterIn = ' ';

      A = importdata(filename,delimiterIn);
      z=A(6,:);
      
      x=A(1,:);
      t(n)=n*dt;
      zmax(n)=max(z);
     
         
 
end 
 
 
    
     t_=t(:,1);
     zmax_=zmax(:,1);
     T = table(t_,zmax_,'VariableNames', { 't','zmax'} );
 
     writetable(T, './zmax_vs_t.txt')
 
 


