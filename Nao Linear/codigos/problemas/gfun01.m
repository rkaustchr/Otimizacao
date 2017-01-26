function[df,dg]=gfun01(fun,x,indgradf,indgradg,nprob,iutil,rutil)

%programado por Marcelo de Franca Cordeiro em 04/2001
%
%  size(dg)= (nvar,ncstr)
%
%  indgradf=0 - df is not computed ( df=[])
%  indgradf=1 - df is computed
%
%  indgradg(i)=0 - dg(:,i) is not computed
%  indgradg(i)=1 - dg(:,i) is computed
%
%  length(indgradg)= ncstr
%
%  if indgradg(i)=0 for i=1:ncstr, take dg=zeros(nvar,0)

df=[]; dg=zeros(iutil(1),0);

if indgradf == 1
   for i = 1 : iutil(1)/2,
      df(2*i-1) = 2 * 10 * ( x(2*i) - x(2*i-1)^2 ) * (-20) * x(2*i-1) + 2 * ( 1 - x(2*i-1) ) * (-1) ;
      df(2*i) = 2 * 10 * ( x(2*i) - x(2*i-1)^2 ) * 10  ;
   end
end

df=df(:);
