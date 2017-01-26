function [x,f,g,k,counter] = Penalidade(x0,fun,gfun,nvar,ncstr,neq,nprob,data,idata,iutil,rutil)
    
    %Dados Iniciais:
    k = 0;
    x = x0;
    u = 1;
    beta = 2;


    %iutil = [ncstr length(x)];
    rutil = [];
    data(3) = 0.0001;
    idata(7) = 100;

    idata(12) = 1;

    counter(1) = 0;
    counter(2) = 0;
    counter(3) = 0;
    counter(4) = 0;

    indf = 1;
    indg = ones(ncstr,1);
    indgradf = 1;
    indgradg = ones(ncstr,1);

    fprintf('*************************************************************************************************************************\n');
    fprintf('  iter  iter_SUB  iter_BL     t       u     counter(1) counter(2) counter(3) counter(4)         f             gradf         \n');
    fprintf('*************************************************************************************************************************\n');

    f = Inf;
    fq = 0;

    while(norm(f-fq)>data(3) && k<idata(7))
        
        fq = f;
        
        [x,f,g,t,k_sub,k_bl,counter] = Quasi_Newton_P(x0,u,fun,gfun,nvar,ncstr,neq,indf,indg,indgradf,indgradg,nprob,data,idata,iutil,rutil);
  
        [f,g] = fun_penalidade(x,u,fun,gfun,ncstr,neq,indf,indg,indgradf,indgradg,nprob,iutil,rutil);
        counter(1) = counter(1)+1;
        
        [gradf, gradg] = gfun_penalidade(x,u,fun,gfun,ncstr,neq,indf,indg,indgradf,indgradg,nprob,iutil,rutil);
        counter(1) = counter(1)+1;
        counter(2) = counter(2)+1;

        u = u*beta;

        if mod(k,10) == 0
            fprintf(' | %3i | %6i | %6i | %6.4g | %6i | %8i | %8i | %8i | %8i | %13.5e | %13.5e | \n',k,k_sub,k_bl,t,u,counter(1),counter(2),counter(3),counter(4),f, norm(gradf) );
        end
        
        k = k+1;

    end