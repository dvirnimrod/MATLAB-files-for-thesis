% Graph the mean sojourn time in each queue, as a function of the effective arrival rate, for different threshold.

% Parameters and initialization:
global mu1 mu2;
mu1 = 1;
mu2 = 1;

j=0;
N = [1,2,3,5,7,9];
%check = zeros(99,9);

% Calculate and plot:
figure;
hold on;
for n=1:length(N);
    j=j+1;
    lambda = (mu1*mu2)/(mu1+mu2)-0.01:-0.01:0.01;
    W = zeros(49,2);
    for i=1:49
        W(i,1:2) = check_W2(N(n),lambda(i));     % Use check_W for Exact-N and check_W2 for N-Limited
    end
    
    subplot(3,2,j);
    plot(lambda,W(:,1),lambda,W(:,2));
    lgnd = ['N = ',num2str(N(n))];
    %plot(lambda,W(:,1),'DisplayName',lgnd);
    %xlabel('lambda');
    %ylabel('W1');
    title(['N = ',num2str(N(n))]);
    %title('W1(lambda) always increasing with N, but very very little');
    legend('W1','W2');
    %check(:,N) = W(:,1);
end
hold off;
legend show;
