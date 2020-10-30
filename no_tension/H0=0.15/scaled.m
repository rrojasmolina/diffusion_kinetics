clear all
close all
hold on

%This files stores the rescaled variables r and z that allow to find the
%membrane shape. The rescaling is performed with the r_est=1/(C0*sigma_av)
%computed in the file r_est_vs_K1.m

dt=6.3e-4*2;

set(0,'defaulttextinterpreter','latex')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultAxesFontName', 'CMU Serif')

A = readtable('./tcut_and_rbud_vs_K1.txt'); %find the scission time
A_est = readtable('./r_est_vs_K1.txt'); %reads the estimated bud radius
tcut=A.tcut; %scission time
rest=A_est.r_est; %estimated bud radius
K1=A.K1; %kinetic parameter


 filename1 = sprintf('./K1=9/K1=9/min7_%d.txt',round(tcut(1)/dt)) ;
 
 delimiterIn = ' ';
 
 A1 = importdata(filename1,delimiterIn);


 r1=A1(4,:);
 z1=A1(6,:); 


rr1=r1/rest(1);
zz1=(-z1+max(z1))/rest(1);
 

 save(sprintf('./scaled.txt')','rr1', 'zz1','-ascii')
 

