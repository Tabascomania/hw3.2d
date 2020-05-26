%% cmfd_setup.m
% Setup CMFD variables

beta = zeros(nodeDim,nodeDim,data.ng);

for i = 1:nodeDim
    for j = 1:nodeDim
        currNode = (i-1)*nodeDim + j;
        currComp = node2comp(currNode);
        for currGrp = 1:data.ng
            beta(i,j,currGrp) = data.D(currComp,currGrp) / h;
        end
    end
end

Dx_tilde = zeros(nodeDim,nodeDim+1,data.ng); % [row, surface, group]
for i = 1:nodeDim
    for currGrp = 1:data.ng
        Dx_tilde(i,1,currGrp) = 0; % Reflective boundary condition
        Dx_tilde(i,nodeDim+1,currGrp) = 2 * beta(i,nodeDim,currGrp); % Vacuum boundary condition
        for j = 2:nodeDim
            Dx_tilde(i,j,currGrp) = 2*beta(i,j-1,currGrp)*beta(i,j,currGrp)/...
                (beta(i,j-1,currGrp)+beta(i,j,currGrp));
        end
    end
    
end

Dy_tilde = zeros(nodeDim+1,nodeDim,data.ng); % [surface, column, group]
for i = 1:nodeDim
    for currGrp = 1:data.ng
        Dy_tilde(1,i,currGrp) = 0; % Reflective boundary condition
        Dy_tilde(nodeDim+1,i,currGrp) = 2 * beta(nodeDim,i,currGrp); % Vacuum boundary condition
        for j = 2:nodeDim
            Dy_tilde(j,i,currGrp) = 2*beta(j-1,i,currGrp)*beta(j,i,currGrp)/...
                (beta(j-1,i,currGrp)+beta(j,i,currGrp));
        end
    end    
end