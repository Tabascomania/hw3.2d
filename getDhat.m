%% getDhat.m
% calculate D_hat

Jx = zeros(nodeDim,nodeDim+1,data.ng); % [row, surface, group]
for i = 1:nodeDim % row
    for j = 1:nodeDim-1 
        currNode = (i-1)*nodeDim + j;
        for currGrp = 1:data.ng
            Jx(i,j+1,currGrp) = jout(currNode,currGrp,2,1) - jout(currNode+1,currGrp,1,1);
        end
    end
    j = nodeDim;
    currNode = (i-1)*nodeDim + j;
    for currGrp = 1:data.ng
        Jx(i,j+1,currGrp) = jout(currNode,currGrp,2,1);
    end
end
Dx_hat = zeros(nodeDim,nodeDim+1,data.ng); % [row, surface, group]
for i = 1:nodeDim % row
    for j = 1:nodeDim-1
        currNode = (i-1)*nodeDim + j;
        for currGrp = 1:data.ng
            Dx_hat(i,j+1,currGrp) = (Jx(i,j+1,currGrp)+Dx_tilde(i,j+1,currGrp)*...
                (a0(currNode+1,currGrp)-a0(currNode,currGrp)))/...
                (a0(currNode+1,currGrp)+a0(currNode,currGrp));
        end
    end
    j = 1;
    currNode = (i-1)*nodeDim + j;
    for currGrp = 1:data.ng
        Dx_hat(i,1,currGrp) = (Jx(i,1,currGrp)+Dx_tilde(i,1,currGrp)*...
            a0(currNode,currGrp))/a0(currNode,currGrp);
    end
    j = nodeDim;
    currNode = (i-1)*nodeDim + j;
    for currGrp = 1:data.ng
        Dx_hat(i,j+1,currGrp) = (Jx(i,j+1,currGrp)+Dx_tilde(i,j+1,currGrp)*...
            a0(currNode,currGrp))/a0(currNode,currGrp);
    end
end

Jy = zeros(nodeDim+1,nodeDim,data.ng); % [surface, column, group]
for i = 1:nodeDim
    for j = 1:nodeDim-1
        currNode = i + (j-1)*nodeDim;
        for currGrp = 1:data.ng
            Jy(j+1,i,currGrp) = jout(currNode,currGrp,2,2) - jout(currNode+nodeDim,currGrp,1,2);
        end
    end
    j = nodeDim;
    currNode = i + (j-1)*nodeDim;
    for currGrp = 1:data.ng
        Jy(j+1,i,currGrp) = jout(currNode,currGrp,2,2);
    end
end
Dy_hat = zeros(nodeDim+1,nodeDim,data.ng); % [surface, column, group]
for i = 1:nodeDim % column
    for j = 1:nodeDim-1
        currNode = i + (j-1)*nodeDim;
        for currGrp = 1:data.ng
            Dy_hat(j+1,i,currGrp) = (Jy(j+1,i,currGrp)+Dy_tilde(j+1,i,currGrp)*...
                (a0(currNode+nodeDim,currGrp)-a0(currNode,currGrp)))/...
                (a0(currNode+nodeDim,currGrp)+a0(currNode,currGrp));
        end
    end
    j = 1;
    currNode = i + (j-1)*nodeDim;
    for currGrp = 1:data.ng
        Dy_hat(j,i,currGrp) = (Jy(j,i,currGrp)+Dy_tilde(j,i,currGrp)*...
            a0(currNode,currGrp))/a0(currNode,currGrp);
    end
    j = nodeDim;
    currNode = i + (j-1)*nodeDim;
    for currGrp = 1:data.ng
        Dy_hat(j+1,i,currGrp) = (Jy(j+1,i,currGrp)+Dy_tilde(j+1,i,currGrp)*...
            a0(currNode,currGrp))/a0(currNode,currGrp);
    end
end