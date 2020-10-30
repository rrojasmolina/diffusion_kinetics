clear all
close all
hold on

%This files computes the scaled shapes, useful to see that after rescaling
%all the shapes looks the same, independently of the value of H0 and K1
dt=6.3e-4*2;

set(0,'defaulttextinterpreter','latex')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultAxesFontName', 'CMU Serif')

filename1 = sprintf('./H0=0.15/scaled.txt') ;
delimiterIn = ' ';

 A1 = importdata(filename1,delimiterIn);
 
%H0=0.1
 r11=A1(1,:);
 z11=A1(2,:); 
 
 
graph11=plot(r11,z11,'k',...
      -r11,z11,'k')
set(graph11,'LineWidth',2);
hold on

set(gca,'fontsize',18)
axis([-7.0 7.0 0 10])
axis off
daspect([1 1 1])


hold off

