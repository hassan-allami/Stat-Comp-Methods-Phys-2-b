%This function calculates the find a best Chi-Square using the "fminsearch"
%function and some starting point in the parameter space 'x0'
function [x, fval] = minchi(star_fluxes,x0)
function X = Chi(x)
flux = star_fluxes(:,1);
sigma = star_fluxes(:,2);
t = (1:400)';
F = x(1);
q = x(2);
T = x(3);
r = x(4);
t0 = x(5);
X = sum((flux - transit(t,F,q,T,r,t0)).^2./(sigma.^2));
end
[x,fval] = fminsearch(@Chi,x0);
end