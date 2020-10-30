clear all
close all
hold on

%This file generates a a 2D plot of the membrane shape colored according to
%the protein density

dt=6.3e-4*2; %time step


A = readtable('./tcut_and_rbud_vs_K1.txt');
tcut=A.tcut; %scission time
t_=tcut(1); 
k=round(t_/dt);

filename1 = sprintf('./K1=9/K1=9/min7_%d.txt',1) ;
 
 delimiterIn = ' ';
 A1 = importdata(filename1,delimiterIn);
 
 sigma1=A1(2,:); %protein density
 r1=A1(4,:); %radial distance
 s1=A1(1,:); %arc-length
 h1=A1(6,:);  %height
 
 
z1 = zeros(size(s1));

col1 = sigma1;  % This is the color, vary with s in this case.

colormap copper
caxis([0 0.2])

graph11=surface([r1;r1],[-h1+max(h1);-h1+max(h1)],[z1;z1],[col1;col1],...
        'facecol','no',...
        'edgecol','interp',...
        'linew',2);
graph12=    surface([-r1;-r1],[-h1+max(h1);-h1+max(h1)],[z1;z1],[col1;col1],...
        'facecol','no',...
        'edgecol','interp',...
        'linew',2);
    daspect([1 1 1])
    hold on
    
    
%Uncomment to include a color bar

%c= colorbar;
%c=colorbar('SouthOutside');
%c.FontSize=25;
%c.Label.Interpreter = 'latex';
%c.Label.FontSize=30;
%c.Label.String = '$\mathbf{\sigma\left(s,t\right)}$';

set(gca,'fontsize',18)
axis([-7.0 7.0 0 18])
axis off
set(graph11,'LineWidth',6);
set(graph12,'LineWidth',6);

%xlabel('$r$','FontSize',30)
%ylabel('$z$','FontSize',30)

%Uncomment to include a scale bar

%obj=scalebar;



hold off

