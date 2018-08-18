%FORWARD MODELING

%Here in this code first I'm searching for the best fit based on this
%strategy: starting with a intial set of parameters: [F q T r t0]=[0.127 0.002 21 7.5 5]
% in an iteration loop I found a new set of parameters using the function
% "minchi". then I will use that result plus some fine random fluctuation
% as the initial value for the next iteration.

x0=[0.127 0.002 21 7.5 5];%it's the starting point of the minimum searching
xmin=zeros(100,5);
chimin=zeros(100,1);
for k=1:100
[x chi] = minchi(star_fluxes,x0);
xmin(k,:)=x;
chimin(k)=chi;
x0=abs(x+x.*(0.01*randn(1,5)));
while (x0(5)>x0(3)||x0(3)>200)
x0=abs(x+x.*(0.01*randn(1,5)));
end
end
%the above random searching above is just a trial and not elaborate one and
%it may go to not acceptable region. I tried to put some basic constraint
%on it to control it, and actually I chose one reasonable parameter
%ensumble after some trial. Here below I will report the covariance matrix
%based on this run, in some other running it may give different result.
mean(xmin)
cov=zeros(5);
for m = 1:5
    for n = 1:5
        cov(m,n)=sum((xmin(:,m)-mean(xmin(:,m))).*(xmin(:,n)-mean(xmin(:,n))));
    end
end
%here is a result from one single runing:
%mean(xmin)=0.1268    0.0004   25.6074   22.9879   14.7878
%covariance matrix:

%cov=
%  1.0e+003 *
%
%    0.0000   -0.0000    0.0000    0.0000    0.0000
%   -0.0000    0.0000   -0.0001   -0.0002   -0.0001
%    0.0000   -0.0001    0.5226    1.3169    1.1454
%    0.0000   -0.0002    1.3169    5.4058    3.2656
%    0.0000   -0.0001    1.1454    3.2656    4.3001