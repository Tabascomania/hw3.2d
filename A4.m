%% Part A Question 4
%fprintf("A4\n");

phiRx = 2*(jout(currNode,currGrp,2,1)+jin(currNode,currGrp,2,1));
phiLx = 2*(jout(currNode,currGrp,1,1)+jin(currNode,currGrp,1,1));
% phiR = a(currNode,currGrp,1) + a(currNode,currGrp,2) - a(currNode,currGrp,3);
% phiL = a(currNode,currGrp,1) - a(currNode,currGrp,2) - a(currNode,currGrp,3);
a(currNode,currGrp,2,1) = (phiRx-phiLx)/2; % Update a1
a(currNode,currGrp,3,1) = a(currNode,currGrp,1,1)-(phiRx+phiLx)/2; % Update a2

phiRy = 2*(jout(currNode,currGrp,2,2)+jin(currNode,currGrp,2,2));
phiLy = 2*(jout(currNode,currGrp,1,2)+jin(currNode,currGrp,1,2));
% phiR = a(currNode,currGrp,1) + a(currNode,currGrp,2) - a(currNode,currGrp,3);
% phiL = a(currNode,currGrp,1) - a(currNode,currGrp,2) - a(currNode,currGrp,3);
a(currNode,currGrp,2,2) = (phiRy-phiLy)/2; % Update a1
a(currNode,currGrp,3,2) = a(currNode,currGrp,1,2)-(phiRy+phiLy)/2; % Update a2

for dr=1:2; for G = 1:data.ng 
    q(currNode,currGrp,i,dr) = 0;
    for i = 1:5   
        q(currNode,currGrp,i,dr) = q(currNode,currGrp,i,dr) + 1/k(stepOut) * data.Chi(currComp,currGrp) *...
            data.XSf(currComp,G) * a(currNode,G,i,dr);
        q(currNode,currGrp,i) = q(currNode,currGrp,i) + data.XSin(currComp,currGrp,G)*a(currNode,G,i);
    end
    % Leakage handling
    for i = 1:3
    q(currNode,currGrp,i) = q(currNode,currGrp,i) - l(currNode,currGrp,i);
    end
 end; end

