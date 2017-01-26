function [x,f,g,t,k,k_bl,counter]=Quasi_Newton_P(x0,u,fun,gfun,nvar,ncstr,neq,indf,indg,indgradf,indgradg,nprob,data,idata,iutil,rutil)

    %Dados Iniciais:
    k = 0;
    k_bl = 0;
    x = x0;
    t = 1;

    idata(12) = 1;
    H = eye(nvar);

    counter(1) = 0;
    counter(2) = 0;
    counter(3) = 0;
    counter(4) = 0;


    %fprintf('********************************************************************************************************\n');
    %fprintf('  iter iter_bl      t      counter(1) counter(2) counter(3) counter(4)      norm(d)           f         \n');
    %fprintf('********************************************************************************************************\n');

    %Calculo do gradiente:

    [gradf, gradg] = gfun_penalidade(x,u,fun,gfun,ncstr,neq,indf,indg,indgradf,indgradg,nprob,iutil,rutil);
    counter(1) = counter(1)+1;
    counter(2) = counter(2)+1;

    %Busca Linear:

    while (norm(gradf)>data(2) && k<idata(7) )
        d = -H*gradf;
        if isnan(d)
            break;
        end

        %if(idata(12)==0)            
        %    [t,iter,counter] = secao_aurea(x,fun,d,nprob,data,idata,iutil,rutil,counter); 
        %else%(idata(12)==1)
            [t,iter,counter] = armijo_p(x,u,fun,gfun,ncstr,neq,indf,indg,indgradf,indgradg,d,nprob,data,idata,iutil,rutil,counter);
        %end
        k_bl = k_bl + iter;

        xn = x+t*d;
        for i = 1:length(xn)
            if xn(i) < 1e+10
                xn(i) = 0;
            end
        end

        [gradfxn, gradgxn] = gfun_penalidade(xn,u,fun,gfun,ncstr,neq,indf,indg,indgradf,indgradg,nprob,iutil,rutil);
        counter(1) = counter(1)+1;
        counter(2) = counter(2)+1;
        
        delta = xn - x;
        gamma = gradfxn-gradf;

        H = H - (delta*gamma'*H + H*gamma*delta')/(delta'*gamma) + ...
            (1+(gamma'*H*gamma)/(delta'*gamma))*((delta*delta')/(delta'*gamma));

        [f,g] = fun_penalidade(x,u,fun,gfun,ncstr,neq,indf,indg,indgradf,indgradg,nprob,iutil,rutil);
        counter(1) = counter(1)+1;

        %fprintf('>|%3i |%6i | %9.4g | %8i | %8i | %8d | %8d | %13.5e | %13.5e |\n',k,iter,t,counter(1),counter(2),counter(3),counter(4),norm(d),f);
        
        gradf = gradfxn;

        x = xn;

        k = k + 1;
        
    end     