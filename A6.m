%% Part A Question 6: Response matrix
% fprintf("A6\n");

A = [c3,c2,0,0,c1;...
    c2,c3,0,0,c1;...
    0,0,c3,c2,c1;...
    0,0,c2,c3,c1];
x = [jin(currNode,currGrp,1,1);jin(currNode,currGrp,2,1);...
    jin(currNode,currGrp,1,2);jin(currNode,currGrp,2,2);a(currNode,currGrp,1,1)];
b = [c1*a(currNode,currGrp,5,1)-c4*a(currNode,currGrp,4,1);...
    c1*a(currNode,currGrp,5,1)+c4*a(currNode,currGrp,4,1);...
    c1*a(currNode,currGrp,5,2)-c4*a(currNode,currGrp,4,2);...
    c1*a(currNode,currGrp,5,2)+c4*a(currNode,currGrp,4,2)];

y = A*x+b; % Update current
jout(currNode,currGrp,:,1)=y(1:2,1);
jout(currNode,currGrp,:,2)=y(3:4,1);

rr=mod(currNode,nodeDim);
qq=(currNode-rr)/nodeDim;
if ~ (rr == 1) % If there is a node on the left...
    jin(currNode-1,currGrp,2,1) = jout(currNode,currGrp,1,1);
end
if ~ (rr == 0) % If there is a node on the right
    jin(currNode+1,currGrp,1,1) = jout(currNode,currGrp,2,1);
end
if ~ (qq == 0) % If there is a node above...
    jin(currNode-1,currGrp,2,2) = jout(currNode,currGrp,1,2);
end
if ~ (qq == nodeDim-1) % If there is a node below
    jin(currNode+1,currGrp,1,2) = jout(currNode,currGrp,2,2);
end

if rr == 0
    jin(currNode,currGrp,1,1) = jout(currNode,currGrp,1,1); % Reflective boundary condition
end
if qq==0
    jin(currNode,currGrp,1,2) = jout(currNode,currGrp,2,2);
end