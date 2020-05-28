%% getPhis.m
% calculate phi_s

phi_x = zeros(nodeDim,nodeDim+1,data.ng);
for i = 1:nodeDim % row
    for j = 2:nodeDim
        currNode = (i-1)*nodeDim + j;
        for currGrp = 1:data.ng
            phi_x(i,j,currGrp) = alpha_x(i,j,currGrp) * phi(currNode-1,currGrp) + ...
                (1-alpha_x(i,j,currGrp)) * phi(currNode,currGrp) + ...
                beta_x(i,j,currGrp) * (phi(currNode,currGrp) + phi(currNode-1,currGrp));
        end
    end
    j = 1;
    currNode = (i-1)*nodeDim + j;
    for currGrp = 1:data.ng
        phi_x(i,j,currGrp) = (2*beta_x(i,j,currGrp)+1)*phi(currNode,currGrp);
    end
    j = nodeDim;
    currNode = (i-1)*nodeDim + j;
    for currGrp = 1:data.ng
        phi_x(i,j+1,currGrp) = 1/(2*BETA(i,j,currGrp))*...
            (Dx_tilde(i,j+1,currGrp)-Dx_hat(i,j+1,currGrp)+2*BETA(i,j,currGrp))*phi(currNode,currGrp);
    end
end

phi_y = zeros(nodeDim+1,nodeDim,data.ng);
for i = 1:nodeDim % column
    for j = 2:nodeDim
        currNode = i + (j-1)*nodeDim;
        for currGrp = 1:data.ng
            phi_y(j,i,currGrp) = alpha_y(j,i,currGrp) * phi(currNode-nodeDim,currGrp) + ...
                (1-alpha_y(j,i,currGrp)) * phi(currNode,currGrp) + ...
                beta_y(j,i,currGrp) * (phi(currNode,currGrp) + phi(currNode-nodeDim,currGrp));
        end
    end
    j = 1;
    currNode = i + (j-1)*nodeDim;
    for currGrp = 1:data.ng
        phi_y(j,i,currGrp) = (2*beta_y(j,i,currGrp)+1)*phi(currNode,currGrp);
    end
    j = nodeDim;
    currNode = i + (j-1)*nodeDim;
    for currGrp = 1:data.ng
        phi_y(j+1,i,currGrp) = 1/(2*BETA(i,j,currGrp))*...
            (Dy_tilde(j+1,i,currGrp)-Dy_hat(j+1,i,currGrp)+2*BETA(i,j,currGrp))*phi(currNode,currGrp);
    end
end