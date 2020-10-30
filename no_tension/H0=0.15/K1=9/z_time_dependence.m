clear all
close all

%This file find the maximal membrane height as a function of time, up to
%the scission time tcut

dt=6.3e-4*2;
A = readtable('../tcut_and_rbud_vs_K1.txt');
tcut=A.tcut; %scission time

t_max=round(tcut(1)/dt);

t=zeros(t_max);
zmax=zeros(t_max);

        
for n=1
     filename = sprintf('./K1=9/min7_%d.txt',n) ;
    
      delimiterIn = ' ';

      A = importdata(filename,delimiterIn);
      z=A(6,:); %membrane height
      t(n)=n*dt; %time
      zmax(n)=max(z);
     
         
 
end 
  
t_=t(:,1);
zmax_=zmax(:,1);
T = table(t_,zmax_,'VariableNames', { 't','zmax'} );
writetable(T, './zmax_vs_t.txt')
 
 


