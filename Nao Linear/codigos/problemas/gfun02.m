function[df,dg]=gfun02(fun,x,indgradf,indgradg,nprob,iutil,rutil)


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
   for i = 1 : iutil(1)/4
      df(4*i-3) = 2 *( x(4*i-3)  + 10 * x(4*i-2) )  + 40 * ( x(4*i-3) - x(4*i) )^3  ;
      df(4*i-2) = 20 * ( x(4*i-3)  + 10 * x(4*i-2) ) + 4 * ( x(4*i-2) - 2 * x(4*i-1) )^3 ;
      df(4*i-1) =  10 * ( x(4*i-1) - x(4*i) ) - 8 * ( x(4*i-2) - 2 * x(4*i-1) )^3 ;
      df(4*i)   = - 10 * ( x(4*i-1) - x(4*i) ) - 40 * ( x(4*i-3) - x(4*i) )^3;
   end
end

df=df(:);
