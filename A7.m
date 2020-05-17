%% Part A Question 7
% fprintf("A7\n");

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

r(stepIn) = 1/k(stepOut) * psi_1G - (Lx + Ly + A);

fprintf("r : %f\n",r(stepIn));

if abs(r(stepIn)/r0) < epsin
    flagIn = true; % Signal inner iteration convergence
    stepIn = 1; % Reset inner iteration step counter
end

stepIn = stepIn + 1; % Increment inner iteration step counter