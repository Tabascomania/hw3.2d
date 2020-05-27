%% getBeta.m
% calculate beta

beta_x = zeros(nodeDim,nodeDim+1,data.ng);
for i = 1:nodeDim
    for j = 2:nodeDim
        currNode = (i-1)*nodeDim + j;
        for currGrp = 1:data.ng
            beta_x(i,j,currGrp) = (2*(jout(currNode-1,currGrp,2,1)+jout(currNode,currGrp,1,1))-...
                alpha_x(i,j,currGrp)*a0(currNode-1,currGrp)-(1-alpha_x(i,j,currGrp))*a0(currNode,currGrp))/...
                (a0(currNode,currGrp)+a0(currNode-1,currGrp));
        end
    end
end

beta_y = zeros(nodeDim+1,nodeDim,data.ng);
for i = 1:nodeDim
    for j = 2:nodeDim
        currNode = i + (j-1)*nodeDim;
        for currGrp = 1:data.ng
            beta_y(j,i,currGrp) = (2*(jout(currNode-nodeDim,currGrp,2,2)+jout(currNode,currGrp,1,2))-...
                alpha_y(j,i,currGrp)*a0(currNode-nodeDim,currGrp)-(1-alpha_y(j,i,currGrp))*a0(currNode,currGrp))/...
                (a0(currNode,currGrp)+a0(currNode-nodeDim,currGrp));
        end
    end
end