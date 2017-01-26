function [x,f,g,k,lambda0,mu0,counter] = Fdipa(x0,fun,gfun,vlb,vub,nvar,ncstr,neq,lvlb,lvub,nprob,data,idata,iutil,rutil)
    nvar = length(x0);
    idata(12) = 1;
  
    indf = 1;
    indg = ones(1,ncstr);
    indgradf = 1;
    indgradg = ones(1,ncstr);
    
    counter(1) = 0;
    counter(2) = 0;
    counter(3) = 0;
    counter(4) = 0;

    fprintf('********************************************************************************************************\n');
    fprintf('  iter iter_bl      t      norm(d)           f     norm(gfx)    \n');
    fprintf('********************************************************************************************************\n');
    
    [fx0,gx0] = feval(fun,x0,indf,indg,nprob,iutil,rutil);
    counter(1) = counter(1)+1;
    
    [gfx0,ggx0] = feval(gfun,fun,x0,indgradf,indgradg,nprob,iutil,rutil);
    counter(2) = counter(2)+1;
    
    %Dados Iniciais:
    k = 0;
    ksi = 0.7;
    mi = 0.5;
    phi = 0.5;

    fx = fx0;
    gx = gx0;
    gfx = gfx0;
    ggx = ggx0;
    
    h = gx(1:neq);
    gh = ggx(:,1:neq);
    
    g = gx(neq+1:end);
    gg = ggx(:,neq+1:end);
    
    B = eye(nvar);
    
    ineq = ncstr-neq;
    lambda = ones(ineq,1);
    r = ones(neq, 1);
    x = x0;
    
    d = ones(size(x));
    while ( norm(d) > data(2))      
        L = diag(lambda);
        G = diag(g);
        
        % Calculo de d_alfa e lambda_alfa [ Sistema 1 ]
        A = [  B     gg      gh; ...
             L*gg'    G     zeros(ineq,size(gh,2)); ...
             gh' zeros(neq,ineq) zeros(neq,size(gh,2)) ];
         
        b = [ -gfx; ...
             zeros(size(lambda)); ...
               -h ];
         
        x_sol = A\b;
        
        d_alfa = x_sol(1:nvar);
        lambda_alfa = x_sol(nvar+1:nvar+ineq);
        mu_alfa = x_sol(nvar+ineq+1:end);
        
        % Otimo
        if d_alfa == zeros(size(d_alfa))
            break;
        end
        
        % Calculo de d_beta e lambda_beta [ Sistema 2 ]
        A = [  B         gg              gh;    ...
              L*gg'      G         zeros(ineq,size(gh,2));  ...
              gh'  zeros(neq,ineq) zeros(neq,size(gh,2))];
        b = [ zeros(size(x0)); ...
             -lambda; ...
             zeros(size(h))];
        
        x_sol = A\b;
        
        d_beta = x_sol(1:nvar);
        lambda_beta = x_sol(nvar+1:nvar+ineq);
        mu_beta = x_sol(nvar+ineq+1:end);
        
        for i=1:length(mu_alfa)
            r(i) = abs(mu_alfa(i)) + 0.1;
        end
        
        if neq > 0
            gfun_phi = gfx + r'*(sign(h)*gh);
        else
            gfun_phi = gfx;
        end
            
        % rho
        if d_beta'*gfun_phi > 0
            rho = min( phi*(norm(d_alfa)^2), (ksi-1)*(d_alfa'*gfun_phi/(d_beta'*gfun_phi)) );
        else
            rho = phi*(norm(d_alfa)^2);
        end
        
        % Direcao de busca
        d = d_alfa + rho*d_beta;
        lambda_barra = lambda_alfa + rho*lambda_beta;  %% lambda || lambda_barra ??
        
        % Busca linear
        [t, iter, counter_bl, fx, gfx] = armijo_fdipa(x,fun,gfun,gfx,counter,d,indf,indg,indgradf,indgradg,nprob,data,idata,iutil,rutil,neq,ncstr,r,lambda_barra);
        counter = counter + counter_bl;
        
        x = x + t*d;
        
        [fx, gx] = feval(fun,x,indf,indg,nprob,iutil,rutil);
        counter(1) = counter(1)+1;
        
        [gfx,ggx] = feval(gfun,fun,x,indgradf,indgradg,nprob,iutil,rutil);
        counter(2) = counter(2)+1;
        
        h = gx(1:neq);
        gh = ggx(:,1:neq);
        
        g = gx(neq+1:end);
        gg = ggx(:,neq+1:end);
                
        % saida da iteracao
        fprintf(' %d     %d    %.8f    %.8f    %.3f   %.8f \n', k,   iter,   t,    norm(d),  fx, norm(gfx) );
        
        
        % Atualizacao do lambda
        for i=1:length(lambda)
            lambda(i) = max(lambda_alfa(i), mi*norm(d_alfa)^2);
        end
        
        
        % atualizacao do B
        %mu = mu0;
        %for j=1:length(g)
        %    lambda(j) = -inv(g(j));
        %end
        
        %delta = x1-x;
        %gamma = ( gfx1+gh1*mu+gg1*lambda ) - ( gfx+gh*mu+gg*lambda ); %gamma = gfx-gfx0; 
        
        %if (delta' * gama) < (0.2*delta'*B*delta)
        %    phi = (0.8*delta'*B*delta) / (delta'*B*delta - delta'*gama);
        %    gama = phi*gama + (1-phi)*B*delta;
        %end
        
        
        %%B = B + ( (gama*gama') / (gama'*delta) ) - ( (B*delta*delta'*B) / (delta'*B*delta) );
       
        %B = B - (delta*gamma'*B + B*gamma*delta')/(delta'*gamma) + ...
        %    (1+(gamma'*B*gamma)/(delta'*gamma))*((delta*delta')/(delta'*ga
        %    mma));
        
        k = k+1;
    end
    
    f = fx;
    lambda0 = lambda;
    mu0 = 0;
    
    