
function[f,g]=fun_penalidade(x,u,fun,gfun,ncstr,neq,indf,indg,indgradf,indgradg,nprob,iutil,rutil)

    %  fun_penalidade - Calcula a funcao potencial a ser utilizada pelo metodo de penalidade
    % 
    %  f is the objective function
    %  g(ncstr) is a vector with the response contraints ordered as follows:
    % 
    %  g(1),...,g(neqlin)     - Linear equality constraints
    %  g(neqlin+1),...,g(neq) - Nonlinear equality constraints
    %  g(neq+1),...,g(ncstr)  - Inequality constraints (it does not
    %                           include box constraints)
    %
    %  indf=0 - f is not computed ( Take f=[])
    %  indf=1 - f is computed
    %
    %  indg(i)=0 - g(i) is not computed
    %  indg(i)=1 - g(i) is computed
    %
    %  length(indg)= ncstr
    %
    %  if indg(i)=0 for i=1:ncstr, take g=[]
    %
    %
    %  
    %  iutil - Integer utility vector, employed to store data in
    %                  probXX, funXX and gfunXX.
    % 
    %  rutil - Real utility vector, employed to 
    %                  store data in probXX, funXX and gfunXX.
    %
         
    [f,g] = feval(fun,x,indf,indg,nprob,iutil,rutil);

    % Adiciona as penalidades
    
    % h(x)
    for i =1:neq
        f = f + u*( g(i)^2 );
    end

    % g(x)
    for i = (neq+1):ncstr
        f = f + u*( max(0, g(i)) );
    end
