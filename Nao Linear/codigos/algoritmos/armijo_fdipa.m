function [t,iter,counter,fx,gfx] = armijo_fdipa(x,fun,gfun,gfx,counter,d,indf,indg,indgradf,indgradg,nprob,data,idata,iutil,rutil,neq,ncstr,r,lambda_barra)
    iter = 0;

    eta = data(15); % 0.5
    nu = data(18); % 0.8
    t = 1;
    
    [fx,q] = feval(fun,x,indf,indg,nprob,iutil,rutil);
    counter(1) = counter(1)+1;

    [gfx,gq] = feval(gfun,fun,x,indgradf,indgradg,nprob,iutil,rutil);
    counter(2) = counter(2)+1;

    h0 = q(1:neq);
    g0 = q(neq+1:end);
    gh0 = gq(:,1:neq);
    
    if neq > 0
        fun_phi = fx + r'*(sign(h0)*h0);
        gfun_phi = gfx + r'*(sign(h0)*gh0);
    else
        fun_phi = fx;
        gfun_phi = gfx;
    end
    
    %phi = fx + h0'*(r .* sign(h0));
    %gphi = gfx + gh0*(r .* sign(h0));
    
    %p01 = phi;
    %p02 = 0.3 * (gphi'*d);
    
    
    
    %phil = fx1+h' * (r .* sign(h));
    %condg = 1;
        
    parada = 0;
    while ( parada==0 )
        
        [ fx1, gx1 ] = feval(fun,x+t*d,indf,indg,nprob,iutil,rutil);
        counter(1) = counter(1)+1;
        h = gx1(1:neq);
        g = gx1(neq+1:end);
        
        if neq > 0
            fun_phi1 = fx1 + r'*(sign(h)*h);
        else
            fun_phi1 = fx1;
        end
        
        if fun_phi1 <= fun_phi + t*eta*gfun_phi'*d
            parada = 1;
        end
        
        if parada == 1
            for i = 1:length(lambda_barra)
                if lambda_barra(i) >= 0             
                    if g(i) >= 0
                        parada = 0;
                        break;
                    end
                else
                    if g(i) > g0(i)
                        parada = 0;
                        break;
                    end
                end
            end
        end
                
        
        if parada == 0
            t = t * nu;
        end
        
        if t <= 0.00005
            break;
        end
                
        iter = iter + 1;  
    end
