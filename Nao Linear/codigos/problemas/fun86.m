function[f,g]=fun86(x,indf,indg,nprob,iutil,rutil) ; 

f=[]; g=[];    
f=-36*x(3)-12*x(5)-18*x(4)+6*x(4)^3+30*x(1)^2-40*x(1)*x(2)+64*x(1)*x(4)+39*x(2)^2+10*x(3)^3+8*x(2)^3-20*x(1)*x(3)-62*x(2)*x(4)-20*x(1)*x(5)+4*x(1)^3+2*x(5)^3-12*x(2)*x(3)-15*x(1)+10*x(3)^2+30*x(5)^2-27*x(2)+64*x(2)*x(5)-12*x(3)*x(4)-20*x(3)*x(5)-40*x(4)*x(5)+39*x(4)^2; 
    
g(1)=-40+16*x(1)-2*x(2)-x(4); 
g(2)=-2+2*x(2)-4*x(4)-2*x(5); 
g(3)=-1/4+7/2*x(1)-2*x(3); 
g(4)=-4+2*x(2)+4*x(4)+x(5); 
g(5)=-4+9*x(2)+2*x(3)-x(4)+14/5*x(5); 
g(6)=-1-2*x(1)+4*x(3); 
g(7)=-40+x(1)+x(2)+x(3)+x(4)+x(5); 
g(8)=-60+x(1)+2*x(2)+3*x(3)+2*x(4)+x(5); 
g(9)=5-x(1)-2*x(2)-3*x(3)-4*x(4)-5*x(5); 
g(10)=1-x(1)-x(2)-x(3)-x(4)-x(5); 
g=g(:) ; 
    
[f,g]=red_fun(f,g,indf,indg) ; 
