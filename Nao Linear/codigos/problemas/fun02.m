
function[f,g]=fun02(x,indf,indg,nprob,iutil,rutil)

%programado por Marcelo de Franca Cordeiro em 04/2001
%  fun02 - computes f and g 
% 
%  f is the objective function
%  g(ncstr) is a vector with the response contraints ordered as follows:
% 
%  g(1),...,g(neqlin)     - Linear equality constraints
%  g(neqlin+1),...,g(neq) - Nonlinear equality constraints
%  g(neq+1),...,g(ncstr)  - Inequality constraints (it does not
%                           include box constraints)
%
%  indf=0 - f is not computed ( Take f=[])
%  indf=1 - f is computed
%
%  indg(i)=0 - g(i) is not computed
%  indg(i)=1 - g(i) is computed
%
%  length(indg)= ncstr
%
%  if indg(i)=0 for i=1:ncstr, take g=[]
%
%
%  
%  iutil - Integer utility vector, employed to store data in
%                  probXX, funXX and gfunXX.
% 
%  rutil - Real utility vector, employed to 
%                  store data in probXX, funXX and gfunXX.
%

% n � qualquer positivo m�ltiplo de 2

f=[];g=[];

if indf==1
   f = 0 ;
   for i = 1 : iutil(1)/4 ,
      f = f + ( x(4*i-3)  + 10 * x(4*i-2) )^2 + ( 5 * ( x(4*i-1) - x(4*i) )^2 ) + ( x(4*i-2) - 2 * x(4*i-1) )^4 + ( 10 * ( x(4*i-3) - x(4*i))^4) ; 
   end
end