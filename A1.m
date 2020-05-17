%% Part A Question 1
% fprintf("A1\n");

% Read XS data
inputFile = fopen('l336.xsc','r');
readXS(); % Reads cross section input file and stores in "data"

% Initialize coefficients
a = zeros(nodeDim2,data.ng,5,2); % coefficients for flux: direction별로 a1-3 달라.
q = zeros(nodeDim2,data.ng,5,2); % coefficients for source
l = zeros(nodeDim2,data.ng,3,2); % coefficients for leakage
% 노드, 그룹, 다항식차수, (x/y) direction

% Initialize flux to be 1.0;
for i = 1:nodeDim2; for g = 1:data.ng
    a(i,g,1,:) = 1.0; % node average flux = a0
end; end

% Initialize outgoing/incoming current
% Node index definition is consistent with "GetTrLkg.m"
jout = zeros(nodeDim2,data.ng,2,2); % Two directios: left[1]; right[2], Two axis: x[1], y[2]
jin = zeros(nodeDim2,data.ng,2,2); % Two directions: right[1]; left[2]

% Initialize incoming current to be 0.25
for i = 1:nodeDim2; for g = 1:data.ng; for j = 1:2
    jin(i,g,j,1) = 0.25; % x-direction
    jin(i,g,j,2) = 0.25; % y-direction
end; end; end
% Boundary conditions for incoming current
jin(nodeDim2,[1,2],2,1) = 0; % Vacuum boundary condition; Jin = 0
jin(nodeDim2,[1,2],2,2) = 0;


for i = 1:nodeDim2; for g = 1:data.ng; for j = 1:2
    jout(i,g,j,1) = 0.25;
    jout(i,g,j,2)=0.25;
end; end; end