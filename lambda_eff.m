function lambda_e = lambda_eff(N,p,V)
% Output: Equilibrium effective arrival rate under Exact-N policy
% (lambda_e).
% Input: Threshold (N), price (p), value of service (V).

% Parameters and initialization:
global mu1 mu2 Cw;

eps = 10^-6;
lambda_e = 0;
l = 0;
u = (mu1*mu2)/(mu1+mu2);

% Monitoring:
%{
lambdaV = 0.01:0.01:u-0.01;
y = 1:length(lambdaV);
for j=1:length(lambdaV)
    y(j) = V-p-Cw*calculate_W(N,lambdaV(j));   % Choose calculate_W for Exact-N and calculate_W2 for N-Limited
end
figure
plot(lambdaV,y,'-');
title(['N = ',num2str(N),', p = ',num2str(p)]);
%}

% Binary search for the equilibrium effective arrival rate (where U=0):
while (u>0.01)
    lambda = 0.5*(l+u);
    W = calc_W(N,lambda);         
    w = calc_W(N,lambda-eps);    
    U = V-p-Cw*W;
    if abs(U)<eps || (l+0.001*eps>u)
        lambda_e = lambda;
        break;
    elseif U>0 || (U<0 && (W-w)<-eps)       % U(lambda)-U(lambda-eps)>0
        l = lambda;
    elseif U<0 && (W-w)>eps      % U(lambda)-U(lambda-eps)<0
        u = lambda;
    elseif U<0 && abs(Cw*(W-w))<=eps
        break;
    end
end
