clear all
close all

%%%%This file plot a 3D shape at the scission time or at fractions of it.
%%%%Also allows to generate images to create videos, for example

dt=6.3e-4*2;
%tfinal=100; %Uncomment to generate several images inside a for loop

k=1; %time step

%for k=1:tfinal  %Uncomment to generate 3D images and save them

    filename1 = sprintf('./K1=9/min7_%d.txt',k) ;
    delimiterIn = ' ';
    A1 = importdata(filename1,delimiterIn);
    
    
    sigma1=A1(2,:); %protein density 
    r1=A1(4,:); %radial distance
    h1=A1(6,:); %height

    theta = 0:pi/20:2*pi;

    f = sigma1;
    ff=repmat(sigma1',1,length(theta));


    xx = bsxfun(@times,r1',cos(theta));
    yy = bsxfun(@times,r1',sin(theta));
    zz = repmat(-h1',1,length(theta));

     hold on
 
 
    s = surf(xx,yy,zz,ff);
    caxis([0.0 0.2]);
    
     lightangle(-45,30)
     s.FaceLighting = 'gouraud';
     s.AmbientStrength = 0.3;
     s.DiffuseStrength = 0.8;
     s.SpecularStrength = 0.9;
     s.SpecularExponent = 25;
     s.BackFaceLighting = 'unlit';

    set(s,'LineStyle','none')
    zoom(30)

    axis([-8.0 8.0 0.0 5.0]);
    daspect([1 1 1])
    view(90,0)
    axis equal
    axis off
    
   %Include a color bar     
   %c=colorbar('SouthOutside');
   %c.FontSize=20;
   %c.Label.Interpreter = 'latex';
   %c.Label.FontSize=25;
   %c.Label.String = '$\mathbf{\bar{\sigma}\left(s,t\right)}$';
   
   %Uncomment to create images in 3D and save them in a folder called video
   
   %filename = ['./video/bud' num2str(k)];
   %saveas(1, [filename '.png']);

    %close all
%end

 