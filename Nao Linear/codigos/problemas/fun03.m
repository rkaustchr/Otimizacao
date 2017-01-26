
function[f,g]=fun03(x,indf,indg,nprob,iutil,rutil)

%programado por Marcelo de Franca Cordeiro em 04/2001
%  fun32 - computes f and g 
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

% n é qualquer positivo múltiplo de 2

f=[];g=[];

if indf==1
   f = 0 ;
   for i = 1 : iutil(1)  ,
      soma = 0 ;
      for j = 1 : iutil(1) ,
          soma = soma + ( cos(x(j)) + i * ( 1 - cos(x(i)) ) - sin(x(i)) ) ;
      end
            
      f = f + ( iutil(1) - soma )^2 ;
   end
end