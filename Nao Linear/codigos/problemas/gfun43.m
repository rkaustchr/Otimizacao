function[df,dg]=gfun43(fun,x,indgradf,indgradg,nprob,iutil,rutil) ; 

df=[]; dg=zeros(4,0);    
df(1)=2*x(1)-5; 
df(2)=2*x(2)-5; 
df(3)=4*x(3)-21; 
df(4)=2*x(4)+7; 
df=df(:) ; 
    
dg(1,1)=2*x(1)+1; 
dg(1,2)=2*x(1)-1; 
dg(1,3)=4*x(1)+2; 
dg(2,1)=2*x(2)-1; 
dg(2,2)=4*x(2); 
dg(2,3)=2*x(2)-1; 
dg(3,1)=2*x(3)+1; 
dg(3,2)=2*x(3); 
dg(3,3)=2*x(3); 
dg(4,1)=2*x(4)-1; 
dg(4,2)=4*x(4)-1; 
dg(4,3)=-1; 
    
[df,dg]=red_gfun(df,dg,indgradf,indgradg) ; 
