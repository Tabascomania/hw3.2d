%% A4.m
% Update source coefficients

q0(currNode,currGrp) = 1/k(stepOut)*data.Chi(currComp,currGrp)*data.XSf(currComp,:)*a0(currNode,:)'+...
    squeeze(data.XSin(currComp,currGrp,:))'*a0(currNode,:)' - sum(l0(currNode,currGrp,:)); 

for i = 1:2
    q(currNode,currGrp,i,:) = 1/k(stepOut)*data.Chi(currComp,currGrp)*data.XSf(currComp,:)*squeeze(a(currNode,:,i,:)) + ...
        squeeze(data.XSin(currComp,currGrp,:))'*squeeze(a(currNode,:,i,:)) - squeeze(l(currNode,currGrp,i,:))';
end
for i = 3:4
    q(currNode,currGrp,i,:) = 1/k(stepOut)*data.Chi(currComp,currGrp)*data.XSf(currComp,:)*squeeze(a(currNode,:,i,:)) + ...
        squeeze(data.XSin(currComp,currGrp,:))'*squeeze(a(currNode,:,i,:));
end