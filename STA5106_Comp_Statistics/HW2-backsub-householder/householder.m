% Householder Transformation for a matrix (m x n, m > n)
% Input:
%   X: Matrix (m x n, m > n)
% Output:
%   X_new: Upper Triangular Matrix (m x n, m > n)

function X_new = householder(X)
    m = size(X, 1);
    n = size(X, 2);
    X_new = X;
    for i = 1:n
        v = house(X_new(i:m, i));
        X_new(i:m, i:n) = rowhouse(X_new(i:m, i:n), v);
    end
end