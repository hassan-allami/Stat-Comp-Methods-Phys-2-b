% Fourier Subspace Fitting
% I'm taking only those with signal to noise larger than "1.5" using below
% command:
f_s=find(s2n>1.5);
% Here are these modes
% f_s= 22    43    44   128   147   255   274   358   359   380
% But these modes are not symmetric around zero and does not necessarily
% give a real output. To have a symmetric spectrum I'm shifting the middle of
% spectrum to the zero in this way:
f_ss=find(s2n>1.5)-201;
%these new modes are:
% f_ss = -179  -158  -157   -73   -54    54    73   157   158   179
% Howerver, after examining through plotting and compairing with the
% original data I felt that it has higher rate of ocsilation, so here I'm
% introducing another set of frequency by mirroring the lower half of the
% original one:
f_sm = [-flipud(f_s(1:5))+1;f_s(1:5)-1];
% these morored modes are:
% f_sm =  -146  -127   -43   -42   -21    21    42    43   127   146

%Here below I'm defining the coef matrix for this new set of basis as well
%as the inhomogenity vector of the equation for above three series of modes
B_s=zeros(length(f_s));B_ss=zeros(length(f_s));B_sm=zeros(length(f_s));
A=zeros(length(f_s),1);AA=zeros(length(f_s),1);Am=zeros(length(f_s),1);
l=(0:399)';
for m=1:length(f_s)
    for n=1:length(f_s)
        B_s(m,n)=sum(exp(2*1i*pi*(f_s(m)-f_s(n))*l/400)./(sigma.^2));
        B_ss(m,n)=sum(exp(2*1i*pi*(f_ss(m)-f_ss(n))*l/400)./(sigma.^2));
        B_sm(m,n)=sum(exp(2*1i*pi*(f_sm(m)-f_sm(n))*l/400)./(sigma.^2));
        A(m)=sum(exp(-2*1i*pi*f_s(m)*l/400).*f./(sigma.^2));
        AA(m)=sum(exp(-2*1i*pi*f_ss(m)*l/400).*f./(sigma.^2));
        Am(m)=sum(exp(-2*1i*pi*f_sm(m)*l/400).*f./(sigma.^2));
    end
    f_s(m)
end
a=B_s\A;%finding the amplitude vector for non-symmetric group of modes
aa=B_ss\AA;%finding the amplitude vector for symmetric shifted group of modes
am=B_sm\Am;%finding the amplitude vector for symmetric mirrored group of modes
% Here below I'm generating above found three models
model=zeros(400,1);model_s=zeros(400,1);model_m=zeros(400,1);
for m=1:length(f_s)
    model=exp(2*1i*pi*f_s(m)*l/400)*a(m)+model;
    model_s=exp(2*1i*pi*f_ss(m)*l/400)*aa(m)+model_s;
    model_m=exp(2*1i*pi*f_sm(m)*l/400)*am(m)+model_m;
end
%ploting the models
plot(l,real(model),l,imag(model))
figure
plot(l,real(model_s),l,imag(model_s))
figure
plot(l,real(model_m),l,imag(model_m))
figure
plot(f)%ploting the flux itself
% DISCUSSION ABOUT THE PLOTS
% Qualitativly I can say that non-symmetric model and the mirrored one
% models the slow oscillation of the data in better way. But the problem
% with the non-symmetric one is that it has larg imaginary part. The
% mirrored model is kind of asymmetric in negative and postive region.
% The shifted model seems more noisy and even looks that has more variation
% rate that the data itself, and this sense it resembles the face of the
% data. I think in the first looking it's more similar than others to the
% data, but I think that this resemlance is because of more noisy behaviour
% of this model.
% But a general point which is true about all of these models is that they
% got a smaller amplitude, roughly about one order magnitude, than the
% original data. In this sense the mirrored model is the best, it has
% larger amplitude than others. I think this feature is a result of
% ignoring the other modes which contain considerable amount of power.