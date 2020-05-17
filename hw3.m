clear all
clc
close all

%% Reactor Numerical Analysis and Design
% HW#3: One-node NEM calculation for NEACRP-L336

%% Part A. Preparation of the Code

nodeCount = 4; % number of nodes per direction per assembly

initialize(); % Define reactor core

A1(); % Setup variables

stepOut = 1; % outer iteration step counter
epsk = 1e-06; % eigenvalue convergence criterion
epspsi = 1e-05; % fission source convergence criterion
flagOut = false; % convergence indicator for outer iteration

k(stepOut) = 1.0; % Initial eigenvalue guess
    
while ~flagOut % Repeat outer iteration until convergence
        
    fprintf("Outer iteration #%d\n",stepOut);
    fprintf("Current k : %f\n",k(stepOut));
    A2(); % Obtain initial residual
    fprintf("Current r0 : %f\n",r0)
    fprintf("Current psi_1G : %f\n", psi_1G)
    
    stepIn = 1; % inner iteration step counter
    epsin = 0.1; % inner iteration convergence condition
    flagIn = false; % Convergence indicator for inner iteration

    while ~flagIn % Repeat inner iteration until convergence
        for n = 1:nodeDim % Node sweep
            currNode = nodeOrder(n);
            currComp = node2comp(currNode); % Material composition for this node
            for currGrp = 1:data.ng % Group sweep
                A3(); % Leakge quadratic expansion; not yet implemented
                A4(); % Update source coefficients
                A5(); % Update flux coefficients
                A6(); % Update outgoing partial currents 
            end
        end
        
        plotFlux();
        A7(); % Obtain residual
    end
    A8(); % Update fission source and k-eigenvalue
end


%% Part B. Examination of the Code