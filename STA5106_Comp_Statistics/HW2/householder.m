% Householder Transformation for a matrix (m x n, m > n)
% Input:
%   X: Matrix (m x n, m > n)
% Output:
%   X_new: Upper Triangular Matrix (m x n, m > n)

% Example
% X = [1.4 4.5 6.5; 5.8 3.2 7.3; 2.3 -2.6 8.2; 8.1 -5.8 -8; 9 0.3 1.5];

function X_new = householder(X)
    m = size(X, 1);
    n = size(X, 2);
    X_new = X;
    for i = 1:n
        v = house(X_new(i:m, i));
        X_new(i:m, i:n) = rowhouse(X_new(i:m, i:n), v);
    end
end