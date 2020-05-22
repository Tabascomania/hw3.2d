%% A2.m
% Obtain initial residual

% Obtain the 1-group total absorption rate (A)
A = 0;
for i = 1:totalNodes
    currComp = node2comp(i); % Material composition for this node
    A = A + (data.XSr(currComp,:)-squeeze(sum(data.XSin(currComp,:,:)))') * a0(i,:)' .* h2;
end
% A = 0;
% for i = 1:totalNodes
%     currComp = node2comp(i);
%     nodeSum = 0;
%     for currGrp = 1:data.ng
%         XSa = data.XSr(currComp,currGrp);
%         for G = 1:data.ng
%             XSa = data.XSr(currComp,currGrp) - data.XSin(currComp,G,currGrp);
%         end
%         nodeSum = nodeSum + XSa * a0(i,currGrp);
%     end
%     A = A + nodeSum * h2;
% end

% Obtain the 1-group fission source (psi)
psi_1G = 0; % 1-group fission source; different from fission source in outer iteration
for i = 1:totalNodes
    currComp = node2comp(i); % Material composition for this node
    psi_1G = psi_1G + data.XSf(currComp,:) * a0(i,:)' .* h2;
end
% psi_1G = 0; 
% for i = 1:totalNodes
%     currComp = node2comp(i);
%     nodeSum = 0;
%     for G = 1:data.ng
%         nodeSum = nodeSum + data.XSf(currComp,G) * a0(i,G);
%     end
%     psi_1G = psi_1G + nodeSum * h2;
% end

% Obtain the 1-group net leakage through the system surface (Lx,Ly)
Lx = sum(jout(eastNodes,:,2,1).*h,'all');
Ly = sum(jout(southNodes,:,2,2).*h,'all');
% Lx = 0;Ly = 0;
% for i = eastNodes
%     for G = 1:data.ng
%         Lx = Lx + jout(i,G,2,1)*h;
%     end
% end
% for i = southNodes
%     for G = 1:data.ng
%         Ly = Ly + jout(i,G,2,2)*h;
%     end
% end

fprintf("Current step A : %f\n",A);
fprintf("Current step psi_1G : %f\n",psi_1G);
fprintf("Current step Lx : %f\n",Lx);
fprintf("Current step Ly : %f\n",Ly);

% Neutron balance equation (residual)
r0 = 1/k(stepOut) * psi_1G - (Lx + Ly + A);