% Householder Transformation - Row Iteration
% Input:
%   X: Matrix (m x n, m > n)
%   v: householder vector array (n x 1)
% Output:
%   X_new: First-row-transformed matrix
function X_new = rowhouse(X,v)
    X_new = X - 2 / norm(v)^2 * v * v' * X;
end