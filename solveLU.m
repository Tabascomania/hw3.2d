function [x] = solveLU(L,U,b)

N = size(b,1);

y = zeros(N,1);
y(1) = b(1);

for i = 2:N
    y(i) = b(i)-L(i)*y(i-1);
end

x = zeros(N,1);
x(N) = y(N)/U(N,1);

for j = 1:N-1
    i = N-j;
    x(i) = (y(i) - U(i,2)*x(i+1))/U(i,1);
end

end

