%% Part A Question 7
% fprintf("A7\n");

% Obtain the 1-group total absorption rate (A)
A = 0;
for i = 1:totalNodes
    currComp = node2comp(i); % Material composition for this node
    A = A + (data.XSr(currComp,:)-squeeze(sum(data.XSin(currComp,:,:)))') * a0(i,:)' .* h2;
end

% Obtain the 1-group net leakage through the system surface (Lx,Ly)
Lx = sum(jout(eastNodes,:,2,1).*h,'all');
Ly = sum(jout(southNodes,:,2,2).*h,'all');

% fprintf("Current step A : %f\n",A);
% fprintf("Current step psi_1G : %f\n",psi_1G);
% fprintf("Current step Lx : %f\n",Lx);
% fprintf("Current step Ly : %f\n",Ly);

% Neutron balance equation (residual)
r(stepIn) = 1/k(stepOut) * psi_1G - (Lx + Ly + A);

fprintf("Current r(%d)/r0 : %f\n", stepIn,r(stepIn)/r0);

if abs(r(stepIn)/r0) < epsin
    flagIn = true; % Signal inner iteration convergence
    stepIn = 1; % Reset inner iteration step counter
end

stepIn = stepIn + 1; % Increment inner iteration step counter