
%This files finds the scission time tcut and the bud radius at tcut for the
%different values of K1

%Initialize the variables
tcut=zeros(1);
K1=zeros(1);

%Add as many files for different values of K2 as needed
A1 = readtable('./K1=9/r_and_neck_vs_t.txt');

neck1=A1.neck;
rmax1=A1.rmax;
t1=A1.t;

%find the time at which the membrane neck equals the membrane thickness,
%which is approx. 5nm, or 0.1 in dimensionless units
[dummy index1] = min(abs(neck1-0.1)); 
tcut(1)=t1(index1); %scission time
rbud(1)=rmax1(index1); %maximal radius at the scission time
K1(1)=20/5; %value of K1

%Convert the data into columns
tcut_=tcut(:,1);
rbud_=rbud(:,1);
K1_=K1(:,1);

T = table(K1_,tcut_, rbud_, 'VariableNames', {'K1','tcut','rbud'} );
  
 writetable(T, './tcut_and_rbud_vs_K1.txt')


