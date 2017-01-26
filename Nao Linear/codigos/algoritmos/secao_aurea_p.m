function [t,iter,counter]=secao_aurea_p(x,u,fun,gfun,ncstr,neq,indf,indg,indgradf,indgradg,d,nprob,data,idata,iutil,rutil,counter)
    %Dados iniciais:

    a = 0;
    b = 1;
    k = 1;
    alfa = (sqrt(5)-1)/2;
    data(2) = 1.0e-3;

    r = b-alfa*(b-a);
    s = a+alfa*(b-a);

    indf = 1;
    indg = 0;
    
    [fr,gr] = fun_penalidade((x+r*d),u,fun,gfun,ncstr,neq,indf,indg,indgradf,indgradg,nprob,iutil,rutil);
    counter(1) = counter(1)+1;
    [fs,gs] = fun_penalidade((x+s*d),u,fun,gfun,ncstr,neq,indf,indg,indgradf,indgradg,nprob,iutil,rutil);
    counter(1) = counter(1)+1;
    
    while (b-a)>data(2)
        k = k+1;

        if (fr<fs)
            b = s;
            s = r;
            fs = fr;
            r = b-alfa*(b-a);
            [fr,gr] = fun_penalidade((x+r*d),u,fun,gfun,ncstr,neq,indf,indg,indgradf,indgradg,nprob,iutil,rutil);
            counter(1) = counter(1)+1;
        else
            a = r;
            r = s;
            fr = fs;
            s = a+alfa*(b-a);
            [fs,gs] = fun_penalidade((x+s*d),u,fun,gfun,ncstr,neq,indf,indg,indgradf,indgradg,nprob,iutil,rutil);
            counter(1) = counter(1)+1;
        end
    end

    t = (a+b)/2;

    iter = k;