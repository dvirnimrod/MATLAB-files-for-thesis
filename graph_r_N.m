% Graph the optimal profit under both policies as a function of the price.

% Parameters:
global mu1 mu2 V Cw Cs;
mu1 = 1;
mu2 = 1;
V = 50;
Cw = 1;
Cs = 100;

% Scope and initialization:
maxN = 20;
r_exact = 1:maxN;
r_limited = 1:maxN;

% Calculate the values:
for N=1:maxN
    [~,~,r_exact(N)] = Optimal_p(Cs,V,N);
    [~,~,r_limited(N)] = Optimal_p2(Cs,V,N);
end

% Plot:
figure
hold on;
plot(1:maxN,r_exact,'-r');
plot(1:maxN,r_limited,'-b');
hold off;
xlabel('$N$','Interpreter', 'latex');
ylabel('$\hat{r}^*$','Interpreter', 'latex');
%title(['$\hat{V} = $',num2str(V),', $\hat{Cs} = $',num2str(Cs)],'Interpreter', 'latex');
