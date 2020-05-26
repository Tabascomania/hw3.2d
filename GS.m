%% GS.m
% Gauss Seidel iteration

phi = a0;
a0
for iter = 1:1
    for g = 1:data.ng
        for i = 1:totalNodes
            inb = nb(i,:);
            rhs = RHS(i,g);
            if inb(1) ~= -1 % not a north node
                rhs  = rhs - gamma(i,g,1)*phi(i-nodeDim,g);
            end
            if inb(2) ~= -1 % not a west node
                rhs = rhs - gamma(i,g,2)*phi(i-1,g);
            end
            if inb(3) ~= -1 % not an east node
                rhs = rhs - gamma(i,g,3)*phi(i+1,g);
            end
            if inb(4) ~= -1 % not a south node
                rhs = rhs - gamma(i,g,4)*phi(i+nodeDim,g);
            end
            phi(i,g) = rhs / d(i,g);
        end
    end
end

a0 = phi;
a0