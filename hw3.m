clear all
clc
close all

%% Reactor Numerical Analysis and Design
% HW#3: One-node NEM calculation for NEACRP-L336

%% Part A. Preparation of the Code
tic
nodeCount = 8; % number of nodes per direction per assembly
assemConf = [1,2,3;2,1,3;3,3,3]; % core configuration (loading pattern)

initialize(); % Define reactor core
A1(); % Setup variables

stepOut = 1; % outer iteration step counter
epsk = 1e-06; % eigenvalue convergence criterion
epspsi = 1e-05; % fission source convergence criterion
flagOut = false; % convergence indicator for outer iteration

k(stepOut) = 1.0; % Initial eigenvalue guess
    
psi = zeros(totalNodes,1);
for i = 1:totalNodes
    currComp = node2comp(i);
    for currGrp = 1:data.ng
        psi(i) = psi(i) + data.XSf(currComp,currGrp) * a0(i,currGrp);
    end
end

lkg = zeros(totalNodes,data.ng,3);



while ~flagOut % Repeat outer iteration until convergence
        
    fprintf("Outer iteration #%d\n",stepOut);
    fprintf("Current k : %f\n",k(stepOut));
    A2(); % Obtain initial residual
%     fprintf("Current r0 : %f\n",r0)
%     fprintf("Current psi_1G : %f\n", psi_1G)

    for n = 1:totalNodes % Node sweep
        currNode = nodeOrder(n);
        currComp = node2comp(currNode); % Material composition for this node
        for currGrp = 1:data.ng % Group sweep
            fisSrc(); % Determine fission source
        end
    end
    
    stepIn = 1; % inner iteration step counter
    epsin = 0.01; % inner iteration convergence condition
    flagIn = false; % Convergence indicator for inner iteration
    
    
    while ~flagIn % Repeat inner iteration until convergence
        
        for n = 1:totalNodes % Node sweep
            currNode = nodeOrder(n);
            currComp = node2comp(currNode); % Material composition for this node
            for currGrp = 1:data.ng % Group sweep
                A3(); % Leakge quadratic expansion
                A4(); % Update source coefficients
                A5(); % Update flux coefficients
                A6(); % Update outgoing partial currents
            end
        end
        
        A7(); % Obtain residual
    end
    
    A8(); % Update fission source and k-eigenvalue
    fprintf("\n");
end
toc
fprintf("Eigenvalue: %.10f\n",k(stepOut));
% plotFlux();