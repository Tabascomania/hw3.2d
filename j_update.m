%% j_update.m
% Update incoming current

for i = 1:nodeDim % row
    for j = 1:nodeDim-1 % right
        currNode = (i-1)*nodeDim + j;
        for currGrp = 1:data.ng
            jout(currNode,currGrp,2,1) = -Dx_tilde(i,j+1,currGrp)*...
                (a0(currNode+1,currGrp)-a0(currNode,currGrp))+...
                Dx_hat(i,j+1,currGrp)*(a0(currNode+1,currGrp)+a0(currNode,currGrp));
        end
    end
    for j = 2:nodeDim % left
        currNode = (i-1)*nodeDim + j;
        for currGrp = 1:data.ng
            jout(currNode,currGrp,1,1) = -Dx_tilde(i,j,currGrp)*...
                (a0(currNode,currGrp)-a0(currNode-1,currGrp))+...
                Dx_hat(i,j,currGrp)*(a0(currNode,currGrp)+a0(currNode-1,currGrp));
        end
    end
    currNode = (i-1)*nodeDim + 1; % left boundary
    jout(currNode,currGrp,1,1) = -Dx_tilde(i,1,currGrp)*a0(currNode,currGrp)+...
        Dx_hat(i,1,currGrp)*a0(currNode,currGrp);
    currNode = i*nodeDim; % right boundary
    jout(currNode,currGrp,2,1) = -Dx_tilde(i,nodeDim+1,currGrp)*a0(currNode,currGrp)+...
        Dx_hat(i,nodeDim+1,currGrp)*a0(currNode,currGrp);
end

for i = 1:nodeDim % column
    for j = 1:nodeDim-1 % bottom
        currNode = i + (j-1)*nodeDim;
        for currGrp = 1:data.ng
            jout(currNode,currGrp,2,2) = -Dy_tilde(j+1,i,currGrp)*...
                (a0(currNode+nodeDim,currGrp)-a0(currNode,currGrp))+...
                Dy_hat(j+1,i,currGrp)*(a0(currNode+nodeDim,currGrp)+a0(currNode,currGrp));
        end
    end
    for j = 2:nodeDim % top
        currNode = i + (j-1)*nodeDim;
        for currGrp = 1:data.ng
            jout(currNode,currGrp,1,2) = -Dy_tilde(j,i,currGrp)*...
                (a0(currNode,currGrp)-a0(currNode-nodeDim,currGrp))+...
                Dy_hat(j,i,currGrp)*(a0(currNode,currGrp)+a0(currNode-nodeDim,currGrp));
        end
    end
    currNode = i; % top boundary
    jout(currNode,currGrp,1,2) = -Dy_tilde(1,i,currGrp)*a0(currNode,currGrp)+...
        Dy_hat(1,i,currGrp)*a0(currNode,currGrp);
    currNode = i + (totalNodes - nodeDim); % bottom boundary
    jout(currNode,currGrp,2,2) = -Dy_tilde(nodeDim+1,i,currGrp)*a0(currNode,currGrp)+...
        Dy_hat(nodeDim+1,i,currGrp)*a0(currNode,currGrp);
end

for currNode = 1:totalNodes
    for currGrp = 1:data.ng
        inb = nb(currNode,:);

        if inb(2) ~= -1 % If there is a node on the left...
            jin(currNode-1,currGrp,2,1) = jout(currNode,currGrp,1,1);
        end
        if inb(3) ~= -1 % If there is a node on the right
            jin(currNode+1,currGrp,1,1) = jout(currNode,currGrp,2,1);
        end
        if inb(1) ~= -1 % If there is a node above...
            jin(currNode-nodeDim,currGrp,2,2) = jout(currNode,currGrp,1,2);
        end
        if inb(4) ~= -1 % If there is a node below
            jin(currNode+nodeDim,currGrp,1,2) = jout(currNode,currGrp,2,2);
        end

        if inb(1) == -1
            jin(currNode,currGrp,1,2) = jout(currNode,currGrp,1,2); % Reflective boundary condition
        end
        if inb(2) == -1
            jin(currNode,currGrp,1,1) = jout(currNode,currGrp,1,1); % Reflective boundary condition
        end
    end
end