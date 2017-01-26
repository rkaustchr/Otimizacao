function[df,dg]=gfun03(fun,x,indgradf,indgradg,nprob,iutil,rutil)


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
   for k = 1 : iutil(1)
      deriv = 0 ;
      for i = 1 : iutil(1) ,
          soma = 0 ;
          dsoma = 0 ;
          for j = 1 : iutil(1)
              
            if (k == i  &  k == j) ,
                 dsoma = dsoma - sin(x(j)) + i * sin(x(i)) - cos(x(i)) ;
            elseif (k == i & k ~= j) ,
                 dsoma = dsoma + i * sin(x(i)) - cos(x(i));
            elseif (k ~= i & k == j),
                 dsoma = dsoma - sin(x(j));
            end
         
            soma = soma + ( cos(x(j)) + i * ( 1 - cos(x(i)) ) - sin(x(i)) ) ;    
         
          end       
         deriv = deriv + 2 * ( iutil(1) - soma ) * (-dsoma) ;
      end
      df(k) = deriv ;
   end
end

df=df(:);
