%% Part A Question 5
% fprintf("A5\n");

% % 흠 a를 여기서 구하면 A4의 q는 전전스텝의 a를 갖고 구하는 것 아닌가. q 구하는 앞에다 놓자
% phiR = 2*(jout(currNode,currGrp,2,1)+jin(currNode,currGrp,2,1));
% phiL = 2*(jout(currNode,currGrp,1,1)+jin(currNode,currGrp,1,1));
% % phiR = a(currNode,currGrp,1) + a(currNode,currGrp,2) - a(currNode,currGrp,3);
% % phiL = a(currNode,currGrp,1) - a(currNode,currGrp,2) - a(currNode,currGrp,3);
% a(currNode,currGrp,2) = (phiR-phiL)/2; % Update a1
% a(currNode,currGrp,3) = a(currNode,currGrp,1)-(phiR+phiL)/2; % Update a2

for dr=1:2 % x,y에 대해 a3,4 계산
a(currNode,currGrp,4,dr) = (5*q(currNode,currGrp,2,dr)+3*q(currNode,currGrp,4,dr)-...
    5*a(currNode,currGrp,2,dr)*data.XSr(currComp,currGrp))/(3*(60*data.XSD(currComp,currGrp)+data.XSr(currComp,currGrp)));
% Update a3
a(currNode,currGrp,5,dr) = (-7*q(currNode,currGrp,3,dr)+3*q(currNode,currGrp,5,dr)+...
    7*a(currNode,currGrp,3,dr)*data.XSr(currComp,currGrp))/(3*(140*data.XSD(currComp,currGrp)+data.XSr(currComp,currGrp)));
% Update a4
end


% Source calculation
nuSigmaFphi = 0;
SigmaInPhi = 0;
for G = 1:data.ng
    nuSigmaFphi = nuSigmaFphi + data.XSf(currComp,G)*a(currNode,G,1,1);
    SigmaInPhi = SigmaInPhi + data.XSin(currComp,currGrp,G)*a(currNode,G,1,1);
end
S = 1/k(stepOut)*data.Chi(currComp,currGrp)*nuSigmaFphi + SigmaInPhi;
beta = data.D(currComp,currGrp)/h;
c1 = (6*beta)/(1+12*beta);
c2 = (-8*beta)/((1+4*beta)*(1+12*beta));
c3 = (1-48*beta^2)/((1+4*beta)*(1+12*beta));
c4 = (6*beta)/(1+4*beta);
% hx=hy=h니까 c는 다 같다

Jsum=0;
for dr=1:2
    Jsum=Jsum+(2*a(currNode,currGrp,5,dr)*c1-(1-c2-c3))*...
        (jin(currNode,currGrp,2,dr)+jin(currNode,currGrp,1,dr))/h;
end

a(currNode,currGrp,1,:) = 1/(data.XSr(currComp,currGrp)+2*c1/h)*...
    (S-Jsum);
% Update a0 (node-average flux)
    