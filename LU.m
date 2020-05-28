function [L,U] = LU(M)

    N = size(M,1);

    L = zeros(N,1);
    U = zeros(N,2);

    for i = 1:N-1
        U(i,2) = M(i,3);
    end
    U(1,1) = M(1);
    for i = 2:N
        L(i) = M(i,2) / U(i-1,1);
        U(i,1) = M(i,1) - L(i) * U(i-1,2);
    end

end

