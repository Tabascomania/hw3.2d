%% Part A Question 8
% fprintf("A8\n");

stepOut = stepOut + 1; % Increment outer iteration step counter
prevPsi = psi;
fprintf("Average flux level : %f\n",norm(a(:,:,1)));

% Obtain the 1-group fission source (psi)
psi = zeros(totalNodes,1);
for i = 1:totalNodes
    currComp = node2comp(i);
    for G = 1:data.ng
        psi(i) = psi(i) + data.XSf(currComp,G) * a0(i,G);
    end
end

k(stepOut) = k(stepOut-1) * dot(psi,psi)/dot(psi,prevPsi);

if stepOut > 2
    if abs(k(stepOut)-k(stepOut-1))/k(stepOut) < epsk
        if norm(psi-prevPsi)/norm(psi) < epspsi
            flag = true; % Signal outer iteration convergence
        end
    end
end

if flag == true
    % obtain assembly-wise absorption rate distribution
end

