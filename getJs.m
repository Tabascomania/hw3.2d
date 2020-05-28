%% getJs.m
% calculate J_s

Js_x = zeros(nodeDim,nodeDim+1,data.ng);
for i = 1:nodeDim % row
    for j = 2:nodeDim
        currNode = (i-1)*nodeDim + j;
        for currGrp = 1:data.ng
            Js_x(i,j,currGrp) = -Dx_tilde(i,j,currGrp)*(phi(currNode-1,currGrp)-phi(currNode,currGrp))+...
                Dx_hat(i,j,currGrp)*(phi(currNode-1,currGrp)+a0(currNode,currGrp));
        end        
    end
    j = 1;
    currNode = (i-1)*nodeDim + j;
    for currGrp = 1:data.ng
        Js_x(i,j,currGrp) = (-Dx_tilde(i,j,currGrp)+Dx_hat(i,j,currGrp))*phi(currNode,currGrp);
    end
    j = nodeDim;
    currNode = (i-1)*nodeDim + j;
    for currGrp = 1:data.ng
        Js_x(i,j+1,currGrp) = (-Dx_tilde(i,j+1,currGrp)+Dx_hat(i,j+1,currGrp))*phi(currNode,currGrp);
    end
end

Js_y = zeros(nodeDim+1,nodeDim,data.ng);
for i = 1:nodeDim % column
    for j = 2:nodeDim
        currNode = i + (j-1)*nodeDim;
        for currGrp = 1:data.ng
            Js_y(j,i,currGrp) = -Dy_tilde(j,i,currGrp)*(phi(currNode-nodeDim,currGrp)-phi(currNode,currGrp))+...
                Dy_hat(j,i,currGrp)*(phi(currNode-nodeDim,currGrp)+phi(currNode,currGrp));
        end        
    end
    j = 1;
    currNode = i + (j-1)*nodeDim;
    for currGrp = 1:data.ng
        Js_y(j,i,currGrp) = (-Dy_tilde(j,i,currGrp)+Dy_hat(j,i,currGrp))*phi(currNode,currGrp);
    end
    j = nodeDim;
    currNode = i + (j-1)*nodeDim;
    for currGrp = 1:data.ng
        Js_y(j+1,i,currGrp) = (-Dy_tilde(j+1,i,currGrp)+Dy_hat(j+1,i,currGrp))*phi(currNode,currGrp);
    end
end