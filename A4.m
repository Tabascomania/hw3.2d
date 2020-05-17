%% Part A Question 4
%fprintf("A4\n");

phiR = 2*(jout(currNode,currGrp,2,1)+jin(currNode,currGrp,2,1));
phiL = 2*(jout(currNode,currGrp,1,1)+jin(currNode,currGrp,1,1));
% phiR = a(currNode,currGrp,1) + a(currNode,currGrp,2) - a(currNode,currGrp,3);
% phiL = a(currNode,currGrp,1) - a(currNode,currGrp,2) - a(currNode,currGrp,3);
a(currNode,currGrp,2) = (phiR-phiL)/2; % Update a1
a(currNode,currGrp,3) = a(currNode,currGrp,1)-(phiR+phiL)/2; % Update a2


for i = 1:5    
    q(currNode,currGrp,i) = 0;
    %q(currNode,currGrp,i) = 1/k(stepOut) * data.Chi(currComp,currGrp)*nuSigmaF*a(currNode,currGrp,i);
    for G = 1:data.ng
        q(currNode,currGrp,i) = q(currNode,currGrp,i) + 1/k(stepOut) * data.Chi(currComp,currGrp) *...
            data.XSf(currComp,G) * a(currNode,G,i);
    end
    %q(currNode,currGrp,i) = 1/k(stepOut) * data.Chi(currComp,currGrp) * nuSigmaF;
    for G = 1:data.ng
        q(currNode,currGrp,i) = q(currNode,currGrp,i) + data.XSin(currComp,currGrp,G)*a(currNode,G,i);
        % No leakge considered for 1D problem
        % Leakage handling needs to be implemented
    end
end

% for i = 1:3
%     q(currNode,currGrp,i) = q(currNode,currGrp,i) - l(currNode,currGrp,i);
% end