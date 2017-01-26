function [t,iter,counter]=armijo_p(x,u,fun,gfun,ncstr,neq,indf,indg,indgradf,indgradg,d,nprob,data,idata,iutil,rutil,counter)
    t = 1;
    k = 1;
    eta1 = 0.1;
    nu = data(18); %0.8

    [f,g] = fun_penalidade(x,u,fun,gfun,ncstr,neq,indf,indg,indgradf,indgradg,nprob,iutil,rutil);
    counter(1) = counter(1)+1;

    [gradf,gradg] = gfun_penalidade(x,u,fun,gfun,ncstr,neq,indf,indg,indgradf,indgradg,nprob,iutil,rutil);
    counter(1) = counter(1)+1;
    counter(2) = counter(2)+1;

    parada = 0;

    while (parada==0 && k < idata(7))

        [m,g] = fun_penalidade((x+t*d),u,fun,gfun,ncstr,neq,indf,indg,indgradf,indgradg,nprob,iutil,rutil);
        counter(1) = counter(1)+1;

        if m <= f+eta1*t*d'*gradf
           parada = 1;
        else    
           t = t*nu;
           k = k+1;
        end
        
    end
    iter = k;