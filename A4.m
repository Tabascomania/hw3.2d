%% A4.m
% Update source coefficients

% q0(currNode,currGrp) = f0(currNode,currGrp); 
% q0(currNode,currGrp) = f0(currNode,currGrp) + squeeze(data.XSin(currComp,currGrp,:))'*a0(currNode,:)' - sum(l0(currNode,currGrp,:));
% 
% for dir = 1:2
%     for i = 1:2
%         q(currNode,currGrp,i,dir) = squeeze(f(currNode,currGrp,i,dir))' + squeeze(data.XSin(currComp,currGrp,:))'*squeeze(a(currNode,:,i,dir))' - squeeze(l(currNode,currGrp,i,dir))';
%     end
%     for i = 3:4
%         q(currNode,currGrp,i,dir) = squeeze(f(currNode,currGrp,i,dir))' + squeeze(data.XSin(currComp,currGrp,:))'*squeeze(a(currNode,:,i,dir))';
%     end
% end

q0(currNode,currGrp) = f0(currNode,currGrp);
InScat = 0;
for G = 1:data.ng
    InScat = InScat + data.XSin(currComp,currGrp,G)*a0(currNode,G);
end
q0(currNode,currGrp) = InScat - l0(currNode,currGrp,1) - l0(currNode,currGrp,2);
for dir = 1:2
    for i = 1:4    
            q(currNode,currGrp,i,dir) = f(currNode,currGrp,i,dir);
        for G = 1:data.ng
            q(currNode,currGrp,i,dir) = q(currNode,currGrp,i,dir) + data.XSin(currComp,currGrp,G)*a(currNode,G,i,dir);
        end
    end
    for i = 1:2
        for G = 1:data.ng
            q(currNode,currGrp,i,dir) = q(currNode,currGrp,i,dir) - l(currNode,currGrp,i,dir);
        end
    end
end

% q0(currNode,currGrp) = q10(currNode,currGrp);
% q(currNode,currGrp,1:2,:) = q1(currNode,currGrp,1:2,:);