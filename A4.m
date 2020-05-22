%% A4.m
% Update source coefficients

q0(currNode,currGrp) = f0(currNode,currGrp) + squeeze(data.XSin(currComp,currGrp,:))'*a0(currNode,:)' - sum(l0(currNode,currGrp,:)); 

for i = 1:2
    q(currNode,currGrp,i,:) = squeeze(f(currNode,currGrp,i,:))' + squeeze(data.XSin(currComp,currGrp,:))'*squeeze(a(currNode,:,i,:)) - squeeze(l(currNode,currGrp,i,:))';
end
for i = 3:4
    q(currNode,currGrp,i,:) = squeeze(f(currNode,currGrp,i,:))' + squeeze(data.XSin(currComp,currGrp,:))'*squeeze(a(currNode,:,i,:));
end


%% Part A Question 4
%fprintf("A4\n");
q10(currNode,currGrp) = f0(currNode,currGrp);
for G = 1:data.ng
    q10(currNode,currGrp) = q10(currNode,currGrp) + data.XSin(currComp,currGrp,G)*a0(currNode,G);
end
q10(currNode,currGrp) = q10(currNode,currGrp) - l0(currNode,currGrp,1) - l0(currNode,currGrp,2);
for dir = 1:2
    for i = 1:4    
            q1(currNode,currGrp,i,dir) = f(currNode,currGrp,i,dir);
        for G = 1:data.ng
            q1(currNode,currGrp,i,dir) = q1(currNode,currGrp,i,dir) + data.XSin(currComp,currGrp,G)*a(currNode,G,i,dir);
        end
    end
    for i = 1:2
        for G = 1:data.ng
            q1(currNode,currGrp,i,dir) = q1(currNode,currGrp,i,dir) - l(currNode,currGrp,i,dir);
        end
    end
end


q(currNode,currGrp,1:2,:) = q1(currNode,currGrp,1:2,:);