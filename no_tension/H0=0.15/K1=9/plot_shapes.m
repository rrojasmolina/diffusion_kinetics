clear all
close all

%This file plots the membrane shapes

for j=[1] %time step
    
   filename1 = sprintf('./K1=9/min7_%d.txt',j) ; 
   delimiterIn = ' ';
   A1 = importdata(filename1,delimiterIn);
    
    r1=A1(4,:); %radial distance
    z1=A1(6,:); %height
     
    
   graph1=plot(r1,-z1+max(z1),'k',...
      -r1,-z1+max(z1),'k')
   set(graph1,'LineWidth',3.5);

  
    axis([-5.0 5.0 0.0 8.0])
    set(gca,'fontsize',18)
    daspect([1 1 1])
    xlabel('r')
    ylabel('z')
    title('Shape', 'FontSize',18)
    hold on
end 


hold off