%% fisSrc.m
% Determine fission source

f0(currNode,currGrp) = 1/k(stepOut)*data.Chi(currComp,currGrp)*data.XSf(currComp,:)*a0(currNode,:)';

for i = 1:4
    f(currNode,currGrp,i,:) = 1/k(stepOut)*data.Chi(currComp,currGrp)*data.XSf(currComp,:)*squeeze(a(currNode,:,i,:));
end


%% Part A Question 4
% f10(currNode,currGrp) = 0;
% for G = 1:data.ng
%     f10(currNode,currGrp) = f10(currNode,currGrp) + 1/k(stepOut) * data.Chi(currComp,currGrp) *...
%     data.XSf(currComp,G) * a0(currNode,G);
% end
% for dir = 1:2
%     for i = 1:4    
%         f1(currNode,currGrp,i,dir) = 0;
%            for G = 1:data.ng
%             f1(currNode,currGrp,i,dir) = f1(currNode,currGrp,i,dir) + 1/k(stepOut) * data.Chi(currComp,currGrp) *...
%                 data.XSf(currComp,G) * a(currNode,G,i,dir);
%         end
%     end
% end
% f0(currNode,currGrp) = f10(currNode,currGrp);
% f(currNode,currGrp,1:4,1:2) = f1(currNode,currGrp,1:4,1:2);