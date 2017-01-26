function [x,f,g,t,counter]=Quasi_Newton(x0,fun,gfun,nvar,nprob,data,idata,iutil,rutil)

    %Dados Iniciais:

    k = 0;
    x = x0;
    t = 1;

    nvar = length(x);
    idata(12) = 1;
    H = eye(nvar);

    counter(1) = 0;
    counter(2) = 0;
    counter(3) = 0;
    counter(4) = 0;

    indf = 1;
    indg = 0;
    indgradf = 1;
    indgradg = 0;

    fprintf('********************************************************************************************************\n');
    fprintf('  iter iterb_l      t      counter(1) counter(2) counter(3) counter(4)      norm(d)           f         \n');
    fprintf('********************************************************************************************************\n');

    %Calculo do gradiente:

    [gradf,gradg] = feval(gfun,fun,x,indgradf,indgradg,nprob,iutil,rutil);
    counter(2) = counter(2)+1;

    %Busca Linear:

    while (norm(gradf)>data(2)&& k<idata(7))
        d = -H*gradf;

        if(idata(12)==0)            
            [t,iter,counter] = secao_aurea(x,fun,d,nprob,data,idata,iutil,rutil,counter); 
        else%(idata(12)==1)
            [t,iter,counter] = armijo(x,fun,gfun,indgradf,indgradg,d,nprob,data,idata,iutil,rutil,counter);
        end

        xn = x+t*d;

        [gradfxn,gradgxn] = feval(gfun,fun,xn,indgradf,indgradg,nprob,iutil,rutil);
        counter(2) = counter(2)+1;

        delta = xn - x;
        gamma = gradfxn-gradf;
       
        H = H - (delta*gamma'*H + H*gamma*delta')/(delta'*gamma) + ...
            (1+(gamma'*H*gamma)/(delta'*gamma))*((delta*delta')/(delta'*gamma));

        [f,g] = feval(fun,xn,indf,indg,nprob,iutil,rutil);
        counter(1) = counter(1)+1;

        if mod(k,10) == 0
            fprintf(' |%3i |%6i | %9.4g | %8i | %8i | %8d | %8d | %13.5e | %13.5e |\n',k,iter,t,counter(1),counter(2),counter(3),counter(4),norm(d),f);
        end
        
        gradf = gradfxn;

        x = xn;

        k = k + 1;
        
    end     