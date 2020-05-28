%% matrix.m
% setup CMFD matrix

gamma = zeros(totalNodes,data.ng,4); % 1:north, 2:west, 3:east, 4:south
d = zeros(totalNodes,data.ng);
for i = 1:nodeDim
    for j = 1:nodeDim
        currNode = (i-1)*nodeDim + j;
        inb = nb(currNode,:);
        currComp = node2comp(currNode);
        for currGrp = 1:data.ng
            if inb(1) ~= -1 % not a north node
                gamma(currNode,currGrp,1) = -1/h*(Dy_tilde(j,i,currGrp)+Dy_hat(j,i,currGrp));
                d(currNode,currGrp) = d(currNode,currGrp) + 1/h*(Dy_tilde(j,i,currGrp)-Dy_hat(j,i,currGrp));
            end
            if inb(2) ~= -1 % not a west node
                gamma(currNode,currGrp,2) = -1/h*(Dx_tilde(i,j,currGrp)+Dx_hat(i,j,currGrp));
                d(currNode,currGrp) = d(currNode,currGrp) + 1/h*(Dx_tilde(i,j,currGrp)-Dx_hat(i,j,currGrp));
            end
            if inb(3) ~= -1 % not an east node
                gamma(currNode,currGrp,3) = -1/h*(Dx_tilde(i,j+1,currGrp)-Dx_hat(i,j+1,currGrp));
                d(currNode,currGrp) = d(currNode,currGrp) + 1/h*(Dx_tilde(i,j+1,currGrp)+Dx_hat(i,j+1,currGrp));
            end
            if inb(4) ~= -1 % not a south node
                gamma(currNode,currGrp,4) = -1/h*(Dy_tilde(j+1,i,currGrp)-Dy_hat(j+1,i,currGrp));
                d(currNode,currGrp) = d(currNode,currGrp) + 1/h*(Dy_tilde(j+1,i,currGrp)+Dy_hat(j+1,i,currGrp));
            end
            d(currNode,currGrp) = d(currNode,currGrp) + data.XSr(currComp,currGrp);
        end
    end
end

