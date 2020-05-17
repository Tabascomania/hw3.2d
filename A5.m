%% Part A Question 5
% fprintf("A5\n");

% % �� a�� ���⼭ ���ϸ� A4�� q�� ���������� a�� ���� ���ϴ� �� �ƴѰ�. q ���ϴ� �տ��� ����
% phiR = 2*(jout(currNode,currGrp,2,1)+jin(currNode,currGrp,2,1));
% phiL = 2*(jout(currNode,currGrp,1,1)+jin(currNode,currGrp,1,1));
% % phiR = a(currNode,currGrp,1) + a(currNode,currGrp,2) - a(currNode,currGrp,3);
% % phiL = a(currNode,currGrp,1) - a(currNode,currGrp,2) - a(currNode,currGrp,3);
% a(currNode,currGrp,2) = (phiR-phiL)/2; % Update a1
% a(currNode,currGrp,3) = a(currNode,currGrp,1)-(phiR+phiL)/2; % Update a2


a(currNode,currGrp,4) = (5*q(currNode,currGrp,2)+3*q(currNode,currGrp,4)-...
    5*a(currNode,currGrp,2)*data.XSr(currComp,currGrp))/(3*(60*data.XSD(currComp,currGrp)+data.XSr(currComp,currGrp)));
% Update a3
a(currNode,currGrp,5) = (-7*q(currNode,currGrp,3)+3*q(currNode,currGrp,5)+...
    7*a(currNode,currGrp,3)*data.XSr(currComp,currGrp))/(3*(140*data.XSD(currComp,currGrp)+data.XSr(currComp,currGrp)));
% Update a4




% Source calculation
nuSigmaFphi = 0;
SigmaInPhi = 0;
for G = 1:data.ng
    nuSigmaFphi = nuSigmaFphi + data.XSf(currComp,G)*a(currNode,G,1);
    SigmaInPhi = SigmaInPhi + data.XSin(currComp,currGrp,G)*a(currNode,G,1);
end
S = 1/k(stepOut)*data.Chi(currComp,currGrp)*nuSigmaFphi + SigmaInPhi;
% S = q(currNode,currGrp,1);
beta = data.D(currComp,currGrp)/h;
c1 = (6*beta)/(1+12*beta);
c2 = (-8*beta)/((1+4*beta)*(1+12*beta));
c3 = (1-48*beta^2)/((1+4*beta)*(1+12*beta));
c4 = (6*beta)/(1+4*beta);

% Jr = c1 * a(currNode,currGrp,1) + c3 * jin(currNode,currGrp,2,1) + c2 * jin(currNode,currGrp,1,1) + ...
%     c4 * a(currNode,currGrp,4) + c1 * a(currNode,currGrp,5);
% Jl = c1 * a(currNode,currGrp,1) + c3 * jin(currNode,currGrp,1,1) + c2 * jin(currNode,currGrp,2,1) - ...
%     c4 * a(currNode,currGrp,4) + c1 * a(currNode,currGrp,5);
% 
% temp = ((Jr-jin(currNode,currGrp,2,1))-(jin(currNode,currGrp,1,1)-Jl))/h;
% a(currNode,currGrp,1) = 1/data.XSr(currComp,currGrp)*(S-temp);

a(currNode,currGrp,1) = 1/(data.XSr(currComp,currGrp)+2*c1/h)*...
    (S-1/h*(2*a(currNode,currGrp,5)*c1-...
    (1-c2-c3)*(jin(currNode,currGrp,2,1)+jin(currNode,currGrp,1,1))));
% Update a0 (node-average flux)
    