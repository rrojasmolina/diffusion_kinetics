hold on
%This files compares the bud radius obtained from the simulations and the
%estimated radius obtained from the spontaneous curvature C0 and the
%average protein density

set(0,'defaulttextinterpreter','latex')
set(0,'DefaultTextFontname', 'CMU Serif')
set(0,'DefaultAxesFontName', 'CMU Serif')
sz=200;


A1 = readtable('./H0=0.15/tcut_and_rbud_vs_K1.txt'); %bud radius

A1_ = readtable('./H0=0.15/r_est_vs_K1.txt'); %estimation of the bud radius


K1=A1.K1; %Kinetic parameter

r1=A1.rbud; %bud radius

r1_=A1_.r_est; %estimation of the bud radius r_est=1/(C0*sigma_av)

scatter(K1, r1./r1_,sz,'rh', 'MarkerFaceColor', 'r'); %numerical

axis([0 K1(end) 0.5 1.5]);

L(1) = plot(nan, nan, 'rh','MarkerSize',15,'MarkerFaceColor', 'r');

legend(L, { 'H_0=0.1'},'Location','northwest')

 xlabel('$K_1$','fontsize',22)
 ylabel('$(C_0 \bar{\sigma}_{av})r_{bud}$','fontsize',22)
 set(gca,'fontsize',22)
