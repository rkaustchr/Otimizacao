function [t,iter,counter]=armijo(x,fun,gfun,indgradf,indgradg,d,nprob,data,idata,iutil,rutil,counter)
    t = 1;
    k = 1;
    eta1 = 0.1;
    nu = data(18); %0.8

    indf = 1;
    indg = [];
    indgradf = 1;
    indgradg = [];

    [f,g] = feval(fun,x,indf,indg,nprob,iutil,rutil);
    counter(1) = counter(1)+1;

    [gradf,gradg] = feval(gfun,fun,x,indgradf,indgradg,nprob,iutil,rutil);
    counter(2) = counter(2)+1;

    parada = 0;

    while ( parada==0 ) %k<idata(7) &&

        [m,g] = feval(fun,(x+t*d),indf,indg,nprob,iutil,rutil);
        counter(1) = counter(1)+1;

        if m <= f+eta1*t*d'*gradf
           parada = 1;
        else    
           t = t * nu;
           k = k+1;
        end
    end
    iter = k;