%% plotFlux.m
% Create a plot of flux distribution
phi = zeros(100,nodeDim);
for i = 1:nodeDim
    x = 0:0.01:0.99;

    P = zeros(size(x,2),4);
    
    P(:,1) = 2*x-1;
    P(:,2) = 6*x.*(1-x)-1;
    P(:,3) = 6*x.*(1-x).*(2*x-1);
    P(:,4) = 6*x.*(1-x).*(5*x.^2-5*x+1);
    
    phi(:,i) = (a0(i,1) + a(i,1,1,1) .* P(:,1) + a(i,1,2,1) .* P(:,2) + a(i,1,3,1) .* P(:,3) + a(i,1,4,1) .* P(:,4))';
end
phi = reshape(phi,[1,nodeDim*100]);
plot(phi)
title("Flux G:1")

pause

phi = zeros(100,nodeDim);
for i = 1:nodeDim
    x = 0:0.01:0.99;

    P = zeros(size(x,2),4);
    
    P(:,1) = 2*x-1;
    P(:,2) = 6*x.*(1-x)-1;
    P(:,3) = 6*x.*(1-x).*(2*x-1);
    P(:,4) = 6*x.*(1-x).*(5*x.^2-5*x+1);
    
    phi(:,i) = (a0(i,2) + a(i,2,1,1) .* P(:,1) + a(i,2,2,1) .* P(:,2) + a(i,2,3,1) .* P(:,3) + a(i,2,4,1) .* P(:,4))';
end
phi = reshape(phi,[1,nodeDim*100]);
plot(phi)
title("Flux G:2")

pause

fis = zeros(100,nodeDim);
for i = 1:nodeDim
    x = 0:0.01:0.99;

    P = zeros(size(x,2),4);
    
    P(:,1) = 2*x-1;
    P(:,2) = 6*x.*(1-x)-1;
    P(:,3) = 6*x.*(1-x).*(2*x-1);
    P(:,4) = 6*x.*(1-x).*(5*x.^2-5*x+1);
    
    fis(:,i) = (f0(i,1) + f(i,1,1,1) .* P(:,1) + f(i,1,2,1) .* P(:,2) + f(i,1,3,1) .* P(:,3) + f(i,1,4,1) .* P(:,4))';
end
fis = reshape(fis,[1,nodeDim*100]);
plot(fis)
title("Fission source")

pause

avgP = zeros(nodeDim+1,nodeDim+1);
avgP(1:nodeDim,1:nodeDim) = reshape(a0(:,1),[nodeDim,nodeDim]);
surf(avgP)
pause

avgP = zeros(nodeDim+1,nodeDim+1);
avgP(1:nodeDim,1:nodeDim) = reshape(a0(:,2),[nodeDim,nodeDim]);
surf(avgP)
pause

avgP = zeros(nodeDim+1,nodeDim+1);
avgP(1:nodeDim,1:nodeDim) = reshape(f0(:,1),[nodeDim,nodeDim]);
surf(avgP)