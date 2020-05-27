%% cmfd_setup.m
% Setup CMFD variables (D_tilde,alpha)

BETA = zeros(nodeDim,nodeDim,data.ng);

for i = 1:nodeDim % row
    for j = 1:nodeDim % column
        currNode = (i-1)*nodeDim + j;
        currComp = node2comp(currNode);
        for currGrp = 1:data.ng
            BETA(i,j,currGrp) = data.D(currComp,currGrp) / h;
        end
    end
end

Dx_tilde = zeros(nodeDim,nodeDim+1,data.ng); % [row, surface, group]
alpha_x = zeros(nodeDim,nodeDim+1,data.ng);
for i = 1:nodeDim
    for currGrp = 1:data.ng
        Dx_tilde(i,1,currGrp) = 0; % Reflective boundary condition
        Dx_tilde(i,nodeDim+1,currGrp) = 2 * BETA(i,nodeDim,currGrp); % Vacuum boundary condition
        for j = 2:nodeDim
            Dx_tilde(i,j,currGrp) = 2*BETA(i,j-1,currGrp)*BETA(i,j,currGrp)/...
                (BETA(i,j-1,currGrp)+BETA(i,j,currGrp));
            alpha_x(i,j,currGrp) = BETA(i,j-1,currGrp)/(BETA(i,j-1,currGrp)+BETA(i,j,currGrp));
        end
    end
    
end

Dy_tilde = zeros(nodeDim+1,nodeDim,data.ng); % [surface, column, group]
alpha_y = zeros(nodeDim+1,nodeDim,data.ng);
for i = 1:nodeDim
    for currGrp = 1:data.ng
        Dy_tilde(1,i,currGrp) = 0; % Reflective boundary condition
        Dy_tilde(nodeDim+1,i,currGrp) = 2 * BETA(nodeDim,i,currGrp); % Vacuum boundary condition
        for j = 2:nodeDim
            Dy_tilde(j,i,currGrp) = 2*BETA(j-1,i,currGrp)*BETA(j,i,currGrp)/...
                (BETA(j-1,i,currGrp)+BETA(j,i,currGrp));
            alpha_y(j,i,currGrp) = BETA(j-1,i,currGrp)/(BETA(j-1,i,currGrp)+BETA(j,i,currGrp));
        end
    end    
end