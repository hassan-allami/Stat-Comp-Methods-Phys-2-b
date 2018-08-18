% Effect of Domain Change
% Here I'm finding the statistical power spectrum and subspace Fourier
% fitting for the first 378 point of the flux series
ft=star_fluxes(1:378,1);ft=ft-mean(ft);%defining the offset removed flux for the truncated data
%finding the DFT of the the truncated flux
D = DFT_Matrix(378);
dft_flu=D*ft;
sigm=star_fluxes(1:378,2);%loading the error for the truncated data
% making the coef matrix in overlaping sense: B_m,n = P_l,m*P^*_l,n/sigma^2
% the difference here is that I'm using the square od the flux-error as the
% sigma
% I'm doing this because it was not clear for me if it is sigma or the the
% error. However, it doesn't bring significant qualitative difference. What
% it makes is just kind of re-scaling.
B=zeros(378);
l=(0:377)';
for m=0:377
    for n=0:377
        B(m+1,n+1)=sum(exp(2*1i*pi*(m-n)*l/378)./(sigm.^2));
    end
    m
end
covt=B^-1;%finding covariance matrix
%computing correlation matrix
cort=zeros(378);
for m=1:378
    for n=1:378
        cort(m,n)=covt(m,n)/sqrt(covt(m,m)*covt(n,n));
    end
end
%finding signal to noise and plotting it
s2nt=abs(dft_flu).^2./diag(covt);
plot(s2nt)%ploting signal to noise diagram
% Shape of the spectrum doesn't change too much and we expected this
% because it has the same fluctuating behaviour all the time

%FOURIER SUBSPACE FITTING
%for this part I only use the non-symmetric set of frequency which is the
%simplest one:
%(I'm doing everthing in the same way; just copy and paste and a little bit clean up)
% generating the coef matrix and inhom vector
f_st=find(s2nt>1500)-1;
B_t=zeros(length(f_st));
At=zeros(length(f_st),1);
l=(0:377)';
for m=1:length(f_st)
    for n=1:length(f_st)
        B_t(m,n)=sum(exp(2*1i*pi*(f_st(m)-f_st(n))*l/378)./(sigm.^2)); 
        At(m)=sum(exp(-2*1i*pi*f_st(m)*l/378).*ft./(sigm.^2));        
    end
    f_st(m)
end
at=B_t\At;%finding the amplitude vector
% Generating the Model
modelt=zeros(378,1);
for m=1:length(f_s)
    modelt=exp(2*1i*pi*f_st(m)*l/378)*at(m)+modelt;    
end
%ploting the models
plot(l,real(modelt),l,imag(modelt))
figure
plot(ft)
%DISCUSSION
%My model here is too much better, both in the sense that there is no
%imaginary part anymore and also its amplitude is very closer to the
%original data. But I believe that these improvment has nothing to do with
%changing the domain. Actually, here I just considered twice more frequency
%modes (20 of them). It also looks more similar to the original one.
% At this point may be it's better to change my previous soltion for the
% Fourier subspace fitting, but I left them unchanged to show the
% difference!