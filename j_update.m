%% j_update.m
% Update incoming current

for i = 1:nodeDim % row
    for j = 1:nodeDim-1
        currNode = (i-1)*nodeDim + j;
        for currGrp = 1:data.ng
            jin(currNode,currGrp,2,1) = 1/4*phi_x(i,j+1,currGrp) - 1/2*Js_x(i,j+1,currGrp);
        end
    end
    for j = 1:nodeDim
        currNode = (i-1)*nodeDim + j;
        for currGrp = 1:data.ng
            jin(currNode,currGrp,1,1) = 1/4*phi_x(i,j,currGrp) + 1/2*Js_x(i,j,currGrp);
        end
    end
end

for i = 1:nodeDim % column
    for j = 1:nodeDim-1
        currNode = i + (j-1)*nodeDim;
        for currGrp = 1:data.ng
            jin(currNode,currGrp,2,2) = 1/4*phi_y(i,j+1,currGrp) - 1/2*Js_y(i,j+1,currGrp);
        end
    end
    for j = 1:nodeDim
        currNode = i + (j-1)*nodeDim;
        for currGrp = 1:data.ng
            jin(currNode,currGrp,1,2) = 1/4*phi_y(i,j,currGrp) + 1/2*Js_y(i,j,currGrp);
        end
    end
end