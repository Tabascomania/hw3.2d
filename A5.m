%% A5.m
% Update flux coefficients

phiR = 2*(jout(currNode,currGrp,2,:)+jin(currNode,currGrp,2,:));
phiL = 2*(jout(currNode,currGrp,1,:)+jin(currNode,currGrp,1,:));
a(currNode,currGrp,1,:) = (phiR-phiL)/2; % Update a1
a(currNode,currGrp,2,:) = a0(currNode,currGrp)-(phiR+phiL)/2; % Update a2   

a(currNode,currGrp,3,:) = (5*q(currNode,currGrp,1,:)+3*q(currNode,currGrp,3,:)-...
    5*a(currNode,currGrp,1,:)*data.XSr(currComp,currGrp))/...
    (3*(60*data.XSD(currComp,currGrp)+data.XSr(currComp,currGrp))); % Update a3
a(currNode,currGrp,4,:) = (-7*q(currNode,currGrp,2,:)+3*q(currNode,currGrp,4,:)+...
    7*a(currNode,currGrp,2,:)*data.XSr(currComp,currGrp))/...
    (3*(140*data.XSD(currComp,currGrp)+data.XSr(currComp,currGrp))); % Update a4


% Source calculation
S = 1/k(stepOut)*data.Chi(currComp,currGrp)*data.XSf(currComp,:)*a0(currNode,:)'+...
    squeeze(data.XSin(currComp,currGrp,:))'*a0(currNode,:)';
beta = data.D(currComp,currGrp)/h;
c1 = (6*beta)/(1+12*beta);
c2 = (-8*beta)/((1+4*beta)*(1+12*beta));
c3 = (1-48*beta^2)/((1+4*beta)*(1+12*beta));
c4 = (6*beta)/(1+4*beta);

Jsum=0;
for dr=1:2
    Jsum=Jsum+(2*a(currNode,currGrp,4,dr)*c1-(1-c2-c3))*...
        (jin(currNode,currGrp,2,dr)+jin(currNode,currGrp,1,dr))/h;
end
a0(currNode,currGrp) = 1/(data.XSr(currComp,currGrp)+4*c1/h)*(S-Jsum); % Update a0 (node-average flux)
    