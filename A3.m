%% Part A Question 3
% fprintf("A3\n");

l(currNode,currGrp,1) = (jout(currNode,currGrp,2,1)-jin(currNode,currGrp,2,1))/h+...
    (jout(currNode,currGrp,1,1)-jin(currNode,currGrp,1,1))/h;


if currNode == 1 % leftmost node; reflective boundary condition
    lkgL = l(currNode,currGrp,1);
else
    lkgL = (jout(currNode-1,currGrp,2,1)-jin(currNode-1,currGrp,2,1))/h+...
        (jout(currNode-1,currGrp,1,1)-jin(currNode-1,currGrp,1,1))/h;
end

if currNode == nodeDim % rightmost node; vacuum boundary condition
    l(currNode,currGrp,3) = (3*l(currNode,currGrp,1)-lkgL) / 8;
    l(currNode,currGrp,2) = l(currNode,currGrp,3)-l(currNode,currGrp,1);
else
    lkgR = (jout(currNode+1,currGrp,2,1)-jin(currNode+1,currGrp,2,1))/h+...
        (jout(currNode+1,currGrp,1,1)-jin(currNode+1,currGrp,1,1))/h;
    l(currNode,currGrp,2) = (lkgR - lkgL) / 4;
    l(currNode,currGrp,3) = (2*l(currNode,currGrp,1)-lkgR-lkgL) / 12;
end

