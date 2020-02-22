function W = calc_W(N,lambda)
% Output: Mean sojourn time under Exact-N policy (W).
% Input: Effective arrival rate (lambda), threshold (N).

global mu1 mu2;
eps = 10^-7;

% Building the generating matrix:

A0 = lambda*eye(2*N);

A1D = [mu1*ones(1,N-1);mu2*ones(1,N-1)];
A1B0d = [mu2*ones(1,N-1);zeros(1,N-1)];
A1 = -lambda*eye(2*N)-diag([mu1;A1D(:);mu2])+diag(A1B0d(:),-2);
A1(2*N,2*N-1) = mu2;

A2d = [zeros(1,N-1);mu1*ones(1,N-1)];
A2 = zeros(2*N)+diag(A2d(:),2);
A2(1,2) = mu1;

B0D = [zeros(1,N-1);mu2*ones(1,N-1)];
B0 = -lambda*eye(2*N)-diag([0;B0D(:);mu2])+diag(A1B0d(:),-2);
B0(2*N,2*N-1) = mu2;

% Finding the rate matrix R, using successive substitutions algorithm:

R1 = zeros(2*N);                     % R1=R(n)
R2 = -(((R1)^2)*A2+A0)/(A1);         % R2=R(n+1)
delta = max(max(abs(R1-R2)));
while delta>eps
    R1 = R2;
    R2 = -(((R1)^2)*A2+A0)/(A1);
    delta = max(max(abs(R1-R2)));
end

% Calculating the boundary probability P0:

Phi = B0+R2*A2;
Psi = (eye(2*N)-R2)\ones(2*N,1);
Phi(:,1) = Psi;     % Creating Phi Tilda
v1zeros = zeros(1,2*N);
v1zeros(1) = 1;

P0 = v1zeros/Phi;

% Calculating the mean queue sizes for both queues:

EL1 = P0*R2/((eye(2*N)-R2)^2)*ones(2*N,1);

Z = [1:N-1;1:N-1];
Z = [0;Z(:);N];
    
EL2 = [0,P0*Z];        % EL2(1)=EL2(n), EL2(2)=EL2(n+1)
n = 1;
while EL2(2)-EL2(1)>eps
   EL2(1) = EL2(2); 
   EL2(2) = EL2(2)+P0*((R2)^n)*Z;
   n = n+1;
end

% Applying Little Law:

W = (EL1+EL2(2))/lambda;
