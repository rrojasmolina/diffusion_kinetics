
%This files finds the budding time, defined as the find at which zmax in
%minimal. In general, surface tension avoids the formation of narrow necks,
%and it is not possible to define a scission time, as in the case when the
%surface tension is zero.
clear all
close all


bud_time=zeros(1);
lambda=zeros(1);

sz=40;


A1 = readtable('./lambda=0.01/zmax_vs_t.txt');


z_1=A1.zmax;
t_1=A1.t;


fmin=islocalmin(z_1); %find the point in time at which the membrane height is minimal
tmin1=t_1(fmin);
bud_time(1)=tmin1(1);
lambda(1)=0.01;

bud_time_=bud_time(:,1);
lambda_=lambda(:,1);


T = table(bud_time_, lambda_,'VariableNames', { 'bud_time', 'lambda'} );
 
 writetable(T, './bud_time_vs_lambda.txt')
 







  
 


