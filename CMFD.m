%% CMFD.m
% CMFD iteration

getBeta(); % calculate beta

getDhat(); % calculate D_hat

matrix(); % setup CMFD matrix

flag = false;
stepCMFD = 0;

phi = a0;


% plotFlux()
% gamma = permute(gamma,[1 3 2]);

k_CMFD = k(stepOut);
psi_CMFD = zeros(totalNodes);
source(); % update source

for currNode = 1:totalNodes
    currComp = node2comp(currNode);
    for currGrp = 1:data.ng
        psi_CMFD(currNode) = psi_CMFD(currNode) + ...
            data.XSf(currComp,currGrp)*phi(currNode,currGrp);
    end
end

while ~flag
    
    stepCMFD = stepCMFD + 1;
        
    source();
    
    
%     [DL,DU,L,U] = preparation(gamma,d,data.ng,[nodeDim,nodeDim]);
%     for g = 1:data.ng
%         [phi_g,nin] = inner_iteration(DL(:,:,g),DU(:,:,:,g),L(:,:,g),U(:,:,g),a0(:,g),RHS(:,g),1.2,[nodeDim,nodeDim],50);
%         a0(:,g) = phi_g;
%     end

    GS(); % Gauss Seidel iteration
    
%     prevK_CMFD = k_CMFD;
%     prevPsi_CMFD = psi_CMFD;
%     psi_CMFD = zeros(totalNodes);
%     
%     for currNode = 1:totalNodes
%         currComp = node2comp(currNode);
%         for currGrp = 1:data.ng
%             psi_CMFD(currNode) = psi_CMFD(currNode) + ...
%                 data.XSf(currComp,currGrp)*phi(currNode,currGrp);
%         end
%     end
%     
%     k_CMFD = k_CMFD * norm(psi_CMFD' * psi_CMFD)/norm(psi_CMFD'*prevPsi_CMFD);
    
    if stepCMFD == 1
        flag = true;
    end
end
% plotFlux()

getJs(); % calculate J_s

getPhis(); % calculate phi_s

j_update(); % Update incoming current

% a0 = phi;