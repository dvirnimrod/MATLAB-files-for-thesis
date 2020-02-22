function W = calc_W2(N,lambda)
% Output: Mean sojourn time under N-Limited policy (W).
% Input: Effective arrival rate (lambda), threshold (N).

global mu1 mu2;
eps = 10^-7;

% Building the generating matrix:

A0 = lambda*eye(2*N);

A1D = [mu1*ones(1,N-1);mu2*ones(1,N-1)];
A1d = [mu2*ones(1,N-1);zeros(1,N-1)];
A1 = -lambda*eye(2*N)-diag([mu1;A1D(:);mu2])+diag(A1d(:),-2);
A1(2*N,2*N-1) = mu2;

A2d = [zeros(1,N-1);mu1*ones(1,N-1)];
A2 = zeros(2*N)+diag(A2d(:),2);
A2(1,2) = mu1;

B0 = -lambda*eye(N+1)-diag([0,mu2*ones(1,N)])+diag(mu2*ones(1,N),-1);

B1 = A2(:,[1,2:2:2*N]);

C1 = A0([1:2:2*N-1,2*N],:);

% Finding the rate matrix R, using successive substitutions algorithm:

R1 = zeros(2*N);                     % R1=R(n)
R2 = -(((R1)^2)*A2+A0)/(A1);         % R2=R(n+1)
delta = max(max(abs(R1-R2)));
while delta>eps
    R1 = R2;
    R2 = -(((R1)^2)*A2+A0)/(A1);
    delta = max(max(abs(R1-R2)));
end

% Calculating the boundary probability P0 and P1:

Phi = [B0,C1; B1,A1+R2*A2];
Psi = [ones(N+1,1);(eye(2*N)-R2)\ones(2*N,1)];
Phi(:,1) = Psi;     % Creating Phi Tilda
v1zeros = zeros(1,3*N+1);
v1zeros(1) = 1;

P01 = v1zeros/Phi;      % P01=[P0,P1]
P0 = P01(1:N+1);
P1 = P01((N+2):(3*N+1));

% Calculating the mean queue sizes for both queues:

EL1 = P1/((eye(2*N)-R2)^2)*ones(2*N,1);

Z0 = 0:N;
Z = [1:N-1;1:N-1];
Z = [0;Z(:);N];
    
EL2 = [0,P0*Z0'+P1*Z];        % EL2(1)=EL2(n), EL2(2)=EL2(n+1)
n = 2;
while EL2(2)-EL2(1)>eps
   EL2(1) = EL2(2); 
   EL2(2) = EL2(2)+P1*((R2)^(n-1))*Z;
   n = n+1;
end

% Applying Little Law:

W = (EL1+EL2(2))/lambda;
