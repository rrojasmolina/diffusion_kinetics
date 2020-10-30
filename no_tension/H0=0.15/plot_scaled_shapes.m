clear all
close all
hold on

%This file plot the scaled shapes for different values of K1
dt=6.3e-4*2;

set(0,'defaulttextinterpreter','latex')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultAxesFontName', 'CMU Serif')

A = readtable('./tcut_and_rbud_vs_K1.txt');
A_est = readtable('./r_est_vs_K1.txt');
tcut=A.tcut; %scission time
r_est=A_est.r_est;

 
 filename1 = sprintf('./K1=9/K1=9/min7_%d.txt',1) ;
 delimiterIn = ' ';
 A1 = importdata(filename1,delimiterIn);
 
 
 r1=A1(4,:);
 z1=A1(6,:); 
 
z1_=(-z1+max(z1))/r_est(1);

%Uncoment to desplace in the z direction the shapes respect to one of them 
%d3=max(z1_)-max(z3_);
%d5=max(z1_)-max(z5_);

 
graph1=plot(r1/r_est(1),z1_,'r-.',...
      -r1/r_est(1),z1_,'r-.')
set(graph1,'LineWidth',3.5);
hold on
  

set(gca,'fontsize',18)
axis([-7.0 7.0 0 10])
axis off
daspect([1 1 1])

L(1) = plot(nan, nan, 'r-.');
set(L(1),'LineWidth',2.5);
legend(L, { 'K_1=9'},'Location','northwest')

hold off

