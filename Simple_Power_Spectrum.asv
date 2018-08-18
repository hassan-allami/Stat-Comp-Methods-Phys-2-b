% Calculation and Ploting the Simple Power Spectrum
flux=star_fluxes(:,1);%loading the star flux
D=DFT_MATRIX(400);%making the DFT matrix operator
f=flux-mean(flux);%removing offset from the flux
dft_flux=D*f;%finding the dft of the flux
plot(abs(dft_flux).^2)%ploting the power spectrum
%from exmaining the plot we see that the maximum of power spectrum is in 
% n = 22 & 380. other two pairs are at 43 & 359
% Also it's visible that the spectrum is symmetric regarding to its middle
% point in the way that indices of each pairs make 402 together.
% (if the inexing was zero base, then they would make 400)