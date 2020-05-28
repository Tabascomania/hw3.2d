clear all
clc
close all

%% Reactor Numerical Analysis and Design
% HW#3: One-node NEM calculation for NEACRP-L336

%% Part A. Preparation of the Code
tic
nodeCount = 1; % number of nodes per direction per assembly
assemConf = [...
    1,2,1,2,3;...
    2,1,2,1,3;...
    1,2,1,2,3;...
    2,1,2,1,3;...
    3,3,3,3,3]; % core configuration (loading pattern)

% assemConf = [...
%     1,2,1,2,1,2,3;...
%     2,1,2,1,2,1,3;...
%     1,2,1,2,1,2,3;...
%     2,1,2,1,2,1,3;...
%     1,2,1,2,1,2,3;...
%     2,1,2,1,2,1,3;...
%     3,3,3,3,3,3,3]; % core configuration (loading pattern)

% assemConf = [...
%     1,2,1,2,1,2,1,2,3;...
%     2,1,2,1,2,1,2,1,3;...
%     1,2,1,2,1,2,1,2,3;...
%     2,1,2,1,2,1,2,1,3;...
%     1,2,1,2,1,2,1,2,3;...
%     2,1,2,1,2,1,2,1,3;...
%     1,2,1,2,1,2,1,2,3;...
%     2,1,2,1,2,1,2,1,3;...
%     1,2,1,2,1,2,1,2,3;...
%     3,3,3,3,3,3,3,3,3]; % core configuration (loading pattern)

% assemConf = [...
%     1,2,1,2,1,2,1,2,1,2,3;...
%     2,1,2,1,2,1,2,1,2,1,3;...
%     1,2,1,2,1,2,1,2,1,2,3;...
%     2,1,2,1,2,1,2,1,2,1,3;...
%     1,2,1,2,1,2,1,2,1,2,3;...
%     2,1,2,1,2,1,2,1,2,1,3;...
%     1,2,1,2,1,2,1,2,1,2,3;...
%     2,1,2,1,2,1,2,1,2,1,3;...
%     1,2,1,2,1,2,1,2,1,2,3;...
%     2,1,2,1,2,1,2,1,2,1,3;...
%     1,2,1,2,1,2,1,2,1,2,3;...
%     3,3,3,3,3,3,3,3,3,3,3]; % core configuration (loading pattern)

initialize(); % Define reactor core
A1(); % Setup variables
cmfd_setup(); % Setup CMFD variables (D_tilde,alpha)

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
        
%         if stepIn == 3
%             flagIn = true;
%         end
    end
    
    if mod(stepOut,2) == 0
        CMFD(); % CMFD iteration
%         plotFlux();
    end
    
    A8(); % Update fission source and k-eigenvalue
    fprintf("\n");
end
toc
fprintf("Eigenvalue: %.10f\n",k(stepOut));
plotFlux();


% 5-by-5 core results (node: 1x1)
% Without CMFD:
%     Outer iteration #87
%     Elapsed time is 2.379742 seconds.
%     Eigenvalue: 0.9961454497
% With CMFD (2 NEM, 1 CMFD):
%     Outer iteration #85
%     Elapsed time is 4.772664 seconds.
%     Eigenvalue: 0.9961456144
% 
% 7-by-7 core results (node: 1x1)
% Without CMFD:
%     Outer iteration #165
%     Elapsed time is 9.091416 seconds.
%     Eigenvalue: 1.0106434905
% Without CMFD (2 NEM, 1 CMFD) :
%     Outer iteration #163
%     Elapsed time is 16.447340 seconds.
%     Eigenvalue: 1.0106436040
% 
% 9-by-9 core results (node: 1x1)
% Without CMFD:
%     Outer iteration #302
%     Elapsed time is 26.868898 seconds.
%     Eigenvalue: 1.0168323575
% Without CMFD (2 NEM, 1 CMFD) :
%     Outer iteration #268
%     Elapsed time is 46.533465 seconds.
%     Eigenvalue: 1.0168324280
% 
% 11-by-11 core results (node: 1x1)
% Without CMFD:
%     Outer iteration #419
%     Elapsed time is 55.802738 seconds.
%     Eigenvalue: 1.0192702058
% Without CMFD (2 NEM, 1 CMFD) :
%     Outer iteration #402
%     Elapsed time is 100.990888 seconds.
%     Eigenvalue: 1.0192702163
