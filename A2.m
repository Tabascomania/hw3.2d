%% Part A Question 2
% fprintf("A2\n");

% Obtain the 1-group total absorption rate (A)
A = 0;
for i = 1:totalNodes
    currComp = node2comp(i); % Material composition for this node
    A = A + data.XSr(currComp,:) * a0(i,:)' .* h2;
end


% Obtain the 1-group fission source (psi)
psi_1G = 0; % 1-group fission source; different from fission source in outer iteration
for i = 1:totalNodes
    currComp = node2comp(i); % Material composition for this node
    psi_1G = psi_1G + data.XSf(currComp,:) * a0(i,:)' .* h2;
end

% Obtain the 1-group net leakage through the system surface (Lx,Ly)
Lx = sum(jout(eastNodes,:,2,1).*h,'all');
Ly = sum(jout(southNodes,:,2,1).*h,'all');

fprintf("Current step A : %f\n",A);
fprintf("Current step psi_1G : %f\n",psi_1G);
fprintf("Current step Lx : %f\n",Lx);
fprintf("Current step Ly : %f\n",Ly);

% Neutron balance equation (residual)
r0 = 1/k(stepOut) * psi_1G - (Lx + Ly + A);