function [df,dg]=gfun05(fun,x,indgradf,indgradg,nprob,iutil,rutil)


%
%  size(dg)= (nvar,ncstr)
%
%  indgradf=0 - df is not computed ( df=[])
%  indgradf=1 - df is computed
%
%  indgradg(i)=0 - dg(:,i) is not computed
%  indgradg(i)=1 - dg(:,i) is computed
%
%  length(indgradg)= ncstr
%
%  if indgradg(i)=0 for i=1:ncstr, take dg=zeros(nvar,0)

df=[]; dg=[];

indgradf=1;
indgradg=zeros(4,1);

if indgradf==1
	df(1)=400*x(1)*(x(1)^2-x(2))+(x(1)-1)+2*(x(1)-1);      
	df(2)=-200*(x(1)^2-x(2))+20.2*(x(2)-1)+19.8*(x(4)-1);
    df(3)=2*(x(3)-1)+360*x(3)*(x(3)^2-x(4));
    df(4)=-180*(x(3)^2-x(4))+20.2*(x(4)-1)+19.8*(x(2)-1);
end

j=0;
if indgradg(1)==1
	j=j+1;   
	dg(1,j)=1.0;
	dg(2,j)=1.0;
    dg(3,j)=1.0;
end   
if indgradg(2)==1
	j=j+1;   
	dg(1,j)=3*x(1)^2;
	dg(2,j)=-6;
    dg(3,j)=-4;
end

df=df(:);