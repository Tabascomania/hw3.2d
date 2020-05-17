%% plotFlux.m
% Create a plot of flux distribution
phi = zeros(101,nodeDim);
for i = 1:nodeDim
    x = 0:0.01:1;

    P = zeros(size(x,2),4);
    
    P(:,1) = 2*x-1;
    P(:,2) = 6*x.*(1-x)-1;
    P(:,3) = 6*x.*(1-x).*(2*x-1);
    P(:,4) = 6*x.*(1-x).*(5*x.^2-5*x+1);
    
    phi(:,i) = (a(i,1,1) + a(i,1,2) .* P(:,1) + a(i,1,3) .* P(:,2) + a(i,1,4) .* P(:,3) + a(i,1,5) .* P(:,4))';
end
phi = reshape(phi,[1,nodeDim*101]);
plot(phi)
title("Flux G:1")

% pause


fis = zeros(101,nodeDim);
for i = 1:nodeDim
    x = 0:0.01:1;

    P = zeros(size(x,2),4);
    
    P(:,1) = 2*x-1;
    P(:,2) = 6*x.*(1-x)-1;
    P(:,3) = 6*x.*(1-x).*(2*x-1);
    P(:,4) = 6*x.*(1-x).*(5*x.^2-5*x+1);
    
    fis(:,i) = (q(i,1,1) + q(i,1,2) .* P(:,1) + q(i,1,3) .* P(:,2) + q(i,1,4) .* P(:,3) + q(i,1,5) .* P(:,4))';
end
fis = reshape(fis,[1,nodeDim*101]);
plot(fis)
title("Fission source")

% pause