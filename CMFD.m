%% CMFD.m
% CMFD iteration

correction(); % calculate D_hat

matrix(); % setup CMFD matrix

flag = false;
stepCMFD = 0;
source(); % update source
% plotFlux()
while ~flag
    
    stepCMFD = stepCMFD + 1;
        
    source();
    
    GS(); % Gauss Seidel iteration
    
    if stepCMFD == 200
        flag = true;
    end
end
% plotFlux()
j_update(); % Update incoming current