%This file plots the scission time tcut in logarithmic scale

hold on

set(0,'defaulttextinterpreter','latex')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultAxesFontName', 'CMU Serif')
%A1 = readtable('.//bud_time_vs_K1.txt');
A1 = readtable('./H0=0.15/tcut_and_rbud_vs_K1.txt');


K1=A1.K1;
tcut=A1.tcut;
X1=log(K1);
Y1=log(tneck1);


loglog(X1, Y1, 'rh', 'MarkerFaceColor', 'r','MarkerSize',14);

 p1 = polyfit(X1,Y1,1) ;
 m=p1(1);
 
 
 y_est1 = polyval(p1,X1);
 plot(X1,m*X1+p1(2),'r--','LineWidth',2)


L(1) = plot(nan, nan, 'rh','MarkerFaceColor', 'r','MarkerSize',14);

set(L(1),'LineWidth',5.0);

legend(L, { 'H_0=0.1'},'Location','northwest')

 xlabel('$log(K_1)$','fontsize',30)
 ylabel('$log(t_{cut})$','fontsize',30)
 set(gca,'fontsize',20)
