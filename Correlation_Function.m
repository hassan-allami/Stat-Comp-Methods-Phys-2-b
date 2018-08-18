%CORRELATTION FUNCTION
%we knoe that Power Spectrum of a zero-mean signal is the Fourier transform
%of its Aoutocorrelation function. So, here I just compute the power
%spectrum and then apply the inverse Fourier transform on it to get the
%Autocorrelation function:
f=star_fluxes(:,1);f=f-mean(f);
D = DFT_Matrix(400);
dft_fl=D*f;
Power = abs(dft_fl).^2;
autocor= D\Power;
plot(1:400,real(autocor),1:400,imag(autocor))
% as we expect the correlation function doesn't have imaginary part and
% it's obviously periodic. The last point means that it resembles itself
% after shifting. The length of this shift is about 20 which reminds the
% strongest mode of power spectrum which is approximately at 400/20.