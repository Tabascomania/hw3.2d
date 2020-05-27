%% source.m
% update source

RHS = zeros(totalNodes,data.ng);
for currNode = 1:totalNodes
    currComp = node2comp(currNode);
    src = 0;
    for currGrp = 1:data.ng
        src = src + data.XSf(currComp,currGrp)*phi(currNode,currGrp);
    end
    for currGrp = 1:data.ng
        RHS(currNode,currGrp) = 1/k_CMFD * data.Chi(currComp,currGrp) * src;
    end
    for currGrp = 1:data.ng
        for G = 1:data.ng
            RHS(currNode,currGrp) = RHS(currNode,currGrp) + data.XSin(currComp,currGrp,G) * phi(currNode,G);
        end
    end
end