
%programado por Marcelo de Franca Cordeiro em 04/2001
%    PROBLEMA TESTE No.1 - EXTENDED ROSENBROCK FUNCTION
%   

clear all;
format long;

fprintf(1,'\n **** PROBLEMA TESTE No.1 - EXTENDED ROSENBROCK FUNCTION *** \n\n') 
nvar= input('> digite o número de variáveis (qualquer número positivo mútiplo de 2): ') ;    % numero de variaveis
ncstr=0;   % Nr. of Constraints, excluded box contraints
neq=0;     % Nr. of Equality Constraints
neqlin=0;  % Nr. of Linear Equality Constraints
nprob=01;  % Nr. of the problem to be solved, required when
           % there are several problems in one file.
%
% x0 -> ponto inicial
%
a0 = [ -1.2 1 ] ;
j = 0 ;
for i = 1 : nvar ,  
   j = j + 1 ;
   x0(i) = a0(j) ;
   if j == length(a0) , j = 0 ;
   end
end

x0 = x0(:);

disp('> resultado esperado : ')
xR = ones(1,length(x0))
pause


vlb = zeros(1,nvar) ;       % Lower Bound value in Box Constraints
vub = 999 .* ones(1,nvar);  % Upper Bound value in Box Constraints
 
lvlb=zeros(1,nvar) ;
lvub=zeros(1,nvar) ;

% lvlb(i)=1 if there is a Lower Bound on x(i).
% lvlb(i)=0 if there is NOT a Lower Bound on x(i). Then,
%           vlb(i) is not taken in consideration.


% lvub(i)=1 if there is an Upper Bound on x(i).
% lvub(i)=0 if there is NOT an Upper Bound on x(i). Then,
%           vub(i) is not taken in consideration.

fun='fun01';   % File with the MATLAB function that computes
               % the Objective and the Constraints.

gfun='gfun01'; % File with the MATLAB function that computes
               % the Objective and the Constraints DERIVATIVES.

iutil=[nvar]; % Integer utility vector, if needed by fun & gfun.
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