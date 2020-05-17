clear all
clc
close all

%% Reactor Numerical Analysis and Design
% HW#3: One-node NEM calculation for NEACRP-L336
% 2017-15546 ? •ë¯¼ê¸°

%% Part A. Preparation of the Code


assemCount = 3; % for 2D
% core configuration (loading pattern)
assemConf = [1,2,3;2,1,3;3,3,3]; % for 2D
assemSize = 21.42; % size of each assembly [cm]
nodeCount = 1; % number of nodes in x,y direction per assembly
nodeDim = nodeCount * assemCount; % total number of nodes in one direction
h = assemSize / nodeCount; % size of each node [cm]
% Red-Black ordering scheme
nodeOrder = zeros(nodeDim^2,1); % for 2D
% Material composition ID for each node
node2comp = zeros(nodeDim^2,1); % for 2D

nodeDim2=nodeDim^2;
% Red-Black ordering scheme assignment
counter = 1;
for i = 1:2:nodeDim2
    nodeOrder(counter) = i;
    counter = counter + 1;
end
for i = 2:2:nodeDim2
    nodeOrder(counter) = i;
    counter = counter + 1;
end

% Mapping node to material composition
nodeIndex = 1;
for i = 1:assemCount; for j = 1:nodeCount % for 2D
for k = 1:assemCount; for l = 1:nodeCount
    node2comp(nodeIndex) = assemConf(i,k); % for 2D
    nodeIndex = nodeIndex + 1;
end; end
end; end % for 2D


A1(); % Setup variables

stepOut = 1; % outer iteraion step counter
epsk = 1e-06;
epspsi = 1e-05;
flagOut = false; % Convergence indicator for outer iteration

k(1) = 1.0; % Initial eigenvalue guess; index is outer iteration count

while ~flagOut % Repeat outer iteration until convergence
        
    stepOut
    fprintf("Current k : %f\n",k(stepOut))
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
%                 A3(); % Leakge quadratic expansion; not yet implemented
                A4(); % Update source coefficients
                A5(); % Update flux coefficients
                A6(); % Update outgoing partial currents 
            end
        end
        
        plot(a(:,2,1))
%         pause
        plotFlux();
        A7(); % Obtain residual
    end
    A8(); % Update fission source and k-eigenvalue
end


%% Part B. Examination of the Code