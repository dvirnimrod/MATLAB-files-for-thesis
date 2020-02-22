function [pOPT,lambdaOPT,rOPT] = Optimal_p(Cs,V,N)
% Output: Optimal price (pOPT), equilibrium effective arrival rate
% (lambdaOPT) and profit (rOPT) under Exact-N policy.
% Input: Switching cost (Cs), value of service (V) and threshold (N).

% Initialization:
eps = 10^-6;
Eps = 10^-3;

pOPT = 0;
lambdaOPT = 0;
rOPT = 0;

l = 0;
u = V;
%iter = 0; % monitoring

% Binary search for the optimal price (where the ptofit (r) is maximal):
while u>0.1
    p = 0.5*(u+l);
    %iter = iter + 1;
    lambda_e = lambda_eff(N,p,V);
    lambda_e0 = lambda_eff(N,p-Eps,V);
    r = lambda_e*(p-Cs/N);              
    r0 = lambda_e0*(p-Eps-Cs/N);        % for the incline in r(p)
    if lambda_e>0
        if (abs(r-r0)<=eps) || (l+0.001*eps>u)
            pOPT = p;
            lambdaOPT = lambda_e;
            %rOPT = r;               % use the real r only for r(N) graphs,
            rOPT = max(0,r);         % use the positive r for finding r*
            break;
        elseif (r-r0)>eps
            l = p;
        elseif (r-r0)<-eps
            u = p;
        end
    elseif lambda_e==0
        u = p;
    else
        fprintf('Error!');
    end
end
% fprintf('%d iterations\n',iter);