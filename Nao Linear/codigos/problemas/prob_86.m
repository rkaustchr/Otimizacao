%gsf
%     problema teste 86 de schittkowski
%
clear all;
format long;

nvar=5;    %nvar
ncstr=10;    %ncstr
neq=0;    %neq 
neqlin=0;    %neqlin
x0= [.1 .1 .1 .1 1]'; %Feasible
%x0= [.1 .1 .1 .1 .1]';

vlb = zeros(1,5);
vub = [999 999 999 999 999]; 
lvlb=[1 1 1 1 1];
lvub=[0 0 0 0 0];


iutil=[];rutil=[];nprob=86;



[data,idata] = fdata;  % CONTROL PARAMETERS                       
data(5)=-32.347;
idata(1)=2

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
                        


fun='fun86';           % File with the Matlab function that computers
                       % the Objetctive and the Constraints.    


gfun='gfun86';         % File with the Matlab function that computers
                       % the Objetctive and the Constraints DERIVATIVES.

%[x,f,g,k,counter] = Penalidade(x0,fun,gfun,nvar,ncstr,neq,nprob,data,idata,iutil,rutil)
%[x,f,g,k,lambda0,mu0,counter] = Fdipa(x0,fun,gfun,vlb,vub,nvar,ncstr,neq,lvlb,lvub,nprob,data,idata,iutil,rutil)
[x,f,g,k,lambda0,mu0,counter] = Fdipa2(x0,fun,gfun,vlb,vub,nvar,ncstr,neq,lvlb,lvub,nprob,data,idata,iutil,rutil)
 
%ger_table(nprob,nvar,ncstr,counter,f);