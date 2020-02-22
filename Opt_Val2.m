function [pOPT,Nopt,lambdaOPT,rOPT,flag] = Opt_Val2(Cs,V)
% Output: Optimal price (pOPT), threshold (Nopt), equilibrium effective arrival rate
% (lambdaOPT) and profit (rOPT) under N-Limited policy.
% flag for saving unnecessary runs.
% Input: Switching cost (Cs) and value of service (V).

% Initialization:
Eps = 10^-3;
N = 1;
[p,lambda,r] = Optimal_p2(Cs,V,N);
optV = [p,lambda,r];
Nopt = 1;
%r_in_N = [optV(3)]; % monitoring
first = false;
flag = false;
fprintf('V=%3.2f, Cs=%3.2f, ',V,Cs);

% Search for the maximal profit (not robust for other curves):
while p>0 && N<20
    N = N+1;
    [p,lambda,r] = Optimal_p2(Cs,V,N);
    %r_in_N = [r_in_N,r];
    if lambda<0.0101
        if r<0 && N>6
            fprintf('1st, N=%d\n',N);
            flag = true;
            break;
        end
    elseif first==false && r<0
        optV = [p,lambda,r];
        Nopt = N;
        first = true;
    elseif r > optV(3)
        if r-optV(3)<Eps && r<0
            fprintf('2nd, N=%d\n',N);
            break;
        end
        optV = [p,lambda,r];
        Nopt = N;
    elseif optV(2)>0.011
        fprintf('3rd, N=%d\n',N);
        if r<0
            flag = true;
        end
        break;
    else
        fprintf('WTF?, N=%d\n',N);
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
title(['V = ',num2str(V), ', Cs = ',num2str(Cs)]);
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