function [x,f,g,t,counter] = Steepest_Descent(x0,fun,gfun,nvar,nprob,data,idata,iutil,rutil)

    %Dados Iniciais:

    k=0;
    x=x0;
    idata(12)=1;

    counter(1)=0;
    counter(2)=0;
    counter(3)=0;
    counter(4)=0;

    fprintf('********************************************************************************************************\n');
    fprintf('  iter iterb_l      t      counter(1) counter(2) counter(3) counter(4)      norm(d)           f         \n');
    fprintf('********************************************************************************************************\n');

    %Calculo da direcao de busca:

    indf = 1;
    indg = 0;
    indgradf = 1;
    indgradg = zeros(2,1);
    

    [gradf,gradg] = feval(gfun,fun,x,indgradf,indgradg,nprob,iutil,rutil);
    counter(2) = counter(2)+1;

    d = -gradf;
    while (norm(d)>data(2) && k<idata(7))    
        
        if(idata(12)==0)
            [t,iter,counter] = secao_aurea(x,fun,d,nprob,data,idata,iutil,rutil,counter);
        else %(idata(12)==1)
            [t,iter,counter] = armijo(x,fun,gfun,indgradf,indgradg,d,nprob,data,idata,iutil,rutil,counter);               
        end

        x = x+t*d;

        [f,g] = feval(fun,x,indf,indg,nprob,iutil,rutil);
        counter(1) = counter(1)+1;

        if mod(k,1000) == 0
            fprintf(' |%3i |%6i | %9.4g | %8i | %8i | %8d | %8d | %13.5e | %13.5e |\n',k,iter,t,counter(1),counter(2),counter(3),counter(4),norm(d),f);
        end
        
        [gradf,gradg] = feval(gfun,fun,x,indgradf,indgradg,nprob,iutil,rutil);
        counter(2) = counter(2)+1;

        d = -gradf;

        k = k + 1;
    end
    
    fprintf(' |%3i |%6i | %9.4g | %8i | %8i | %8d | %8d | %13.5e | %13.5e |\n',k,iter,t,counter(1),counter(2),counter(3),counter(4),norm(d),f);