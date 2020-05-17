%% initialize.m
% Define reactor core

assemCount = 3; % number of assemblies per direction
assemConf = [1,2,3;2,1,3;3,3,3]; % core configuration (loading pattern)
assemSize = 21.42; % size of each assembly [cm]
nodeDim = nodeCount * assemCount; % number of nodes per direction
totalNodes = nodeDim^2;
h = assemSize / nodeCount; % size of each node [cm]
h2 = h^2; % node area [cm^2]
nodeOrder = zeros(totalNodes,1); % Red-Black ordering scheme
node2comp = zeros(totalNodes,1); % material composition ID for each node

% index of boundary nodes
northNodes = 1:nodeDim;
westNodes = 1:nodeDim:totalNodes;
eastNodes = nodeDim:nodeDim:totalNodes;
southNodes = northNodes + totalNodes-nodeDim;

% Red-Black ordering scheme assignment
counter = 1;
for i = 1:2:nodeDim
    nodeOrder(counter) = i;
    counter = counter + 1;
end
for i = 2:2:nodeDim
    nodeOrder(counter) = i;
    counter = counter + 1;
end

% mapping node to material composition
nodeIndex = 1;
for i = 1:assemCount; for j = 1:nodeCount
for k = 1:assemCount; for l = 1:nodeCount
    node2comp(nodeIndex) = assemConf(i,k);
    nodeIndex = nodeIndex + 1;
end; end; end; end