%% A1.m
% Setup variables

% Read XS data
inputFile = fopen('l336.xsc','r');
readXS(); % Reads cross section input file and stores in "data"

% Initialize coefficients
a0 = zeros(totalNodes,data.ng); % node average flux
a = zeros(totalNodes,data.ng,4,2); % coefficients for flux; [4 coefficients, 2 directions]
q0 = zeros(totalNodes,data.ng); % node average source
q = zeros(totalNodes,data.ng,4,2); % coefficients for source; [4 coefficients, 2 directions]
l0 = zeros(totalNodes,data.ng,2); % node average leakage [2 directions]
l = zeros(totalNodes,data.ng,2,2); % coefficients for leakage; [4 coefficients, 2 directions]
f0 = zeros(totalNodes,data.ng); % node average fission source
f = zeros(totalNodes,data.ng,4,2); % coefficients for fission source; [4 coefficients, 2 directions]

% Initialize flux to be 1.0;
a0(:,:) = 1.0;

% Initialize outgoing/incoming current
% Node index definition is consistent with "GetTrLkg.m"
jout = zeros(totalNodes,data.ng,2,2); % outgoing current; [2 directions(1:l+, 2:r+), 2 axis(1:x, 2:y)]
jin = zeros(totalNodes,data.ng,2,2); % incoming current; [2 directions(1:l-, 2:r-), 2 axis(1:x, 2:y)]

% Initialize outgoing/incoming current to be 0.25
jin(:,:,:,:) = 0.25;
jout(:,:,:,:) = 0.25;

% Boundary conditions
jin(eastNodes,:,2,1) = 0; % Vacuum boundary condition; J_in = 0
jin(southNodes,:,2,2) = 0;
jout(westNodes,:,1,1) = jin(westNodes,:,1,1); % Reflective boundary condition; J_net = 0
jout(northNodes,:,1,2) = jin(northNodes,:,1,2);