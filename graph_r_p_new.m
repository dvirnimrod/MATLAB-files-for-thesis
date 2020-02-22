% Graph the equilibrium effective arrival rate and the profit as a function of the price.

% Parameters:
global mu1 mu2 V Cw;
mu1 = 1;
mu2 = 1;
V = 20;
Cw = 1;

Cs1 = 1;
Cs2 = 30;

% Resolution, scope and initialization:
d = 0.1;
p = d:d:V;
maxN = 10;

DV = cell(3,maxN);   % Decision Variables - 1st row: Every cell N (1:maxN) is a vector lambda_eff(p), 2nd row: A vector r(p) with Cs1, 3rd row: A vector r(p) with Cs2

% Calculate the values:
for N=1:maxN
    
    lambdaeff = 1:length(p);
    r1 = 1:length(p);
    r2 = 1:length(p);
    
    for i=1:length(p)
        
        lambdaeff(i) = lambda_eff(N,p(i),V);      % For Exact-N
        r1(i) = lambdaeff(i)*(p(i)-Cs1/N);        % also
        r2(i) = lambdaeff(i)*(p(i)-Cs2/N);        % also
        %}
        %{
        lambdaeff(i) = lambda_eff2(N,p(i),V);      % For N-Limited
        if N==1
            r1(i) = lambdaeff(i)*(p(i)-Cs1/N);
            r2(i) = lambdaeff(i)*(p(i)-Cs2/N);
        else
            r1(i) = lambdaeff(i)*p(i)-Cs1*calculate_r(N,lambdaeff(i));        % For N-Limited (all the IF)
            r2(i) = lambdaeff(i)*p(i)-Cs2*calculate_r(N,lambdaeff(i));
        end
        %}
    end
    
    DV(1,N) = {lambdaeff};
    DV(2,N) = {r1};
    DV(3,N) = {r2};
    
end

% Plot:
figure
%subplot(3,1,1);
hold on;
for N=maxN:-1:1
    lgnd = ['N = ',num2str(N)];
    plot(p,DV{1,N},'-','DisplayName',lgnd);
end
hold off;
xlabel('$\hat{p}$','Interpreter', 'latex');
ylabel('$\lambda_e$','Interpreter', 'latex');
%title(['$\hat{V}$ = ',num2str(V)],'Interpreter', 'latex');
xL = xlim;
line(xL, [0 0]);

figure
%subplot(3,1,2);
hold on;
for N=maxN:-1:1
    lgnd = ['N = ',num2str(N)];
    plot(p,DV{2,N},'-','DisplayName',lgnd);
end
hold off;
xlabel('$\hat{p}$','Interpreter', 'latex');
ylabel('$\hat{r}$','Interpreter', 'latex');
%title(['$\hat{C_S}$ = ',num2str(Cs1)],'Interpreter', 'latex');
xL = xlim;
line(xL, [0 0]);

figure
%subplot(3,1,3);
hold on;
for N=maxN:-1:1
    lgnd = ['N = ',num2str(N)];
    plot(p,DV{3,N},'-','DisplayName',lgnd);
end
hold off;
xlabel('$\hat{p}$','Interpreter', 'latex');
ylabel('$\hat{r}$','Interpreter', 'latex');
%title(['$\hat{C_S}$ = ',num2str(Cs2)],'Interpreter', 'latex');
xL = xlim;
line(xL, [0 0]);