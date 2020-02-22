function [pOPT,lambdaOPT,rOPT] = Optimal_p2(Cs,V,N)
% Output: Optimal price (pOPT), equilibrium effective arrival rate
% (lambdaOPT) and profit (rOPT) under N-Limited policy.
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
    lambda_e = lambda_eff2(N,p,V);
    lambda_e0 = lambda_eff2(N,p-Eps,V);
    if N==1
        r = lambda_e*(p-Cs/N);
        r0 = lambda_e0*(p-Eps-Cs/N);
    else
        r = lambda_e*p-Cs*calc_r(N,lambda_e);        
        r0 = lambda_e0*(p-Eps)-Cs*calc_r(N,lambda_e0);
    end    
    if lambda_e>0
        if (abs(r-r0)<=eps) || (l+0.001*eps>u)
            pOPT = p;
            lambdaOPT = lambda_e;
            rOPT = r; 
            %rOPT = max(0,r);
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