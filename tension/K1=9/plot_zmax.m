%This file plots zmax as a function of time

clear all
close all

hold on

sz=40;


set(0,'defaulttextinterpreter','latex')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultAxesFontName', 'CMU Serif')

A1 = readtable('./lambda=0.01/zmax_vs_t.txt');

t1=A1.t;
z1=A1.zmax;

graph1=scatter(t1(1:end,1),z1(1:end,1),sz, 'o','MarkerEdgeColor','r');
hold on

 set(gca,'fontsize',20)

 xlabel('$t$','FontSize',30)
 ylabel('$z_{max}$','FontSize',30)
 

[lgd, objh] = legend({'\lambda=0.01'}, 'location', 'NorthWest', 'Fontsize', 20);
%// set font size as desired
% note that even if you plot(x,y,'.') it's a "line" plot 
%objhl = findobj(objh, 'type', 'line'); %// objects of legend of type line
%set(objhl, 'Markersize', 500); %// set marker size as desired
% or for Patch plots 
objhl = findobj(objh, 'type', 'patch'); % objects of legend of type patch
set(objhl, 'Markersize', 12); % set marker size as desired
