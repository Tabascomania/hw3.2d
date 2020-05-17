%% Part A Question 4
%fprintf("A4\n");

for dr=1:2
phiR = 2*(jout(currNode,currGrp,2,dr)+jin(currNode,currGrp,2,dr));
phiL = 2*(jout(currNode,currGrp,1,dr)+jin(currNode,currGrp,1,dr));
a(currNode,currGrp,2,dr) = (phiR-phiL)/2; % Update a1
a(currNode,currGrp,3,dr) = a(currNode,currGrp,1,dr)-(phiR+phiL)/2; % Update a2   
end

for dr=1:2; for G = 1:data.ng 
    q(currNode,currGrp,i,dr) = 0;
    for i = 1:5   
        q(currNode,currGrp,i,dr) = q(currNode,currGrp,i,dr) + 1/k(stepOut) * data.Chi(currComp,currGrp) *...
            data.XSf(currComp,G) * a(currNode,G,i,dr);
        q(currNode,currGrp,i,dr) = q(currNode,currGrp,i,dr) + data.XSin(currComp,currGrp,G)*a(currNode,G,i,dr);
    end
    % Leakage handling
    for i = 1:3
    q(currNode,currGrp,i,dr) = q(currNode,currGrp,i,dr) - l(currNode,currGrp,i,dr);
    end
 end; end

