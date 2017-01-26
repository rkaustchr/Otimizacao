%
%     Test Problem Nr. 05 - Schittkowski et al.
%

clear all;
format long;

nvar=4;    % Nr. of Variables
ncstr=0;   % Nr. of Constraints, excluded box contraints
neq=0;     % Nr. of Equality Constraints
neqlin=0;  % Nr. of Linear 


%Constraints
nprob=05;  % Nr. of the problem to be solved, required when
           % there are several problems in one file.

x0 = [-3 -1 -3 -1]'; % Initial Point
vlb = [-999 -999 -999 -999];        % Lower Bound value in Box Constraints
vub = [999 999 999 999];  % Upper Bound value in Box Constraints
 
lvlb=[0 0 0 0];
lvub=[0 0 0 0];

disp('> resultado esperado : ')
xR = ones(1,length(x0))

pause


% lvlb(i)=1 if there is a Lower Bound on x(i).
% lvlb(i)=0 if there is NOT a Lower Bound on x(i). Then,
%           vlb(i) is not taken in consideration.


% lvub(i)=1 if there is an Upper Bound on x(i).
% lvub(i)=0 if there is NOT an Upper Bound on x(i). Then,
%           vub(i) is not taken in consideration.

fun='fun05';   % File with the MATLAB function that computes
               % the Objective and the Constraints.

gfun='gfun05'; % File with the MATLAB function that computes
               % the Objective and the Constraints DERIVATIVES.

iutil=[]; % Integer utility vector, if needed by fun & gfun.
rutil=[]; % Real utility vector, if needed by fun & gfun.

[data,idata]=fdata; % CONTROL PARAMETERS

%[x,f,g,t,counter] = Steepest_Descent(x0,fun,gfun,nvar,nprob,data,idata,iutil,rutil)
[x,f,g,t,counter] = Quasi_Newton(x0,fun,gfun,nvar,nprob,data,idata,iutil,rutil)
%[x,f,g,k,counter] = Penalidade(x0,fun,gfun,nvar,ncstr,neq,nprob,data,idata,iutil,rutil)


% COMPUTED OPTIMUM:
%
% x ------- Variables
% f ------- Objective Function
% g ------- Constraints
% lambda0 - Lagrange Multipliers of Inequality Constraints.
% mu0 ----- Lagrange Multipliers of Equality Constraints

%
% counter(1)=number of evaluations of the objective function
% counter(2)=number of evaluations of the objective function's derivatives
% counter(3)=number of constraints evaluations (each const. counted)
% counter(4)=number of evaluations of the constraints' derivatives
% (each const. counted)