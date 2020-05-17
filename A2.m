%% Part A Question 2
% fprintf("A2\n");

% Obtain the 1-group total absorption rate (A)
A = 0;
hh=h^2;

for i = 1:nodeDim2
    currComp = node2comp(i); % Material composition for this node
    nodeSum = 0;
    for G = 1:data.ng
        nodeSum = nodeSum + data.XSr(currComp,G) * a(i,G,1);        
    end
    A = A + nodeSum * hh;  % volume of each node in 1D problem taken as its width
end

% Obtain the 1-group fission source (psi)
psi_1G = 0; % 1-group fission source; different from fission source in outer iteration
for i = 1:nodeDim^2
    currComp = node2comp(i);
    nodeSum = 0;
    for G = 1:data.ng
        nodeSum = nodeSum + data.XSf(currComp,G) * a(i,G,1);
    end
    psi_1G = psi_1G + nodeSum * hh;
end

% Obtain the 1-group net leakage through the system surface (Lx,Ly)
Lx = 0;
Ly = 0; % y-directional leakage
for i = nodeDim:nodeDim:nodeDim2 % eastern bdry
    nodeSumX = 0;
    for G = 1:data.ng
        nodeSumX = nodeSumX + jout(nodeDim,G,2,1);
    end
    Lx = Lx + nodeSumX*h;
end
for i = nodeDim2-nodeDim2+1:nodeDim2 % southern bdry
    nodeSumY = 0;
    for G = 1:data.ng
        nodeSumY = nodeSumY + jout(nodeDim,G,2,2);
    end
    Ly = Ly + nodeSumY * h;
end


fprintf("Lx : %f\n", Lx);
fprintf("A : %f\n", A);

% Neutron balance equation (residual)
r0 = 1/k(stepOut) * psi_1G - (Lx + Ly + A);