function [pOPT,Nopt,lambdaOPT,rOPT,flag] = Opt_Val(Cs,V)
% Output: Optimal price (pOPT), threshold (Nopt), equilibrium effective arrival rate
% (lambdaOPT) and profit (rOPT) under Exact-N policy.
% flag for saving unnecessary runs.
% Input: Switching cost (Cs) and value of service (V).

% Initialization:
N = 1;
[p,lambda,r] = Optimal_p(Cs,V,N);
optV = [p,lambda,r];
Nopt = 1;
%r_in_N = [optV(3)]; % monitoring
flag = false;
fprintf('V=%3.2f, Cs=%3.2f \n',V,Cs);

% Search for the maximal profit (concave):
while p>0
    N = N+1;
    [p,lambda,r] = Optimal_p(Cs,V,N);
    %r_in_N = [r_in_N,r];
    if r >= optV(3)
        optV = [p,lambda,r];
        Nopt = N;
        if r==0
            fprintf('lambda = %3.3f\n',lambda);
        end
    else
        if r<=0
            flag = true;
        end
        fprintf('lambda = %3.3f\n',lambda);
        break;
    end
end

% Monitoring:
%{
figure
hold on;
plot(1:N,r_in_N,'-');
hold off;
xlabel('N');
ylabel('r');
title(['V = ',num2str(V)]);title(['V = ',num2str(V), ', Cs = ',num2str(Cs)]);
%}

if optV(3)>0
    pOPT = optV(1);
    lambdaOPT = optV(2);
    rOPT = optV(3);
else   % No positive profit is possible
    Nopt = 0;
    pOPT = 0;
    lambdaOPT = 0;
    rOPT = 0;
    flag = true;
end