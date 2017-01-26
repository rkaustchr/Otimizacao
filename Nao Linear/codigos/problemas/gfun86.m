function[df,dg]=gfun86(fun,x,indgradf,indgradg,nprob,iutil,rutil) ; 

df=[]; dg=zeros(5,0);    
df(1)=60*x(1)-20*x(5)-20*x(3)+64*x(4)+12*x(1)^2-15-40*x(2); 
df(2)=24*x(2)^2+78*x(2)-27+64*x(5)-12*x(3)-62*x(4)-40*x(1); 
df(3)=30*x(3)^2+20*x(3)-20*x(5)-12*x(4)-12*x(2)-20*x(1)-36; 
df(4)=-18+18*x(4)^2-40*x(5)-12*x(3)-62*x(2)+64*x(1)+78*x(4); 
df(5)=60*x(5)+6*x(5)^2-40*x(4)-20*x(3)+64*x(2)-20*x(1)-12; 
df=df(:) ; 
    
dg(1,1)=16; 
dg(1,2)=0; 
dg(1,3)=7/2; 
dg(1,4)=0; 
dg(1,5)=0; 
dg(1,6)=-2; 
dg(1,7)=1; 
dg(1,8)=1; 
dg(1,9)=-1; 
dg(1,10)=-1; 
dg(2,1)=-2; 
dg(2,2)=2; 
dg(2,3)=0; 
dg(2,4)=2; 
dg(2,5)=9; 
dg(2,6)=0; 
dg(2,7)=1; 
dg(2,8)=2; 
dg(2,9)=-2; 
dg(2,10)=-1; 
dg(3,1)=0; 
dg(3,2)=0; 
dg(3,3)=-2; 
dg(3,4)=0; 
dg(3,5)=2; 
dg(3,6)=4; 
dg(3,7)=1; 
dg(3,8)=3; 
dg(3,9)=-3; 
dg(3,10)=-1; 
dg(4,1)=-1; 
dg(4,2)=-4; 
dg(4,3)=0; 
dg(4,4)=4; 
dg(4,5)=-1; 
dg(4,6)=0; 
dg(4,7)=1; 
dg(4,8)=2; 
dg(4,9)=-4; 
dg(4,10)=-1; 
dg(5,1)=0; 
dg(5,2)=-2; 
dg(5,3)=0; 
dg(5,4)=1; 
dg(5,5)=14/5; 
dg(5,6)=0; 
dg(5,7)=1; 
dg(5,8)=1; 
dg(5,9)=-5; 
dg(5,10)=-1; 
    
[df,dg]=red_gfun(df,dg,indgradf,indgradg) ; 
