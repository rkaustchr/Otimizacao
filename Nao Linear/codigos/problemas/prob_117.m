clear all;
format long;

nvar=15;    %nvar
ncstr=5;    %ncstr
neq=0;    %neq 
neqlin=0;    %neqlin
%x0 = ...
%   [ 1.421522450580931e-06 ...
%    1.500875684856549e-06 ...
%     1.500875684856549e-06 ...
%     5.769046208969431e+00 ...
%     1.308304733101134e-06 ...
%     2.997931425696970e+00 ...
%     1.301445659173457e+01 ...
%     1.416518726931646e-06 ...
%     1.416695543474014e-06 ...
%     3.971782388129234e-01 ...
%     1.406802083819606e-06 ...
%     2.557334253087452e-01 ...
%     3.344646984374198e-01 ...
%     3.423945670453323e-01 ...
%     4.722736084356656e-01 ...
%     2.446712540662354e-01 ]
                            
x0=0.001*[1 1 1 1 1 1 60000 1 1 1 1 1 1 1 1]';
!x0=0.001*[1 1 1 1 1 1 10000 1 1 1 1 1 1 1 1]';


vlb = [0   0   0   0   0   0   0   0   0   0   0   0   0   0   0  ];
vub = [999 999 999 999 999 999 999 999 999 999 999 999 999 999 999]; 
lvlb= [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
lvub= [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

iutil=[];rutil=[];nprob=117;



[data,idata] = fdata;  % CONTROL PARAMETERS                       
data(5)=32.349;
idata(1)=2;
idata(4)=0
                          
                       % COMPUTED OPTIMUM:

                       %

                       % x1, x2, x3, etc  ------- Variables

                       %

                       % sf --------------------- Objective Function

                       %

                       % sg1, sg2, sg3, ets ----- Constraints

                       %

                       % lambda0 ----- Lagrange Multipliers of Inequality Constraints.

                       %

                       % mu0 --------- Lagrange Multipliers of Equality Constraints



                       % counter(1) = number of evaluations of the objective function
                       % counter(2) = number of evaluations of the objective function's derivatives
                       % counter(3) = number of constraints evaluations (each const. counted)
                       % counter(4) = number of evaluations of the constraints' derivatives                    
            % (each const. counted)                                       
                        


fun='fun117';           % File with the Matlab function that computers
                       % the Objetctive and the Constraints.    


gfun='gfun117';         % File with the Matlab function that computers
                       % the Objetctive and the Constraints DERIVATIVES.

%[x,f,g,k,counter] = Penalidade(x0,fun,gfun,nvar,ncstr,neq,nprob,data,idata,iutil,rutil)
%[x,f,g,k,lambda0,mu0,counter] = Fdipa(x0,fun,gfun,vlb,vub,nvar,ncstr,neq,lvlb,lvub,nprob,data,idata,iutil,rutil)
[x,f,g,k,lambda0,mu0,counter] = Fdipa2(x0,fun,gfun,vlb,vub,nvar,ncstr,neq,lvlb,lvub,nprob,data,idata,iutil,rutil)

%ger_table(nprob,nvar,ncstr,counter,f); 