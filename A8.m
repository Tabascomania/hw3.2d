%% Part A Question 8
% fprintf("A8\n");

stepOut = stepOut + 1; % Increment outer iteration step counter

fprintf("Average flux level : %f\n",norm(a(:,:,1)));

% Obtain the 1-group fission source (psi)
psi(stepOut,:) = zeros(nodeDim2,1);
for i = 1:nodeDim2
    currComp = node2comp(i);
    for G = 1:data.ng
        psi(stepOut,i) = psi(stepOut,i) + data.XSf(currComp,G) * a(i,G,1);
    end
end

if stepOut > 2
    k(stepOut) = k(stepOut-1) * dot(psi(stepOut,:),psi(stepOut,:))/dot(psi(stepOut,:),psi(stepOut-1,:));
else
    k(stepOut) = 1;
    %k(stepOut) = k(stepOut-1) * norm(psi(stepOut,:))/psi_1G;
end

if stepOut > 2
    if abs(k(stepOut)-k(stepOut-1))/k(stepOut) < epsk
        if norm(psi(stepOut,:)-psi(stepOut-1,:))/norm(psi(stepOut,:)) < epspsi
            flag = true; % Signal outer iteration convergence
        end
    end
end

if flag == true
    % obtain assembly-wise absorption rate distribution
end

