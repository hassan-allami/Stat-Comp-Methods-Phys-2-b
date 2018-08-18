%Making the DFT Matrix Operator of size "N"
function D = DFT_Matrix(N)
D=zeros(N);
for k=0:N-1
    for l=0:N-1
        D(k+1,l+1) = exp(-2*1i*k*pi*l/N)/sqrt(N);
    end
end
% I showed in the paper why I took sqrt(N) as the normalization factor to
% have a Hermitian operator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% comparing my result with the embeded "fft function" of matlab itself, I
% found out that the ratio factor between them is approximately 0.05 (mine
% is smaller).
% of course there is a very small fluctuation on this ratio in order of
% 10^-12.