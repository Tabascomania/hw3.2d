phiX = a(n,g,1,1)*P1(x)+a(n,g,2,1)*P2(x)+a(n,g,3,1)*P3(x)+a(n,g,4,1)*P4(x);
phiY = a(n,g,1,2)*P2(y)+a(n,g,2,2)*P2(y)+a(n,g,3,2)*P3(y)+a(n,g,4,2)*P4(y);

function [f] = P1(x)
    f = 2*x-1;
end
function [f] = P2(x)
    f = 6*x.*(1-x)-1;
end
function [f] = P3(x)
    f = 6*x.*(1-x).*(2*x-1);
end
function [f] = P4(x)
    f = 6*x.*(1-x).*(5*x.^2-5*x+1);
end