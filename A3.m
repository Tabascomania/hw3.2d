%% Part A Question 3
% fprintf("A3\n");

l0(currNode,currGrp,:) = (jout(currNode,currGrp,2,:)-jin(currNode,currGrp,2,:))/h+...
    (jout(currNode,currGrp,1,:)-jin(currNode,currGrp,1,:))/h;


if ismember(currNode,westNodes) % leftmost node; reflective boundary condition
    lkgLx = l0(currNode,currGrp,1);
else
    lkgLx = (jout(currNode-1,currGrp,2,1)-jin(currNode-1,currGrp,2,1))/h+...
        (jout(currNode-1,currGrp,1,1)-jin(currNode-1,currGrp,1,1))/h;
end

if ismember(currNode,eastNodes) % rightmost node; vacuum boundary condition
    l(currNode,currGrp,2,1) = (3*l0(currNode,currGrp,1)-lkgLx) / 8;
    l(currNode,currGrp,1,1) = l(currNode,currGrp,2,1)-l0(currNode,currGrp,1);
else
    lkgRx = (jout(currNode+1,currGrp,2,1)-jin(currNode+1,currGrp,2,1))/h+...
        (jout(currNode+1,currGrp,1,1)-jin(currNode+1,currGrp,1,1))/h;
    l(currNode,currGrp,1,1) = (lkgRx - lkgLx) / 4;
    l(currNode,currGrp,2,1) = (2*l0(currNode,currGrp,1)-lkgRx-lkgLx) / 12;
end

if ismember(currNode,northNodes) % leftmost node; reflective boundary condition
    lkgLy = l0(currNode,currGrp,2);
else
    lkgLy = (jout(currNode-1,currGrp,2,2)-jin(currNode-1,currGrp,2,2))/h+...
        (jout(currNode-1,currGrp,1,2)-jin(currNode-1,currGrp,1,2))/h;
end

if ismember(currNode,southNodes) % rightmost node; vacuum boundary condition
    l(currNode,currGrp,2,2) = (3*l0(currNode,currGrp,2)-lkgLx) / 8;
    l(currNode,currGrp,1,2) = l(currNode,currGrp,2,2)-l0(currNode,currGrp,2);
else
    lkgRy = (jout(currNode+1,currGrp,2,2)-jin(currNode+1,currGrp,2,2))/h+...
        (jout(currNode+1,currGrp,1,2)-jin(currNode+1,currGrp,1,2))/h;
    l(currNode,currGrp,1,2) = (lkgRy - lkgLy) / 4;
    l(currNode,currGrp,2,2) = (2*l0(currNode,currGrp,2)-lkgRy-lkgLy) / 12;
end