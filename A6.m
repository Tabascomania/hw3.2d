%% Part A Question 6: Response matrix
% fprintf("A6\n");

A = [c3,c2,c1;c2,c3,c1];
x = [jin(currNode,currGrp,1,1);jin(currNode,currGrp,2,1);a(currNode,currGrp,1)];
b = [c1*a(currNode,currGrp,5)-c4*a(currNode,currGrp,4);...
    c1*a(currNode,currGrp,5)+c4*a(currNode,currGrp,4)];

% A = [c1,c2,c0;c2,c1,c0];
% b = [-c3*a(currNode,currGrp,4)+c4*a(currNode,currGrp,5);c3*a(currNode,currGrp,4)+c4*a(currNode,currGrp,5)];

jout(currNode,currGrp,:,1) = A*x+b; % Update outgoing current

% 위에 걸 그냥 explicit하게 나타낸 거
% jout(currNode,currGrp,1,1) = c1*(a(currNode,currGrp,1)+a(currNode,currGrp,5))+c2*jin(currNode,currGrp,2,1)+...
%     c3*jin(currNode,currGrp,1,1)-c4*a(currNode,currGrp,4);
% jout(currNode,currGrp,2,1) = c1*(a(currNode,currGrp,1)+a(currNode,currGrp,5))+c3*jin(currNode,currGrp,2,1)+...
%     c2*jin(currNode,currGrp,1,1)+c4*a(currNode,currGrp,4);

if currNode - 1 >= 1 % If there is a node on the left...
    jin(currNode-1,currGrp,2,1) = jout(currNode,currGrp,1,1);
end
if currNode + 1 <= nodeDim % If there is a node on the right
    jin(currNode+1,currGrp,1,1) = jout(currNode,currGrp,2,1);
end

if currNode == 1
    jin(1,currGrp,1,1) = jout(1,currGrp,1,1); % Reflective boundary condition
end