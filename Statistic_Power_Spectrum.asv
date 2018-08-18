% Statistical Power Spectrum Calculation
sigma=star_fluxes(:,2);%loading the error
% making the coef matrix in overlaping sense: B_m,n = P_l,m*P^*_l,n/sigma^2
B=zeros(400);
l=(0:399)';
for m=0:399
    for n=0:399
        B(m+1,n+1)=sum(exp(2*1i*pi*(m-n)*l/400)./sigma);
    end
    m
end
%covariance matrix is the inverse of the matrix "B"
cov=B^-1;%It's covariance matrix as shown in the previous part of the assignment
%computing correlation matrix
%by definition of correlation we have:
cor=zeros(400);
for m=1:400
    for n=1:400
        cor(m,n)=cov(m,n)/sqrt(cov(m,m)*cov(n,n));
    end
end
% we can see that the correlation matrix as well as covariance matrix is
% Hermitian. The off-diagonal elements of both are due to deviation from
% the orthogonality of fourier basis. Their amplitude is roughly 2 order of
% magnitude smaller than the diagonal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%computing the signal to noise of model i.e. power spectrum divide by the
%diagonal of covariance matrix:
s2n=abs(dft_flux).^2./diag(cov);
plot(s2n)%ploting signal to noise diagram
%this plot shows that the the power of that dominant frequency is actually
%significant because the signal to noise ratio at that point is about 10!