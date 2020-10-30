clear all
close all

%This files computes the estimated bud radius r_est based on the spontaneous
%curvature C0 and the average protein density in the bud region


C_0=5.0; %dimensionless spontaneous curvature


dt=6.3e-4*2;
A=readtable('./tcut_and_rbud_vs_K1.txt');


tcut=A.tcut; %scission time a function of K1
l1=round(tcut(1)/dt);
K1=A.K1; %recruitment parameter

r_est=zeros(size(tcut));

filename1 = sprintf('./K1=9/K1=9/min7_%d.txt',1) ;
delimiterIn = ' ';
A1 = importdata(filename1,delimiterIn);

s1=A1(1,:); %arc-length
sigma1=A1(2,:); %protein density
r1=A1(4,:); %radial distance
area1=A1(5,:); %membrane area


A_1=readtable('./K1=9/r_and_neck_vs_t.txt');
tneck1=A_1.t; %times associated to the formation of membrane neck
sneck1=A_1.s_neck; %location of the neck alog s
[dummy index1] = min(abs(tneck1-tcut(1)));
lim1=sneck1(index1); %limit of the bud region
[dummy index11] = min(abs(lim1-s1));
abud1=area1(index11); %area of the budded region, up to the neck 
int1=find(area1<abud1); %find the area smaller than the limit of the bud region
area_int1=area1(int1); %area interval comprised up to the neck
sigma_int1=sigma1(int1); %sigma defined on the bud only
sigmat1=trapz(area_int1,sigma_int1)/abud1; %integral of the protein density on the bud region
r_est(1)=1./(sigmat1*C_0); %estimated bud radius
    


T = table(r_est, K1,'VariableNames', { 'r_est', 'K1'} );
 
 writetable(T, './r_est_vs_K1.txt')
 






  
 


